<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MostSeen.aspx.cs" Inherits="EDC_ProjetoFinal.MostSeen" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <br />
    <hr />
    <h4>Most Seen Movies:</h4>
    <hr />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
        SelectCommand="MostSeenMovies" 
        SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" GridLines="None" DataSourceID="SqlDataSource1" CssClass="table table-striped">
        <EmptyDataTemplate>
            <div class="panel panel-warning">
                <div class="panel-heading"><h3 class="panel-title">No User has seen any movie so far!!</h3></div>
                <div class="panel-body">
                    Go ahead and be the first one!!
                </div>
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:ImageField DataImageUrlField="SmallImageTemp2">
            </asp:ImageField>
            <asp:BoundField DataField="ENNameTemp2" HeaderText="Movie" />
            <asp:BoundField DataField="YearTemp2" HeaderText="Year">
            </asp:BoundField>
            <asp:BoundField DataField="NrSeens">
                <ItemStyle HorizontalAlign="right" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Seens">
                <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" />
            </asp:BoundField>         
            <asp:HyperLinkField DataNavigateUrlFields="IdTemp2" DataNavigateUrlFormatString="MoviesDetails.aspx?id={0}" Text="More">
            </asp:HyperLinkField>          
        </Columns>
    </asp:GridView>

</asp:Content>
