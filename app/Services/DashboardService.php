<?php

namespace App\Services;

use App\Enums\ProjectStatus;
use App\Enums\TaskStatus;
use App\Models\Task;
use App\Models\User;

class DashboardService
{
    public function statsFor(User $user): array
    {
        $projects = $user->projects()
            ->selectRaw('count(*) as total')
            ->selectRaw('sum(case when status = ? then 1 else 0 end) as active', [ProjectStatus::Active->value])
            ->first();

        $tasks = Task::query()
            ->ownedBy($user)
            ->selectRaw('count(*) as total')
            ->selectRaw('sum(case when status = ? then 1 else 0 end) as completed', [TaskStatus::Done->value])
            ->selectRaw('sum(case when status != ? then 1 else 0 end) as pending', [TaskStatus::Done->value])
            ->selectRaw(
                'sum(case when due_date < ? and status != ? then 1 else 0 end) as overdue',
                [today()->toDateString(), TaskStatus::Done->value]
            )
            ->first();

        return [
            'total_projects' => (int) $projects->total,
            'active_projects' => (int) $projects->active,
            'total_tasks' => (int) $tasks->total,
            'completed_tasks' => (int) $tasks->completed,
            'pending_tasks' => (int) $tasks->pending,
            'overdue_tasks' => (int) $tasks->overdue,
        ];
    }
}
