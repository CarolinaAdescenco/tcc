$(document).ready(function () {

    $("#cep").blur(function () {
        var cep = $("#cep").val().replace(/\D/g, '');
        console.log(cep);

        if (cep != null) {
            let validaCep = /^[0-9]{8}$/;

            if (validaCep.test(cep)) {
                $.getJSON("https://viacep.com.br/ws/" + cep + "/json/?callback=?", function (endereco) {
                    $("#logradouro").val(endereco.logradouro);
                    $("#bairro").val(endereco.bairro);
                    $("#municipio").val(endereco.localidade);
                    $("#estado").val(endereco.uf);
                });
            }
        }
    });
    
    $('.tabs').tabs();
    $('select').formSelect();
});

