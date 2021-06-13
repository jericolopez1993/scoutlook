$(function () {
    statusNotes(true, 'invoice-audit-comment');
    $("#invoice_status").change(function () {
        statusNotes((currentInvoiceStatus === $(this).val()), 'invoice-audit-comment');
    });

    $("#master_invoice_shipper_id").change(function () {
        clientLocation($(this).val(), 'origin');
    });
    $('.total_charge_fields').keyup(function () {
        addTotalNumbers('total_charge_fields', 'shipment_total_charge');
        addTotalNumbers('total_charge_fields', 'master_invoice_total_charge_shipment');
    });
    $('.total_charge_with_tax_fields').keyup(function () {
        addTotalNumbers('total_charge_with_tax_fields', 'shipment_total_charge_with_tax');
        addTotalNumbers('total_charge_with_tax_fields', 'master_invoice_total_charge_with_tax');
    });
});

function clientLocation(id, name) {
    $.ajax({
        method: 'get',
        url: "/api/clients/" + id
    }).done(function (data) {
        $("#" + name + "_location_id").val(data.default_location.id).change();
    })
}

function addTotalNumbers(className, id) {
    var total_num = 0;
    $('.' + className).each(function () {
        if ($(this).val() != "") {
            total_num = total_num + parseFloat($(this).val().replace('$ ', '').replace(/,/g, ""));
        }
    })
    $('#' + id).val(total_num);
}