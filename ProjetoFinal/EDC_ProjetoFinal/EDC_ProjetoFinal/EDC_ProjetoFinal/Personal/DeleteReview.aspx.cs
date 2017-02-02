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

namespace EDC_ProjetoFinal
{
    public partial class DeleteReview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /* Needs to be authenticated */
            if (!User.Identity.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("USER NOT AUTHENTICATED!!!");
                Response.Redirect("~/Default.aspx");
            }

            /* HTTP POST to load Review by link */
            if (!IsPostBack)
            {
                System.Diagnostics.Debug.WriteLine(getUserName());
                System.Diagnostics.Debug.WriteLine(Request.QueryString["text"]);
            }
            DeleteReviewF();
        }

        protected String getUserName()
        {
            var manager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId());
            return currentUser.Name;
        }

        /* Delete a review from authenticated user */
        protected void DeleteReviewF()
        {
            /* Open XML Document */
            XmlDocument xdoc = LoadXML();

            /* Select the review node from user */
            XmlElement review = xdoc.SelectSingleNode("about/reviews/review[@user=\"" + getUserName() + "\" and @text=\"" + Request.QueryString["text"] + "\"]") as XmlElement;

            /* Parent and child node Review destruction */
            review.RemoveAll();
            review.ParentNode.RemoveChild(review);

            /* Store XML on DB */
            StoreXML(xdoc);

            /* Redirect to the same page */
            Response.Redirect("~/Personal/Reviews.aspx");
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
                    SqlCommand myCommand = new SqlCommand("SELECT [About] FROM Movies WHERE Id=" + id, conn);

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