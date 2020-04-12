using ExceptionIcon.Models;
using System;
using System.Threading;

namespace ExceptionIcon
{
    public class ExceptionIconSdk: IDisposable
    {
        private static ExceptionIconClient _client;

        /// <summary>
        /// Initializes the specified apikey.
        /// </summary>
        /// <param name="apikey">The apikey.</param>
        /// <returns></returns>
        public static IDisposable Init(string apikey)
        {
            return Init(new ExceptionIconOptions() { ApiKey = apikey });
        }

        /// <summary>
        /// Initializes the specified options.
        /// </summary>
        /// <param name="options">The options.</param>
        /// <returns></returns>
        public static IDisposable Init(ExceptionIconOptions options)
        {
            return UseClient(new ExceptionIconClient(options));
        }

        /// <summary>
        /// Captures the exception.
        /// </summary>
        /// <param name="ex">The ex.</param>
        public static void CaptureException(Exception ex)
        {
            _client.CaptureException(new ExceptionInstance(ex));
        }

        /// <summary>
        /// Uses the client.
        /// </summary>
        /// <param name="client">The client.</param>
        /// <returns></returns>
        private static IDisposable UseClient(ExceptionIconClient client)
        {
            var existingClient = Interlocked.Exchange(ref _client, client);
            existingClient?.Dispose();
            return _client;
        }

        #region IDisposable Support

        private bool disposed = false; 

        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    _client.Dispose();
                }

                _client = null;
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
