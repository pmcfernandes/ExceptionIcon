# ExceptionIcon Node SDK

Minimal Node.js SDK for ExceptionIcon.

Install

```bash
cd Sdks/ExceptionIcon.Node
npm install
```

Usage example

```js
const ExceptionIconClient = require('@exceptionicon/sdk-node');
const Options = require('./src/options');
const ExceptionInstance = require('./src/models/ExceptionInstance');

const opts = new Options({ url: 'http://localhost:44345', apiKey: 'your-api-key' });
const client = new ExceptionIconClient(opts);

const instance = new ExceptionInstance('Test exception from Node SDK', 'Error', 'stack trace here');
client.captureException(instance.toJSON()).then(console.log).catch(console.error);
```

Notes

- Uses `node-fetch` for HTTP. For Node 18+ you can use the native fetch API and remove the dependency.
- This SDK is intentionally minimal; extend models and helpers as needed.
