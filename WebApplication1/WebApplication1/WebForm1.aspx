<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Gest_Palestre.WebForm1" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestione palestre</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
        <asp:Timer ID="timer1" runat="server" Interval="3000" OnTick="timer1_tick"></asp:Timer>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="actigrafo_idactigrafo" DataValueField="actigrafo_idactigrafo" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT timestamp, pressione, temperatura, umidita, idsensore_ambientale FROM misura_ambientale" OnSelecting="SqlDataSource1_Selecting"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT `indice_attività`, `timestamp` FROM misura_actigrafo WHERE (actigrafo_idactigrafo =@Param1) AND TIMESTAMP BETWEEN TIMESTAMP (DATE_SUB(NOW(), INTERVAL 1 MINUTE)) AND TIMESTAMP (NOW()) " OnSelecting="SqlDataSource2_Selecting"></asp:SqlDataSource>
            <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource2" OnLoad="Chart1_Load" style="margin-top: 0px" Width="461px">
                <series>
                    <asp:Series Legend="Legend1" Name="Series1" XValueMember="timestamp" YValueMembers="indice_attività">
                    </asp:Series>
                </series>
                <chartareas>
                    <asp:ChartArea Name="ChartArea1">
                    </asp:ChartArea>
                </chartareas>
                <Legends>
                    <asp:Legend Name="Legend1">
                    </asp:Legend>
                </Legends>
            </asp:Chart>
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="idsensore_ambientale" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexhanged" RowHeaderColumn="nome_centro">
                <Columns>
                    <asp:BoundField DataField="timestamp" HeaderText="timestamp" SortExpression="timestamp" />
                    <asp:BoundField DataField="pressione" HeaderText="pressione" SortExpression="pressione" />
                    <asp:BoundField DataField="temperatura" HeaderText="temperatura" SortExpression="temperatura" />
                    <asp:BoundField DataField="umidita" HeaderText="umidita" SortExpression="umidita" />
                    <asp:BoundField DataField="idsensore_ambientale" HeaderText="idsensore_ambientale" ReadOnly="True" SortExpression="idsensore_ambientale" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT actigrafo_idactigrafo FROM misura_actigrafo"></asp:SqlDataSource>
        </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="timer1" EventName ="tick"/>
            </Triggers>
        </asp:UpdatePanel>
        <br />
    
    </div>
    </form>
</body>
</html>
