using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AplikacijaZaEvidencijuRadnihSati.Models
{
    public class DnevniIzvjestaj
    {
        public int IDDnevniIzvjestaj { get; set; }
        public DateTime Datum { get; set; }
        public int IzvjestajStatus { get; set; }
        public int DjelatnikID { get; set; }
        public string Naziv { get; set; }
        public string Komentar { get; set; }


    }
}