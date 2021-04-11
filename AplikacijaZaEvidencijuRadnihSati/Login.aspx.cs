using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Security;
using Microsoft.ApplicationBlocks.Data;
using AplikacijaZaEvidencijuRadnihSati.Models;
using System.Web.Mvc;

namespace AplikacijaZaEvidencijuRadnihSati
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //Dohvat podataka korisnika iz baze podataka
        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                
                string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlParameter[] spParameter = new SqlParameter[2];

                    spParameter[0] = new SqlParameter("@Email", SqlDbType.NVarChar, 20);
                    spParameter[0].Direction = ParameterDirection.Input;
                    spParameter[0].Value = TbEmail.Text;

                    spParameter[1] = new SqlParameter("@Password", SqlDbType.NVarChar, 20);
                    spParameter[1].Direction = ParameterDirection.Input;
                    spParameter[1].Value = TbPassword.Text;

                    var tblDjelatnik = SqlHelper.ExecuteDataset(cs, "LoginDjelatnici", spParameter).Tables[0];
                    if (tblDjelatnik.Columns.Count > 1)
                    {
                        Djelatnik user = new Djelatnik();
                        foreach (DataRow row in tblDjelatnik.Rows)
                        {
                            user.IDDjelatnik = (int)row["IDDjelatnik"];
                            user.Ime = row["Ime"].ToString();
                            user.Prezime = row["Prezime"].ToString();
                            user.Email = row["Email"].ToString();
                            user.DatumZaposlenja = (DateTime)row["DatumZaposlenja"];
                            user.Zaporka = row["Zaporka"].ToString();
                            user.TipDjelatnikaID = (int)row["TipDjelatnikaID"];
                            user.TimID = (int)row["TimID"];


                        }
                        Session["USER"] = user;
                        Session["Ime"] = user.Ime;
                        Session["UserID2"] = user.IDDjelatnik;
                        Session["TimID"] = user.TimID;
                        if (user.TipDjelatnikaID == 1 || user.TipDjelatnikaID == 2)
                        {
                            if (DropDownList1.SelectedValue == "1")
                            {
                             
                                Response.Redirect("Administracija.aspx");
                            }
                            
                            else
                            {
                                if (user.TipDjelatnikaID == 1)
                                {
                                    Session.Abandon();
                                    LblPoruka.Text = "Vaš račun ima ovlasti samo za pristup administrativnoj aplikaciji";
                                }
                                else
                                {
                                    UrlHelper urlHelp = new UrlHelper(HttpContext.Current.Request.RequestContext);
                                    Response.Redirect(urlHelp.Action("Index", "Evidencija"));
                                }

                            }
                        }
                        else if (user.TipDjelatnikaID != 1 && user.TipDjelatnikaID != 2)
                        {
                            if (DropDownList1.SelectedValue == "1")
                            {
                                Session.Abandon();
                                LblPoruka.Text = "Vaš račun nema ovlašteni pristup administraciji, molimo odaberite evidenciju sati!";
                            }
                            else
                            {

                                    UrlHelper urlHelp = new UrlHelper(HttpContext.Current.Request.RequestContext);
                                Response.Redirect(urlHelp.Action("Index", "Evidencija"));
                            }
                        }
                    }
                    else
                    {
                        LblPoruka.Text = "Neispravni login podaci!";
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }

       
    
}