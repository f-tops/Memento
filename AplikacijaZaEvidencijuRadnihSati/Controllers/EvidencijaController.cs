using AplikacijaZaEvidencijuRadnihSati.Models;
using Microsoft.ApplicationBlocks.Data;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;

namespace AplikacijaZaEvidencijuRadnihSati.Controllers
{
    public class EvidencijaController : Controller
    {
        //Provjera sessiona
        public ActionResult Index()
        {
            if (Session == null || Session["USER"] == null)
            {
                return Redirect("~/Login.aspx");
            }
            else
            {
                return View(GetProjektDjelatnik());
            }
            
        }

        public ActionResult Logout()
        {
            Session.Contents.RemoveAll();
            return Redirect("~/Login.aspx");
        }

        //Dohvat podataka projekata za zadanog djelatnika u tablici
        public List<ProjektDjelatnik> GetProjektDjelatnik()
        {
            var model = new List<ProjektDjelatnik>();
            try
            {

                string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                var user = (Djelatnik)Session["USER"];
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlParameter[] spParameter = new SqlParameter[1];

                    spParameter[0] = new SqlParameter("@IDDjelatnik", SqlDbType.NVarChar, 20);
                    spParameter[0].Direction = ParameterDirection.Input;
                    spParameter[0].Value = user.IDDjelatnik;

                    var tblProjektDjelatnik = SqlHelper.ExecuteDataset(cs, "GetProjektDjelatnik", spParameter).Tables[0];
                    if (tblProjektDjelatnik.Columns.Count > 1)
                    {

                        foreach (DataRow row in tblProjektDjelatnik.Rows)
                        {
                            ProjektDjelatnik projektDjelatnik = new ProjektDjelatnik();
                            projektDjelatnik.IDProjektDjelatnik = (int)row["IDProjektDjelatnik"];
                            projektDjelatnik.DjelatnikID = (int)row["DjelatnikID"];
                            projektDjelatnik.ProjektID = (int)row["ProjektID"];
                            projektDjelatnik.NazivProjekta = row["NazivProjekta"].ToString();
                            model.Add(projektDjelatnik);
                        }
                    }
                }
            }

            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            return model;
        }

        [HttpPost]
        public ActionResult Predano(JSONObjekt data)
        {
            string DateString = data.Datum;
            string Komentar = $"{data.Komentar}";
            string ListaIdeva = data.ListaIdeva;
            string ListaRadni = data.ListaRadni;
            string ListaPrekovremeni = data.ListaPrekovremeni;
            List<int> Idevi = ListaIdeva.Split(',').Select(Int32.Parse).ToList();
            List<string> Radni = ListaRadni.Split(',').ToList();
            List<string> Prekovremeni = ListaPrekovremeni.Split(',').ToList();


            for (int i = 0; i < Radni.Count(); i++)
            {
                Radni[i] = $"{Radni[i]}:00";
                Prekovremeni[i] = $"{Prekovremeni[i]}:00";
            }


            int Identity = 0;
            try
            {

                
                string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                var user = (Djelatnik)Session["USER"];
                string Naziv = $"Dnevni izvjestaj|{DateString}|{user.Ime} {user.Prezime}";
                using (SqlConnection con = new SqlConnection(cs))
                {

                    SqlCommand cmd = new SqlCommand("NoviDnevniIzvjestaj", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter parm = new SqlParameter("@Datum", SqlDbType.NVarChar);
                    parm.Value = DateString;
                    parm.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm);

                    SqlParameter parm2 = new SqlParameter("@IzvjestajStatus", SqlDbType.Int);
                    parm2.Value = 1;
                    parm2.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm2);

                    SqlParameter parm3 = new SqlParameter("@DjelatnikID", SqlDbType.Int);
                    parm3.Value = user.IDDjelatnik;
                    parm3.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm3);

                    SqlParameter parm4 = new SqlParameter("@Naziv", SqlDbType.NVarChar);
                    parm4.Value = Naziv;
                    parm4.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm4);

                    SqlParameter parm6 = new SqlParameter("@Komentar", SqlDbType.NVarChar);
                    parm6.Value = Komentar;
                    parm6.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(parm6);

                    SqlParameter parm5 = new SqlParameter("@Identity", SqlDbType.Int);
                    parm5.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(parm5);

                    

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    Identity = Int32.Parse(cmd.Parameters["@Identity"].Value.ToString());

                }
            }

            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

            if (Identity != 0)
            {
                for (int i = 0; i < Idevi.Count(); i++)
                {
                    try
                    {


                        string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                        var user = (Djelatnik)Session["USER"];
                        using (SqlConnection con = new SqlConnection(cs))
                        {

                            SqlCommand cmd = new SqlCommand("Predaj", con);
                            cmd.CommandType = CommandType.StoredProcedure;

                            SqlParameter parm = new SqlParameter("@ProjektDjelatnikID", SqlDbType.Int);
                            parm.Value = Idevi[i];
                            parm.Direction = ParameterDirection.Input;
                            cmd.Parameters.Add(parm);

                            SqlParameter parm2 = new SqlParameter("@RadniSati", SqlDbType.Time);
                            parm2.Value = Radni[i];
                            parm2.Direction = ParameterDirection.Input;
                            cmd.Parameters.Add(parm2);

                            SqlParameter parm3 = new SqlParameter("@PrekovremeniSati", SqlDbType.Time);
                            parm3.Value = Prekovremeni[i];
                            parm3.Direction = ParameterDirection.Input;
                            cmd.Parameters.Add(parm3);


                            SqlParameter parm4 = new SqlParameter("@DnevniIzvjestajID", SqlDbType.Int);
                            parm4.Value = Identity;
                            parm4.Direction = ParameterDirection.Input;
                            cmd.Parameters.Add(parm4);

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



                }


            }


            return View("Index", "_GlavnaAERS", GetProjektDjelatnik());
        }


        


        //Odabir lokalizacije
        public ActionResult Change(String LanguageAbbrevation)
        {


            if (Session == null || Session["USER"] == null)
            {
                return Redirect("~/Login.aspx");
            }
            else
            {
                if (LanguageAbbrevation != null)
                {
                    Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(LanguageAbbrevation);
                    Thread.CurrentThread.CurrentUICulture = new CultureInfo(LanguageAbbrevation);
                }
                HttpCookie cookie = new HttpCookie("Language");
                cookie.Value = LanguageAbbrevation;
                Response.Cookies.Add(cookie);


                return View("Index", "_GlavnaAERS", GetProjektDjelatnik());
            }

            
        }




    }
}