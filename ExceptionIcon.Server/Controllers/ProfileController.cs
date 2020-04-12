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
    public class ProfileController : ApiBaseController
    {
        private User user;

        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            user = new User(Database);
        }

        [HttpGet]
        [Route("api/profile")]
        public IHttpActionResult GetProfile()
        {
            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser))
            {
                StoredProcedure proc = new StoredProcedure(Database, "sp_GetProfile");
                proc.AddInputWithValue("IDUser", IdUser);

                try
                {
                    return Ajs(proc.Map<Profile>());
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
        [Route("api/profile")]
        public IHttpActionResult UpdateProfile([FromBody] Profile profile)
        {
            if (user.IsAuhtorized(Request.Headers.Authorization, out int IdUser) && profile.Password == profile.ConfirmPassword)
            {
                string strPassword = null;

                if (!String.IsNullOrEmpty(profile.Password) && !String.IsNullOrEmpty(profile.ConfirmPassword))
                {
                    if (profile.Password == profile.ConfirmPassword)
                    {
                        strPassword = CSoft.Core.Security.PasswordHelper.ToMd5(profile.Password); 
                    }
                    else
                    {
                        return Unauthorized();
                    }
                }

                StoredProcedure proc = new StoredProcedure(Database, "sp_UpdateProfile");
                proc.AddInputWithValue("IDUser", IdUser);
                proc.AddInputWithValue("Name", profile.Name);
                proc.AddInputWithValue("Email", profile.Email);
                proc.AddInputWithValue("Password", strPassword);

                try
                {
                    return Ajs(proc.MapList<Profile>());
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
    }
}
