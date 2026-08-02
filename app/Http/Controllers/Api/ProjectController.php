<?php

namespace App\Http\Controllers\Api;

use App\Enums\ProjectStatus;
use App\Http\Controllers\Controller;
use App\Http\Requests\Project\StoreProjectRequest;
use App\Http\Requests\Project\UpdateProjectRequest;
use App\Http\Resources\ProjectResource;
use App\Models\Project;
use App\Services\ProjectService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Validation\Rule;

/**
 * @group Projects
 *
 * Manage the authenticated user's projects.
 */
class ProjectController extends Controller
{
    public function __construct(protected ProjectService $projectService)
    {
    }

    /**
     * List projects
     *
     * @queryParam status Filter by status: active, completed or archived. Example: active
     * @queryParam per_page Results per page (max 100). Example: 10
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $this->authorize('viewAny', Project::class);

        $filters = $request->validate([
            'status' => ['sometimes', Rule::enum(ProjectStatus::class)],
            'per_page' => ['sometimes', 'integer', 'min:1', 'max:100'],
        ]);

        return ProjectResource::collection(
            $this->projectService->listForUser($request->user(), $filters)
        );
    }

    /**
     * Create a project
     */
    public function store(StoreProjectRequest $request): JsonResponse
    {
        $project = $this->projectService->create($request->user(), $request->validated());

        return (new ProjectResource($project))
            ->response()
            ->setStatusCode(201);
    }

    /**
     * View a project
     */
    public function show(Project $project): ProjectResource
    {
        $this->authorize('view', $project);

        return new ProjectResource($project->loadCount('tasks'));
    }

    /**
     * Update a project
     */
    public function update(UpdateProjectRequest $request, Project $project): ProjectResource
    {
        $this->authorize('update', $project);

        return new ProjectResource(
            $this->projectService->update($project, $request->validated())
        );
    }

    /**
     * Delete a project
     */
    public function destroy(Project $project): JsonResponse
    {
        $this->authorize('delete', $project);

        $this->projectService->delete($project);

        return response()->json([
            'message' => 'Project deleted successfully.',
        ]);
    }
}
