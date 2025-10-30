using Newtonsoft.Json;
using System;

namespace ExceptionIcon.Server.Models
{
    public class UserAuthorization
    {
        [JsonProperty("username")]
        public string Username { get; set; }

        [JsonProperty("uuid")]
        public Guid UUID { get; set; }
    }
}