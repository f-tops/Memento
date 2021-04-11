

$(document).on('click', '#btnSubmit', function () {
    var Datum = $("#datepicker").val();
    var listaIdeva = $(".custId")
        .map(function () {
            return this.value;
        })
        .get()
        .join();

    var listaRadni = $(".radni")
        .map(function () {
            return this.value;
        })
        .get()
        .join();
    var listaPrekovremeni = $(".prekovremeni")
        .map(function () {
            return this.value;
        })
        .get()
        .join();
    var komentar2 = $("#comment").val();
    var SendObject = {
        datum: Datum,
        listaIdeva: listaIdeva,
        listaRadni: listaRadni,
        listaPrekovremeni: listaPrekovremeni,
        Komentar: komentar2
    }

    $.ajax({
        method: 'POST',
        url: '/PredaniIzvjestaji/UpdateVremena',
        contentType: 'application/json',  // send data type to server
        dataType: 'json',  //return type of data from server
        data: JSON.stringify(SendObject),
        //  asyn: false,
        success: function (data, status, xhr) {

            // do stuff here

        },
        error: function (response, status, xhr) {

            alert(response.statusText);

        }
    });
});



