const ExceptionIconClient = require('../src/client');
const Options = require('../src/options');
const ExceptionInstance = require('../src/models/ExceptionInstance');

(async () => {
  const opts = new Options({ url: 'http://localhost:44345', apiKey: 'your-api-key' });
  const client = new ExceptionIconClient(opts);

  const instance = new ExceptionInstance('Test exception from Node SDK', 'Error', 'stack trace here');

  try {
    const res = await client.captureException(instance.toJSON());
    console.log(res);
  } catch (err) {
    console.error('Error:', err.message);
  }
})();
