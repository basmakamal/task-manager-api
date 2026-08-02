# Task Manager API

A RESTful API for a simple task management system built with Laravel 12 and Sanctum. Users register, create projects, and manage tasks inside them, with filtering, search, pagination and a dashboard endpoint for quick stats.

## Requirements

- PHP 8.2+
- Composer
- MySQL 5.7+ / MariaDB 10.4+

## Installation

```bash
git clone https://github.com/basmakamal/task-manager-api.git
cd task-manager-api
composer install
copy .env.example .env        # cp on Linux/Mac
php artisan key:generate
```

Create a MySQL database and point the `.env` at it:

```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=task_manager
DB_USERNAME=root
DB_PASSWORD=
```

Then run the migrations with the sample data seeder:

```bash
php artisan migrate --seed
```

(Alternatively, import `database/task_manager.sql` for a ready-made schema + sample data.)

Start the server:

```bash
php artisan serve
```

The API is now available at `http://127.0.0.1:8000/api`.

### Seeded accounts

| Email | Password |
|---|---|
| demo@example.com | password |
| jane@example.com | password |

## API Documentation

Interactive docs (generated with Scribe) are available at **`/docs`** once the server is running. The same content is exported as:

- `postman_collection.json` — import into Postman (also served at `/docs.postman`)
- `openapi.yaml` — OpenAPI 3 spec (also served at `/docs.openapi`)

### Endpoints overview

All routes are prefixed with `/api`. Everything except register/login requires an `Authorization: Bearer <token>` header.

| Method | Endpoint | Description |
|---|---|---|
| POST | `/register` | Create an account, returns a token |
| POST | `/login` | Returns a token |
| POST | `/logout` | Revokes the current token |
| GET | `/projects` | List own projects (`?status=`, `?per_page=`) |
| POST | `/projects` | Create a project |
| GET | `/projects/{id}` | View a project |
| PUT/PATCH | `/projects/{id}` | Update a project |
| DELETE | `/projects/{id}` | Soft delete a project |
| GET | `/projects/{id}/tasks` | List tasks of a project (same filters as `/tasks`) |
| POST | `/projects/{id}/tasks` | Create a task in a project |
| GET | `/tasks` | List all own tasks (`?status=`, `?priority=`, `?search=`, `?per_page=`) |
| GET | `/tasks/{id}` | View a task |
| PUT/PATCH | `/tasks/{id}` | Update a task |
| DELETE | `/tasks/{id}` | Soft delete a task |
| GET | `/dashboard` | Project/task counters incl. overdue tasks |

Project status: `active`, `completed`, `archived`.
Task status: `todo`, `in_progress`, `done` — priority: `low`, `medium`, `high`.

## Architecture notes

- Thin controllers delegating to **service classes** (`app/Services`)
- **Form Requests** for validation, **API Resources** for responses, **Policies** for ownership checks
- PHP **backed enums** for project/task status and priority
- **Soft deletes** on projects and tasks
- Consistent JSON errors (401/403/404/422) for all `api/*` routes

## Overdue task notifications

A scheduled command queues a notification (mail + database channels) to the project owner for every task that passed its due date and isn't done yet:

```bash
php artisan tasks:notify-overdue   # runs daily at 08:00 via the scheduler
php artisan queue:work             # processes the queued notifications
```

Each task is only notified about once (`overdue_notified_at` guard).

## Tests

Feature tests cover auth, project/task CRUD + authorization, filtering, search, the dashboard and the overdue notification command. They run on an in-memory SQLite database:

```bash
php artisan test
```
