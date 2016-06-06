using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Gest_Palestre
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexhanged(object sender, EventArgs e)
        {

        }

        protected void timer1_tick(object sender, EventArgs e)
        {
            //if (0 > DateTime.Compare(DateTime.Now, DateTime.Parse(Session["timeout"].ToString())))
            //{
            //Aggiorna tabella
            GridView1.DataBind();
            Label1.Text = DateTime.Now.ToString();
            //    ((Int32)DateTime.Parse(Session["timeout"].ToString()).Subtract(DateTime.Now).TotalMinutes).ToString();
            //}
        }
    }
}