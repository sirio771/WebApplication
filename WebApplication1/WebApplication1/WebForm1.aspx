<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Gest_Palestre.WebForm1" %>

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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString2 %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString2.ProviderName %>" SelectCommand="SELECT timestamp, pressione, temperatura, umidita, idsensore_ambientale FROM misura_ambientale"></asp:SqlDataSource>
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
