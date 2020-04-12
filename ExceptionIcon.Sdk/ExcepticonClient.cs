using ExceptionIcon.Helpers;
using ExceptionIcon.Models;
using Newtonsoft.Json;
using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace ExceptionIcon
{
    public class ExceptionIconClient : IExceptionIconClient, IDisposable
    {
        private ExceptionIconOptions options;

        /// <summary>
        /// Initializes a new instance of the <see cref="ExcepticonClient"/> class.
        /// </summary>
        /// <param name="options">The options.</param>
        public ExceptionIconClient(ExceptionIconOptions options)
        {
            this.options = options;
        }

        /// <summary>
        /// Captures the exception.
        /// </summary>
        /// <param name="instance">The instance.</param>
        /// <exception cref="System.ObjectDisposedException">ExcepticonClient</exception>
        public void CaptureException(ExceptionInstance instance)
        {
            if (disposed)
            {
                throw new ObjectDisposedException(nameof(ExceptionIconClient));
            }
            else
            {
                string key = options.ApiKey;

                var t = Task.Run(() => DoSendExceptionInstance(instance, key));
                t.Wait();
            }
        }

        /// <summary>
        /// Does the send exception instance.
        /// </summary>
        /// <param name="instance">The instance.</param>
        /// <param name="apiKey">The API key.</param>
        private async Task<string> DoSendExceptionInstance(ExceptionInstance instance, string apiKey)
        {
            using (HttpClient client = new HttpClient() { BaseAddress = new Uri(options.Url, UriKind.Absolute) })
            {
                StringContent content = new StringContent(JsonConvert.SerializeObject(instance));
                content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
                content.Headers.Add(CustomHeaders.ExceptionIconApiKey, apiKey);

                try
                {
                    HttpResponseMessage result = await client.PostAsync("/api/issues", content);

                    if (result.IsSuccessStatusCode)
                    {
                        var response = await result.Content.ReadAsStringAsync();
                        return response;
                    }
                    else
                    {
                        return "";
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        #region IDisposable Support

        private bool disposed = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposed)
                {

                }

                options = null;
                disposed = true;
            }
        }

        // This code added to correctly implement the disposable pattern.
        public void Dispose()
        {
            Dispose(true);
        }

        #endregion
    }
}
