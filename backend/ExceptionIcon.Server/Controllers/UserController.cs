using CSoft.Data;
using CSoft.Web.Mvc.Controllers;
using ExceptionIcon.Server.Models;
using System;
using System.Web.Http;
using System.Web.Http.Cors;

namespace ExceptionIcon.Server.Controllers
{
#if DEBUG
    [EnableCors("*", "*", "*")]
#endif
    public class UserController : ApiBaseController
    {
        [HttpPost]
        [Route("api/login")]
        public IHttpActionResult Login([FromBody] Login login)
        {
            if (String.IsNullOrEmpty(login.Password))
            {
                return Unauthorized();
            }
            else
            {
                string strPassword = CSoft.Core.Security.PasswordHelper.ToMd5(login.Password);

                StoredProcedure proc = new StoredProcedure(Database, "sp_Login");
                proc.AddInputWithValue("Username", login.Username);
                proc.AddInputWithValue("Password", strPassword);

                try
                {
                    UserAuthorization userAuthorization = proc.Map<UserAuthorization>();

                    if (Guid.Empty != userAuthorization.UUID)
                    {
                        return Ajs(userAuthorization); 
                    }

                    return Unauthorized();
                }
                catch (Exception ex)
                {
                    return AjsError(ex.Message);
                }
            }
        }
    }
}