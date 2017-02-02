<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Movies.aspx.cs" Inherits="EDC_ProjetoFinal.Movies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <br />
    <hr />

     <div class="row">
            <div class="col-md-1 text-center">Year: </div>
            <div class="col-md-2 text-center"> 
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Year" DataValueField="Year" CssClass="form-control"></asp:DropDownList>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT [Year] FROM [Movies] ORDER BY [Year] DESC"></asp:SqlDataSource>               
            </div>

            <div class="col-md-1 text-center">Genre: </div>
            <div class="col-md-2 text-center">
                <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Genre" DataValueField="Genre" CssClass="form-control"></asp:DropDownList>

                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT DISTINCT [Genre] FROM [Movies] WHERE ([Year] = @Year) AND ([Genre] != ' ') ORDER BY [Genre] DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div> 

            <div class="col-md-2 text-right">Search Movie: </div>
            <div class="col-md-4 text-center">
                <asp:TextBox ID="TextBox1" runat="server" Width="200px"></asp:TextBox>
                <asp:Button ID="Pesquisa" runat="server" OnClick="SearchMovie" Text="Search" />
            </div>
        </div>
    <hr />
    <br />

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" GridLines="None" CellPadding="4" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource3" CssClass="table table-striped">
        <EmptyDataTemplate>
            <div class="panel panel-warning">
                <div class="panel-heading"><h3 class="panel-title">ATTENTION!!!</h3></div>
                <div class="panel-body">
                    There are no movies that match your request!!
                </div>
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:ImageField DataImageUrlField="SmallImage" />
            <asp:BoundField DataField="ENName" HeaderText="Movie" SortExpression="ENName" ControlStyle-Width="100" />
            <asp:BoundField DataField="Synopsis" HeaderText="Synopsis" SortExpression="Synopsis" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Id") %>' Visible="False"></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="MoviesDetails.aspx?id={0}" Text="More" >
            <ItemStyle ForeColor="White" />
            </asp:HyperLinkField>
        </Columns>
         <PagerStyle HorizontalAlign="Center" CssClass="pagination-ys"/>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Id], [SmallImage], [ENName], [Synopsis] FROM [Movies] WHERE ([Year] = @Year) AND ([Genre] = @Genre) ORDER BY [Year] ASC">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Year" DefaultValue="2016" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="DropDownList2" Name="Genre"  DefaultValue="Drama" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <hr />

</asp:Content>