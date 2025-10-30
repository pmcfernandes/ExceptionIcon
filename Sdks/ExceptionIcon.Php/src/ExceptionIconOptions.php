<?php

namespace ExceptionIcon;

class ExceptionIconOptions
{
    private $url;
    private $apiKey;
    private $timeout = 5;

    public function __construct(string $url = '', string $apiKey = '')
    {
        $this->url = $url;
        $this->apiKey = $apiKey;
    }

    public function getUrl(): string
    {
        return $this->url;
    }

    public function getApiKey(): string
    {
        return $this->apiKey;
    }

    public function getTimeout(): int
    {
        return $this->timeout;
    }

    public function setTimeout(int $seconds): void
    {
        $this->timeout = $seconds;
    }
}
