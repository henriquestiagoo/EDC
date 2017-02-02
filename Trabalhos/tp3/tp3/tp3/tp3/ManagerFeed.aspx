<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManagerFeed.aspx.cs" Inherits="tp3.ManagerFeed" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><i class="fa fa-rss fa-4"></i> Gestão de feeds</h1>
     <hr />
    <asp:FormView ID="FormView1" runat="server" AllowPaging="True" DataSourceID="XmlDataSource1" OnItemUpdating="formFeeds_ItemUpdating" OnItemInserting="formFeeds_ItemInserting" OnItemDeleting="formFeeds_ItemDeliting" Width="100%">
        <EditItemTemplate>
             <table class="table table-bordered" border="0">
                <tr>
                    <td>Name:</td>
                    <td>
                        <asp:TextBox runat="server" ID="nameFeed" CssClass="form-control" Text='<%# Bind("name") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>URL:</td>
                    <td>
                        <asp:TextBox runat="server" ID="url" CssClass="form-control"  Text='<%# Bind("url") %>'></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:LinkButton ID="UpdateButton" runat="server" CssClass="btn btn-default" CommandName="Update"><i class="fa fa-floppy-o"></i></asp:LinkButton>
            <asp:LinkButton ID="UpdateCancelButton" runat="server" CssClass="btn btn-default" CommandName="Cancel"><i class="fa fa-times"></i></asp:LinkButton>
        </EditItemTemplate>
        <InsertItemTemplate>
           <table class="table table-bordered" border="0">
                <tr>
                    <td>Name:</td>
                    <td>
                        <asp:TextBox runat="server" ID="nameInsert" CssClass="form-control"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>URL:</td>
                    <td>
                        <asp:TextBox runat="server" ID="urlInsert" CssClass="form-control"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:LinkButton ID="InsertButton" runat="server" CssClass="btn btn-default" CommandName="Insert"><i class="fa fa-floppy-o"></i></asp:LinkButton>
            <asp:LinkButton ID="InsertCancelButton" runat="server" CssClass="btn btn-default" CommandName="Cancel"><i class="fa fa-times"></i></asp:LinkButton>
        </InsertItemTemplate>
        <ItemTemplate>
            <table class="table table-bordered">
                <tr>
                    <td class="col-xs-2">Name:</td>
                    <td class="col-xs-10">
                        <asp:Label runat="server" ID="nameLabel" Text='<%# Bind("name") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>URL:</td>
                    <td>
                        <asp:Label runat="server" ID="urlLabel" Text='<%# Bind("url") %>'></asp:Label>
                    </td>
                </tr>
            </table>
            <asp:LinkButton ID="editButton" runat="server" CssClass="btn btn-default" CommandName="Edit"><i class="fa fa-pencil-square-o"></i></asp:LinkButton>
            <asp:LinkButton ID="deleteButton" runat="server" CssClass="btn btn-default" CommandName="Delete"><i class="fa fa-trash"></i></asp:LinkButton>
            <asp:LinkButton ID="newButton" runat="server" CssClass="btn btn-default" CommandName="New"><i class="fa fa-plus"></i></asp:LinkButton>
        </ItemTemplate>
        <PagerStyle CssClass="pagination-ys" />
    </asp:FormView>

    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/FeddList.xml" XPath="/feeds/feed"></asp:XmlDataSource>
    <hr />
    <p></p>
    <asp:LinkButton ID="Fedds" PostBackUrl="~/Fedd.aspx" runat="server" CssClass="btn btn-primary"><i class="fa fa-rss"></i>&nbsp;Leitor de Feeds</asp:LinkButton>
</asp:Content>
