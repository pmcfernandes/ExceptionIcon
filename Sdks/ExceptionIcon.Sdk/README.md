# ExceptionIcon C# SDK

This folder contains the ExceptionIcon SDK for .NET (C#). It provides a thin client to send exceptions to the ExceptionIcon API.

## Quick start

1. Add the SDK project (`ExceptionIcon.Sdk`) to your solution or compile the project and reference the resulting assembly.
2. Configure the `ExceptionIconOptions` with your API URL and ApiKey.

## Example

```csharp
using System;
using ExceptionIcon;
using ExceptionIcon.Models;

class Program
{
    static void Main(string[] args)
    {
        var options = new ExceptionIconOptions {
            ApiKey = "<your-api-key>",
            Url = "http://localhost:44345"
        };

        using (var client = new ExceptionIconClient(options))
        {
            try
            {
                // cause a sample exception
                var x = int.Parse("not-a-number");
            }
            catch (Exception ex)
            {
                var instance = new ExceptionInstance(ex);
                client.CaptureException(instance);
            }
        }
    }
}
```

## Notes

- The SDK sends exceptions to `POST /api/issues` on the configured `Url` (it uses `HttpClient` internally).
- The SDK sets a custom header with the API key: `X-ExceptionIcon-ApiKey` (see `Helpers/CustomHeaders.cs`).
- The example uses the synchronous `CaptureException` which internally runs a task to post the exception.

If you'd like, I can add a NuGet packaging manifest and CI pipeline to publish this SDK.
