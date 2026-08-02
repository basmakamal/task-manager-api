<?php

namespace Tests\Feature;

use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use App\Notifications\TaskOverdueNotification;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Notification;
use Tests\TestCase;

class OverdueNotificationTest extends TestCase
{
    use RefreshDatabase;

    public function test_command_notifies_owner_about_overdue_tasks_only(): void
    {
        Notification::fake();

        $user = User::factory()->create();
        $project = Project::factory()->for($user)->create();

        $overdue = Task::factory()->overdue()->for($project)->create();
        Task::factory()->for($project)->create(['status' => 'done', 'due_date' => now()->subDay()]);
        Task::factory()->for($project)->create(['status' => 'todo', 'due_date' => now()->addWeek()]);

        $this->artisan('tasks:notify-overdue')->assertSuccessful();

        Notification::assertSentTo(
            $user,
            TaskOverdueNotification::class,
            fn ($notification) => $notification->task->is($overdue)
        );
        Notification::assertCount(1);
    }

    public function test_command_does_not_notify_twice_for_the_same_task(): void
    {
        Notification::fake();

        $task = Task::factory()->overdue()->create();

        $this->artisan('tasks:notify-overdue');
        $this->artisan('tasks:notify-overdue');

        Notification::assertCount(1);
    }
}
