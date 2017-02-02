<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Fedd.aspx.cs" Inherits="tp3.Fedd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><i class="fa fa-rss fa-4"></i> My Feed Reader</h1>
    <asp:XmlDataSource ID="XmlDataSource4" runat="server" DataFile="~/public_feeds.xml"></asp:XmlDataSource>
    <asp:XmlDataSource ID="XmlDataSource5" runat="server" DataFile="~/Publico_feed.xml" TransformFile="~/RSS.xslt"></asp:XmlDataSource>
    <hr />
    <div class="row">
        <asp:XmlDataSource ID="XmlDataSource2" runat="server" TransformFile="~/RSS.xslt" DataFile="~/public_feeds.xml" XPath="rss/channel"></asp:XmlDataSource>
        <div class="col-md-6" style="text-align: center">
            <asp:DropDownList ID="DropDownList1" CssClass="form-control" AutoPostBack="true"  runat="server"  DataSourceID="XmlDataSource1" DataTextField="name" DataValueField="name" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
            <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/FeddList.xml"></asp:XmlDataSource>
         <div class="col-md-5" style="text-align: right; margin-top: 0px; ">
             <asp:Button ID="Button1" runat="server" Text="Manage Feeds" CssClass="btn btn-primary" OnClick="btnConfirm_Click" />
         </div>
         <div class="col-md-1" style="text-align: right; margin-top: 0px;">
             <asp:Button ID="Button2" runat="server" Text="Aggregator" CssClass="btn btn-primary" OnClick="Aggregator_Click" />
         </div>
         
      </div >

      <div class="row">
           <div class="col-md-6">
                <h3> Feed Info </h3>
               <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="392px" AutoGenerateRows="False" DataSourceID="XmlDataSource2" class="table table-striped table-hover ">
                   <Fields>
                       <asp:BoundField DataField="title" HeaderText="title" SortExpression="title" />
                       <asp:BoundField DataField="link" HeaderText="link" SortExpression="link" />
                       <asp:BoundField DataField="language" HeaderText="language" SortExpression="language" />
                       <asp:BoundField DataField="description" HeaderText="description" SortExpression="description" />
                       <asp:BoundField DataField="managingEditor" HeaderText="managingEditor" SortExpression="managingEditor" />
                       <asp:BoundField DataField="webMaster" HeaderText="webMaster" SortExpression="webMaster" />
                       <asp:BoundField DataField="lastBuildDate" HeaderText="lastBuildDate" SortExpression="lastBuildDate" />
                       <asp:BoundField DataField="category" HeaderText="category" SortExpression="category" />
                       <asp:BoundField DataField="image" HeaderText="image" SortExpression="image" />
                   </Fields>
                </asp:DetailsView>
               </div>

            <div class="col-md-6 text-center">
                <h3>Feed Image</h3>
                <div class="row">
                    <div class="col-xs-4">
                         <asp:Image ID="Image1" runat="server"  style="width:160px" class="img-responsive img-radio" />
                    </div>
                    <div class="col-xs-4">
                    </div>
                </div>
            </div>
     </div>
        <div>
            <h3>
            Feed News
            </h3>
             <asp:XmlDataSource ID="XmlDataSource3" runat="server" DataFile="~/public_feeds.xml" TransformFile="~/RSS.xslt" XPath="rss/channel/item"></asp:XmlDataSource>
            <asp:ListView ID="ListView1" runat="server" DataSourceID="XmlDataSource3" GroupItemCount="3">
                <AlternatingItemTemplate>
                    <td runat="server" style="background-color: #FFFFFF;color: #284775;">title:
                        <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>' />
                        <br />description:
                        <asp:Label ID="descriptionLabel" runat="server" Text='<%# Eval("description") %>' />
                        <br />link:
                        <asp:Label ID="linkLabel" runat="server" Text='<%# Eval("link") %>' />
                        <br />category:
                        <asp:Label ID="categoryLabel" runat="server" Text='<%# Eval("category") %>' />
                        <br />pubDate:
                        <asp:Label ID="pubDateLabel" runat="server" Text='<%# Eval("pubDate") %>' />
                        <br /></td>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <td runat="server" style="background-color: #999999;">title:
                        <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' />
                        <br />description:
                        <asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' />
                        <br />link:
                        <asp:TextBox ID="linkTextBox" runat="server" Text='<%# Bind("link") %>' />
                        <br />category:
                        <asp:TextBox ID="categoryTextBox" runat="server" Text='<%# Bind("category") %>' />
                        <br />pubDate:
                        <asp:TextBox ID="pubDateTextBox" runat="server" Text='<%# Bind("pubDate") %>' />
                        <br />
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                        <br />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        <br /></td>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <EmptyItemTemplate>
<td runat="server" />
                </EmptyItemTemplate>
                <GroupTemplate>
                    <tr id="itemPlaceholderContainer" runat="server">
                        <td id="itemPlaceholder" runat="server"></td>
                    </tr>
                </GroupTemplate>
                <InsertItemTemplate>
                    <td runat="server" style="">title:
                        <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' />
                        <br />description:
                        <asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' />
                        <br />link:
                        <asp:TextBox ID="linkTextBox" runat="server" Text='<%# Bind("link") %>' />
                        <br />category:
                        <asp:TextBox ID="categoryTextBox" runat="server" Text='<%# Bind("category") %>' />
                        <br />pubDate:
                        <asp:TextBox ID="pubDateTextBox" runat="server" Text='<%# Bind("pubDate") %>' />
                        <br />
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                        <br />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                        <br /></td>
                </InsertItemTemplate>
                <ItemTemplate>
                    <td runat="server" style="background-color: #E0FFFF;color: #333333;">title:
                        <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>' />
                        <br />description:
                        <asp:Label ID="descriptionLabel" runat="server" Text='<%# Eval("description") %>' />
                        <br />link:
                        <asp:Label ID="linkLabel" runat="server" Text='<%# Eval("link") %>' />
                        <br />category:
                        <asp:Label ID="categoryLabel" runat="server" Text='<%# Eval("category") %>' />
                        <br />pubDate:
                        <asp:Label ID="pubDateLabel" runat="server" Text='<%# Eval("pubDate") %>' />
                        <br /></td>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table id="groupPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                    <tr id="groupPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="text-align: center;background-color: #5D7B9D;font-family: Verdana, Arial, Helvetica, sans-serif;color: #FFFFFF">
                                <asp:DataPager ID="DataPager1" runat="server" PageSize="12">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                        <asp:NumericPagerField />
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <td runat="server" style="background-color: #E2DED6;font-weight: bold;color: #333333;">title:
                        <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>' />
                        <br />description:
                        <asp:Label ID="descriptionLabel" runat="server" Text='<%# Eval("description") %>' />
                        <br />link:
                        <asp:Label ID="linkLabel" runat="server" Text='<%# Eval("link") %>' />
                        <br />category:
                        <asp:Label ID="categoryLabel" runat="server" Text='<%# Eval("category") %>' />
                        <br />pubDate:
                        <asp:Label ID="pubDateLabel" runat="server" Text='<%# Eval("pubDate") %>' />
                        <br /></td>
                </SelectedItemTemplate>
                </asp:ListView>
        </div>
    <div runat="server" ID="news" class="row"></div>
</asp:Content>
