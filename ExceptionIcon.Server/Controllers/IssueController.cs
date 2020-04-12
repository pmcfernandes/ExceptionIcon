using CSoft.Data;
using CSoft.Web.Mvc.Controllers;
using ExceptionIcon.Server.Helpers;
using ExceptionIcon.Server.Models;
using System;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Cors;

namespace ExceptionIcon.Server.Controllers
{
    [EnableCors("*", "*", "*")]
    public class IssueController : ApiBaseController
    {
        private User user;

        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            user = new User(Database);
        }

        [HttpGet]
        [Route("api/issues")]
        public IHttpActionResult GetIssuesByProject([FromUri] Guid projectUUID, [FromUri] bool includeResolved = false)
        {
            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_GetIssuesByProject");
                proc.AddInputWithValue("UUID", projectUUID);
                proc.AddInputWithValue("IncludeResolved", includeResolved);

                try
                {
                    return Ajs(proc.MapList<IssuesByProject>());
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
        [Route("api/issues")]
        public IHttpActionResult GetIssue([FromUri] Guid uuid)
        {
            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_GetIssue");
                proc.AddInputWithValue("UUID", uuid);

                try
                {
                    return Ajs(proc.Map<Issue>());
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

        [HttpPatch]
        [Route("api/issues/markResolved")]
        public IHttpActionResult MarkResolved([FromUri] Guid uuid)
        {
            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_UpdateMarkIssues");
                proc.AddInputWithValue("UUID", uuid);
                proc.AddInputWithValue("MarkAsResolved", true);
                proc.AddInputWithValue("MarkAll", true);

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
        [Route("api/issues/markActive")]
        public IHttpActionResult MarkActive([FromUri] Guid uuid)
        {
            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_UpdateMarkIssues");
                proc.AddInputWithValue("UUID", uuid);
                proc.AddInputWithValue("MarkAsResolved", false);
                proc.AddInputWithValue("MarkAll", true);

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
        [Route("api/issues/markAllResolved")]
        public IHttpActionResult MarkAllResolved([FromUri] Guid projectUUID)
        {
            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_UpdateMarkIssuesByProject");
                proc.AddInputWithValue("UUID", projectUUID);
                proc.AddInputWithValue("MarkAsResolved", true);

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
    }

}
