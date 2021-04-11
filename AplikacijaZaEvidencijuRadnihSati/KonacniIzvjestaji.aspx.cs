using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AplikacijaZaEvidencijuRadnihSati
{
    public partial class KonacniIzvjestaji : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session == null || Session["USER"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
        }



        protected void BTNExportCSV_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=ExportCSVKlijent.csv");
            Response.Charset = "";
            Response.ContentType = "text/csv";


            GridView1.AllowPaging = false;

            StringBuilder sb = new StringBuilder();

            sb.Append(DDLKlijentOdabir.Text + ';');
            sb.Append(DateTime.Now.ToShortDateString() + ';');
            sb.Append("\r\n");
            sb.Append("Naziv projekta" + ';');
                sb.Append("Ukupno vrijeme(HH,MM)" + ';');


            sb.Append("\r\n");

            foreach (GridViewRow row in GridView1.Rows)
            {
                foreach (TableCell cell in row.Cells)
                {

                    sb.Append(cell.Text + ';');
                }

                sb.Append("\r\n");
            }

            Response.Output.Write(sb.ToString());
            Response.Flush();
            Response.End();
        }

        protected void DDLKlijentOdabir_SelectedIndexChanged(object sender, EventArgs e)
        {
            LblExportUCSV.Visible = true;
            GridView1.Visible = true;
            BTNExportCSV.Visible = true;
        }
    }
}