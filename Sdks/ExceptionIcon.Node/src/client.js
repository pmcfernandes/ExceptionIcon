const fetch = require('node-fetch');

class ExceptionIconClient {
  constructor(options) {
    this.url = options.url.replace(/\/$/, '') + '/api/';
    this.apiKey = options.apiKey || '';
    this.timeout = options.timeout || 5000;
  }

  async captureException(payload) {
    const headers = { 'Accept': 'application/json', 'Content-Type': 'application/json' };
    if (this.apiKey) headers['Authorization'] = `Bearer ${this.apiKey}`;

    const res = await fetch(this.url + 'exceptions', {
      method: 'POST',
      body: JSON.stringify(payload),
      headers,
      timeout: this.timeout
    });

    if (!res.ok) {
      const body = await res.text();
      throw new Error(`API responded with ${res.status}: ${body}`);
    }

    return res.json();
  }
}

module.exports = ExceptionIconClient;
