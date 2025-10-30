# ExceptionIcon

ExceptionIcon is a small web application and API to collect and monitor .NET exceptions. The backend API is built in C# and the frontend UI is built with React.

You can use the included SDK to capture exceptions from your applications and send them to the ExceptionIcon API for centralized storage and analysis.

## Example

```csharp
var client = new ExceptionIconClient(new ExceptionIconOptions {
    ApiKey = "<your key>",
    Url = "<your url>"
});

try {
    // example that causes an error
    Console.Write("de".ToInt32().ToString());
} catch (Exception ex) {
    client.CaptureException(new ExceptionInstance(ex));
}
```

## Installation (quick)

1. Build the frontend React app:

    ```powershell
    cd frontend
    npm install
    npm run build
    ```

1. Deploy the backend API (for example, in IIS) and host the built React files (from `frontend/build`) where your frontend will be served.

1. Verify the API is running and the frontend can reach the API base URL.

1. Add the SDK to your application and configure it with your API URL and ApiKey.

## Default application credentials

For a local/dev install the default credentials are:

- Username: `admin`
- Password: `pedro`

(Change these defaults before using in production.)

## Notes

- The React app expects the API to be reachable at the configured base URL; update the frontend configuration or environment variables to match your deployment.
- Consider upgrading dependencies and scanning for security vulnerabilities (the project previously used an older axios version with known vulnerabilities; make sure dependencies are up-to-date before production use).
