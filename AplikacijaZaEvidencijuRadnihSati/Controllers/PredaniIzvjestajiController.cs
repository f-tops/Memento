using AplikacijaZaEvidencijuRadnihSati.Models;
using Microsoft.ApplicationBlocks.Data;
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
    public class PredaniIzvjestajiController : Controller
    {
        // GET: PredaniIzvjestaji
        public ActionResult Index()
        {
            if (Session == null || Session["USER"] == null)
            {
                return Redirect("~/Login.aspx");
            }
            else
            {
                var user = (Djelatnik)Session["USER"];
                return View(GetDnevniIzvjestaj(user.IDDjelatnik));
            }
            
        }


        public List<DnevniIzvjestaj> GetDnevniIzvjestaj(int DjelatnikID)
        {
            var model = new List<DnevniIzvjestaj>();
            try
            {

                string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlParameter[] spParameter = new SqlParameter[1];

                    spParameter[0] = new SqlParameter("@DjelatnikID", SqlDbType.NVarChar, 20);
                    spParameter[0].Direction = ParameterDirection.Input;
                    spParameter[0].Value = DjelatnikID;

                    var tblProjektDjelatnik = SqlHelper.ExecuteDataset(cs, "GetDnevniIzvjestaj", spParameter).Tables[0];
                    if (tblProjektDjelatnik.Columns.Count > 1)
                    {

                        foreach (DataRow row in tblProjektDjelatnik.Rows)
                        {
                            DnevniIzvjestaj dnevniIzvjestaj = new DnevniIzvjestaj();
                            dnevniIzvjestaj.IDDnevniIzvjestaj = (int)row["IDDnevniIzvjestaj"];
                            dnevniIzvjestaj.Datum = (DateTime)row["Datum"];
                            dnevniIzvjestaj.DjelatnikID = (int)row["DjelatnikID"];
                            dnevniIzvjestaj.Naziv = row["Naziv"].ToString();
                            dnevniIzvjestaj.Komentar = row["Komentar"].ToString();
                            dnevniIzvjestaj.IzvjestajStatus = (int)row["IzvjestajStatus"];

                            model.Add(dnevniIzvjestaj);
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


        public ActionResult Detalji(string id)
        {
            int a = Int32.Parse(id);
            List<Detalji> detalji = GetDetalji(a);
            return View(detalji);

        }

        public List<Detalji> GetDetalji(int id)
        {
            var model = new List<Detalji>();
            try
            {

                string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlParameter[] spParameter = new SqlParameter[1];

                    spParameter[0] = new SqlParameter("@Id", SqlDbType.NVarChar, 20);
                    spParameter[0].Direction = ParameterDirection.Input;
                    spParameter[0].Value = id;

                    var tblDetalji = SqlHelper.ExecuteDataset(cs, "PrikazDetalja", spParameter).Tables[0];
                    if (tblDetalji.Columns.Count > 1)
                    {

                        foreach (DataRow row in tblDetalji.Rows)
                        {
                            Detalji detalji = new Detalji();
                            detalji.Datum = (DateTime)row["Datum"];
                            detalji.IzvjestajStatus = (int)row["IzvjestajStatus"];
                            detalji.Naziv = row["Naziv"].ToString();
                            detalji.Komentar = row["Komentar"].ToString();
                            detalji.ProjektNaziv = row["Projekt"].ToString();
                            detalji.RadniSati = row["RadniSati"].ToString();
                            detalji.PrekovremeniSati = row["PrekovremeniSati"].ToString();
                            model.Add(detalji);
                        }
                    }
                }
            }

            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            HttpCookie cookie10 = new HttpCookie("Greska3");
            cookie10.Value = model.ToString();
            Response.Cookies.Add(cookie10);
            return model;

        }

    }

 }
