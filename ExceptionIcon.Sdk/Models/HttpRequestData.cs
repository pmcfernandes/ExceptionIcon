using System.Collections.Generic;
using System.Web;

namespace ExceptionIcon.Models
{
    public class HttpRequestData
    {
        public HttpRequestData()
        {

        }

        /// <summary>
        /// Initializes a new instance of the <see cref="HttpRequestData"/> class.
        /// </summary>
        /// <param name="context">The context.</param>
        public HttpRequestData(HttpContext context)
            : base()
        {
            LoadContext(context);
        }

        /// <summary>
        /// Loads the context.
        /// </summary>
        /// <param name="context">The context.</param>
        private void LoadContext(HttpContext context)
        {
            HttpRequest request = context.Request;

            Schema = request.Url.Scheme;
            Host = request.Url.Host + (request.Url.IsDefaultPort ? "":  ":" +  request.Url.Port);
            Method = request.PathInfo;
            Protocol = request.HttpMethod;
            Path = request.Url.AbsolutePath;
            QueryString = request.Url.Query;

            foreach (string key in request.QueryString)
            {
                Query.Add(key, request.QueryString.Get(key));
            }

            foreach (var key in request.Cookies.AllKeys)
            {
                Cookies.Add(key, request.Cookies.Get(key).Value);
            }

            foreach (var key in request.Headers.AllKeys)
            {
                Headers.Add(key, request.Headers.Get(key));
            }

            foreach (string key in context.Session.Keys)
            {
                Session.Add(key, context.Session[key].ToString());
            }
        }

        /// <summary>
        /// Gets the host.
        /// </summary>
        /// <value>
        /// The host.
        /// </value>
        public string Host
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the method.
        /// </summary>
        /// <value>
        /// The method.
        /// </value>
        public string Method
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the path.
        /// </summary>
        /// <value>
        /// The path.
        /// </value>
        public string Path
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the protocol.
        /// </summary>
        /// <value>
        /// The protocol.
        /// </value>
        public string Protocol
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the query string.
        /// </summary>
        /// <value>
        /// The query string.
        /// </value>
        public string QueryString
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the schema.
        /// </summary>
        /// <value>
        /// The schema.
        /// </value>
        public string Schema
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the query.
        /// </summary>
        /// <value>
        /// The query.
        /// </value>
        public IDictionary<string, string> Query
        {
            get;
            private set;
        } = new Dictionary<string, string>();

        /// <summary>
        /// Gets the session.
        /// </summary>
        /// <value>
        /// The session.
        /// </value>
        public IDictionary<string, string> Session
        {
            get;
            private set;
        } = new Dictionary<string, string>();

        /// <summary>
        /// Gets the cookies.
        /// </summary>
        /// <value>
        /// The cookies.
        /// </value>
        public IDictionary<string, string> Cookies
        {
            get;
            private set;
        } = new Dictionary<string, string>();

        /// <summary>
        /// Gets the headers.
        /// </summary>
        /// <value>
        /// The headers.
        /// </value>
        public IDictionary<string, string> Headers
        {
            get;
            private set;
        } = new Dictionary<string, string>();
    }
}