using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AplikacijaZaEvidencijuRadnihSati.Models
{
    public class Detalji
    {
        public DateTime Datum { get; set; }
        public int IzvjestajStatus { get; set; }
        public string Naziv { get; set; }
        public string Komentar { get; set; }
        public string RadniSati { get; set; }
        public string PrekovremeniSati { get; set; }
        public string ProjektNaziv { get; set; }
    }
}