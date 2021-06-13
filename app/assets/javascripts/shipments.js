$(function () {

    shipmentFields($('input[type=radio][name="master_invoice[shipment_entry]"]:checked').val());
    $('input[type=radio][name="master_invoice[shipment_entry]"]').change(function () {
        shipmentFields(this.value);
    });

    statusNotes(true, 'shipment-audit-comment');
    $("#shipment_status").change(function () {
        statusNotes((currentShipmentStatus === $(this).val()), 'shipment-audit-comment');
    });
});


function shipmentFields(shipmentEntry) {
    if (shipmentEntry == "Single") {
        $(".shipment-fields").show();
        $(".single-shipment").hide();
    } else {
        $(".shipment-fields").hide();
        $(".single-shipment").show();
    }
}

function statusNotes(isTrue, className) {
    if (isTrue) {
        $("." + className).hide();
    } else {
        $("." + className).show();
    }
}