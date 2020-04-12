using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExceptionIcon.Server.Models
{
    public class ProjectByUser
    {
        [JsonProperty("uuid")]
        public Guid UUID { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("lastError")]
        public string LastError { get; set; }

        [JsonProperty("lastOccurred")]
        public DateTime LastTimeOccurred { get; set; }

        [JsonProperty("totalActives")]
        public int TotalActive { get; set; }

        [JsonProperty("total")]
        public int Total { get; set; }

        [JsonProperty("avg")]
        public int Avg { get; set; }
    }
}