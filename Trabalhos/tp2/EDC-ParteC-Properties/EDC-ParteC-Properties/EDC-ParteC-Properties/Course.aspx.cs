﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDC_ParteC_Properties
{
    public partial class Course : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id;
            var result = int.TryParse(Request.QueryString["ID"], out id);
            if (result)
            {
                XmlDataSource1.DataFile = "http://acesso.ua.pt/xml/curso.asp?i=" + id;
            }
            else
            {
                // TODO
            }
        }
    }
}