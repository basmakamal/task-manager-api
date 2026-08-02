<?php

namespace App\Http\Requests\Task;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreTaskRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'priority' => ['nullable', Rule::enum(TaskPriority::class)],
            'status' => ['nullable', Rule::enum(TaskStatus::class)],
            'due_date' => ['nullable', 'date'],
        ];
    }

    public function bodyParameters(): array
    {
        return [
            'title' => ['example' => 'Design the landing page'],
            'description' => ['example' => 'First draft in Figma, then review.'],
            'priority' => ['description' => 'One of: low, medium, high. Defaults to medium.', 'example' => 'high'],
            'status' => ['description' => 'One of: todo, in_progress, done. Defaults to todo.', 'example' => 'todo'],
            'due_date' => ['example' => '2026-09-15'],
        ];
    }
}
