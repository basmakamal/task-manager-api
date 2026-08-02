<?php

namespace App\Http\Requests\Task;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateTaskRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => ['sometimes', 'required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'priority' => ['sometimes', Rule::enum(TaskPriority::class)],
            'status' => ['sometimes', Rule::enum(TaskStatus::class)],
            'due_date' => ['nullable', 'date'],
        ];
    }

    public function bodyParameters(): array
    {
        return [
            'title' => ['example' => 'Design the landing page'],
            'description' => ['example' => 'Second draft after feedback.'],
            'priority' => ['description' => 'One of: low, medium, high.', 'example' => 'medium'],
            'status' => ['description' => 'One of: todo, in_progress, done.', 'example' => 'in_progress'],
            'due_date' => ['example' => '2026-09-20'],
        ];
    }
}
