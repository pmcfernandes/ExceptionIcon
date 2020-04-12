using CSoft.Data;
using CSoft.Web.Mvc.Controllers;
using ExceptionIcon.Helpers;
using ExceptionIcon.Server.Helpers;
using ExceptionIcon.Server.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Cors;

namespace ExceptionIcon.Server.Controllers
{
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
                    Issue issue = null;

                    proc.OpenDataSetAsync(output =>
                    {
                        if (!output.NoRecords())
                        {
                            using (IDataReader reader = output.DataSet.Tables[0].CreateDataReader())
                            {
                                issue = CSoft.Data.DataMapper.Map<Issue>(reader);
                            }

                            foreach (DataRow row in output.DataSet.Tables[1].Rows)
                            {
                                issue.EnvironmentVariables.Add(row.Field<string>("Name"), row.Field<string>("Value"));
                            }

                            if (output.DataSet.Tables[2].Rows.Count == 0)
                            {
                                issue.HttpContext = null;
                            }
                            else
                            {
                                DataRow row = output.DataSet.Tables[2].Rows[0];

                                HttpContext context = new HttpContext();
                                context.Host = row.Field<string>("Host");
                                context.Path = row.Field<string>("Path");
                                context.Protocol = row.Field<string>("Protocol");
                                context.Schema = row.Field<string>("Schema");
                                context.Method = row.Field<string>("Method");
                                context.QueryString = row.Field<string>("QueryString");

                                if (!row.IsNull("Query")) context.Query = JsonConvert.DeserializeObject<Dictionary<string, string>>(row.Field<string>("Query"));
                                if (!row.IsNull("Cookies")) context.Cookies = JsonConvert.DeserializeObject<Dictionary<string, string>>(row.Field<string>("Cookies"));
                                if (!row.IsNull("Headers")) context.Headers = JsonConvert.DeserializeObject<Dictionary<string, string>>(row.Field<string>("Headers"));
                                if (!row.IsNull("Session")) context.Session = JsonConvert.DeserializeObject<Dictionary<string, string>>(row.Field<string>("Session"));

                                issue.HttpContext = context;
                            }
                        }
                    });

                    return Ajs(issue);
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
        [Route("api/issues")]
        [EnableCors("*", CustomHeaders.ExceptionIconApiKey, "*")]
        public IHttpActionResult InsertIssue([FromBody] ExceptionIcon.Models.ExceptionInstance data)
        {
            if (Request.Headers.TryGetValues(CustomHeaders.ExceptionIconApiKey, out IEnumerable<string> values))
            {
                using (ProjectDAO project = new ProjectDAO(Database))
                {
                    Guid projectUUID = project.GetProjectByAPI(values.FirstOrDefault());

                    if (projectUUID != Guid.Empty)
                    {
                        StoredProcedure proc = new StoredProcedure(Database, "sp_InsertIssue");
                        proc.AddInputWithValue("ProjectUUID", projectUUID);
                        proc.AddInputWithValue("ExceptionType", data.Type);
                        proc.AddInputWithValue("Source", data.Source);
                        proc.AddInputWithValue("Message", data.Message);
                        proc.AddInputWithValue("StackTrace", data.StackTrace);
                        proc.AddInputWithValue("Type", data.Type);
                        proc.AddInputWithValue("FullyQualifiedType", data.FullyQualifiedType);
                        proc.AddInputWithValue("DeclaringTypeFullName", data.TargetSite.DeclaringTypeFullName);
                        proc.AddInputWithValue("DeclaringTypeName", data.TargetSite.DeclaringTypeName);
                        proc.AddInputWithValue("MemberType", data.TargetSite.MemberType);
                        proc.AddInputWithValue("TargetSite", data.TargetSite.Name);
                        proc.AddInputWithValue("CurrentDirectory", data.Environment.CurrentDirectory);
                        proc.AddInputWithValue("DateOccurred", data.TimeOccurred);
                        proc.AddInputWithValue("IsResolved", false);
                        proc.AddInputWithValue("IsDeleted", false);

                        try
                        {
                            Guid uuid = proc.ExecuteScalar<Guid>();

                            if (uuid != Guid.Empty)
                            {
                                StoredProcedure proc1 = new StoredProcedure(Database, "sp_InsertIssueHttpContext");
                                proc1.AddInputWithValue("UUID", uuid);
                                proc1.AddInputWithValue("Host", data.HttpRequest.Host);
                                proc1.AddInputWithValue("Schema", data.HttpRequest.Schema);
                                proc1.AddInputWithValue("Method", data.HttpRequest.Method);
                                proc1.AddInputWithValue("Protocol", data.HttpRequest.Protocol);
                                proc1.AddInputWithValue("Path", data.HttpRequest.Path);
                                proc1.AddInputWithValue("QueryString", data.HttpRequest.QueryString);
                                proc1.AddInputWithValue("Query", JsonConvert.SerializeObject(data.HttpRequest.Query));
                                proc1.AddInputWithValue("Cookies", JsonConvert.SerializeObject(data.HttpRequest.Cookies));
                                proc1.AddInputWithValue("Headers", JsonConvert.SerializeObject(data.HttpRequest.Headers));
                                proc1.AddInputWithValue("Session", JsonConvert.SerializeObject(data.HttpRequest.Session));

                                try
                                {
                                    proc1.ExecuteNonQuery();
                                }
                                catch (Exception ex)
                                {
                                }

                                foreach (var item in data.Environment.EnvironmentVariables)
                                {
                                    StoredProcedure proc2 = new StoredProcedure(Database, "sp_InsertIssueEnvironmentVariables");
                                    proc2.AddInputWithValue("UUID", uuid);
                                    proc2.AddInputWithValue("Name", item.Key);
                                    proc2.AddInputWithValue("Value", item.Value);

                                    try
                                    {
                                        proc2.ExecuteNonQuery();
                                    }
                                    catch (Exception ex)
                                    {
                                    }
                                }
                            }

                            return Ajs(new Issue() { UUID = uuid });
                        }
                        catch (Exception ex)
                        {
                            return AjsError(ex);
                        }
                    }
                }
            }

            return Unauthorized();
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
