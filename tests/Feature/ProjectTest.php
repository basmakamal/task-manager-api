<?php

namespace Tests\Feature;

use App\Models\Project;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class ProjectTest extends TestCase
{
    use RefreshDatabase;

    protected User $user;

    protected function setUp(): void
    {
        parent::setUp();

        $this->user = User::factory()->create();
        Sanctum::actingAs($this->user);
    }

    public function test_user_can_list_only_their_own_projects(): void
    {
        Project::factory(3)->for($this->user)->create();
        Project::factory(2)->create();

        $response = $this->getJson('/api/projects');

        $response->assertOk()
            ->assertJsonCount(3, 'data')
            ->assertJsonStructure(['data', 'links', 'meta']);
    }

    public function test_projects_can_be_filtered_by_status(): void
    {
        Project::factory(2)->for($this->user)->create(['status' => 'active']);
        Project::factory()->for($this->user)->create(['status' => 'archived']);

        $response = $this->getJson('/api/projects?status=archived');

        $response->assertOk()->assertJsonCount(1, 'data');
    }

    public function test_user_can_create_a_project(): void
    {
        $response = $this->postJson('/api/projects', [
            'name' => 'New Project',
            'description' => 'Something to build',
        ]);

        $response->assertCreated()
            ->assertJsonPath('data.name', 'New Project')
            ->assertJsonPath('data.status', 'active');

        $this->assertDatabaseHas('projects', [
            'name' => 'New Project',
            'user_id' => $this->user->id,
        ]);
    }

    public function test_project_name_is_required(): void
    {
        $this->postJson('/api/projects', ['description' => 'no name'])
            ->assertUnprocessable()
            ->assertJsonValidationErrors(['name']);
    }

    public function test_project_status_must_be_valid(): void
    {
        $this->postJson('/api/projects', ['name' => 'Test', 'status' => 'bogus'])
            ->assertUnprocessable()
            ->assertJsonValidationErrors(['status']);
    }

    public function test_user_can_view_their_project(): void
    {
        $project = Project::factory()->for($this->user)->create();

        $this->getJson("/api/projects/{$project->id}")
            ->assertOk()
            ->assertJsonPath('data.id', $project->id);
    }

    public function test_user_cannot_view_someone_elses_project(): void
    {
        $project = Project::factory()->create();

        $this->getJson("/api/projects/{$project->id}")->assertForbidden();
    }

    public function test_user_can_update_their_project(): void
    {
        $project = Project::factory()->for($this->user)->create();

        $response = $this->putJson("/api/projects/{$project->id}", [
            'name' => 'Renamed',
            'status' => 'completed',
        ]);

        $response->assertOk()
            ->assertJsonPath('data.name', 'Renamed')
            ->assertJsonPath('data.status', 'completed');
    }

    public function test_user_cannot_update_someone_elses_project(): void
    {
        $project = Project::factory()->create();

        $this->putJson("/api/projects/{$project->id}", ['name' => 'Hacked'])
            ->assertForbidden();
    }

    public function test_user_can_soft_delete_their_project(): void
    {
        $project = Project::factory()->for($this->user)->create();

        $this->deleteJson("/api/projects/{$project->id}")->assertOk();

        $this->assertSoftDeleted('projects', ['id' => $project->id]);
    }

    public function test_viewing_a_missing_project_returns_404(): void
    {
        $this->getJson('/api/projects/999')->assertNotFound();
    }
}
