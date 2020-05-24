$(document).ready(function () {

    $("#cep").blur(function () {
        var cep = $("#cep").val().replace(/\D/g, '');

        if (cep !== null) {
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

    $('.cancelarReserva').on('click', function () {
        const href = $(this).attr('href');
        if (!String(href).length) {
            return;
        }
        return confirm('Deseja cancelar? 50% do valor sera cobrado.');
    });
    

    $('[name="parcelas"]').on('input', function () {
        parcelas = parseInt($(this).val());
        valorParcelas = $('#valorParcelas');
        valorTotal = parseInt($('[name="subTotal"]').val());

        if (parcelas !== null && parcelas !== "") {
            total = valorTotal / parcelas;
            console.log(total);
            valorParcelas.html("Parcelas: " + parcelas + "x de R$ " + Math.ceil(total));
            return;
        }

        valorParcelas.html("Parcelas: " + parcelas + "x de R$ " + Math.ceil(valorTotal));
    });
});

