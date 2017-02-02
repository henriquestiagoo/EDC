using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

namespace tp1
{
    public class MyHandler1 : IHttpHandler
    {
        /// <summary>
        /// You will need to configure this handler in the Web.config file of your 
        /// web and register it with IIS before being able to use it. For more information
        /// see the following link: http://go.microsoft.com/?linkid=8101007
        /// </summary>
        /// 
   
        #region IHttpHandler Members

        public bool IsReusable
        {
            // Return false in case your Managed Handler cannot be reused for another request.
            // Usually this would be false in case you have some state information preserved per request.
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            //write your handler implementation here.
            //context.Response.Write("Hello World!!");
            String conStr = ConfigurationManager.ConnectionStrings["pubsConnectionString1"].ConnectionString;  // to get connection string
            SqlConnection conn = new SqlConnection(conStr); // to create a connection with the DB
            SqlCommand comm = new SqlCommand("SELECT au_fname, au_lname, phone, address FROM authors WHERE au_fname = "+"'"+context.Request.QueryString["name"]+"'", conn); // to create a SQL query
            comm.Connection.Open();
            SqlCommand comm2 = new SqlCommand("SELECT au_fname, au_lname FROM authors", conn); 
            SqlDataReader sdr = comm.ExecuteReader();   // execute query and get a results reader
            String messageOut = "<?xml version=\"1.0\"?>\n<results>";
            int n;
            try
            {
                n = Int32.Parse(context.Request.QueryString["n"]);
            }
            catch (Exception e)
            {
                n = -1;
            }

            if (!String.IsNullOrEmpty(context.Request.QueryString["name"]))
            {
                while (sdr.Read())
                {
                    messageOut += "<author>" + sdr.GetString(0) + " " + sdr.GetString(1) +  " " + sdr.GetString(2) + " " + sdr.GetString(3) + "</author>\n";
                    break;
                }
                sdr.Close();
            }
            else
            {
                comm.Connection.Close();
                comm2.Connection.Open();
                SqlDataReader sdr2 = comm2.ExecuteReader();   // execute query and get a results reader
                while (sdr2.Read())
                {
                    if (n == 0) break;
                    n--; // n starts on 0
                    messageOut += "<author>" + sdr2.GetString(0) + " " + sdr2.GetString(1) + "</author>\n"; // au_fname + " " + au_lname
                }
                sdr2.Close();
            }
            //
            messageOut += "\n</results>";
            context.Response.Write(messageOut); // send responde to browser
        }

        #endregion
    }
}
