<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddMoviesDB.aspx.cs" Inherits="EDC_ProjetoFinal.AddMoviesDB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <br />
    <hr />
    <asp:Label ID="Label_Load" runat="server" Text="Load Movies" Font-Bold="true"></asp:Label>
    <hr />

    <div class="row">
        <div class="col-md-5 text-center"> 
            <asp:TextBox ID="TextBox1" runat="server" ForeColor="Black" Height="160px" TextMode="MultiLine" Width="470px"></asp:TextBox>
        </div>

        <div class="col-md-7 text-center"> 
                <div class="row">
                    <div class="col-md-1 text-center">Since: </div>
                    <div class="col-md-3 text-center"> 
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" />
                    </div>

                  <div class="col-md-1 text-center">Until: </div>
                    <div class="col-md-3 text-center">
                        <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control" />
                    </div>
       
                    <div class="col-md-2 text-center">
                        <asp:Button ID="Load" CssClass="btn btn-primary" runat="server" OnClick="Load_Click" Text="Load DB" />
                    </div>
                </div>
        </div>

    </div>
   
    <br />  

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Visible="False">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" />
            <asp:BoundField DataField="PTName" HeaderText="PTName" SortExpression="PTName" />
            <asp:BoundField DataField="ENName" HeaderText="ENName" SortExpression="ENName" />
            <asp:BoundField DataField="Genre" HeaderText="Genre" SortExpression="Genre" />
            <asp:BoundField DataField="Rating" HeaderText="Rating" SortExpression="Rating" />
            <asp:BoundField DataField="ProductionCountry" HeaderText="ProductionCountry" SortExpression="ProductionCountry" />
            <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
            <asp:BoundField DataField="OfficialURL" HeaderText="OfficialURL" SortExpression="OfficialURL" />
            <asp:BoundField DataField="BigImage" HeaderText="BigImage" SortExpression="BigImage" />
            <asp:BoundField DataField="SmallImage" HeaderText="SmallImage" SortExpression="SmallImage" />
            <asp:BoundField DataField="Actors" HeaderText="Actors" SortExpression="Actors" />
            <asp:BoundField DataField="Directors" HeaderText="Directors" SortExpression="Directors" />
            <asp:BoundField DataField="Argument" HeaderText="Argument" SortExpression="Argument" />
            <asp:BoundField DataField="Synopsis" HeaderText="Synopsis" SortExpression="Synopsis" />
            <asp:BoundField DataField="Distributor" HeaderText="Distributor" SortExpression="Distributor" />
        </Columns>
    </asp:GridView>

    <asp:XmlDataSource ID="XmlDataSource1" runat="server"></asp:XmlDataSource>

    <br />
    <hr />
    <asp:Label ID="Label_Delete" runat="server" Text="Delete DB" Font-Bold="true"></asp:Label>
    <hr />

    <div class="row">
        <div class="col-md-4 text-center"> 
            <asp:TextBox ID="TextBox2" runat="server" ForeColor="Black" Height="80px" TextMode="MultiLine" Width="470px"></asp:TextBox>
        </div>

        <div class="col-md-3 text-center"> 
            <asp:Button ID="DeleteButton" CssClass="btn btn-primary" runat="server" OnClick="Delete_Click" Text="Delete" />   
        </div>   
    </div>    
    <br />

</asp:Content>

