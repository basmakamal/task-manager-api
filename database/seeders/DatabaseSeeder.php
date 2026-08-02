<?php

namespace Database\Seeders;

use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    public function run(): void
    {
        $demo = User::factory()->create([
            'name' => 'Demo User',
            'email' => 'demo@example.com',
        ]);

        Project::factory(5)
            ->for($demo)
            ->create()
            ->each(function (Project $project) {
                Task::factory(fake()->numberBetween(3, 6))->for($project)->create();
            });

        // a few overdue tasks so the dashboard has something to show
        Task::factory(3)
            ->overdue()
            ->for($demo->projects->first())
            ->create();

        // second account to demonstrate data isolation between users
        User::factory()
            ->has(Project::factory(2)->has(Task::factory(3)))
            ->create([
                'name' => 'Jane Smith',
                'email' => 'jane@example.com',
            ]);
    }
}
