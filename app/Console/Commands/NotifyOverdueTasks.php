<?php

namespace App\Console\Commands;

use App\Enums\TaskStatus;
use App\Models\Task;
use App\Notifications\TaskOverdueNotification;
use Illuminate\Console\Command;

class NotifyOverdueTasks extends Command
{
    protected $signature = 'tasks:notify-overdue';

    protected $description = 'Queue notifications to project owners for overdue tasks';

    public function handle(): int
    {
        $tasks = Task::query()
            ->with('project.user')
            ->whereNull('overdue_notified_at')
            ->whereDate('due_date', '<', today())
            ->where('status', '!=', TaskStatus::Done)
            ->get();

        foreach ($tasks as $task) {
            $task->project->user->notify(new TaskOverdueNotification($task));
            $task->forceFill(['overdue_notified_at' => now()])->save();
        }

        $this->info("Queued notifications for {$tasks->count()} overdue task(s).");

        return self::SUCCESS;
    }
}
