<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UpdateReview.aspx.cs" Inherits="EDC_ProjetoFinal.UpdateReview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <hr />
    <br />
    <br />
    
    <div class="row">
        <div class="col-md-3 text-center"> 
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" GridLines="None">
                <EmptyDataTemplate>
                    <div class="panel panel-warning">
                        <div class="panel-heading"><h3 class="panel-title">ATTENTION!!!</h3></div>
                        <div class="panel-body">
                            No Review has been succesfully loaded!!
                        </div>
                    </div>
                </EmptyDataTemplate>
                <Columns>
                    <asp:ImageField DataImageUrlField="SmallImage" >
                    </asp:ImageField>
                    <asp:BoundField DataField="ENName" SortExpression="ENName"/>
                </Columns>
            </asp:GridView>
        </div>
        <div class="col-md-2 text-left"> 
            <br />
            <asp:TextBox ID="TextBox1" runat="server" Height="75px" TextMode="MultiLine" Width="270px"></asp:TextBox>
            <asp:Button ID="Update_Button" runat="server" OnClick="Update_Click" Text="Update Review" Width="270px" CssClass="btn btn-primary" />
        </div>
    </div>
    <br />
 
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="select SmallImage, ENName from Movies
            where Id=@id">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
