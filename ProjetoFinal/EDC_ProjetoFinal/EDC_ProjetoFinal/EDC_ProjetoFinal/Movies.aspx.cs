using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDC_ProjetoFinal
{
    public partial class Movies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /* Search on the DB based on the input search */
        protected void SearchMovie(object sender, EventArgs e)
        {            
            /* Only names with more or equal to one letters are valid */
            if (TextBox1.Text == "")
                Response.Redirect("Movies.aspx");
            else
                Response.Redirect("MoviesSearch.aspx?movie=" + TextBox1.Text);
        }
    }
}