<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EDC_ProjetoFinal._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <br />
    <hr />
    <br />

    <div class="row">
        <div class="col-md-2 text-left"> 
            <asp:Label ID="Label_movies" runat="server" Text="Latest Movies" Font-Bold="true" Font-Size="Large"></asp:Label>
            <br />
            <br />

            <asp:GridView ID="GridView1" runat="server" GridLines="None" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource3" CssClass="table table-striped">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                             <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("Id", "MoviesDetails.aspx?id={0}") %>'>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("SmallImage") %>' />
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>       
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT  TOP 5 Id, [SmallImage] FROM [Movies] WHERE Genre='Drama' AND [Year]='2016'">
            </asp:SqlDataSource>
        </div>

        <div class="col-md-2 text-center"> 
            <asp:Label runat="server" Text="  "></asp:Label>
            <br />
            <br />

            <asp:GridView ID="GridView2" runat="server" GridLines="None" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" CssClass="table table-striped">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                             <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("Id", "MoviesDetails.aspx?id={0}") %>'>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("SmallImage") %>' />
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>         
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT  TOP 5 Id, [SmallImage] FROM [Movies] WHERE Genre='Comédia' AND [Year]='2016'">
            </asp:SqlDataSource>
        </div>

        <div class="col-md-2 text-center"> 
            <asp:Label runat="server" Text="  "></asp:Label>
            <br />
            <br />

            <asp:GridView ID="GridView3" runat="server" GridLines="None" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource2" CssClass="table table-striped">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                             <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# Eval("Id", "MoviesDetails.aspx?id={0}") %>'>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("SmallImage") %>' />
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>       
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT  TOP 5 Id, [SmallImage] FROM [Movies] WHERE Genre='Terror' AND [Year]='2016'">
            </asp:SqlDataSource>
        </div>

        <div class="col-md-2 text-center"> 
            <asp:Label runat="server" Text="  "></asp:Label>
            <br />
            <br />

            <asp:GridView ID="GridView4" runat="server" GridLines="None" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource4" CssClass="table table-striped">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                             <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# Eval("Id", "MoviesDetails.aspx?id={0}") %>'>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("SmallImage") %>' />
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>       
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT  TOP 5 Id, [SmallImage] FROM [Movies] WHERE Genre='Ação/Aventura' AND [Year]='2016'">
            </asp:SqlDataSource>
        </div>

        <div class="col-md-4 text-left"> 
            <asp:Label ID="Reviews_only" runat="server" Text="Latest Reviews" Font-Bold="true" Font-Size="Large"></asp:Label>
            <br />
            <br />

            <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource5" GridLines="None" CssClass="table table-striped">
                <EmptyDataTemplate>
                    <div class="panel panel-warning">
                        <div class="panel-heading"><h3 class="panel-title">No Reviews !!</h3></div>
                        <div class="panel-body">
                            No User has made Reviews so far!!
                        </div>
                    </div>
                </EmptyDataTemplate>
                <Columns>            
                    <asp:BoundField DataField="Movie" HeaderText="Movie" ReadOnly="True" SortExpression="Movie"/>
                    <asp:BoundField DataField="User" HeaderText="User" ReadOnly="True" SortExpression="User"/>
                    <asp:BoundField DataField="Review" HeaderText="Review" ReadOnly="True" SortExpression="Review" />
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT TOP 10 [Id],[ENName] AS [Movie],
	                    r.value('@user','varchar(100)') as [User],
	                    r.value('@text','varchar(300)') as [Review]			
                        FROM [Movies] 
                        CROSS APPLY Movies.About.nodes('about/reviews/review') AS x(r)
                        ORDER BY ENName;">
            </asp:SqlDataSource>            
            
        </div>        
    </div>

</asp:Content>