<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reviews.aspx.cs" Inherits="EDC_ProjetoFinal.Reviews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <br />
    <hr />
    <h3>Your Reviews:</h3>
    <hr />
    <br />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ReturnReviewsFromUser" SelectCommandType="StoredProcedure">
         <SelectParameters>
            <asp:ControlParameter ControlID="Label1" DefaultValue="" Name="x" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label> 

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" GridLines="None" CssClass="table table-striped">
        <EmptyDataTemplate>
            <div class="panel panel-warning">
                <div class="panel-heading"><h3 class="panel-title">Still no Reviews ??</h3></div>
                <div class="panel-body">
                    Go ahead and do some Reviews on your favorite movies!!
                </div>
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:ImageField DataImageUrlField="SmallImage">
            </asp:ImageField>
            <asp:BoundField DataField="ENName" HeaderText="Movie" />
            <asp:BoundField ApplyFormatInEditMode="True" DataField="review" HeaderText="Review" />
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="../MoviesDetails.aspx?id={0}" Text="More">
            </asp:HyperLinkField>        
            <asp:HyperLinkField DataNavigateUrlFields="Id,review" DataNavigateUrlFormatString="UpdateReview.aspx?id={0}&amp;text={1}" Text="Editar Review">
            </asp:HyperLinkField>
            <asp:HyperLinkField  DataNavigateUrlFields="Id,review" DataNavigateUrlFormatString="DeleteReview.aspx?id={0}&amp;text={1}" Text="Apagar Review">
            </asp:HyperLinkField>
        </Columns>
    </asp:GridView>

</asp:Content>
