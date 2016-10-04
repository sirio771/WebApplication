<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Gest_Palestre.WebForm1" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestione palestre</title>
    <link rel="stylesheet" type="text/css" href="StyleSheet1.css">
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="login_div">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
        <asp:Timer ID="timer1" runat="server" Interval="3000" OnTick="timer1_tick"></asp:Timer>
        <asp:Label ID="Label2" runat="server" Text="Nome Titolare" Font-Bold="True" Font-Names="Calibri" Font-Size="Large"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<asp:Label ID="Label3" runat="server" Text="Cognome Titolare" BorderColor="#000099" Font-Bold="True" Font-Names="Calibri" Font-Size="Large"></asp:Label>
        <br />
        <br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="LoginButton" runat="server" OnClick="Button1_Click" Text="Visualizza Palestre" />
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT nome_centro FROM palestra WHERE idtitolare = (SELECT idtitolare FROM titolare WHERE nome = @Nome AND cognome = @Cognome)"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT idactigrafo FROM actigrafo WHERE palestra_idluogo = (SELECT DISTINCT idluogo FROM palestra WHERE nome_centro = @nome_centro)"></asp:SqlDataSource>
        <br />
&nbsp;&nbsp;&nbsp;
        </div>
        <div id="palestre__div">
        <asp:Label ID="Label4" runat="server" Text="Palestre" Font-Bold="True" Font-Names="Calibri" Font-Size="Large"></asp:Label>
        <br />
        <br />
        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource4" DataTextField="nome_centro" DataValueField="nome_centro" style="margin-bottom: 0px" Font-Size="Medium">
        </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="SensorButton" runat="server" OnClick="Button2_Click" Text="Carica Sensori" />
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <br />
            <br />
            <div id="labelPalestra">
            <asp:Label ID="Label1" runat="server" Text="Label" Font-Bold="True" Font-Names="Calibri"></asp:Label>
            </div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <div id="sensore_div">
            <asp:Label ID="Label5" runat="server" Text="Sensore" Font-Italic="True" Font-Names="Calibri"></asp:Label>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="idactigrafo" DataValueField="idactigrafo" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Font-Size="Medium">
            </asp:DropDownList>
            <br />
            </div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT timestamp, pressione, temperatura, umidita, idsensore_ambientale FROM misura_ambientale WHERE idsensore_ambientale IN (SELECT idsensore FROM sensore_ambientale WHERE idluogo = (SELECT idluogo FROM palestra WHERE nome_centro = @Nome)) ORDER BY idmisura DESC LIMIT 20 " OnSelecting="SqlDataSource1_Selecting"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT idsensore FROM storico_errore WHERE idsensore IN (SELECT idsensore FROM sensore_ambientale WHERE idluogo = (SELECT idluogo FROM palestra WHERE nome_centro = @NomePalestra)) AND TIMESTAMP BETWEEN TIMESTAMP (DATE_SUB(NOW(), INTERVAL 1 MINUTE)) AND TIMESTAMP (NOW()) "></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT `indice_attività`, `timestamp` FROM misura_actigrafo WHERE (idactigrafo =@Param1) AND TIMESTAMP BETWEEN TIMESTAMP (DATE_SUB(NOW(), INTERVAL 1 MINUTE)) AND TIMESTAMP (NOW()) " OnSelecting="SqlDataSource2_Selecting"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT nome, cognome FROM utente WHERE actigrafo_idactigrafo = @actigrafo"></asp:SqlDataSource>
            <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource2" OnLoad="Chart1_Load" style="margin-top: 0px" Width="1162px" Height="539px">
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
            <asp:Image ID="Image1" runat="server" />
            <br />
            <br />
            <asp:Label ID="gymLabel" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Large" Text="Stato Palestra: "></asp:Label>
            <br />
            <asp:Label ID="alarmLabel" runat="server" Font-Italic="True" Font-Names="Calibri" Font-Size="Large"></asp:Label>
            <br />
            <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT * FROM storico_errore WHERE idsensore IN (SELECT DISTINCT idsensore FROM sensore_ambientale WHERE idluogo = (SELECT idluogo FROM palestra WHERE nome_centro = @NomePalestra)) AND TIMESTAMP BETWEEN TIMESTAMP (DATE_SUB(NOW(), INTERVAL 1 MINUTE)) AND TIMESTAMP (NOW()) ORDER BY iderrore DESC LIMIT 1"></asp:SqlDataSource>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="iderrore,idmisure,idsensore" DataSourceID="SqlDataSource7">
                <Columns>
                    <asp:BoundField DataField="iderrore" HeaderText="iderrore" InsertVisible="False" ReadOnly="True" SortExpression="iderrore" />
                    <asp:BoundField DataField="erPress" HeaderText="erPress" SortExpression="erPress" />
                    <asp:BoundField DataField="erTemp" HeaderText="erTemp" SortExpression="erTemp" />
                    <asp:BoundField DataField="erUmid" HeaderText="erUmid" SortExpression="erUmid" />
                    <asp:BoundField DataField="timestamp" HeaderText="timestamp" SortExpression="timestamp" />
                    <asp:BoundField DataField="idmisure" HeaderText="idmisure" ReadOnly="True" SortExpression="idmisure" />
                    <asp:BoundField DataField="idsensore" HeaderText="idsensore" ReadOnly="True" SortExpression="idsensore" />
                </Columns>
            </asp:GridView>
            <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource1" Height="413px" OnLoad="Chart2_Load" Width="956px">
                <Series>
                    <asp:Series BorderWidth="10" ChartType="Line" Color="Red" Legend="Legend1" Name="Temperatura" XValueMember="timestamp" YValueMembers="temperatura">
                    </asp:Series>
                    <asp:Series BorderWidth="10" ChartArea="ChartArea1" ChartType="Line" Color="Yellow" Legend="Legend1" Name="Umidità" XValueMember="timestamp" YValueMembers="umidita">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                        <AxisY Title="°C">
                        </AxisY>
                        <AxisX Title="Tempo">
                        </AxisX>
                        <AxisY2 Enabled="True" Title="%">
                        </AxisY2>
                    </asp:ChartArea>
                </ChartAreas>
                <Legends>
                    <asp:Legend Name="Legend1" TitleFont="Microsoft Sans Serif, 12pt, style=Bold">
                    </asp:Legend>
                </Legends>
            </asp:Chart>
            <asp:Chart ID="Chart3" runat="server" DataSourceID="SqlDataSource8" Height="400px" ImageLocation="" OnLoad="Chart3_Load" Width="400px">
                <Series>
                    <asp:Series BorderWidth="100" ChartType="Bubble" Color="Black" Name="Series1" XValueMember="temperatura" YValueMembers="umidita" YValuesPerPoint="2">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea BackImage="~/Models/afa.gif" BackImageAlignment="TopRight" Name="ChartArea1">
                        <AxisY Maximum="100" Minimum="10" Title="%">
                        </AxisY>
                        <AxisX Maximum="42" Minimum="19" Title="°C">
                        </AxisX>
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
            <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT timestamp, pressione, temperatura, umidita, idsensore_ambientale FROM misura_ambientale WHERE idsensore_ambientale IN (SELECT idsensore FROM sensore_ambientale WHERE idluogo = (SELECT idluogo FROM palestra WHERE nome_centro = @Nome)) ORDER BY idmisura DESC LIMIT 1"></asp:SqlDataSource>
            <br />
            <br />
            <div id="tabella_div">
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="idsensore_ambientale" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexhanged" RowHeaderColumn="nome_centro" Width="734px">
                <Columns>
                    <asp:BoundField DataField="timestamp" HeaderText="Ora" SortExpression="timestamp" >
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Names="Calibri" Font-Size="Large" ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="pressione" HeaderText="Pressione (mbar)" SortExpression="pressione" >
                    <ControlStyle Font-Bold="True" Font-Names="Calibri" Font-Size="Large" ForeColor="White" />
                    <HeaderStyle Font-Bold="True" Font-Names="Calibri" Font-Size="Large" ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="temperatura" HeaderText="Temperatura (°C)" SortExpression="temperatura" >
                    <HeaderStyle Font-Bold="True" Font-Names="Calibri" Font-Size="Large" ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="umidita" HeaderText="Umidità (%)" SortExpression="umidita" >
                    <HeaderStyle Font-Bold="True" Font-Names="Calibri" Font-Size="Large" ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="idsensore_ambientale" HeaderText="IDsensore" ReadOnly="True" SortExpression="idsensore_ambientale" >
                    <HeaderStyle Font-Bold="True" Font-Names="Calibri" Font-Size="Large" ForeColor="White" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            </div>
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
