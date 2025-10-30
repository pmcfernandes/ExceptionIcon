<?php

namespace ExceptionIcon\Models;

class ExceptionInstance
{
    private $message;
    private $stackTrace;
    private $type;
    private $occurredAt;

    public function __construct(string $message, string $type = '', string $stackTrace = '', ?\DateTime $occurredAt = null)
    {
        $this->message = $message;
        $this->type = $type;
        $this->stackTrace = $stackTrace;
        $this->occurredAt = $occurredAt ?? new \DateTime();
    }

    public function toArray(): array
    {
        return [
            'message' => $this->message,
            'type' => $this->type,
            'stackTrace' => $this->stackTrace,
            'occurredAt' => $this->occurredAt->format(DATE_ATOM)
        ];
    }
}
