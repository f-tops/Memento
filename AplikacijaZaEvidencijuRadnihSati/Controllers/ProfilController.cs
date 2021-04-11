using AplikacijaZaEvidencijuRadnihSati.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AplikacijaZaEvidencijuRadnihSati.Controllers
{
    public class ProfilController : Controller
    {
        // GET: Profil
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Ispravi(string KorisnickiEmail, string TrenutniPass, string NoviPass)
        {
            try
            {


                string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {

                    SqlCommand cmd = new SqlCommand("PromijeniZaporku", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter parm = new SqlParameter("@Email", SqlDbType.NVarChar);
                    parm.Value = KorisnickiEmail;
                    parm.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm);

                    SqlParameter parm2 = new SqlParameter("@CurrentPassword", SqlDbType.NVarChar);
                    parm2.Value = TrenutniPass; ;
                    parm2.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm2);

                    SqlParameter parm3 = new SqlParameter("@NewPassword", SqlDbType.NVarChar);
                    parm3.Value = NoviPass; ;
                    parm3.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm3);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    
                }
            }

            catch (Exception ex)
            {
                HttpCookie cookie2 = new HttpCookie("Greska3");
                cookie2.Value = ex.Message;
                Response.Cookies.Add(cookie2);
                Response.Write(ex.Message);
            }
            return View("Index", "_GlavnaAERS");
        }
    }
}