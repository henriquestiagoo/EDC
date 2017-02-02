using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDC_ParteC_Properties
{
    public partial class Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (ViewState["grau"] != null && ViewState["local"] != null)
            {
                XmlDataSource1.XPath = $"/cursos/curso[@grau='{ViewState["grau"]}' and @local = '{ViewState["local"]}']";
                XmlDataSource1.DataBind();
                GridView1.DataBind();
            }

        }

        protected void listaDeGraus_SelectedIndexChanged(object sender, EventArgs e)
        {
            var grau = listaDeGraus.SelectedValue;
            ViewState["grau"] = grau;
            var local = listaDeLocais.SelectedValue;
            ViewState["local"] = local;
            XmlDataSource1.XPath = $"/cursos/curso[@grau='{grau}' and @local = '{local}']";
            GridView1.DataBind();
            // TO DO selectionar tudo

        }

        protected void listaDeLocais_SelectedIndexChanged(object sender, EventArgs e)
        {
            listaDeGraus_SelectedIndexChanged(sender, e);
        }
    }
}

