<?php

namespace App\Notifications;

use App\Models\Task;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class TaskOverdueNotification extends Notification implements ShouldQueue
{
    use Queueable;

    public function __construct(public Task $task)
    {
    }

    public function via(object $notifiable): array
    {
        return ['mail', 'database'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
            ->subject("Task overdue: {$this->task->title}")
            ->greeting("Hello {$notifiable->name},")
            ->line("The task \"{$this->task->title}\" in project \"{$this->task->project->name}\" was due on {$this->task->due_date->format('M d, Y')}.")
            ->line('Please update its status or adjust the due date.');
    }

    public function toArray(object $notifiable): array
    {
        return [
            'task_id' => $this->task->id,
            'project_id' => $this->task->project_id,
            'title' => $this->task->title,
            'due_date' => $this->task->due_date->toDateString(),
        ];
    }
}
