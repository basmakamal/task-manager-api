<?php

namespace App\Http\Requests\Auth;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Password;

class RegisterRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users,email'],
            'password' => ['required', 'confirmed', Password::defaults()],
            'password_confirmation' => ['required', 'string'],
        ];
    }

    public function bodyParameters(): array
    {
        return [
            'name' => ['example' => 'John Doe'],
            'email' => ['example' => 'john@example.com'],
            'password' => ['description' => 'Minimum 8 characters.', 'example' => 'password123'],
            'password_confirmation' => ['description' => 'Must match password.', 'example' => 'password123'],
        ];
    }
}
