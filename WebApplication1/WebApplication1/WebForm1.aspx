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
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="idluogo,idtitolare" DataSourceID="SqlDataSource1" AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexhanged" RowHeaderColumn="nome_centro">
            <Columns>
                <asp:BoundField DataField="idluogo" HeaderText="idluogo" ReadOnly="True" SortExpression="idluogo" />
                <asp:BoundField DataField="citta" HeaderText="citta" SortExpression="citta" />
                <asp:BoundField DataField="via" HeaderText="via" SortExpression="via" />
                <asp:BoundField DataField="nome_centro" HeaderText="nome_centro" SortExpression="nome_centro" />
                <asp:BoundField DataField="idtitolare" HeaderText="idtitolare" ReadOnly="True" SortExpression="idtitolare" />
            </Columns>
        </asp:GridView>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mrc_dbConnectionString %>" ProviderName="<%$ ConnectionStrings:mrc_dbConnectionString.ProviderName %>" SelectCommand="SELECT * FROM palestra"></asp:SqlDataSource>
        </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="timer1" EventName ="tick"/>
            </Triggers>
        </asp:UpdatePanel>
        <br />
        <asp:TreeView ID="TreeView1" runat="server">
        </asp:TreeView>
    
    </div>
    </form>
</body>
</html>
