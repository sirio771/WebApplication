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
        <asp:Label ID="Label2" runat="server" Text="Nome Titolare"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" Text="Cognome Titolare"></asp:Label>
        <br />
        <br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Login" />
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT nome_centro FROM palestra WHERE idtitolare = (SELECT idtitolare FROM titolare WHERE nome = @Nome AND cognome = @Cognome)"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT idactigrafo FROM actigrafo WHERE palestra_idluogo = (SELECT DISTINCT idluogo FROM palestra WHERE nome_centro = @nome_centro)"></asp:SqlDataSource>
        <br />
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label4" runat="server" Text="Palestra"></asp:Label>
        <br />
        <br />
        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource4" DataTextField="nome_centro" DataValueField="nome_centro" style="margin-bottom: 0px">
        </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Carica Sensori" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label5" runat="server" Text="Sensore"></asp:Label>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="idactigrafo" DataValueField="idactigrafo" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            </asp:DropDownList>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT timestamp, pressione, temperatura, umidita, idsensore_ambientale FROM misura_ambientale" OnSelecting="SqlDataSource1_Selecting"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT `indice_attività`, `timestamp` FROM misura_actigrafo WHERE (idactigrafo =@Param1) AND TIMESTAMP BETWEEN TIMESTAMP (DATE_SUB(NOW(), INTERVAL 1 MINUTE)) AND TIMESTAMP (NOW()) " OnSelecting="SqlDataSource2_Selecting"></asp:SqlDataSource>
            <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource2" OnLoad="Chart1_Load" style="margin-top: 0px" Width="884px">
                <Series>
                    <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Series1" XValueMember="timestamp" YValueMembers="indice_attività">
                    </asp:Series>
                </Series>
                <chartareas>
                    <asp:ChartArea Name="ChartArea1">
                    </asp:ChartArea>
                </chartareas>
                <Legends>
                    <asp:Legend Name="Legend1">
                    </asp:Legend>
                </Legends>
            </asp:Chart>
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="idsensore_ambientale" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexhanged" RowHeaderColumn="nome_centro" Width="734px">
                <Columns>
                    <asp:BoundField DataField="timestamp" HeaderText="Ora" SortExpression="timestamp" />
                    <asp:BoundField DataField="pressione" HeaderText="Pressione (mbar)" SortExpression="pressione" />
                    <asp:BoundField DataField="temperatura" HeaderText="Temperatura (°C)" SortExpression="temperatura" />
                    <asp:BoundField DataField="umidita" HeaderText="Umidità (%)" SortExpression="umidita" />
                    <asp:BoundField DataField="idsensore_ambientale" HeaderText="IDsensore" ReadOnly="True" SortExpression="idsensore_ambientale" />
                </Columns>
            </asp:GridView>
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
