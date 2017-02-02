<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="displayReports.aspx.cs" Inherits="tp1.Personal.displayReports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Sales -->
    <div>
        <h2>As minhas vendas</h2>
    </div>
    <br />

    <!-- GridView --> 
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="title_id,stor_id,ord_num" DataSourceID="SqlDataSource1" class="table table-striped table-hover ">
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="UserName" ReadOnly="True" SortExpression="UserName" />
            <asp:BoundField DataField="title_id" HeaderText="title_id" ReadOnly="True" SortExpression="title_id" />
            <asp:BoundField DataField="title" HeaderText="title" SortExpression="title" />
            <asp:BoundField DataField="stor_id" HeaderText="stor_id" SortExpression="stor_id" ReadOnly="True" />
            <asp:BoundField DataField="ord_num" HeaderText="ord_num" SortExpression="ord_num" ReadOnly="True" />
            <asp:BoundField DataField="ord_date" HeaderText="ord_date" SortExpression="ord_date" />
            <asp:BoundField DataField="qty" HeaderText="qty" SortExpression="qty" />
            <asp:BoundField DataField="payterms" HeaderText="payterms" SortExpression="payterms" />
        </Columns>
    </asp:GridView>
 
    <!-- Database 1 -->
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:pubsConnectionString1 %>" SelectCommand="getMySales" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Username" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
