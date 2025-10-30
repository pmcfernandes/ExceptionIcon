using System;
using System.Collections;
using System.Collections.Generic;

namespace ExceptionIcon.Models
{
    public class EnvironmentData
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="EnvironmentData"/> class.
        /// </summary>
        public EnvironmentData()
        {
            CurrentDirectory = Environment.CurrentDirectory;
            LoadEnvironmentVariables();
        }

        /// <summary>
        /// Loads the environment variables.
        /// </summary>
        private void LoadEnvironmentVariables()
        {
            foreach (DictionaryEntry de in Environment.GetEnvironmentVariables())
            {
                EnvironmentVariables.Add(de.Key.ToString(), de.Value.ToString());
            }
        }

        /// <summary>
        /// Gets or sets the current directory.
        /// </summary>
        /// <value>
        /// The current directory.
        /// </value>
        public string CurrentDirectory 
        {
            get;
            set; 
        }

        /// <summary>
        /// Gets the ASP net core features.
        /// </summary>
        /// <value>
        /// The ASP net core features.
        /// </value>
        public List<string> AspNetCoreFeatures
        {
            get;
            private set;
        } = new List<string>();

        /// <summary>
        /// Gets the environment variables.
        /// </summary>
        /// <value>
        /// The environment variables.
        /// </value>
        public Dictionary<string, string> EnvironmentVariables
        {
            get;
            private set;
        } = new Dictionary<string, string>();
    }
}
