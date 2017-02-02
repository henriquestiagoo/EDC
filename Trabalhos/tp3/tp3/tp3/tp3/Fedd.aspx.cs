using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace tp3
{
    public partial class Fedd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string url = "Sapo Cinema";
            string url = DropDownList1.SelectedValue;
            if (url.Length == 0)
            {
                url = "http://feeds.feedburner.com/PublicoRSS";
            }

            XmlDocument xdoc = XmlDataSource1.GetXmlDocument();
            XmlNodeList elemList = xdoc.GetElementsByTagName("feed");

            for (int i = 0; i < elemList.Count; i++)
            {
                System.Diagnostics.Debug.WriteLine(elemList[i].Attributes["name"].Value + "_feed.xml");
                System.Diagnostics.Debug.WriteLine(DropDownList1.SelectedValue);

                if (elemList[i].Attributes["name"].Value == DropDownList1.SelectedValue)
                {
                    string attrVal = elemList[i].Attributes["url"].Value;
                    XmlReader reader = XmlReader.Create(attrVal);
                    XmlDocument doc = new XmlDocument();
                    doc.Load(reader);
                    reader.Close();

                    //doc.Save("C:/Users/Utilizador/Desktop/Universidade/4_ano/1_semestre/EDC/Práticas/EDC_ProjetoFinal/EDC_ProjetoFinal/EDC_ProjetoFinal/xml" + elemList[i].Attributes["name"].Value + "_feed.xml");
                    doc.Save("C:/Users/Utilizador/Desktop/Universidade/4_ano/1_semestre/EDC/Práticas/tp3/tp3/tp3/tp3/" + elemList[i].Attributes["name"].Value + "_feed.xml");
                    XmlDataSource4.DataFile = "~/" + elemList[i].Attributes["name"].Value + "_feed.xml";

                }
            }

            XmlDocument xdoc1 = XmlDataSource4.GetXmlDocument();

            elemList = xdoc1.GetElementsByTagName("url");
            if(elemList.Count > 0)
            {
                XmlNode x1 = elemList[0].ChildNodes.Item(0);
                Image1.ImageUrl = x1.InnerText;
            }
            else
            {
                Image1.ImageUrl = null;
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

            XmlDataSource4.DataFile = "~/" + DropDownList1.SelectedValue + "_feed.xml";
            XmlDataSource3.DataFile = "~/" + DropDownList1.SelectedValue + "_feed.xml";
            XmlDataSource2.DataFile = "~/" + DropDownList1.SelectedValue + "_feed.xml";

            XmlDocument xdoc = XmlDataSource2.GetXmlDocument();
            XmlNodeList elemList = xdoc.GetElementsByTagName("channel");
        
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManagerFeed.aspx");
        }

         protected void Aggregator_Click(object sender, EventArgs e)
        {
            Response.Redirect("Aggregator.aspx");
        }
    }
}