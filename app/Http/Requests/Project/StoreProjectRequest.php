<?php

namespace App\Http\Requests\Project;

use App\Enums\ProjectStatus;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreProjectRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'status' => ['nullable', Rule::enum(ProjectStatus::class)],
        ];
    }

    public function bodyParameters(): array
    {
        return [
            'name' => ['example' => 'Website Redesign'],
            'description' => ['example' => 'Revamp the marketing site before Q4.'],
            'status' => ['description' => 'One of: active, completed, archived. Defaults to active.', 'example' => 'active'],
        ];
    }
}
