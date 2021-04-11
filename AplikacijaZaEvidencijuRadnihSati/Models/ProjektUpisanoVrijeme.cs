using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AplikacijaZaEvidencijuRadnihSati.Models
{
    public class ProjektUpisanoVrijeme
    {
        public int IDProjektUpisanoVrijeme { get; set; }
        public int ProjektDjelatnikID { get; set; }
        public string RadniSati { get; set; }
        public string PrekovremeniSati { get; set; }
        public int DnevniIzvjestajID { get; set; }
    }
}