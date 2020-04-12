using Newtonsoft.Json;
using System;

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

        [JsonProperty("exceptionType")]
        public string ExceptionType { get; set; }

        [JsonProperty("message")]
        public string Message { get; set; }

        [JsonProperty("stackTrace")]
        public string StackTrace { get; set; }

        [JsonProperty("dateOccurred")]
        public DateTime DateOccurred { get; set; }

        [JsonProperty("isResolved")]
        public bool IsResolved { get; set; }


    }
}