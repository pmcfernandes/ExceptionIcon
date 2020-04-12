using CSoft.Data;
using System;
using System.Web.Http;

namespace ExceptionIcon.Server
{
    public class Global : CSoft.Web.Mvc.HttpApplication
    {

        /// <summary>
        /// Initializes a new instance of the <see cref="Global"/> class.
        /// </summary>
        public Global()
            : base()
        {
            this.UseMvc = false;
            this.UseWebApi = true;
        }

        /// <summary>
        /// Handles the Start event of the Session control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Session_Start(object sender, EventArgs e)
        {
            DatabaseWeb.Init();
        }

        protected override void RegisterApiRoutes(HttpConfiguration config)
        {
            config.EnableCors();

            base.RegisterApiRoutes(config);
        }
    }
}