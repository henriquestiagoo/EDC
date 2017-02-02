<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="EDC_ParteC_Properties.Courses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <h2>Lista de Cursos</h2> 

        <!-- Dropdown and Filters -->
        <hr />
        <div class="row">
            <div class="col-md-1 text-center">Tipos: </div>
            <div class="col-md-5 text-center"> 
                <asp:DropDownList ID="listaDeGraus" runat="server" AutoPostBack="True" DataSourceID="XmlDataSource2" 
                    DataTextField="nome" DataValueField="nome" OnSelectedIndexChanged="listaDeGraus_SelectedIndexChanged" 
                    CssClass="form-control" >
                </asp:DropDownList>
                 <asp:XmlDataSource ID="XmlDataSource2" runat="server" DataFile="~/App_Data/courses.xml"
                    TransformFile="~/graus.xslt" 
                    XPath="Graus/grau[not(@nome=preceding:: grau/@nome)]"
                    EnableCaching="False" >
                 </asp:XmlDataSource>
            </div>
            <div class="col-md-1 text-center">Locais: </div>
            <div class="col-md-5 text-center">
                <asp:DropDownList ID="listaDeLocais" runat="server" AutoPostBack="True" DataSourceID="XmlDataSource3" 
                    DataTextField="nome" DataValueField="nome" OnSelectedIndexChanged="listaDeLocais_SelectedIndexChanged" 
                    CssClass="form-control">
                </asp:DropDownList>
                <asp:XmlDataSource ID="XmlDataSource3" runat="server" DataFile="~/App_Data/courses.xml"
                    TransformFile="~/locais.xslt" 
                    XPath="Locais/local[not(@nome=preceding:: local/@nome)]"
                    EnableCaching="False" >
                </asp:XmlDataSource>
          </div> 
        </div>
        <hr />

        <!--GridView -->
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="XmlDataSource1" GridLines="None" CssClass="table table-striped">
            <EmptyDataTemplate>
                <div class="panel panel-warning">
                    <div class="panel-heading"><h3 class="panel-title">ATENÇÃO!!!</h3></div>
                    <div class="panel-body">
                       Não há cursos desse tipo nessa instituição!
                    </div>
                </div>
            </EmptyDataTemplate>
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="guid" DataNavigateUrlFormatString="/Course.aspx?id={0}" DataTextField="guid" HeaderText="guid"  SortExpression="guid"/>
                <asp:BoundField DataField="nome" HeaderText="nome" SortExpression="nome" />
                <asp:BoundField DataField="grau" HeaderText="grau" SortExpression="grau" />
                <asp:BoundField DataField="local" HeaderText="local" SortExpression="local" />
            </Columns>
             <SelectedRowStyle BackColor="White" />
            <PagerStyle HorizontalAlign="Center" CssClass="pagination-ys"/>
        </asp:GridView>
         <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/courses.xml"
            TransformFile="~/courses.xslt" 
            EnableCaching="False" >
         </asp:XmlDataSource>
        
</asp:Content>

