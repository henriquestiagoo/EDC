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
    public partial class Favorites : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /* Needs to be authenticated */
            if (!User.Identity.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("USER NOT AUTHENTICATED!!!");
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                Label2.Text = getUserName();
            }       
        }

        protected String getUserName()
        {
            var manager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId());
            return currentUser.Name;
        }
    }
}