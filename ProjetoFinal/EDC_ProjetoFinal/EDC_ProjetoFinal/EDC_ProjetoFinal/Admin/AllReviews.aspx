<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AllReviews.aspx.cs" Inherits="EDC_ProjetoFinal.Personal.AllReviews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <br />
    <hr />
    <h3>All Reviews</h3>
    <hr />

    <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label> 

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource2" GridLines="None" CssClass="table table-striped">
        <EmptyDataTemplate>
            <div class="panel panel-warning">
                <div class="panel-heading"><h3 class="panel-title">No Reviews !!</h3></div>
                <div class="panel-body">
                    No User has made Reviews so far!!
                </div>
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:ImageField DataImageUrlField="Image" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Silver" />
            <asp:BoundField DataField="Movie" HeaderText="Movie" ReadOnly="True" SortExpression="Movie" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Silver"/>
            <asp:BoundField DataField="User" HeaderText="User" ReadOnly="True" SortExpression="User" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Silver"/>
            <asp:BoundField DataField="Review" HeaderText="Review" ReadOnly="True" SortExpression="Review" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Silver" />
            <asp:HyperLinkField  DataNavigateUrlFields="Id,review" DataNavigateUrlFormatString="~/Admin/DeleteReviewsAdmin.aspx?id={0}&amp;text={1}" Text="Delete Review" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Silver">
            </asp:HyperLinkField>
        </Columns>
        <PagerStyle HorizontalAlign="Center" CssClass="pagination-ys"/>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Id],[smallImage] AS [Image], [ENName] AS [Movie],
	            r.value('@user','varchar(100)') as [User],
	            r.value('@text','varchar(300)') as [Review]			
                FROM [Movies] 
                CROSS APPLY Movies.About.nodes('about/reviews/review') AS x(r)
                ORDER BY ENName;">
        </asp:SqlDataSource>

</asp:Content>
