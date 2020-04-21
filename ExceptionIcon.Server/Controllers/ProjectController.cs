using CSoft.Data;
using CSoft.Web.Mvc.Controllers;
using ExceptionIcon.Server.Helpers;
using ExceptionIcon.Server.Models;
using System;
using System.Text;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Cors;

namespace ExceptionIcon.Server.Controllers
{
#if DEBUG
    [EnableCors("*", "*", "*")]
#endif
    public class ProjectController : ApiBaseController
    {
        private User user;

        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            user = new User(Database);
        }

        [HttpGet]
        [Route("api/projects")]
        public IHttpActionResult GetProjects()
        {
            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_GetProjectsByUser");
                proc.AddInputWithValue("IDUser", IdUser);

                try
                {
                    return Ajs(proc.MapList<ProjectByUser>());
                }
                catch (Exception ex)
                {
                    return AjsError(ex.Message);
                }
            }
            else
            {
                return Unauthorized();
            }
        }

        [HttpGet]
        [Route("api/projects")]
        public IHttpActionResult GetProject([FromUri] Guid uuid)
        {
            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_GetProject");
                proc.AddInputWithValue("UUID", uuid);

                try
                {
                    return Ajs(proc.Map<Project>());
                }
                catch (Exception ex)
                {
                    return AjsError(ex.Message);
                }
            }
            else
            {
                return Unauthorized();
            }
        }

        [HttpPost]
        [Route("api/projects")]
        public IHttpActionResult CreateProject([FromBody] Project project)
        {
            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_InsertProject");
                proc.AddInputWithValue("Name", project.Name);
                proc.AddInputWithValue("IDUser", IdUser);

                try
                {
                    project.UUID = proc.ExecuteScalar<Guid>();
                    return Ajs(project);
                }
                catch (Exception ex)
                {
                    return AjsError(ex.Message);
                }
            }
            else
            {
                return Unauthorized();
            }
        }

        [HttpPut]
        [Route("api/projects")]
        public IHttpActionResult UpdateProject([FromUri] Guid uuid, [FromBody] Project project)
        {
            project.UUID = uuid;

            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_UpdateProject");
                proc.AddInputWithValue("UUID", project.UUID);
                proc.AddInputWithValue("Name", project.Name);

                try
                {
                    proc.ExecuteNonQuery();
                    return Ajs(project);
                }
                catch (Exception ex)
                {
                    return AjsError(ex.Message);
                }
            }
            else
            {
                return Unauthorized();
            }
        }

        [HttpDelete]
        [Route("api/projects")]
        public IHttpActionResult DeleteProject([FromUri] Guid uuid)
        {
            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_DeleteProject");
                proc.AddInputWithValue("UUID", uuid);

                try
                {
                    proc.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    return AjsError(ex.Message);
                }

                return Ajs(null);
            }
            else
            {
                return Unauthorized();
            }
        }

        [HttpPatch]
        [Route("api/projects/generateKey")]
        public IHttpActionResult GenerateApiKey([FromUri] Guid uuid)
        {
            string strApiKey = CSoft.Core.Security.Encryption.SHA1Hash(Guid.NewGuid().ToString(), Encoding.UTF8);

            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_UpdateProjectApiKey");
                proc.AddInputWithValue("UUID", uuid);
                proc.AddInputWithValue("ApiKey", strApiKey);

                try
                {
                    proc.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    return AjsError(ex.Message);
                }

                return Ajs(new Project()
                {
                    UUID = uuid,
                    ApiKey = strApiKey
                });
            }
            else
            {
                return Unauthorized();
            }
        }
    }
}
