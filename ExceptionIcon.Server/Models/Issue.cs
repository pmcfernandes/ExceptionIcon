using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace ExceptionIcon.Server.Models
{
    public class Issue
    {
        [JsonProperty("uuid")]
        public Guid UUID { get; set; }

        [JsonProperty("projectName")]
        public string ProjectName { get; set; }

        [JsonProperty("number")]
        public int Number { get; set; }

        [JsonProperty("source")]
        public string Source { get; set; }

        [JsonProperty("exceptionType")]
        public string ExceptionType { get; set; }

        [JsonProperty("message")]
        public string Message { get; set; }

        [JsonProperty("stackTrace")]
        public string StackTrace { get; set; }

        //[JsonProperty("parsedStackTrace")]
        //public dynamic ParsedStackTrace { get; set; }

        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("fullyQualifiedType")]
        public string FullyQualifiedType { get; set; }

        [JsonProperty("declaringTypeFullName")]
        public string DeclaringTypeFullName { get; set; }

        [JsonProperty("declaringTypeName")]
        public string DeclaringTypeName { get; set; }

        [JsonProperty("memberType")]
        public string MemberType { get; set; }

        [JsonProperty("targetSite")]
        public string TargetSite { get; set; }

        [JsonProperty("currentDirectory")]
        public string CurrentDirectory { get; set; }

        [JsonProperty("dateOccurred")]
        public DateTime DateOccurred { get; set; }

        [JsonProperty("isResolved")]
        public bool IsResolved { get; set; }

        [JsonProperty("httpContext")]
        public HttpContext HttpContext { get; set; } = new HttpContext();

        [JsonProperty("environmentVariables")]
        public IDictionary<string, string> EnvironmentVariables { get; set; } = new Dictionary<string, string>();
    }
}