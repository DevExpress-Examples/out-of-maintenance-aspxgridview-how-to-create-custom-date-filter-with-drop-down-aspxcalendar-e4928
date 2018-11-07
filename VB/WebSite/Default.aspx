<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<script type="text/javascript">
		function OnKey(s, e) {
			if (e.htmlEvent.keyCode == 13) {
				ASPxClientUtils.PreventEventAndBubble(e.htmlEvent);

				if (/^[\d|/]+$/.test(s.GetText())) {
					grid.AutoFilterByColumn("ShippedDate", s.GetText());
				}
			}
		}

		function OnCalChanged(s, e) {
			var d = s.GetValue();
			var dd = (d.getMonth() + 1) + '/' + d.getDate() + '/' + d.getFullYear();
			dde.SetValue(dd);
			dde.HideDropDown();
			grid.AutoFilterByColumn("ShippedDate", dd);
		}

		function OnCustomButton(s, e) {
			if (e.buttonID == "clearFilter") {
				dde.SetValue();
				grid.ClearFilter();
			}
		}
	</script>
</head>
<body>
	<form id="form1" runat="server">

		<dx:ASPxGridView ID="ASPxGridView1" runat="server" ClientInstanceName="grid" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" >
			<Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="False">
                    <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton ID="clearFilter" Text="Clear" Visibility="FilterRow">
                        </dx:GridViewCommandColumnCustomButton>
                    </CustomButtons>
                </dx:GridViewCommandColumn>
				<dx:GridViewDataTextColumn FieldName="ShipName" VisibleIndex="1">
				</dx:GridViewDataTextColumn>
				<dx:GridViewDataTextColumn FieldName="ShipAddress" VisibleIndex="2">
				</dx:GridViewDataTextColumn>
				<dx:GridViewDataDateColumn FieldName="ShippedDate" VisibleIndex="3">
					<Settings AutoFilterCondition="Contains" FilterMode="DisplayText" />
					<FilterTemplate>
						<dx:ASPxDropDownEdit ClientInstanceName="dde" ID="ASPxDropDownEdit1" runat="server">
							<DropDownWindowTemplate>
								<dx:ASPxCalendar ID="ASPxCalendar1" runat="server">
									<ClientSideEvents ValueChanged="OnCalChanged" />
								</dx:ASPxCalendar>
							</DropDownWindowTemplate>
							<ClientSideEvents KeyPress="OnKey" />
						</dx:ASPxDropDownEdit>
					</FilterTemplate>
				</dx:GridViewDataDateColumn>
			</Columns>
			<Settings ShowFilterRow="True" />
			<ClientSideEvents CustomButtonClick="OnCustomButton" />
		</dx:ASPxGridView>
		<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>" SelectCommand="SELECT [ShipName], [ShipAddress], [ShippedDate] FROM [Invoices]"></asp:SqlDataSource>

	</form>
</body>
</html>