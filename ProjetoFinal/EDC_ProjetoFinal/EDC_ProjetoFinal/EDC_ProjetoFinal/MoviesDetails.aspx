<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MoviesDetails.aspx.cs" Inherits="EDC_ProjetoFinal.MoviesDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Stars CSS -->
    <style>
        .starRating {
			width:25px;
			height:25px;
			cursor:pointer;
			background-repeat:no-repeat;
			display:block;
		}

		.filledStar {
			background-image:url("Images/smallFilledStar.png");
		}

		.waitingStar {
			background-image:url("Images/smallFilledStar.png");
		}

		.EmptyStar {
			background-image:url("Images/smallEmptyStar.png");
		}
    </style>

    <br />
    <hr />
    <br />
    <br />

    <div class="row">
            <div class="col-md-4 text-center"> 
                <asp:DetailsView ID="DetailsView1" runat="server" Height="50px"  CellPadding="4" GridLines="None" AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" CssClass="table table-striped">
                    <Fields>
                        <asp:ImageField DataImageUrlField="BigImage" />
                    </Fields>
                </asp:DetailsView>
            </div>

             <div class="col-md-8 text-center"> 
                 <asp:DetailsView ID="DetailsView2" runat="server" GridLines="None" AutoGenerateRows="False" OnLoad="DetailsView2_Load" DataKeyNames="Id" DataSourceID="SqlDataSource1" CssClass="table table-striped">
                     <RowStyle HorizontalAlign="Left" />
                     <HeaderStyle Font-Bold="True"/>
                     <Fields>
                        <asp:BoundField DataField="ENName" HeaderText="Original Title:" SortExpression="ENName" />
                        <asp:BoundField DataField="PTName" HeaderText="Portuguese Title:" SortExpression="PTName" />
                         <asp:BoundField DataField="Year" HeaderText="Year:" SortExpression="Year" />
                        <asp:BoundField DataField="Genre" HeaderText="Genre:" SortExpression="Genre" />
                        <asp:BoundField DataField="Rating" HeaderText="Rating:" SortExpression="Rating" />
                        <asp:BoundField DataField="ProductionCountry" HeaderText="Production Country:" SortExpression="ProductionCountry" />
                        <asp:HyperLinkField DataNavigateUrlFields="OfficialURL" ControlStyle-ForeColor="black" DataTextField="OfficialURL" HeaderText="Official URL:" />
                        <asp:BoundField DataField="Actors" HeaderText="Actors:" SortExpression="Actors" />
                        <asp:BoundField DataField="Directors" HeaderText="Director(s):" SortExpression="Directors" />
                        <asp:BoundField DataField="Argument" HeaderText="Argument:" SortExpression="Argument" />
                        <asp:BoundField DataField="Distributor" HeaderText="Distributor:" SortExpression="Distributor" />
                    </Fields>
                </asp:DetailsView>

                 <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT * FROM [Movies] WHERE ([Id] = @Id)">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="15938" Name="Id" QueryStringField="Id" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>    
            </div>
        </div>
    <br />

    <asp:DetailsView ID="DetailsView3" runat="server" Height="50px" CellPadding="4" GridLines="None" AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" CssClass="table table-striped">
        <Fields>
            <asp:BoundField DataField="Synopsis" SortExpression="Synopsis" />
        </Fields>
    </asp:DetailsView>

    <br />

    <div class="row">
        <div class="col-md-1 text-left"> 
            <asp:Label ID="Label3" runat="server" Text="Rating: "></asp:Label>
        </div>
        
        <div class="col-md-4 text-left"> 
            <asp:Label runat="server" ID="Label_Stars" Visible="false"></asp:Label>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>         
                    <ajaxToolkit:Rating ID="Rating1" runat="server" AutoPostBack="true" StarCssClass="starRating" FilledStarCssClass="filledStar" EmptyStarCssClass="EmptyStar" WaitingStarCssClass="waitingStar" MaxRating="10">
                    </ajaxToolkit:Rating>
                    <asp:Label ID="Label_Rate" runat="server"></asp:Label>
                    <asp:Button ID="Rating_Button" runat="server" style="margin-left:0.2cm;" Text="Rate" CssClass="btn btn-primary" OnClick="Rating_Button_Click"/>
                </ContentTemplate>
            </asp:UpdatePanel>            
        </div>

        <div class="col-md-3 text-center"> 
            <asp:LinkButton ID="Seen_Button"  runat="server" CssClass="btn btn-primary" OnClick="Seen_Click"><i class="fa fa-rss"></i>&nbsp;Add to seen!</asp:LinkButton>
        </div>

        <div class="col-md-3 text-center"> 
            <asp:LinkButton ID="Favs_Button" runat="server" CssClass="btn btn-primary" OnClick="Favs_Button_Clicked"><i class="fa fa-heart"></i>&nbsp;Add to Favourites!</asp:LinkButton>
        </div>    
    </div>

    <br />
    <br />

    <!-- Microformat hReview -->
    <div class="hreview">
        <asp:Label ID="LabelReview" runat="server" Text="Add review: "></asp:Label>
        <asp:Label ID="LabelReviewer" runat="server" class="reviewer vcard" Visible="false"></asp:Label>
        <asp:Label ID="LabelDate" runat="server" class="dtreviewed" Visible="false"></asp:Label>
        <br />
        <div class="description item vcard">
            <asp:TextBox ID="TextBox1" runat="server" ForeColor="Black" Height="117px" 
                MaxLength="5" TextMode="MultiLine" Width="839px" >
            </asp:TextBox>
        </div>
    </div>
    <!-- End -->
    
    <br /> 
    
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add Review" CssClass="btn btn-primary" />
    <br />
    <br />

    <hr />
    <h4>Reviews: </h4>
    <hr />
    <br />
    
    <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label> 

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource2" GridLines="None" CssClass="table table-striped">
        <EmptyDataTemplate>
            <div class="panel panel-warning">
                <div class="panel-heading"><h3 class="panel-title">The movie doesn't have reviews yet!</h3></div>
                <div class="panel-body">
                    Go ahead and make a review!
                </div>
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField DataField="User" HeaderText="User" ReadOnly="True" SortExpression="User" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Silver"/>
            <asp:BoundField DataField="Review" HeaderText="Review" ReadOnly="True" SortExpression="Review" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Silver" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Id],
	        r.value('@user','varchar(100)') as [User],
	        r.value('@text','varchar(300)') as [Review]			
            FROM [Movies] 
            CROSS APPLY Movies.About.nodes('about/reviews/review') AS x(r) 
            where Movies.Id = @Id
        ">
        <SelectParameters>
            <asp:QueryStringParameter Name="Id" QueryStringField="Id" />
        </SelectParameters>
    </asp:SqlDataSource>

    <br />
    <br />

</asp:Content>
