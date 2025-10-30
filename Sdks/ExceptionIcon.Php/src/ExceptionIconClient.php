<?php

namespace ExceptionIcon;

use GuzzleHttp\Client as GuzzleClient;
use GuzzleHttp\Exception\GuzzleException;

class ExceptionIconClient
{
    private $http;
    private $options;

    public function __construct(ExceptionIconOptions $options)
    {
        $this->options = $options;
        $this->http = new GuzzleClient([
            'base_uri' => rtrim($options->getUrl(), '/') . '/api/',
            'timeout' => $options->getTimeout()
        ]);
    }

    /**
     * Send an exception payload to the API
     *
     * @param array $payload
     * @return array|null
     * @throws GuzzleException
     */
    public function captureException(array $payload): ?array
    {
        $headers = [
            'Accept' => 'application/json'
        ];

        if ($this->options->getApiKey()) {
            $headers['Authorization'] = 'Bearer ' . $this->options->getApiKey();
        }

        $response = $this->http->post('exceptions', [
            'json' => $payload,
            'headers' => $headers
        ]);

        $body = (string)$response->getBody();
        $data = json_decode($body, true);

        return is_array($data) ? $data : null;
    }
}
