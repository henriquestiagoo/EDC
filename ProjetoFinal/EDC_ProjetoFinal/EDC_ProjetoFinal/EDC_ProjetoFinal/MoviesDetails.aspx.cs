using EDC_ProjetoFinal.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace EDC_ProjetoFinal
{
    public partial class MoviesDetails : System.Web.UI.Page
    {
        /* Global Variables */
        int user = 0;
        int seen = 0;
        int fav = 0;
        int rated = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            /* User not authenticated */
            if (!User.Identity.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("USER NOT AUTHENTICATED!!!");
                user = 0;
            }
            else
            {
                user = 1;
                Label1.Text = getUserName();
                /* MicroFormat hReview */
                LabelReviewer.Text = getUserName();
                LabelDate.Text = DateTime.Today.ToString("dd-MM-yyyy");
                /* END*/
                System.Diagnostics.Debug.WriteLine(Rating1.CurrentRating.ToString());
                seen = checkIfSeenByUser(getUserName());
                //
                fav = checkIfFavoriteByUser(getUserName());
                //
                rated = checkIfRatedByUser(getUserName());
                //
                if (seen == 1 && fav == 1)
                {
                    Seen_Button.Text = "Remove from Seen";
                    Favs_Button.Text = "Remove from Favorites";
                }
                else if (seen == 1 && fav == 0)
                {
                    Seen_Button.Text = "Remove from Seen";
                    Favs_Button.Text = "Add to Favorites";
                }
                else if (seen == 0 && fav == 1)
                {
                    Favs_Button.Text = "Remove from Favorites";
                    Seen_Button.Text = "Add to Seen";
                }
                else if (seen == 0 && fav == 0)
                {
                    Seen_Button.Text = "Add to Seen";
                    Favs_Button.Text = "Add to Favorites";
                }
                else
                {
                    Seen_Button.Text = "Add to Seen";
                    Favs_Button.Text = "Add to Favorites";
                }

                if (rated == 1)
                {
                    // Get number of stars on rating system
                    Label_Stars.Text = returnStarsFromUser(getUserName());
                    Rating1.CurrentRating = Int32.Parse(Label_Stars.Text);
                    Label_Rate.Text = "(" + Label_Stars.Text + "/10)";
                    Rating1.ReadOnly = true;
                    Rating_Button.Enabled = false;
                    System.Diagnostics.Debug.WriteLine("RATED = 1");
                }
                else
                {
                    Label_Rate.Text = "(" + Rating1.CurrentRating.ToString() + "/10)";
                }
            }

        }

        protected void DetailsView2_Load(object sender, EventArgs e)
        {
            String data;

            foreach (DetailsViewRow r in DetailsView2.Rows)
            {
                if (r.Cells.Count > 1)
                {
                    data = r.Cells[1].Text;
                }
                else
                {
                    data = r.Cells[0].Text;
                }

                // Null lines take the value &#160
                data = data.Replace("&#160;", "").Trim();
                if (data == null || data == "")
                {
                    r.Visible = false;
                }
            }
        }

        protected String getUserName()
        {
            var manager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId());
            return currentUser.Name;
        }

        /* Add Review from User */
        protected void AddReview(string userReview)
        {
            /* Open XML Document */
                XmlDocument xdoc = LoadXML();
            XmlElement reviews = xdoc.SelectSingleNode("//reviews") as XmlElement;

            if (reviews == null)
            {
                /* Create element if doesn't exist */
                reviews = xdoc.CreateElement("reviews");
            }

            /* Create elements */
            XmlElement review = xdoc.CreateElement("review");
            XmlAttribute user = xdoc.CreateAttribute("user");
            XmlAttribute text = xdoc.CreateAttribute("text");

            /* Add Element Values */
            user.Value = getUserName();
            text.Value = userReview;

            /* Create Structure for review */
            review.Attributes.Append(user);
            review.Attributes.Append(text);

            /* Create Structure for xdoc */
            reviews.AppendChild(review);
            xdoc.DocumentElement.AppendChild(reviews);

            /* Update field on Database */
            StoreXML(xdoc);

            /* Refresh GridView */
            SqlDataSource2.DataBind();
            GridView1.DataBind();
        }

        /* Add Movie to User watchlist */
        protected void AddSeen()
        {
            // Load XML File
            XmlDocument xdoc = LoadXML();
            XmlElement watchlist = xdoc.SelectSingleNode("//watchlist") as XmlElement;

            if (watchlist == null)
            {
                /* Create element if doesn't exist */
                watchlist = xdoc.CreateElement("watchlist");
            }

            /* Create node elements */
            XmlElement seen = xdoc.CreateElement("seen");
            XmlAttribute user = xdoc.CreateAttribute("user");

            /* Add elements to node */
            user.Value = getUserName();

            /* Create Structure */
            seen.Attributes.Append(user);

            /* Create Structure for xdoc */
            watchlist.AppendChild(seen);
            xdoc.DocumentElement.AppendChild(watchlist);

            /* Store XML */
            StoreXML(xdoc);
        }

        /* Remove Movie from Seen on DB and Update Button */
        protected void removeSeen()
        {
            /* Open XML Document */
            XmlDocument xdoc = LoadXML();

            XmlElement seen = xdoc.SelectSingleNode("about/watchlist/seen[@user=\"" + getUserName() + "\"]") as XmlElement;

            seen.RemoveAll();
            seen.ParentNode.RemoveChild(seen);

            /* Update file on DataBase*/
            StoreXML(xdoc);
        }

        /* Add Movie to User wishlist */
        protected void AddFavorites()
        {
            // Load XML File
            XmlDocument xdoc = LoadXML();
            XmlElement wishlist = xdoc.SelectSingleNode("//wishlist") as XmlElement;

            if (wishlist == null)
            {
                /* Create elements if doesn't exist */
                wishlist = xdoc.CreateElement("wishlist");
            }

            /* Create Node Elements */
            XmlElement fav = xdoc.CreateElement("favorite");
            XmlAttribute user = xdoc.CreateAttribute("user");

            /* Add elements to Node */
            user.Value = getUserName();

            /* Creates Structure */
            fav.Attributes.Append(user);

            /* Creates Structure for xdoc */
            wishlist.AppendChild(fav);
            xdoc.DocumentElement.AppendChild(wishlist);

            /* Store XML On DB*/
            StoreXML(xdoc);
        }

        /* Add rating to movie from User */
        protected void AddRating(String starsRating)
        {
            /* Load XML File */
            XmlDocument xdoc = LoadXML();
            XmlElement ratings = xdoc.SelectSingleNode("//ratings") as XmlElement;

            if (ratings == null)
            {
                /* Create element if doesn't exist */
                ratings = xdoc.CreateElement("ratings");
            }

            /* Create node elements */
            XmlElement rating = xdoc.CreateElement("rating");
            XmlAttribute user = xdoc.CreateAttribute("user");
            XmlAttribute stars = xdoc.CreateAttribute("stars");
            
            /* Add elements to node */
            user.Value = getUserName();
            stars.Value = starsRating;

            /* Creates the Structure */
            rating.Attributes.Append(user);
            rating.Attributes.Append(stars);

            /* Creates the Structure for xdoc */
            ratings.AppendChild(rating);
            xdoc.DocumentElement.AppendChild(ratings);

            /* Store XML On DB */
            StoreXML(xdoc);
        }

        protected String returnStarsFromUser(String username)
        {
            String stars = null;
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    SqlCommand myCommand = new SqlCommand("SELECT [Id], r.value('@user', 'varchar(100)') as [User], r.value('@stars', 'varchar(300)') as [Stars] FROM [Movies] CROSS APPLY Movies.About.nodes('about/ratings/rating') AS x(r) where Movies.Id = '" +Request.QueryString["Id"]+ "'and r.value('@user','varchar(100)') = '" + username+ "'", conn);

                    conn.Open();

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            stars = reader["Stars"].ToString();
                        }
                    }

                    conn.Close();
                }
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
            }
            return stars;         
        }

        /* Remove Movie from wishlist and update Button */
        protected void removeFavorites()
        {
            /* Open XML Document */
            XmlDocument xdoc = LoadXML();

            XmlElement fav = xdoc.SelectSingleNode("about/wishlist/favorite[@user=\"" + getUserName() + "\"]") as XmlElement;

            fav.RemoveAll();
            fav.ParentNode.RemoveChild(fav);

            /* Update file on DataBase*/
            StoreXML(xdoc);
        }

        /* Load XML from DB */
        protected XmlDocument LoadXML()
        {
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
            string id = Request.QueryString["Id"];
            string x = xml.OuterXml;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    conn.Open();
                    SqlCommand myCommand = new SqlCommand(@"UPDATE Movies SET [About] = @x WHERE [Id] =" + id, conn);

                    SqlParameter BDfile = myCommand.Parameters.Add("@x", SqlDbType.Xml);

                    BDfile.Value = "<?xml version=\"1.0\" encoding=\"utf-16\" ?>" + x;
                    int rows = myCommand.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
            }
        }


        /* Button for Add Reviews */
        protected void Button1_Click(object sender, EventArgs e)
        {
            /* If user is authenticated */
            if (user==1)
            {
                if (TextBox1.Text != "")
                {
                    AddReview(TextBox1.Text);
                }
                TextBox1.Text = "";
            }
            else
            {
               TextBox1.Text = "";
               ScriptManager.RegisterStartupScript(this, this.GetType(),
               "alert",
               "alert('You need to Log In!!');",
               true);
            }
        }

        /* Button for insert or change rating */
        protected void Rating_Button_Click(object sender, EventArgs e)
        {
            /* If user is authenticated */
            if (user==1)
            {
                int s = checkIfRatedByUser(getUserName());

                /* If hasn't rated  the movie */
                if (s == 0)
                {
                    AddRating(Rating1.CurrentRating.ToString());
                }
                else
                {
                    /* Disable button */
                    System.Diagnostics.Debug.WriteLine("JA FEZ RATING NESTE FILME");
                }

                Response.Redirect("~/MoviesDetails.aspx?Id=" + Request.QueryString["Id"]);
            }
            else
            {
                Rating1.CurrentRating = 0;
                ScriptManager.RegisterStartupScript(this, this.GetType(),
               "alert",
               "alert('You need to Log In!!');",
               true);
            }
            
        }

        /* Button for Seen or Not Seen */
        protected void Seen_Click(object sender, EventArgs e)
        {
            /* If user is authenticated */
            if (user==1)
            {
                int s = checkIfSeenByUser(getUserName());

                /* If movie is not on the watchlist */
                if (s == 0)
                {
                    AddSeen();
                    Seen_Button.Text = "Remove from Seen";
                    seen = 1;
                }
                else
                {
                    removeSeen();
                    Seen_Button.Text = "Add to seen";
                    seen = 0;
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
               "alert",
               "alert('You need to Log In!!');",
               true);
            }
            
        }

        /* Button for Favorite or Not Favorite */
        protected void Favs_Button_Clicked(object sender, EventArgs e)
        {
            /* If user is authenticated */
            if (user==1)
            {
                int s = checkIfFavoriteByUser(getUserName());

                /* If movie is not on the wishlist */
                if (s == 0)
                {
                    AddFavorites();
                    Favs_Button.Text = "Remove from Favorites";
                    fav = 1;
                }
                else
                {
                    removeFavorites();
                    Favs_Button.Text = "Add to Favorites";
                    fav = 0;
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
               "alert",
               "alert('You need to Log In!!');",
               true);
            }
        }

        /* Returns if a user has or hasn't seen the movie */
        protected int checkIfSeenByUser(String user)
        {
            int res = 0;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    SqlCommand myCommand = new SqlCommand("dbo.CheckMovieSeen", conn);
                    myCommand.CommandType = CommandType.StoredProcedure;
                    myCommand.Parameters.Add("@x", SqlDbType.VarChar, 100).Value = user;
                    myCommand.Parameters.Add("@y", SqlDbType.Int).Value = Request.QueryString["Id"];

                    conn.Open();
                    res = (int)myCommand.ExecuteScalar();
                    conn.Close();
                }
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
            }
            return res;
        }

        /* Returns if the movie is on the favorite list of that user */
        protected int checkIfFavoriteByUser(String user)
        {
            int res = 0;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    SqlCommand myCommand = new SqlCommand("dbo.CheckMovieFavorite", conn);
                    myCommand.CommandType = CommandType.StoredProcedure;
                    myCommand.Parameters.Add("@x", SqlDbType.VarChar, 100).Value = user;
                    myCommand.Parameters.Add("@y", SqlDbType.Int).Value = Request.QueryString["Id"];

                    conn.Open();
                    res = (int)myCommand.ExecuteScalar();
                    conn.Close();
                }
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
            }
            return res;
        }

        /* Returns if the the user has or hasn't rated the movie */
        protected int checkIfRatedByUser(String user)
        {
            int res = 0;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    SqlCommand myCommand = new SqlCommand("dbo.CheckMovieRated", conn);
                    myCommand.CommandType = CommandType.StoredProcedure;
                    myCommand.Parameters.Add("@x", SqlDbType.VarChar, 100).Value = user;
                    myCommand.Parameters.Add("@y", SqlDbType.Int).Value = Request.QueryString["Id"];
                    //
                    conn.Open();
                    res = (int)myCommand.ExecuteScalar();
                    conn.Close();
                }
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
            }
            return res;
        }
        
    }
}