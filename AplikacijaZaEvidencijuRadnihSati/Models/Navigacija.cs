using AplikacijaZaEvidencijuRadnihSati.Controllers;
using Resources;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AplikacijaZaEvidencijuRadnihSati.Models
{
    public class Navigacija
    {
        [Display(Name = "Link1", ResourceType = typeof(Resource))]
        public string Link1 { get; set; }

        [Display(Name = "Link2", ResourceType = typeof(Resource))]
        public string Link2 { get; set; }

        [Display(Name = "Link3", ResourceType = typeof(Resource))]
        public string Link3 { get; set; }

        [Display(Name = "Pozdrav", ResourceType = typeof(Resource))]
        public string Pozdrav { get; set; }

        [Display(Name = "TrenutnoJe", ResourceType = typeof(Resource))]
        public string TrenutnoJe { get; set; }
    }
}