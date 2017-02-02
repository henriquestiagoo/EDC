using EDC_ProjetoFinal.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDC_ProjetoFinal.Personal
{
    public partial class AllReviews : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /* Admin Function! If Not authenticated or Admin, redirect to default page */
            if (!User.Identity.IsAuthenticated || getUserNick() != "Admin")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('You cannot access this page!!');window.location ='../Default.aspx';",
                true);
            }
            else
            {
                Label1.Text = getUserNick();
            }
        }

        protected String getUserNick()
        {
            var manager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId());
            return currentUser.Name;
        }
    }
}