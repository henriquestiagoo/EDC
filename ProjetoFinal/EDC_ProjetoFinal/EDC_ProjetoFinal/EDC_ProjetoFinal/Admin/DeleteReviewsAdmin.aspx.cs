using EDC_ProjetoFinal.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace EDC_ProjetoFinal.Admin
{
    public partial class DeleteReviewsAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /* Admin Function! If Not authenticated or Admin, redirect to default page */
            if (!User.Identity.IsAuthenticated || getUserName() != "Admin")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('You cannot access this page!!');window.location ='../Default.aspx';",
                true);
            }
            DeleteReviewAdmin();
        }

        protected String getUserName()
        {
            var manager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId());
            return currentUser.Name;
        }

        /* Delete a review as Admin - Can Delete any Review */
        protected void DeleteReviewAdmin()
        {
            /* Open XML Document */
            XmlDocument xdoc = LoadXML();

            /* Select the review node from user */
            XmlElement review = xdoc.SelectSingleNode("about/reviews/review[@text=\"" + Request.QueryString["text"] + "\"]") as XmlElement;

            /* Parent and child node Review destruction */
            review.RemoveAll();
            review.ParentNode.RemoveChild(review);

            /* Store XML on DB */
            StoreXML(xdoc);

            /* Redirect to the same page */
            Response.Redirect("~/Admin/AllReviews.aspx");
        }

        /* Load XML on DB */
        protected XmlDocument LoadXML()
        {
            /* Movie id is passed by address */
            string id = Request.QueryString["Id"];

            XmlDocument xdoc = new XmlDocument();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    conn.Open();
                    SqlCommand myCommand = new SqlCommand("SELECT [About] FROM Movies WHERE [Id] =" + id, conn);

                    SqlDataReader reader = myCommand.ExecuteReader();
                    string outxml = null;
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            outxml += reader[0];
                        }
                    }
                    xdoc.LoadXml(outxml);
                    conn.Close();
                }
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
            }

            return xdoc;
        }

        /* Store XML on DB */
        protected void StoreXML(XmlDocument xml)
        {
            /* Same process */
            string id = Request.QueryString["Id"];
            string x = xml.OuterXml;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    conn.Open();
                    SqlCommand myCommand = new SqlCommand(@"UPDATE [Movies] SET [About] = @x WHERE Id=" + id, conn);

                    SqlParameter BDFile = myCommand.Parameters.Add("@x", SqlDbType.Xml);
                    BDFile.Value = "<?xml version=\"1.0\" encoding=\"utf-16\" ?>" + x;
                    int rows = myCommand.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
            }
        }

    }
}