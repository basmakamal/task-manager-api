<?php

namespace App\Http\Controllers\Api;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use App\Http\Controllers\Controller;
use App\Http\Requests\Task\StoreTaskRequest;
use App\Http\Requests\Task\UpdateTaskRequest;
use App\Http\Resources\TaskResource;
use App\Models\Project;
use App\Models\Task;
use App\Services\TaskService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Validation\Rule;

/**
 * @group Tasks
 *
 * Manage tasks inside the authenticated user's projects.
 */
class TaskController extends Controller
{
    public function __construct(protected TaskService $taskService)
    {
    }

    /**
     * List all tasks
     *
     * Returns tasks across all of the user's projects.
     *
     * @queryParam status Filter by status: todo, in_progress or done. Example: todo
     * @queryParam priority Filter by priority: low, medium or high. Example: high
     * @queryParam search Search in task titles. Example: deploy
     * @queryParam per_page Results per page (max 100). Example: 10
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $filters = $this->validateFilters($request);

        return TaskResource::collection(
            $this->taskService->listForUser($request->user(), $filters)
        );
    }

    /**
     * List tasks of a project
     *
     * @queryParam status Filter by status: todo, in_progress or done. Example: done
     * @queryParam priority Filter by priority: low, medium or high. Example: medium
     * @queryParam search Search in task titles. Example: bug
     * @queryParam per_page Results per page (max 100). Example: 10
     */
    public function indexForProject(Request $request, Project $project): AnonymousResourceCollection
    {
        $this->authorize('view', $project);

        $filters = $this->validateFilters($request);

        return TaskResource::collection(
            $this->taskService->listForProject($project, $filters)
        );
    }

    /**
     * Create a task
     */
    public function store(StoreTaskRequest $request, Project $project): JsonResponse
    {
        $this->authorize('update', $project);

        $task = $this->taskService->create($project, $request->validated());

        return (new TaskResource($task))
            ->response()
            ->setStatusCode(201);
    }

    /**
     * View a task
     */
    public function show(Task $task): TaskResource
    {
        $this->authorize('view', $task);

        return new TaskResource($task->load('project'));
    }

    /**
     * Update a task
     */
    public function update(UpdateTaskRequest $request, Task $task): TaskResource
    {
        $this->authorize('update', $task);

        return new TaskResource(
            $this->taskService->update($task, $request->validated())
        );
    }

    /**
     * Delete a task
     */
    public function destroy(Task $task): JsonResponse
    {
        $this->authorize('delete', $task);

        $this->taskService->delete($task);

        return response()->json([
            'message' => 'Task deleted successfully.',
        ]);
    }

    protected function validateFilters(Request $request): array
    {
        return $request->validate([
            'status' => ['sometimes', Rule::enum(TaskStatus::class)],
            'priority' => ['sometimes', Rule::enum(TaskPriority::class)],
            'search' => ['sometimes', 'string', 'max:255'],
            'per_page' => ['sometimes', 'integer', 'min:1', 'max:100'],
        ]);
    }
}
