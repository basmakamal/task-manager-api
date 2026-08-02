<?php

namespace App\Services;

use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Builder;

class TaskService
{
    public function listForUser(User $user, array $filters = []): LengthAwarePaginator
    {
        return $this->applyFilters(Task::query()->ownedBy($user), $filters)
            ->with('project')
            ->latest()
            ->paginate($filters['per_page'] ?? 10);
    }

    public function listForProject(Project $project, array $filters = []): LengthAwarePaginator
    {
        return $this->applyFilters($project->tasks()->getQuery(), $filters)
            ->latest()
            ->paginate($filters['per_page'] ?? 10);
    }

    public function create(Project $project, array $data): Task
    {
        return $project->tasks()->create($data);
    }

    public function update(Task $task, array $data): Task
    {
        $task->update($data);

        return $task->refresh();
    }

    public function delete(Task $task): void
    {
        $task->delete();
    }

    protected function applyFilters(Builder $query, array $filters): Builder
    {
        return $query
            ->when($filters['status'] ?? null, fn (Builder $q, $status) => $q->status($status))
            ->when($filters['priority'] ?? null, fn (Builder $q, $priority) => $q->priority($priority))
            ->when($filters['search'] ?? null, fn (Builder $q, $search) => $q->search($search));
    }
}
