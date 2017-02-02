using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace tp3
{
    public partial class ManagerFeed : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void formFeeds_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            XmlDocument xdoc = XmlDataSource1.GetXmlDocument();
            XmlElement feed = xdoc.CreateElement("feed");
            XmlAttribute name = xdoc.CreateAttribute("name");
            XmlAttribute url = xdoc.CreateAttribute("url");


            name.Value = (FormView1.FindControl("nameInsert") as TextBox).Text;

            url.Value = (FormView1.FindControl("urlInsert") as TextBox).Text;

            feed.Attributes.Append(name);
            feed.Attributes.Append(url);

            xdoc.DocumentElement.AppendChild(feed);
            XmlDataSource1.Save();
            FormView1.ChangeMode(FormViewMode.ReadOnly);
            e.Cancel = true;
        }

        protected void formFeeds_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            XmlDocument xdoc = XmlDataSource1.GetXmlDocument();
            XmlElement feed = xdoc.SelectSingleNode("feeds/feed[@name='" + e.OldValues["name"] + "']") as XmlElement;

            feed.Attributes["name"].Value = e.NewValues["name"].ToString();
            feed.Attributes["url"].Value = e.NewValues["url"].ToString();

            XmlDataSource1.Save();
            e.Cancel = true;
            FormView1.ChangeMode(FormViewMode.ReadOnly);
        }

        protected void formFeeds_ItemDeliting(object sender, FormViewDeleteEventArgs e)
        {
            XmlDocument xdoc = XmlDataSource1.GetXmlDocument();
            System.Diagnostics.Debug.WriteLine(e.Values["name"]);
            XmlElement feed = xdoc.SelectSingleNode("feeds/feed[@name='" + e.Values["name"] + "']") as XmlElement;
            xdoc.DocumentElement.RemoveChild(feed);
            XmlDataSource1.Save();
            e.Cancel = true;
            FormView1.DataBind();
        }
    }
}