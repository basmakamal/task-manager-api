<?php

namespace Tests\Feature;

use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class DashboardTest extends TestCase
{
    use RefreshDatabase;

    public function test_dashboard_returns_correct_stats(): void
    {
        $user = User::factory()->create();
        Sanctum::actingAs($user);

        $active = Project::factory()->for($user)->create(['status' => 'active']);
        Project::factory()->for($user)->create(['status' => 'completed']);

        Task::factory(2)->for($active)->create(['status' => 'done']);
        Task::factory(3)->for($active)->create(['status' => 'todo', 'due_date' => null]);
        Task::factory()->for($active)->create([
            'status' => 'todo',
            'due_date' => now()->subDays(3)->toDateString(),
        ]);

        // another user's data must not leak into the stats
        Task::factory(4)->create();

        $this->getJson('/api/dashboard')
            ->assertOk()
            ->assertJson([
                'data' => [
                    'total_projects' => 2,
                    'active_projects' => 1,
                    'total_tasks' => 6,
                    'completed_tasks' => 2,
                    'pending_tasks' => 4,
                    'overdue_tasks' => 1,
                ],
            ]);
    }

    public function test_soft_deleted_records_are_excluded_from_stats(): void
    {
        $user = User::factory()->create();
        Sanctum::actingAs($user);

        $project = Project::factory()->for($user)->create(['status' => 'active']);
        $task = Task::factory()->for($project)->create(['status' => 'todo']);

        $task->delete();

        $this->getJson('/api/dashboard')
            ->assertOk()
            ->assertJsonPath('data.total_tasks', 0);
    }
}
