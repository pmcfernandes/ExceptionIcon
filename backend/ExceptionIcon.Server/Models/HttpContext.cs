using Newtonsoft.Json;
using System.Collections.Generic;

namespace ExceptionIcon.Server.Models
{
    public class HttpContext
    {

        [JsonProperty("host")]
        public string Host { get; set; }

        [JsonProperty("schema")]
        public string Schema { get; set; }

        [JsonProperty("method")]
        public string Method { get; set; }

        [JsonProperty("protocol")]
        public string Protocol { get; set; }

        [JsonProperty("path")]
        public string Path { get; set; }

        [JsonProperty("queryString")]
        public string QueryString { get; set; }

        [JsonProperty("query")]
        public IDictionary<string, string> Query { get; set; } = new Dictionary<string, string>();

        [JsonProperty("cookies")]
        public IDictionary<string, string> Cookies { get; set; } = new Dictionary<string, string>();

        [JsonProperty("headers")]
        public IDictionary<string, string> Headers { get; set; } = new Dictionary<string, string>();

        [JsonProperty("session")]
        public IDictionary<string, string> Session { get; set; } = new Dictionary<string, string>();
    }
}