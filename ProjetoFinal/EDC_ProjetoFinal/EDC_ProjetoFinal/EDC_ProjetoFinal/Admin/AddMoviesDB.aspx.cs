using EDC_ProjetoFinal.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDC_ProjetoFinal
{
    public partial class AddMoviesDB : System.Web.UI.Page
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

            /* Dropdown Load */
            for (int i = 2016; i >= 2000; i--)
            {
                /* Add Item if doesn't exist */
                if (!DropDownList1.Items.Contains(new ListItem((i).ToString())))
                    DropDownList1.Items.Add(new ListItem((i).ToString()));
                if (!DropDownList2.Items.Contains(new ListItem((i).ToString())))
                    DropDownList2.Items.Add(new ListItem((i).ToString()));
            }
            DropDownList1.DataBind();
            DropDownList2.DataBind();
        }

        protected String getUserNick()
        {
            var manager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var currentUser = manager.FindById(System.Web.HttpContext.Current.User.Identity.GetUserId());
            return currentUser.Name;
        }

        /* Movies DB Insertion */
        static void InsertDB(int Id, String PTName, String ENName, String Genre, String Rating, String ProductionCountry, 
            String Year, String OficialURL, String BigPic, String SmallPic, String Actors, String Directors,
                        String Argument, String Synopsis, String Distributor)
        {

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    conn.Open();

                    SqlCommand myCommand = new SqlCommand(@"IF NOT EXISTS (select * from Movies where ENName = cast(@ENName as varchar(max)))
                                                                    INSERT INTO [Movies] ([Id], [PTName],[ENName],
                                                                    [Genre],[Rating],[ProductionCountry],[Year],
                                                                    [OfficialURL],[BigImage],[SmallImage],[Actors],
                                                                    [Directors],[Argument],[Synopsis],[Distributor],[About]) 
                                                                VALUES (@Id, @PTName,@ENName,@Genre,@Rating,
                                                                        @ProductionCountry,@Year,@OficialURL,@BigPic,
                                                                        @SmallPic,@Actors,@Directors,@Argument,@Synopsis,@Distributor,@About);", conn); 
                             
                    SqlParameter BDId = myCommand.Parameters.Add("@Id", SqlDbType.Int);
                    SqlParameter BDPName = myCommand.Parameters.Add("@PTName", SqlDbType.Text);
                    SqlParameter BDEName = myCommand.Parameters.Add("@ENName", SqlDbType.Text);
                    SqlParameter BDGenre = myCommand.Parameters.Add("@Genre", SqlDbType.Text);
                    SqlParameter BDRating = myCommand.Parameters.Add("@Rating", SqlDbType.Text);
                    SqlParameter BDProductionCountry = myCommand.Parameters.Add("@ProductionCountry", SqlDbType.Text);
                    SqlParameter BDYear = myCommand.Parameters.Add("@Year", SqlDbType.Text);
                    SqlParameter BDOficialURL = myCommand.Parameters.Add("@OficialURL", SqlDbType.Text);
                    SqlParameter BDBigPic = myCommand.Parameters.Add("@BigPic", SqlDbType.Text);
                    SqlParameter BDSmallPic = myCommand.Parameters.Add("@SmallPic", SqlDbType.Text);
                    SqlParameter BDActors = myCommand.Parameters.Add("@Actors", SqlDbType.Text);
                    SqlParameter BDDirecting = myCommand.Parameters.Add("@Directors", SqlDbType.Text);
                    SqlParameter BDArgument = myCommand.Parameters.Add("@Argument", SqlDbType.Text);
                    SqlParameter BDSynopsis = myCommand.Parameters.Add("@Synopsis", SqlDbType.Text);
                    SqlParameter BDDistributor = myCommand.Parameters.Add("@Distributor", SqlDbType.Text);
                    SqlParameter BDFile = myCommand.Parameters.Add("@About", SqlDbType.Xml);

                    BDId.Value = Id;
                    BDPName.Value = PTName;
                    BDEName.Value = ENName;
                    BDDistributor.Value = Distributor;
                    BDGenre.Value = Genre; BDRating.Value = Rating;
                    BDProductionCountry.Value = ProductionCountry;
                    BDYear.Value = Year;
                    BDOficialURL.Value = OficialURL;
                    BDBigPic.Value = BigPic;
                    BDSmallPic.Value = SmallPic;
                    BDActors.Value = Actors;
                    BDDirecting.Value = Directors;
                    BDArgument.Value = Argument;
                    BDSynopsis.Value = Synopsis;
                    BDFile.Value = "<?xml version=\"1.0\" encoding=\"utf-16\" ?><about version=\"99.0\" authors=\"Miguel Oliveira nmec: 72638; Tiago Henriques nmec: 73046\"></about>";

                    int rows = myCommand.ExecuteNonQuery();
                    System.Diagnostics.Debug.WriteLine("Success on Loading Movies!");
                    System.Diagnostics.Debug.WriteLine("Movies added: " + rows);
                    conn.Close();
                }
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
            }
        }

        /* Load Movies on DB through sapo WebServices based on Year and Page 
        Call WebService and InsertBD */
        protected int LoadMovies(int Year, int Page)
        {
            /* Use of Web Services to gather data from external sources - Consuming as a client */
            WebClient wc = new WebClient();
            wc.Encoding = System.Text.Encoding.UTF8;
            do
            {
                /* Load Sapo WebService*/
                try
                {
                    String xmlData = wc.DownloadString("http://services.sapo.pt/Cinema/GetMovies?Year=" + Year.ToString() + "&PageNumber=" + Page.ToString() + "&RecordsPerPage=20");
                    XmlDataSource1.Data = xmlData;
                    XmlDataSource1.TransformFile = "~/xslt/ListMovies.xslt";
                    XmlDataSource1.DataBind();
                    GridView1.DataSource = XmlDataSource1;
                    GridView1.DataBind();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex);
                }

                /* Run GridView and Add to the DB Data 
                 Feed the data system */
                for (int rows = 0; rows < GridView1.Rows.Count; rows++)
                {
                    InsertDB(Convert.ToInt32(GridView1.Rows[rows].Cells[0].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[1].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[2].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[3].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[4].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[5].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[6].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[7].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[8].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[9].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[10].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[11].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[12].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[13].Text),
                            HttpUtility.HtmlDecode(GridView1.Rows[rows].Cells[14].Text));
                }
                Page++;
            } while (GridView1.Rows.Count == 20);

            TextBox1.Text += "Ended on page " + Page + " -> Year " + Year + System.Environment.NewLine;
            return Page * 20;
        }

        protected void Load_Click(object sender, EventArgs e)
        {
            TextBox1.Text = "";
            TextBox2.Text = "";

            int total = 0;

            if (Convert.ToInt32(DropDownList1.SelectedValue) > Convert.ToInt32(DropDownList2.SelectedValue))
            {
                TextBox1.Text += "The Movies loading dates are incorrect!! " + System.Environment.NewLine;
            }

            for (int i = Convert.ToInt32(DropDownList1.SelectedValue); i <= Convert.ToInt32(DropDownList2.SelectedValue); i++)
            {
                total += LoadMovies(i, 1);
            }
            TextBox1.Text += "Inserted: " + total.ToString() + " movies!!" + System.Environment.NewLine;
            /* Save Movies Data to XML - xml Folder */
            saveToXML();
        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            TextBox1.Text = "";
            TextBox2.Text = "";

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    conn.Open();
                    SqlCommand myCommand = new SqlCommand("DELETE FROM [Movies]", conn);
                    int rows = myCommand.ExecuteNonQuery();
                    System.Diagnostics.Debug.WriteLine("Movies Deleted:" + rows);
                    TextBox2.Text += "Sucess on Delete!! " + System.Environment.NewLine;
                    TextBox2.Text += "Movies Deleted: " + rows + System.Environment.NewLine;
                    TextBox1.Text += "Database is now empty!! " + System.Environment.NewLine;
                    conn.Close();
                }
            }
            catch (SqlException ex)
            {
                TextBox2.Text += "Could Not delete Movies DB! " + System.Environment.NewLine;
                System.Diagnostics.Debug.WriteLine(ex);
            }
        }

        /* Save to XML File all the Movies Data Stored on the DB */
        private void saveToXML()
        {
            try { 
                SqlConnection connection;
                SqlDataAdapter adapter;
                DataSet ds = new DataSet();
                string sql = null;

                connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                sql = "SELECT * FROM [Movies]";

                connection.Open();
                adapter = new SqlDataAdapter(sql, connection);
                adapter.Fill(ds);
                connection.Close();
                ds.WriteXml(Server.MapPath("../xml/Movies.xml"));
                System.Diagnostics.Debug.WriteLine("XML Generated successfully!!");
                TextBox1.Text += "Movies XML generated successfully!! " + System.Environment.NewLine;
            }
            catch (Exception)
            {
                System.Diagnostics.Debug.WriteLine("XML not Generated!!");
            }
        }

     }
}