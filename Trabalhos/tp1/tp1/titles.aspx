﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="titles.aspx.cs" Inherits="tp1.titles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- Filter Title-->
    <div>
        <h2>Publication type</h2>
    </div>

    <!-- DropDownList - Types -->
    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="type" DataValueField="type" class="form-control" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
    </asp:DropDownList>

    <!-- Database 2 -->
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:pubsConnectionString1 %>" SelectCommand="SELECT DISTINCT [type] FROM [titles]">
    </asp:SqlDataSource>
    <br />

    <!-- Titles -->
    <div>
        <h2>Titles</h2>
    </div>

    <!-- GridView -->
    <asp:GridView ID="GridView1" runat="server" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="title_id" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display." class="table table-striped table-hover ">
        <PagerStyle CssClass="pagination-ys" />
        <Columns>
            <asp:BoundField DataField="title_id" HeaderText="title_id" ReadOnly="True" SortExpression="title_id"/>
            <asp:BoundField DataField="title" HeaderText="title" SortExpression="title" />
            <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />
            <asp:BoundField DataField="pub_id" HeaderText="pub_id" SortExpression="pub_id" />
            <asp:TemplateField ShowHeader="True" HeaderText="Comandos">
                <ItemTemplate> 
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"><i class="fa fa-check-square-o"></i></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <!-- Database 1 -->
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:pubsConnectionString1 %>" SelectCommand="SELECT [title_id], [title], [type], [pub_id] FROM [titles] WHERE ([type] = @type)" DeleteCommand="DELETE FROM [titles] WHERE [title_id] = @title_id" InsertCommand="INSERT INTO [titles] ([title_id], [title], [type], [pub_id]) VALUES (@title_id, @title, @type, @pub_id)" UpdateCommand="UPDATE [titles] SET [title] = @title, [type] = @type, [pub_id] = @pub_id WHERE [title_id] = @title_id">
        <DeleteParameters>
            <asp:Parameter Name="title_id" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="title_id" Type="String" />
            <asp:Parameter Name="title" Type="String" />
            <asp:Parameter Name="type" Type="String" />
            <asp:Parameter Name="pub_id" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="type" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="title" Type="String" />
            <asp:Parameter Name="type" Type="String" />
            <asp:Parameter Name="pub_id" Type="String" />
            <asp:Parameter Name="title_id" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <!-- Details View -->
    <asp:DetailsView ID="DetailsView1" runat="server" class="table table" GridLines="None" AutoGenerateRows="False" DataKeyNames="title_id" DataSourceID="SqlDataSource3" Height="50px" Width="793px" OnItemUpdated="ItemUpdated">
        <Fields>
            <asp:TemplateField HeaderText="title_id" SortExpression="title_id">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("title_id") %>'></asp:Label>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("title_id") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("title_id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="title" SortExpression="title">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" class="form-control" Text='<%# Bind("title") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" class="form-control" Text='<%# Bind("title") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("title") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="type" SortExpression="type">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="type" DataValueField="type" class="form-control" Text='<%# Bind("type") %>' />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("type") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("type") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="pub_id" SortExpression="pub_id">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" class="form-control" Text='<%# Bind("pub_id") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" class="form-control" Text='<%# Bind("pub_id") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("pub_id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="price" SortExpression="price">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" class="form-control" Text='<%# Bind("price") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" class="form-control" Text='<%# Bind("price") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("price") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="advance" SortExpression="advance">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" class="form-control" Text='<%# Bind("advance") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" class="form-control" Text='<%# Bind("advance") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("advance") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="royalty" SortExpression="royalty">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox6" runat="server" class="form-control" Text='<%# Bind("royalty") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox6" runat="server" class="form-control" Text='<%# Bind("royalty") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("royalty") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ytd_sales" SortExpression="ytd_sales">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox7" runat="server" class="form-control" Text='<%# Bind("ytd_sales") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox7" runat="server" class="form-control" Text='<%# Bind("ytd_sales") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("ytd_sales") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="notes" SortExpression="notes">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox8" runat="server" class="form-control" Rows="3" TextMode="multiline" Columns="60" Text='<%# Bind("notes") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox8" runat="server" class="form-control" Rows="3" TextMode="multiline" Columns="60" Text='<%# Bind("notes") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("notes") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="pubdate" SortExpression="pubdate">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox9" runat="server" class="form-control" Text='<%# Bind("pubdate") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox9" runat="server" class="form-control" Text='<%# Bind("pubdate") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("pubdate") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"><i class="fa fa-floppy-o"></i></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"><i class="fa fa-times"></i></asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Fields>
        <HeaderTemplate><h2>Title details</h2></HeaderTemplate>
    </asp:DetailsView>

    <!-- Database 3 -->
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:pubsConnectionString1 %>" SelectCommand="SELECT * FROM [titles] WHERE ([title_id] = @title_id)" DeleteCommand="DELETE FROM [titles] WHERE [title_id] = @title_id" InsertCommand="INSERT INTO [titles] ([title_id], [title], [type], [pub_id], [price], [advance], [royalty], [ytd_sales], [notes], [pubdate]) VALUES (@title_id, @title, @type, @pub_id, @price, @advance, @royalty, @ytd_sales, @notes, @pubdate)" UpdateCommand="UPDATE [titles] SET [title] = @title, [type] = @type, [pub_id] = @pub_id, [price] = @price, [advance] = @advance, [royalty] = @royalty, [ytd_sales] = @ytd_sales, [notes] = @notes, [pubdate] = @pubdate WHERE [title_id] = @title_id">
        <DeleteParameters>
            <asp:Parameter Name="title_id" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="title_id" Type="String" />
            <asp:Parameter Name="title" Type="String" />
            <asp:Parameter Name="type" Type="String" />
            <asp:Parameter Name="pub_id" Type="String" />
            <asp:Parameter Name="price" Type="Decimal" />
            <asp:Parameter Name="advance" Type="Decimal" />
            <asp:Parameter Name="royalty" Type="Int32" />
            <asp:Parameter Name="ytd_sales" Type="Int32" />
            <asp:Parameter Name="notes" Type="String" />
            <asp:Parameter Name="pubdate" Type="DateTime" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="title_id" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="title" Type="String" />
            <asp:Parameter Name="type" Type="String" />
            <asp:Parameter Name="pub_id" Type="String" />
            <asp:Parameter Name="price" Type="Decimal" />
            <asp:Parameter Name="advance" Type="Decimal" />
            <asp:Parameter Name="royalty" Type="Int32" />
            <asp:Parameter Name="ytd_sales" Type="Int32" />
            <asp:Parameter Name="notes" Type="String" />
            <asp:Parameter Name="pubdate" Type="DateTime" />
            <asp:Parameter Name="title_id" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>    

</asp:Content>