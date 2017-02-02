<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MoviesSearch.aspx.cs" Inherits="EDC_ProjetoFinal.MoviesSearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  <br />
  <hr />

  <div class="row">
        <div class="col-md-2 text-right">Search Movie: </div>
        <div class="col-md-4 text-center">
            <asp:TextBox ID="TextBox1" runat="server" Width="200px"></asp:TextBox>
            <asp:Button ID="Pesquisa" runat="server"  OnClick="SearchMovie" Text="Search" />
        </div>
  </div>

  <br />
  <hr />

  <asp:GridView ID="GridView1" runat="server" AllowPaging="True" GridLines="None" CellPadding="4" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" CssClass="table table-striped">
        <EmptyDataTemplate>
            <div class="panel panel-warning">
                <div class="panel-heading"><h3 class="panel-title">ATTENTION!!!</h3></div>
                <div class="panel-body">
                    There are no movies that match your search request!!
                </div>
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:ImageField DataImageUrlField="SmallImage" />
            <asp:BoundField DataField="ENName" HeaderText="Movie" SortExpression="ENName" />
            <asp:BoundField DataField="Synopsis" HeaderText="Synopsis" SortExpression="Synopsis" />
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="MoviesDetails.aspx?id={0}" Text="More" >
            <ItemStyle ForeColor="White" />
            </asp:HyperLinkField>
        </Columns>
         <PagerStyle HorizontalAlign="Center" CssClass="pagination-ys"/>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
        SelectCommand="SELECT DISTINCT [Id], [SmallImage], [ENName], [Synopsis] FROM [Movies] 
            WHERE (([ENName] LIKE '%' + @movie + '%') OR ([PTName] LIKE '%' + @movie + '%'))">
      <SelectParameters>
            <asp:QueryStringParameter Name="movie" QueryStringField="movie" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>