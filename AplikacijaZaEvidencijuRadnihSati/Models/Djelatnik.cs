using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AplikacijaZaEvidencijuRadnihSati.Models
{
    public class Djelatnik
    {
        public int IDDjelatnik { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Email { get; set; }
        public DateTime DatumZaposlenja { get; set; }
        public string Zaporka { get; set; }
        public int TipDjelatnikaID { get; set; }
        public int TimID { get; set; }


    }
}