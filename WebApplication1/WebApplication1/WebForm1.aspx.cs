using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;
using System.Data;

namespace Gest_Palestre
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = DateTime.Now.ToString();
            if (!IsPostBack)
            {
                DropDownList1.DataBind();
                DropDownList2.DataBind();
            }
        }

        protected void GridView1_SelectedIndexhanged(object sender, EventArgs e)
        {

        }

        protected void timer1_tick(object sender, EventArgs e)
        {
            //if (0 > DateTime.Compare(DateTime.Now, DateTime.Parse(Session["timeout"].ToString())))
            //{
            //Aggiorna tabella
            SqlDataSource1.SelectCommand = "SELECT timestamp, pressione, temperatura, umidita, idsensore_ambientale FROM misura_ambientale WHERE idsensore_ambientale IN (SELECT idsensore FROM sensore_ambientale WHERE idluogo = (SELECT idluogo FROM palestra WHERE nome_centro = '" + DropDownList2.SelectedValue + "')) ORDER BY idmisura DESC LIMIT 20 ";
            SqlDataSource2.SelectCommand = "SELECT indice_attività, timestamp FROM misura_actigrafo WHERE idactigrafo = '" + DropDownList1.SelectedValue + "' AND timestamp BETWEEN timestamp(DATE_SUB(NOW(), INTERVAL 1 MINUTE)) AND timestamp(NOW()) ";
            SqlDataSource5.SelectCommand = "SELECT nome, cognome FROM utente WHERE actigrafo_idactigrafo = '" + DropDownList1.SelectedValue + "'";
            GridView1.DataBind();
            Label1.Text = DateTime.Now.ToString();
            DataSourceSelectArguments sr = new DataSourceSelectArguments();
            DataView dv = (DataView)SqlDataSource5.Select(sr);
            if (dv.Count != 0)
                Chart1.Series["Series1"].Name = dv[0][0].ToString() + dv[0][1].ToString();
            //    ((Int32)DateTime.Parse(Session["timeout"].ToString()).Subtract(DateTime.Now).TotalMinutes).ToString();
            //}
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void Chart1_Load(object sender, EventArgs e)
        {
            CustomLabel Fermo = new CustomLabel(0.9, 1, "Fermo", 0, LabelMarkStyle.None);
            CustomLabel Camminata = new CustomLabel(1.9, 2, "Lento", 0, LabelMarkStyle.None);
            CustomLabel Moderato = new CustomLabel(2.9, 3, "Moderato", 0, LabelMarkStyle.None);
            CustomLabel CorsaVeloce = new CustomLabel(3.9, 4, "Veloce", 0, LabelMarkStyle.None);
            CustomLabel CorsaMoltoVeloce = new CustomLabel(4.9, 5, "Molto Veloce", 0, LabelMarkStyle.None);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(Fermo);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(Camminata);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(Moderato);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(CorsaVeloce);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(CorsaMoltoVeloce);
            Chart1.ChartAreas[0].AxisX.LabelStyle.Interval = 4;
            Chart1.ChartAreas[0].AxisX.LabelStyle.IntervalType = DateTimeIntervalType.Seconds;
            Chart1.ChartAreas[0].AxisX.LabelStyle.Format = "hh:mm:ss";
            Chart1.ChartAreas[0].AxisX.IntervalType = DateTimeIntervalType.Seconds;
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdatePanel1.Update();
        }

        protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlDataSource4.SelectCommand = "SELECT nome_centro FROM palestra WHERE idtitolare = (SELECT idtitolare FROM titolare WHERE nome = '"+TextBox1.Text+"' AND cognome = '"+TextBox2.Text+"')";
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            SqlDataSource3.SelectCommand = "SELECT DISTINCT idactigrafo FROM actigrafo WHERE palestra_idluogo = (SELECT DISTINCT idluogo FROM palestra WHERE nome_centro = '" + DropDownList2.SelectedValue + "')";
        }
    }
}