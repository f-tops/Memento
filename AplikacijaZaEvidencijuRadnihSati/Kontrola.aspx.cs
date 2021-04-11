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
    public partial class Kontrola : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session == null || Session["USER"] == null)
            {
               Response.Redirect("~/Login.aspx");
            }

        }

        protected void GVKontrola_SelectedIndexChanged(object sender, EventArgs e)
        {
            BtnOdobri.Visible = true;
            BtnVratiNaDoradu.Visible = true;
            LblKomentarIOdobravanje.Visible = true;
            LblDetalji.Visible = true;
            Session["IDIzvjestaj"] = GVKontrola.SelectedValue;
        }

        protected void BtnVratiNaDoradu_Click(object sender, EventArgs e)
        {
            try
            {

                string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {

                    SqlCommand cmd = new SqlCommand("VratiNaDoradu", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter parm1 = new SqlParameter("@IDIzvjestaj", SqlDbType.Int);
                    parm1.Value = Session["IDIzvjestaj"];
                    parm1.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm1);

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

        protected void BtnOdobri_Click(object sender, EventArgs e)
        {
            try
            {

                string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {

                    SqlCommand cmd = new SqlCommand("Odobri", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter parm1 = new SqlParameter("@IDIzvjestaj", SqlDbType.Int);
                    parm1.Value = Session["IDIzvjestaj"];
                    parm1.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm1);

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
    }
}