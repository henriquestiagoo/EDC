<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Aggregator.aspx.cs" Inherits="tp3.Aggregator" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
        <br />
     <h2><i class="fa fa-rss fa-4"></i> My Feed Aggregator</h2>
    <hr />
        <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/Publico_feed.xml"></asp:XmlDataSource>
        <asp:XmlDataSource ID="XmlDataSource2" runat="server" DataFile="~/FeddList.xml"></asp:XmlDataSource>
        <div runat="server" ID="news" class="row" />
</asp:Content>
