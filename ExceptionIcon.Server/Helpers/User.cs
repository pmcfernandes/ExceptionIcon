using CSoft.Data;
using System;
using System.Net.Http.Headers;

namespace ExceptionIcon.Server.Helpers
{
    public class User
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="User"/> class.
        /// </summary>
        /// <param name="Database">The database.</param>
        public User(CSoft.Data.Database Database)
        {
            this.Database = Database;
        }

        /// <summary>
        /// Gets the database.
        /// </summary>
        /// <value>
        /// The database.
        /// </value>
        public CSoft.Data.Database Database
        {
            get;
            private set;
        }

        /// <summary>
        /// Determines whether the specified authorization is auhtorized.
        /// </summary>
        /// <param name="authorization">The authorization.</param>
        /// <param name="IdUser">The identifier user.</param>
        /// <returns>
        ///   <c>true</c> if the specified authorization is auhtorized; otherwise, <c>false</c>.
        /// </returns>
        public bool IsAuhtorized(AuthenticationHeaderValue authorization, out int IdUser)
        {
            if (authorization != null && authorization.Scheme == "Bearer" && !String.IsNullOrEmpty(authorization.Parameter))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_GetUserByUUID");
                proc.AddInputWithValue("UUID", authorization.Parameter);
                
                try
                {
                    IdUser = proc.ExecuteScalar<int>();
                }
                catch
                {
                    IdUser = 0;
                }

                return IdUser != 0;
            }

            IdUser = 0;
            return false;
        }
    }
}