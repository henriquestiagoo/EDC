<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MoviesNews.aspx.cs" Inherits="EDC_ProjetoFinal.MoviesNews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <br />
    <hr />

    <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" AutoGenerateColumns="False" AllowPaging="True" GridLines="None" CssClass="table table-striped">
        <EmptyDataTemplate>
            <br />
            <div class="panel panel-warning">
                <div class="panel-heading"><h3 class="panel-title">ATTENTION!!!</h3></div>
                <div class="panel-body">
                    No data has been retrieved!!
                </div>
            </div>
        </EmptyDataTemplate>
        <Columns>
        <asp:TemplateField HeaderText="Latest Movie News">          
            <ItemTemplate>
                <br />
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Bind("link") %>' Text='<%# Bind("title") %>' Font-Bold="True" Font-Size="Large"></asp:HyperLink> 
                <br />
                <br />
                <asp:Image runat="server" ID="image2" Width="400" Height="200"/>
                <br />
                <br />
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("enclosure") %>' Visible="false"></asp:Label>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                <br />
                <asp:Label ID="updated" runat="server" Text="Updated on " Font-Bold="True"></asp:Label>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("pubDate") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    <PagerStyle HorizontalAlign="Center" CssClass="pagination-ys"/>
    </asp:GridView>

    <asp:XmlDataSource ID="XmlDataSource1" runat="server"></asp:XmlDataSource>

</asp:Content>
