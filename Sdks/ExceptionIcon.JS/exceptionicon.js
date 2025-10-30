export class ExceptionIconOptions {
  constructor({ url = 'http://localhost:44345', apiKey = '' } = {}) {
    this.url = url.replace(/\/$/, '');
    this.apiKey = apiKey;
  }
}

export class ExceptionIconClient {
  constructor(options) {
    this.options = options;
    this.baseUrl = this.options.url + '/api/';
  }

  async captureException(payload) {
    const headers = new Headers({ 'Accept': 'application/json', 'Content-Type': 'application/json' });
    if (this.options.apiKey) headers.set('Authorization', `Bearer ${this.options.apiKey}`);

    const resp = await fetch(this.baseUrl + 'exceptions', {
      method: 'POST',
      headers,
      body: JSON.stringify(payload),
      credentials: 'same-origin'
    });

    if (!resp.ok) {
      const text = await resp.text();
      throw new Error(`API error ${resp.status}: ${text}`);
    }

    return resp.json();
  }
}

// Convenience helpers -------------------------------------------------------

function _errorToPayload(message, source, lineno, colno, error) {
  return {
    message: message || (error && error.message) || 'Unknown error',
    type: (error && error.name) || 'Error',
    stackTrace: (error && error.stack) || `${source || ''}:${lineno || 0}:${colno || 0}`,
    url: (typeof location !== 'undefined' && location.href) || '',
    timeOccurred: new Date().toISOString()
  };
}

/**
 * Install a window.onerror handler that forwards errors to the provided client.
 * Returns an uninstall function that restores the previous handler.
 */
export function captureWindowErrors(client) {
  if (typeof window === 'undefined') return () => {};

  const previous = window.onerror;

  window.onerror = async function (message, source, lineno, colno, error) {
    try {
      const payload = _errorToPayload(message, source, lineno, colno, error);
      await client.captureException(payload);
    } catch (e) {
      // swallow
    }

    if (typeof previous === 'function') {
      try { return previous.apply(this, arguments); } catch (e) { return false; }
    }

    return false;
  };

  return function uninstall() {
    window.onerror = previous;
  };
}

/**
 * Install a handler for unhandledrejection events (Promise rejections).
 * Returns an uninstall function.
 */
export function captureUnhandledRejections(client) {
  if (typeof window === 'undefined' || typeof window.addEventListener !== 'function') return () => {};

  const handler = async function (event) {
    try {
      const reason = event && event.reason;
      const payload = {
        message: (reason && reason.message) || String(reason) || 'Unhandled rejection',
        type: (reason && reason.name) || 'UnhandledRejection',
        stackTrace: (reason && reason.stack) || '',
        url: (typeof location !== 'undefined' && location.href) || '',
        timeOccurred: new Date().toISOString()
      };

      await client.captureException(payload);
    } catch (e) {
      // swallow
    }
  };

  window.addEventListener('unhandledrejection', handler);

  return function uninstall() {
    window.removeEventListener('unhandledrejection', handler);
  };
}

/**
 * Convenience installer: enables automatic capture for window errors and unhandled rejections.
 * Returns an uninstall function that removes all handlers installed by this call.
 */
export function installAutoCapture(client, { onError = true, onUnhandledRejection = true } = {}) {
  const uninstallers = [];

  if (onError) uninstallers.push(captureWindowErrors(client));
  if (onUnhandledRejection) uninstallers.push(captureUnhandledRejections(client));

  return function uninstallAll() {
    for (const u of uninstallers) {
      try { u(); } catch (e) { /* ignore */ }
    }
  };
}
