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
    public partial class UpdateReview : System.Web.UI.Page
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
                TextBox1.Text = Request.QueryString["text"];
            }
        }

        /* Whenever the Button Edit is Pressed */
        protected void Update_Click(object sender, EventArgs e)
        {
            /* Call Function responsable for Update Reviews */
            UpdateReviewF();
        }

        protected String getUserName()
        {
            var manager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId());
            return currentUser.Name;
        }

        /* Update Review from user */
        protected void UpdateReviewF()
        {
            /* Open XML Document */
            XmlDocument xdoc = LoadXML();

            /* Element Reviews */
            XmlElement reviews = xdoc.SelectSingleNode("//reviews") as XmlElement;

            /* Select the review node from user */
            XmlElement review = xdoc.SelectSingleNode("about/reviews/review[@user=\"" + getUserName() + "\" and @text=\"" + Request.QueryString["text"] + "\"]") as XmlElement;

            /* Parent and child node Review destruction */
            review.RemoveAll();
            review.ParentNode.RemoveChild(review);

            /* New Review Creation */
            review = null;
            review = xdoc.CreateElement("review");
            XmlAttribute user = xdoc.CreateAttribute("user");
            XmlAttribute text = xdoc.CreateAttribute("text");

            /* Get values for review attributes */
            user.Value = getUserName();
            text.Value = TextBox1.Text;

            /* Create Structure*/
            review.Attributes.Append(user);
            review.Attributes.Append(text);

            /* Structure */
            reviews.AppendChild(review);
            xdoc.DocumentElement.AppendChild(reviews);

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
                    SqlCommand myCommand = new SqlCommand("SELECT [About] FROM Movies WHERE [Id] =" + id, conn);
                    SqlDataReader reader = myCommand.ExecuteReader();
                    string outxml = null;

                    if (reader.HasRows)
                        while (reader.Read())
                            outxml += reader[0];

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
                    SqlCommand myCommand = new SqlCommand(@"UPDATE [Movies] SET [About] = @x WHERE [Id] =" + id, conn);

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