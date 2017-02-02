
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MoviesSeen.aspx.cs" Inherits="EDC_ProjetoFinal.Personal.MoviesSeen" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <br />
    <hr />
    <h4>Movies Seen by you:</h4>
    <hr />

    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Medium" Text="Label" Visible="False"></asp:Label>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ReturnMoviesSeenFromUser" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="Label2" Name="tempUser" PropertyName="Text" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" GridLines="None" DataSourceID="SqlDataSource1" CssClass="table table-striped">
         <EmptyDataTemplate>
            <div class="panel panel-warning">
                <div class="panel-heading"><h3 class="panel-title">Still no Movies Seen ??</h3></div>
                <div class="panel-body">
                    Go ahead and add some Movie to the Seen List!!
                </div>
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:ImageField DataImageUrlField="SmallImage">
            </asp:ImageField>
            <asp:BoundField DataField="ENName" HeaderText="Movie" />
            <asp:BoundField DataField="Year" HeaderText="Year" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Id") %>' Visible="False"></asp:Label>                  
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4" GridLines="None"> 
                        <EmptyDataTemplate>
                            0 review(s) 
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="NrReviews" runat="server" Text='<%# Bind("NReviews") %>'></asp:Label>
                                    <asp:Label ID="Just_Reviews" runat="server" Text=" review(s)"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ReturnNrReviewsByMovie" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Label3" DefaultValue="0" Name="Id" PropertyName="Text" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>           
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="../MoviesDetails.aspx?id={0}" Text="More">
            </asp:HyperLinkField>
            <asp:HyperLinkField  DataNavigateUrlFields="Id" DataNavigateUrlFormatString="RemoveFromSeen.aspx?id={0}" Text="Remove from Seen">
            </asp:HyperLinkField>
        </Columns>
    </asp:GridView>

</asp:Content>
