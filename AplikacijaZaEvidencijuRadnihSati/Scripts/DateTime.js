$(document).ready(function () {
    $('.vrijeme').click(function () {
        $(this).stopwatch('toggle');
    });
    $("#datepicker").datepicker({
        dateFormat: "yy-mm-dd",
        dayNames: ["Nedjelja", "Ponedjeljak", "Utorak", "Srijeda", "Četvrtak", "Petak", "Subota"],
        dayNamesShort: ["Ned", "Pon", "Uto", "Sri", "Čet", "Pet", "Sub"],
        dayNamesMin: ["Ned", "Pon", "Uto", "Sri", "Čet", "Pet", "Sub"],
        firstDay: 1,
        monthNames: ["Siječanj", "Veljača", "Ožujak", "Travanj", "Svibanj", "Lipanj", "Srpanj", "Kolovoz", "Rujan", "Listopad", "Studeni", "Prosinac"]
    });
    $('#datepicker').datepicker('setDate', new Date());
    $('.radni').on('change', function () {
        var radni = ".radni";
        var txt3 = "txt3";
        sum(radni, txt3);
    });
    $('.prekovremeni').on('change', function () {
        var prekovremeni = ".prekovremeni";
        var txt4 = "txt4";
        sum(prekovremeni, txt4);
    });
});




function sumaStopWatch() {
    var suma = 0;
    var sumaSati = 0;
    var sumaMinuta = 0;
        $(".hours").each(function () {
            var qty = parseInt($(this).text())
            var qty2 = parseInt(qty) * 60;
            sumaSati += qty2;
        });
        $(".minutes").each(function () {
            var qty = parseInt($(this).text())
            var qty2 = parseInt(qty);
            sumaMinuta += qty2;
        });
    suma = sumaSati + sumaMinuta;
    document.getElementById("txt2").innerHTML = toTime(suma);
}


function sum(element, txt) {
    var suma = 0;
    //iteriranje kroz svaki element
    $(element).each(function () {

        //validacija, potrebno usavršiti
        if (this.value.length == 5) {
            var qty = $(this).val();
            suma += fromTime(qty);
        }

    });
    document.getElementById(txt).innerHTML = toTime(suma);
}

function fromTime(time) {
    var timeArray = time.split(':');
    var hours = parseInt(timeArray[0]);
    var minutes = parseInt(timeArray[1]);

    return (hours * 60) + minutes;
}



function toTime(number) {
    var hours = Math.floor(number / 60);
    var minutes = number % 60;

    return hours + ":" + (minutes <= 9 ? "0" : "") + minutes;
}