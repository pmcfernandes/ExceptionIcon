<?php

require __DIR__ . '/../vendor/autoload.php';

use ExceptionIcon\ExceptionIconClient;
use ExceptionIcon\ExceptionIconOptions;
use ExceptionIcon\Models\ExceptionInstance;

$options = new ExceptionIconOptions('http://localhost:5000', 'your-api-key');
$options->setTimeout(5);

$client = new ExceptionIconClient($options);

$e = new ExceptionInstance('Test exception from PHP SDK', 'System.Exception', "Stack trace here");

try {
    $result = $client->captureException($e->toArray());
    print_r($result);
} catch (Exception $ex) {
    echo 'Error: ' . $ex->getMessage();
}
