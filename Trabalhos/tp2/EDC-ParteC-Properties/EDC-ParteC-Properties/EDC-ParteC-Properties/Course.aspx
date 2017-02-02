<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Course.aspx.cs" Inherits="EDC_ParteC_Properties.Course" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        
    <h2>Informação do curso</h2>
    <hr />

    <asp:DetailsView ID="DetailsView1" runat="server" DataSourceID="XmlDataSource1" AutoGenerateRows="False" CssClass="table table-bordered table-hover" AlternatingRowStyle-BackColor="Red">
<AlternatingRowStyle BackColor="Red"></AlternatingRowStyle>
        <EmptyDataTemplate>
        There is no data to display
    </EmptyDataTemplate>
        <Fields>
            <asp:BoundField DataField="guid" HeaderText="guid" SortExpression="guid"  HeaderStyle-BackColor="#ddffcc" ItemStyle-BackColor="#f2f2f2" HeaderStyle-BorderColor="Black" HeaderStyle-Font-Bold="true" ItemStyle-BorderColor="Black"/>
            <asp:BoundField DataField="nome" HeaderText="nome" SortExpression="nome" HeaderStyle-BackColor="#ddffcc" ItemStyle-BackColor="#f2f2f2" HeaderStyle-BorderColor="Black" HeaderStyle-Font-Bold="true" ItemStyle-BorderColor="Black"/>
            <asp:BoundField DataField="codigo" HeaderText="código" SortExpression="codigo" HeaderStyle-BackColor="#ddffcc" ItemStyle-BackColor="#f2f2f2" HeaderStyle-Font-Bold="true" HeaderStyle-BorderColor="Black" ItemStyle-BorderColor="Black"/>
            <asp:BoundField DataField="grau" HeaderText="grau" SortExpression="grau" HeaderStyle-BackColor="#ddffcc" ItemStyle-BackColor="#f2f2f2" HeaderStyle-Font-Bold="true" HeaderStyle-BorderColor="Black" ItemStyle-BorderColor="Black"/>
            <asp:BoundField DataField="vagas" HeaderText="vagas" SortExpression="vagas" HeaderStyle-BackColor="#ddffcc"  ItemStyle-BackColor="#f2f2f2" HeaderStyle-Font-Bold="true" HeaderStyle-BorderColor="Black" ItemStyle-BorderColor="Black"/>
            <asp:BoundField DataField="saidas_profissionais" HeaderText="saídas profissionais" SortExpression="saidas_profissionais" HtmlEncode="false" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="#ddffcc" ItemStyle-BackColor="#f2f2f2" HeaderStyle-BorderColor="Black" ItemStyle-BorderColor="Black"/>
            <asp:BoundField DataField="fase1" HeaderText="média [1ª fase]" SortExpression="fase1" HeaderStyle-BackColor="#ddffcc" ItemStyle-BackColor="#f2f2f2" HeaderStyle-Font-Bold="true" HeaderStyle-BorderColor="Black" ItemStyle-BorderColor="Black"/>
            <asp:BoundField DataField="fase2" HeaderText="média [2ª fase]" SortExpression="fase2" HeaderStyle-BackColor="#ddffcc" ItemStyle-BackColor="#f2f2f2" HeaderStyle-Font-Bold="true" HeaderStyle-BorderColor="Black" ItemStyle-BorderColor="Black" />
            <asp:BoundField DataField="duracao" HeaderText="duração" SortExpression="duracao" HeaderStyle-BackColor="#ddffcc" ItemStyle-BackColor="#f2f2f2" HeaderStyle-Font-Bold="true" HeaderStyle-BorderColor="Black" ItemStyle-BorderColor="Black"/>
            <asp:BoundField DataField="provas" HeaderText="provas" SortExpression="provas" HeaderStyle-BackColor="#ddffcc" ItemStyle-BackColor="#f2f2f2" HeaderStyle-Font-Bold="true" HeaderStyle-BorderColor="Black" ItemStyle-BorderColor="Black" HtmlEncode="false"/>
        </Fields>
    </asp:DetailsView>

     <asp:XmlDataSource ID="XmlDataSource1" runat="server" 
         TransformFile="~/details.xslt" DataFile="~/App_Data/mect.xml">
     </asp:XmlDataSource>

</asp:Content>
