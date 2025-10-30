# ExceptionIcon JS (Vanilla)

This is a tiny browser-friendly SDK written as an ES module. It can be dropped into a static site or imported from modern bundlers.

Usage

1. Serve the files from a static server (or your app).
2. Open `examples/example.html` in a browser and update the API `url` and `apiKey` in the script.

Notes

- Uses the browser Fetch API; ensure the backend supports CORS if the API is on another origin.
- The module exports `ExceptionIconClient` and `ExceptionIconOptions`, plus convenience helpers:
	- `captureWindowErrors(client)` — installs `window.onerror` capture.
	- `captureUnhandledRejections(client)` — installs `unhandledrejection` capture.
	- `installAutoCapture(client)` — installs both and returns an `uninstall` function.

Auto-capture example

```html
<script type="module">
	import { ExceptionIconOptions, ExceptionIconClient, installAutoCapture } from '../exceptionicon.js';

	const opts = new ExceptionIconOptions({ url: 'http://localhost:44345', apiKey: 'your-api-key' });
	const client = new ExceptionIconClient(opts);

	// Install automatic capture (returns uninstall function)
	const uninstall = installAutoCapture(client);

	// To stop capturing later: uninstall();
</script>
```
