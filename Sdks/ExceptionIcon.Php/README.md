# ExceptionIcon PHP SDK

This folder contains a minimal PHP SDK for ExceptionIcon.

Installation

```bash
cd Sdks/ExceptionIcon.Php
composer install
```

Usage

```php
require 'vendor/autoload.php';

use ExceptionIcon\ExceptionIconClient;
use ExceptionIcon\ExceptionIconOptions;
use ExceptionIcon\Models\ExceptionInstance;

$options = new ExceptionIconOptions('http://your-api', 'your-api-key');
$client = new ExceptionIconClient($options);

$instance = new ExceptionInstance('Example error', 'System.Exception', 'stack trace');
$client->captureException($instance->toArray());
```

Notes

- This SDK uses Guzzle for HTTP calls.
- It is intentionally minimal; add models and helpers as needed.
