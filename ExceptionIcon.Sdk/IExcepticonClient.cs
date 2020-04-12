using ExceptionIcon.Models;

namespace ExceptionIcon
{
    public interface IExceptionIconClient
    {
        /// <summary>
        /// Captures the exception.
        /// </summary>
        /// <param name="instance">The instance.</param>
        void CaptureException(ExceptionInstance instance);

        /// <summary>
        /// Releases unmanaged and - optionally - managed resources.
        /// </summary>
        void Dispose();
    }
}