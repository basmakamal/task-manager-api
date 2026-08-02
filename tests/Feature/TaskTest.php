<?php

namespace Tests\Feature;

use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class TaskTest extends TestCase
{
    use RefreshDatabase;

    protected User $user;

    protected Project $project;

    protected function setUp(): void
    {
        parent::setUp();

        $this->user = User::factory()->create();
        $this->project = Project::factory()->for($this->user)->create();
        Sanctum::actingAs($this->user);
    }

    public function test_user_can_create_a_task_in_their_project(): void
    {
        $response = $this->postJson("/api/projects/{$this->project->id}/tasks", [
            'title' => 'Write tests',
            'priority' => 'high',
            'due_date' => now()->addWeek()->toDateString(),
        ]);

        $response->assertCreated()
            ->assertJsonPath('data.title', 'Write tests')
            ->assertJsonPath('data.priority', 'high')
            ->assertJsonPath('data.status', 'todo');

        $this->assertDatabaseHas('tasks', [
            'title' => 'Write tests',
            'project_id' => $this->project->id,
        ]);
    }

    public function test_user_cannot_create_a_task_in_someone_elses_project(): void
    {
        $other = Project::factory()->create();

        $this->postJson("/api/projects/{$other->id}/tasks", ['title' => 'Nope'])
            ->assertForbidden();
    }

    public function test_task_title_is_required(): void
    {
        $this->postJson("/api/projects/{$this->project->id}/tasks", [])
            ->assertUnprocessable()
            ->assertJsonValidationErrors(['title']);
    }

    public function test_task_priority_and_status_must_be_valid(): void
    {
        $this->postJson("/api/projects/{$this->project->id}/tasks", [
            'title' => 'Test',
            'priority' => 'urgent',
            'status' => 'later',
        ])
            ->assertUnprocessable()
            ->assertJsonValidationErrors(['priority', 'status']);
    }

    public function test_user_can_list_tasks_of_a_project(): void
    {
        Task::factory(4)->for($this->project)->create();

        $this->getJson("/api/projects/{$this->project->id}/tasks")
            ->assertOk()
            ->assertJsonCount(4, 'data');
    }

    public function test_user_can_list_all_their_tasks_across_projects(): void
    {
        Task::factory(2)->for($this->project)->create();
        Task::factory(3)->for(Project::factory()->for($this->user))->create();
        Task::factory(2)->create(); // other user's tasks

        $this->getJson('/api/tasks')
            ->assertOk()
            ->assertJsonCount(5, 'data');
    }

    public function test_tasks_can_be_filtered_by_status(): void
    {
        Task::factory(2)->for($this->project)->create(['status' => 'done']);
        Task::factory(3)->for($this->project)->create(['status' => 'todo']);

        $this->getJson('/api/tasks?status=done')
            ->assertOk()
            ->assertJsonCount(2, 'data');
    }

    public function test_tasks_can_be_filtered_by_priority(): void
    {
        Task::factory(2)->for($this->project)->create(['priority' => 'low']);
        Task::factory()->for($this->project)->create(['priority' => 'high']);

        $this->getJson('/api/tasks?priority=high')
            ->assertOk()
            ->assertJsonCount(1, 'data');
    }

    public function test_tasks_can_be_searched_by_title(): void
    {
        Task::factory()->for($this->project)->create(['title' => 'Deploy to production']);
        Task::factory()->for($this->project)->create(['title' => 'Update readme']);

        $this->getJson('/api/tasks?search=deploy')
            ->assertOk()
            ->assertJsonCount(1, 'data')
            ->assertJsonPath('data.0.title', 'Deploy to production');
    }

    public function test_user_can_update_their_task(): void
    {
        $task = Task::factory()->for($this->project)->create();

        $this->patchJson("/api/tasks/{$task->id}", ['status' => 'in_progress'])
            ->assertOk()
            ->assertJsonPath('data.status', 'in_progress');
    }

    public function test_user_cannot_update_someone_elses_task(): void
    {
        $task = Task::factory()->create();

        $this->patchJson("/api/tasks/{$task->id}", ['status' => 'done'])
            ->assertForbidden();
    }

    public function test_user_can_soft_delete_their_task(): void
    {
        $task = Task::factory()->for($this->project)->create();

        $this->deleteJson("/api/tasks/{$task->id}")->assertOk();

        $this->assertSoftDeleted('tasks', ['id' => $task->id]);
    }
}
