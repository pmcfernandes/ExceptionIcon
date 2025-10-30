class ExceptionIconOptions {
  constructor({ url = 'http://localhost:44345', apiKey = '', timeout = 5000 } = {}) {
    this.url = url;
    this.apiKey = apiKey;
    this.timeout = timeout;
  }
}

module.exports = ExceptionIconOptions;
