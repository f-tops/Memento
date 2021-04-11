using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AplikacijaZaEvidencijuRadnihSati
{
    public partial class Administracija : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session == null || Session["USER"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void BtnDodaj_Click(object sender, EventArgs e)
        {
            try
            {

                string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {

                    SqlCommand cmd = new SqlCommand("PromijeniTimDjelatnika", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter parm1 = new SqlParameter("@TimID", SqlDbType.Int);
                    parm1.Value = Session["TimID"];
                    parm1.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm1);

                    SqlParameter parm2 = new SqlParameter("@IDDjelatnik", SqlDbType.Int);
                    parm2.Value = DDLDjelatnici.SelectedValue;
                    parm2.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm2);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                }
            }

            catch (Exception ex)
            {
                HttpCookie cookie6 = new HttpCookie("Greska6");
                cookie6.Value = ex.Message;
                Response.Cookies.Add(cookie6);
                Response.Write(ex.Message);
            }
        }

        protected void BtnDodaj2_Click(object sender, EventArgs e)
        {
            try
            {

                string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {

                    SqlCommand cmd = new SqlCommand("DodajDjelatnikaNaProjekt", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter parm1 = new SqlParameter("@DjelatnikID", SqlDbType.Int);
                    parm1.Value = DDLDjelatniciKojiNisuNaProjektu.SelectedValue;
                    parm1.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm1);

                    SqlParameter parm2 = new SqlParameter("@ProjektID", SqlDbType.Int);
                    parm2.Value = GVProjekt.SelectedValue;
                    parm2.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm2);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                }
            }

            catch (Exception ex)
            {
                HttpCookie cookie6 = new HttpCookie("Greska6");
                cookie6.Value = ex.Message;
                Response.Cookies.Add(cookie6);
                Response.Write(ex.Message);
            }
        }

        protected void GVProjekt_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label2.Visible = true;
            Label3.Visible = true;
            DDLDjelatniciKojiNisuNaProjektu.Visible = true;
            BtnDodaj2.Visible = true;
        }
    }
}