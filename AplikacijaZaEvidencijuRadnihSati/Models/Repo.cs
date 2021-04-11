using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

namespace AplikacijaZaEvidencijuRadnihSati.Models
{
    public class Repo
    {
        private static string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        public static IEnumerable<Djelatnik> GetDjelatnici()
        {
            var tblDjelatnici = SqlHelper.ExecuteDataset(cs, "GetDjelatnici").Tables[0];
            foreach (DataRow row in tblDjelatnici.Rows)
            {
                yield return new Djelatnik
                {
                    IDDjelatnik = (int)row["IDDjelatnik"],
                    Ime = row["Ime"].ToString(),
                    Prezime = row["Prezime"].ToString(),
                    Email = row["Email"].ToString(),
                    DatumZaposlenja = (DateTime)row["DatumZaposlenja"],
                    Zaporka = row["Zaporka"].ToString(),
                    TipDjelatnikaID = (int)row["TipDjelatnikaID"],
                    TimID = (int)row["TimID"]

                };
            }
        }
    }
}