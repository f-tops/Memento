using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AplikacijaZaEvidencijuRadnihSati
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LblIme.Text = Session["Ime"].ToString();
        }

        public void Change(String LanguageAbbrevation)
        {
            if (Session == null || Session["USER"] == null)
            {
                Response.Redirect("~/Login.aspx");
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
            }
        }
        protected void BtnHrvatski_Click(object sender, EventArgs e)
        {
            Change("hr-HR");
        }

        protected void BtnEnglish_Click(object sender, EventArgs e)
        {
            Change("en-GB");
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Contents.RemoveAll();
            Response.Redirect("~/Login.aspx");
        }
    }
}


    