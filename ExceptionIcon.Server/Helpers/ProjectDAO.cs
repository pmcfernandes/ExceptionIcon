using CSoft.Data;
using System;

namespace ExceptionIcon.Server.Helpers
{
    public class ProjectDAO: IDisposable
    {
        private CSoft.Data.Database m_Database;

        /// <summary>
        /// Initializes a new instance of the <see cref="ProjectDAO"/> class.
        /// </summary>
        /// <param name="Database">The database.</param>
        public ProjectDAO(CSoft.Data.Database Database)
        {
            m_Database = Database;
        }

        /// <summary>
        /// Gets the project by API.
        /// </summary>
        /// <param name="key">The key.</param>
        /// <returns></returns>
        public Guid GetProjectByAPI(string key)
        {
            using (StoredProcedure proc = new StoredProcedure(m_Database, "sp_GetProjectByAPIKey"))
            {
                proc.AddInputWithValue("APIKey", key);
                return proc.ExecuteScalar<Guid>();
            }
        }

        #region IDisposable Support

        private bool disposed = false; 

        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                disposed = true;
            }
        }

        // This code added to correctly implement the disposable pattern.
        public void Dispose()
        {
            Dispose(true);
        }

        #endregion
    }
}