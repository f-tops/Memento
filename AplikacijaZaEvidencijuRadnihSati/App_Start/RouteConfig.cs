using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace AplikacijaZaEvidencijuRadnihSati
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
            name: "Ispravi",
            url: "Project/Survey/{KorisnickiMail}/{TrenutniPass}/{NoviPass}",
            defaults: new { controller = "Profil", action = "Ispravi" }
            );

        }
    }
}
