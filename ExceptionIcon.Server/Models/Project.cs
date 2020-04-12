using Newtonsoft.Json;
using System;

namespace ExceptionIcon.Server.Models
{
    public class Project
    {
        [JsonProperty("uuid")]
        public Guid UUID { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("apiKey")]
        public string ApiKey { get; set; }
    }
}