﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace Gest_Palestre
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownList1.DataBind();
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
            SqlDataSource2.SelectCommand = "SELECT indice_attività, timestamp FROM misura_actigrafo WHERE actigrafo_idactigrafo = '" + DropDownList1.SelectedValue + "' AND timestamp BETWEEN timestamp(DATE_SUB(NOW(), INTERVAL 1 MINUTE)) AND timestamp(NOW()) ";
            GridView1.DataBind();
            Label1.Text = DateTime.Now.ToString();
            //    ((Int32)DateTime.Parse(Session["timeout"].ToString()).Subtract(DateTime.Now).TotalMinutes).ToString();
            //}
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void Chart1_Load(object sender, EventArgs e)
        {
            CustomLabel Fermo = new CustomLabel(0.9, 1, "Fermo", 0, LabelMarkStyle.None);
            CustomLabel Camminata = new CustomLabel(1.9, 2, "Camminata", 0, LabelMarkStyle.None);
            CustomLabel Corsa = new CustomLabel(2.9, 3, "Corsa", 0, LabelMarkStyle.None);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(Fermo);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(Camminata);
            Chart1.ChartAreas[0].AxisY.CustomLabels.Add(Corsa);
            Chart1.ChartAreas[0].AxisX.LabelStyle.Interval = 5;
            Chart1.ChartAreas[0].AxisX.LabelStyle.IntervalType = DateTimeIntervalType.Seconds;
            Chart1.ChartAreas[0].AxisX.LabelStyle.Format = "hh:mm:ss";
            Chart1.ChartAreas[0].AxisX.IntervalType = DateTimeIntervalType.Seconds;
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}