﻿using System;
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
            SqlDataSource6.SelectCommand = "SELECT DISTINCT idsensore FROM storico_errore WHERE idsensore IN (SELECT idsensore FROM sensore_ambientale WHERE idluogo = (SELECT idluogo FROM palestra WHERE nome_centro = '" + DropDownList2.SelectedValue + "')) AND TIMESTAMP BETWEEN TIMESTAMP (DATE_SUB(NOW(), INTERVAL 1 MINUTE)) AND TIMESTAMP (NOW()) ORDER BY iderrore DESC LIMIT 1";
            SqlDataSource7.SelectCommand = "SELECT DISTINCT * FROM storico_errore WHERE idsensore IN (SELECT idsensore FROM sensore_ambientale WHERE idluogo = (SELECT idluogo FROM palestra WHERE nome_centro = '" + DropDownList2.SelectedValue + "')) AND TIMESTAMP BETWEEN TIMESTAMP (DATE_SUB(NOW(), INTERVAL 1 MINUTE)) AND TIMESTAMP (NOW()) ORDER BY iderrore DESC LIMIT 1 ";
            SqlDataSource8.SelectCommand = "SELECT timestamp, pressione, temperatura, umidita, idsensore_ambientale FROM misura_ambientale WHERE idsensore_ambientale IN (SELECT idsensore FROM sensore_ambientale WHERE idluogo = (SELECT idluogo FROM palestra WHERE nome_centro = '" + DropDownList2.SelectedValue + "')) ORDER BY idmisura DESC LIMIT 1 ";
            GridView1.DataBind();
            GridView2.DataBind();
            Label1.Text = DateTime.Now.ToString();
            DataSourceSelectArguments sr = new DataSourceSelectArguments();
            DataSourceSelectArguments sr_2 = new DataSourceSelectArguments();
            DataSourceSelectArguments sr_3 = new DataSourceSelectArguments();
            //DataSourceSelectArguments sr_3 = new DataSourceSelectArguments();
            //DataView dv_3 = (DataView)SqlDataSource7.Select(sr_3);
            DataView dv = (DataView)SqlDataSource5.Select(sr);
            DataView dv_2 = (DataView)SqlDataSource7.Select(sr_2);
            DataView dv_3 = (DataView)SqlDataSource2.Select(sr_3);
            DataTable dt = dv_3.ToTable();
            if (dv.Count != 0)
            {
                Chart1.Series["Series1"].Name = dv[0][0].ToString() + " " + dv[0][1].ToString();
                Chart1.Legends[0].Font = new System.Drawing.Font("Trebuchet MS", 15F, System.Drawing.FontStyle.Bold);
            }
            if (dv_2.Count != 0)
            {
                alarmLabel.ForeColor = System.Drawing.Color.Red;
                alarmLabel.Font.Size = 32;
                if (dv_2.Count < 2)
                    alarmLabel.Text = "Rilevate anomalie su " + dv_2.Count + " sensore ambientale";
                else
                    alarmLabel.Text = "Rilevate anomalie su " + dv_2.Count + " sensori ambientali";
            }
            else
            {
                alarmLabel.ForeColor = System.Drawing.Color.Green;
                alarmLabel.Font.Size = 12;
                alarmLabel.Text = "Nessuna anomalia rilevata";
            }
            if (dv_3.Count > 0)
            {
                int num = int.Parse(dv_3[dv_3.Count - 1][0].ToString());
                if (num == 1)
                    Image1.ImageUrl = "~/Models/Fermo.png";
                else if (num == 2)
                    Image1.ImageUrl = "~/Models/Lento.png";
                else if (num == 3)
                    Image1.ImageUrl = "~/Models/Moderato.png";
                else if (num == 4)
                    Image1.ImageUrl = "~/Models/Veloce.png";
                else if (num == 5)
                    Image1.ImageUrl = "~/Models/Vigoroso.png";
            }
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
            CustomLabel CorsaMoltoVeloce = new CustomLabel(4.9, 5, "Vigoroso", 0, LabelMarkStyle.None);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(Fermo);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(Camminata);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(Moderato);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(CorsaVeloce);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(CorsaMoltoVeloce);
            Chart1.ChartAreas[0].AxisX.LabelStyle.Interval = 4;
            Chart1.ChartAreas[0].AxisY.LabelAutoFitStyle= LabelAutoFitStyles.None;
            Chart1.ChartAreas[0].AxisX.LabelAutoFitStyle = LabelAutoFitStyles.None;
            Chart1.ChartAreas[0].AxisX.LabelStyle.Font = new System.Drawing.Font("Trebuchet MS", 12F, System.Drawing.FontStyle.Bold);
            Chart1.ChartAreas[0].AxisY.LabelStyle.Font = new System.Drawing.Font("Trebuchet MS", 22.5F, System.Drawing.FontStyle.Bold);
            Chart1.ChartAreas[0].AxisX.LabelStyle.IntervalType = DateTimeIntervalType.Seconds;
            Chart1.ChartAreas[0].AxisX.LabelStyle.Format = "HH:mm:ss";
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

        protected void Chart2_Load(object sender, EventArgs e)
        {
            Chart2.Series[0].YAxisType = AxisType.Primary;
            Chart2.Series[1].YAxisType = AxisType.Secondary;
            Chart2.ChartAreas[0].AxisY.LabelAutoFitStyle = LabelAutoFitStyles.None;
            Chart2.ChartAreas[0].AxisX.LabelAutoFitStyle = LabelAutoFitStyles.None;
            Chart2.ChartAreas[0].AxisX.LabelStyle.Font = new System.Drawing.Font("Trebuchet MS", 12F, System.Drawing.FontStyle.Bold);
            Chart2.ChartAreas[0].AxisY.LabelStyle.Font = new System.Drawing.Font("Trebuchet MS", 22.5F, System.Drawing.FontStyle.Bold);
            Chart2.ChartAreas[0].AxisX.LabelStyle.IntervalType = DateTimeIntervalType.Seconds;
            Chart2.ChartAreas[0].AxisX.LabelStyle.Format = "HH:mm:ss";
            Chart2.ChartAreas[0].AxisX.IntervalType = DateTimeIntervalType.Seconds;
            
        }

        protected void Chart3_Load(object sender, EventArgs e)
        {
            
        }
    }
}