using System;
using System.Web;

namespace ExceptionIcon.Models
{
    public class ExceptionInstance
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ExceptionInstance"/> class.
        /// </summary>
        public ExceptionInstance()
        {

        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ExceptionInstance"/> class.
        /// </summary>
        /// <param name="ex">The ex.</param>
        public ExceptionInstance(Exception ex)
            : base()
        {
            LoadException(ex);
        }

        /// <summary>
        /// Loads the exception.
        /// </summary>
        /// <param name="ex">The ex.</param>
        private void LoadException(Exception ex)
        {
            TargetSite = new TargetSite(ex.TargetSite);
            Environment = new EnvironmentData();

            Source = ex.Source;
            Message = ex.Message;
            StackTrace = ex.StackTrace;
            TimeOccurred = DateTimeOffset.UtcNow;

            LoadType(ex.GetType());

            if (HttpContext.Current != null)
            {
                HttpRequest = new HttpRequestData(HttpContext.Current);
            }
        }

        /// <summary>
        /// Loads the type.
        /// </summary>
        /// <param name="type">The type.</param>
        private void LoadType(Type type)
        {
            Type = type.Name;
            FullyQualifiedType = type.FullName;
        }

        /// <summary>
        /// Gets or sets the source.
        /// </summary>
        /// <value>
        /// The source.
        /// </value>
        public string Source
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the message.
        /// </summary>
        /// <value>
        /// The message.
        /// </value>
        public string Message
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the stack trace.
        /// </summary>
        /// <value>
        /// The stack trace.
        /// </value>
        public string StackTrace
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the target site.
        /// </summary>
        /// <value>
        /// The target site.
        /// </value>
        public TargetSite TargetSite
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the time occurred.
        /// </summary>
        /// <value>
        /// The time occurred.
        /// </value>
        public DateTimeOffset TimeOccurred
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the type.
        /// </summary>
        /// <value>
        /// The type.
        /// </value>
        public string Type
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the type of the fully qualified.
        /// </summary>
        /// <value>
        /// The type of the fully qualified.
        /// </value>
        public string FullyQualifiedType
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the environment.
        /// </summary>
        /// <value>
        /// The environment.
        /// </value>
        public EnvironmentData Environment
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the HTTP request.
        /// </summary>
        /// <value>
        /// The HTTP request.
        /// </value>
        public HttpRequestData HttpRequest
        {
            get;
            set;
        }
    }
}