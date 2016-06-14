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
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="idsensore_ambientale" DataSourceID="SqlDataSource1" AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexhanged" RowHeaderColumn="nome_centro">
            <Columns>
                <asp:BoundField DataField="timestamp" HeaderText="Orario misure" SortExpression="timestamp" />
                <asp:BoundField DataField="pressione" HeaderText="Pressione (mbar)" SortExpression="pressione" />
                <asp:BoundField DataField="temperatura" HeaderText="Temperatura (° C)" SortExpression="temperatura" />
                <asp:BoundField DataField="umidita" HeaderText="Umidità relativa (%)" SortExpression="umidita" />
                <asp:BoundField DataField="idsensore_ambientale" HeaderText="Identificativo sensore" ReadOnly="True" SortExpression="idsensore_ambientale" />
            </Columns>
        </asp:GridView>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT timestamp, pressione, temperatura, umidita, idsensore_ambientale FROM misura_ambientale" OnSelecting="SqlDataSource1_Selecting"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT indice_attività, timestamp FROM misura_actigrafo WHERE timestamp BETWEEN timestamp(DATE_SUB(NOW(), INTERVAL 1 MINUTE)) AND timestamp(NOW())"></asp:SqlDataSource>
            <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource2" OnLoad="Chart1_Load" Width="461px">
                <series>
                    <asp:Series Name="Series1" XValueMember="timestamp" YValueMembers="indice_attività" Legend="Legend1">
                    </asp:Series>
                </series>
                <chartareas>
                    <asp:ChartArea Name="ChartArea1">
                    </asp:ChartArea>
                </chartareas>
            </asp:Chart>
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
