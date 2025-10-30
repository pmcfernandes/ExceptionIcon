using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExceptionIcon.Server.Models
{
    public class IssuesByProject
    {
        [JsonProperty("total")]
        public int Total { get; set; }

        [JsonProperty("lastUUID")]
        public Guid LastUUID { get; set; }

        [JsonProperty("lastOccurred")]
        public DateTime LastOccurred { get; set; }

        [JsonProperty("exceptionType")]
        public string ExceptionType { get; set; }

        [JsonProperty("message")]
        public string Message { get; set; }

        [JsonProperty("totalActives")]
        public int TotalActive { get; set; }
    }
}