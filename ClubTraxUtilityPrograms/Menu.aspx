<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="ClubTraxUtilityPrograms.Menu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


   
 
    
	 
	<h3><span> Menu<br />  </span></h3>
	<br />
     
		 
               <center>
				   Search by:   <asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem>PLU</asp:ListItem>
            <asp:ListItem>MenuItem</asp:ListItem>
            <asp:ListItem>PriceName</asp:ListItem>
        </asp:DropDownList>
				   as <asp:TextBox runat="server" ID="filter" /> <asp:Button ID="filterit" OnClick="filterit_Click" runat="server" Text="Filter" />
				   <br /><br />
				 
		 <asp:GridView ID="GridView1"       DataKeyNames="nID"  PageSize="100"  runat="server" AutoGenerateColumns="false"  Width="100%" AllowPaging="True" AllowCustomPaging="true" AllowSorting="True" DataSourceID="SqlDataSource1">
				<Columns>
				 
					<%--<asp:BoundField HeaderStyle-ForeColor="#cc0000"   DataField="id" Visible="true" HeaderText="id" />--%>

	
					<asp:BoundField HeaderStyle-ForeColor="#cc0000" SortExpression="PLU"  DataField="PLU" HeaderText="PLU" />
					<asp:BoundField  HeaderStyle-ForeColor="#cc0000" SortExpression="MenuItem"  DataField="MenuItem" HeaderText="MenuItem" />
					<asp:BoundField HeaderStyle-ForeColor="#cc0000"  sortexpression="pricename" DataField="PriceName" HeaderText="PriceName" />
					<asp:BoundField HeaderStyle-ForeColor="#cc0000"  DataField="nAmount" HeaderText="Amount" />
					<asp:BoundField HeaderStyle-ForeColor="#cc0000"  DataField="nDiscountPrice" HeaderText="DiscountPrice" />

			

		<%--			<asp:TemplateField ShowHeader="False">
    <ItemTemplate>
        <asp:ImageButton ID="DeleteButton"  runat="server" ImageUrl="images/del.png" width="25"  BorderWidth="0"
                    CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this Product?');"
                    AlternateText="Delete" />               
    </ItemTemplate>
</asp:TemplateField>  --%>
					 
					
				</Columns>
			</asp:GridView>
                   <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cn %>" SelectCommand="SELECT * FROM tempChangePricing ORDER BY [nID]"></asp:SqlDataSource>
	 

</asp:Content>





