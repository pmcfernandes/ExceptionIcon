using Newtonsoft.Json;

namespace ExceptionIcon.Server.Models
{
    public class Profile
    {
        [JsonProperty("username")]
        public string Username { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("email")]
        public string Email { get; set; }

        [JsonProperty("password")]
        public string Password { get; set; }

        [JsonProperty("confirmPassword")]
        public string ConfirmPassword { get; set; }
    }
}