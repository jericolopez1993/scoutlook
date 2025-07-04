// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require inputmask
//= require jquery.inputmask
//= require inputmask.extensions
//= require inputmask.date.extensions
//= require inputmask.phone.extensions
//= require inputmask.numeric.extensions
//= require inputmask.regex.extensions
//= require tinymce
//= require select2
//= require_tree .
var originTags = [
    "AL",
    "AK",
    "AZ",
    "AR",
    "CA",
    "CO",
    "CT",
    "DE",
    "FL",
    "GA",
    "HI",
    "ID",
    "IL",
    "IN",
    "IA",
    "KS",
    "KY",
    "LA",
    "ME",
    "MD",
    "MA",
    "MI",
    "MN",
    "MS",
    "MO",
    "MT",
    "NE",
    "NH",
    "NJ",
    "NV",
    "NC",
    "ND",
    "OH",
    "OK",
    "OR",
    "PA",
    "RI",
    "SC",
    "SD",
    "TN",
    "TX",
    "UT",
    "VT",
    "VA",
    "WA",
    "WV",
    "WI",
    "WY",
    "US-Northeast",
    "US-Northeast (No Bronx)",
    "US-Southeast",
    "US-Northwest",
    "US-Midwest",
    "BC",
    "AB",
    "SK",
    "MB",
    "ON",
    "QC",
    "NB",
    "NS",
    "PEI",
    "NL",
    "NU",
    "NT",
    "YK",
];
var destinationTags = originTags;
$(document).ready(function () {
    activityOutcomeFields($("#engagement_type").val(), $("#engagement_status").val(), $("#engagement_outcome").val());
    isHeadOffice($('[data-change="check-switchery-state-same-office"]').prop('checked'));
    addressCreateOD($('[data-change="check-switchery-state-new-location-origin"]').prop('checked'), 'origin');
    addressCreateOD($('[data-change="check-switchery-state-new-location-destination"]').prop('checked'), 'destination');
    addressCreateQuickS($('[data-change="check-switchery-state-new-location-quick-destination"]').prop('checked'), 'quick_destination');


    $(".shipper-type-multiple-select2").select2({placeholder: "Select shipper types", allowClear: true});
    $(".new-load-origin-multiple").select2({
        placeholder: "Select origins",
        allowClear: true,
        dropdownParent: $("#new_load")
    });
    $(".new-load-destination-multiple").select2({
        placeholder: "Select destinations",
        allowClear: true,
        dropdownParent: $("#new_load")
    });
    $(".new-truck-origin-multiple").select2({
        placeholder: "Select origins",
        allowClear: true,
        dropdownParent: $("#new_truck")
    });
    $(".new-truck-destination-multiple").select2({
        placeholder: "Select destinations",
        allowClear: true,
        dropdownParent: $("#new_truck")
    });
    $(".static-dropdown").select2({allowClear: true});
    $(".new-load-dropdown").select2({allowClear: true, dropdownParent: $("#new_load")});
    $("#origin_location_id").chained("#origin_id");
    $("#destination_location_id").chained("#destination_id");

    $('.tags-input').tagsinput({
        confirmKeys: [13, 188]
    });

    $('.tags-input input').on('keypress', function (e) {
        if (e.keyCode == 13) {
            e.keyCode = 188;
            e.preventDefault();
        }
        ;
    });

    $('.datepicker-autoClose').datepicker({
        autoclose: true,
        orientation: 'auto bottom'
    });
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        $($.fn.dataTable.tables(true)).DataTable().columns.adjust();
    });
    Inputmask().mask(document.querySelectorAll("input"));
    $("#engagement_type").change(function () {
        activityOutcomeFields($(this).val(), $("#engagement_status").val(), $("#engagement_outcome").val());
    });
    $("#engagement_status").change(function () {
        activityOutcomeFields($("#engagement_type").val(), $(this).val(), $("#engagement_outcome").val());
    });
    $("#engagement_outcome").change(function () {
        activityOutcomeFields($("#engagement_type").val(), $("#engagement_status").val(), $(this).val());
    });
    $(document).on('change', '[data-change="check-switchery-state-text"]', function () {
        sameHeadOffice($(this).prop('checked'));
    });
    $(document).on('change', '[data-change="check-switchery-state-same-office"]', function () {
        isHeadOffice($(this).prop('checked'));
    });
    $(document).on('change', '[data-change="check-switchery-state-new-location"]', function () {
        addressCreate($(this).prop('checked'));
    });
    $(document).on('change', '[data-change="check-switchery-state-new-location-origin"]', function () {
        addressCreateOD($(this).prop('checked'), 'origin');
    });
    $(document).on('change', '[data-change="check-switchery-state-new-location-destination"]', function () {
        addressCreateOD($(this).prop('checked'), 'destination');
    });
    $(document).on('change', '[data-change="check-switchery-state-new-location-quick-destination"]', function () {
        addressCreateQuickS($(this).prop('checked'), 'quick_destination');
    });
    $("#rate_origin_city, #rate_destination_city").keyup(function () {
        getDistance();
    });
    $("#rate_origin_state, #rate_origin_country, #rate_destination_state, #rate_destination_country").change(function () {
        getDistance();
    });
    $("#shipment_date, #received_date").change(function () {
        var shipment_date = $("#shipment_date").val();
        var received_date = $("#received_date").val();
        var transit_time = getDateDifference(shipment_date, received_date);
        $("#transit_time").val(transit_time);
    });
    $("#location_id").change(function () {
        var er = /^-?[0-9]+$/;
        var isNew = er.test($(this).val());
        addressCreate(!isNew);
        if (isNew) {
            locationDetails($(this).val());
        }
    });
    $("#origin_location_id").change(function () {
        var er = /^-?[0-9]+$/;
        var isNew = er.test($(this).val());
        addressCreateOD(!isNew, 'origin');
        if (isNew) {
            locationDetailsOD($(this).val(), 'origin');
        }
    });
    $("#destination_location_id").change(function () {
        var er = /^-?[0-9]+$/;
        var isNew = er.test($(this).val());
        addressCreateOD(!isNew, 'destination');
        if (isNew) {
            locationDetailsOD($(this).val(), 'destination');
        }
    });
    $("#quick_destination_id").change(function () {
        var er = /^-?[0-9]+$/;
        var isNew = er.test($(this).val());
        addressCreateQuickS(!isNew, 'quick_destination');
        if (isNew) {
            locationDetailsOD($(this).val(), 'quick_destination');
        }
    });
    $("#years_established").change(function () {
        $("#years_in_business").val((new Date()).getFullYear() - parseInt($(this).val()));
    });
});

function activityOutcomeFields(actype, stat, outcome) {
    if (actype === 'Proposal' && stat === "false") {
        $(".outcome-fields").show();
        $(".proposal-fields").show();
        $(".activity_buttons").hide();
        if (outcome.includes("Win")) {
            $(".win-fields").show();
            $("#activity_load_numbers").attr('data-parsley-required', 'true');
        } else {
            $(".win-fields").hide();
            $("#activity_load_numbers").removeAttr("data-parsley-required");
        }
    } else {
        $(".outcome-fields").hide();
        $(".proposal-fields").hide();
        $(".activity_buttons").show();
        $(".win-fields").hide();
    }
}

function getDateDifference(str_date1, str_date2) {
    var date1 = new Date(str_date1);
    var date2 = new Date(str_date2);
    var timeDiff = Math.abs(date2.getTime() - date1.getTime());
    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
    return diffDays;
}

function sameHeadOffice(isTrue) {
    if (isTrue) {
        $(".address-fields").hide();
    } else {
        $(".address-fields").show();
    }
}

function statusNotes(isTrue, className) {
    if (isTrue) {
        $("." + className).hide();
    } else {
        $("." + className).show();
    }
}

function addressCreate(isTrue) {
    $("#address").val('');
    $("#city").val('');
    $("#postal").val('');
    $("#state").val('').change();
    if (isTrue) {
        $("#address").attr("disabled", false);
        $("#city").attr("disabled", false);
        $("#postal").attr("disabled", false);
        $("#country").attr("disabled", false);
        $("#state").attr("disabled", false);
        $("#country").val('USA').change();

    } else {
        $("#address").attr("disabled", true);
        $("#city").attr("disabled", true);
        $("#postal").attr("disabled", true);
        $("#country").attr("disabled", true);
        $("#state").attr("disabled", true);
        $("#country").val('-1').change();

    }
}

function addressCreateQuickS(isTrue, name) {
    $("#" + name + "_address").val('');
    $("#" + name + "_city").val('');
    $("#" + name + "_postal").val('');
    $("#" + name + "_state").val('').change();
    if (isTrue) {
        $("#" + name + "_address").attr("disabled", false);
        $("#" + name + "_city").attr("disabled", false);
        $("#" + name + "_postal").attr("disabled", false);
        $("#" + name + "_country").attr("disabled", false);
        $("#" + name + "_state").attr("disabled", false);
        $("#" + name + "_country").val('USA').change();
    } else {
        $("#" + name + "_address").attr("disabled", true);
        $("#" + name + "_city").attr("disabled", true);
        $("#" + name + "_postal").attr("disabled", true);
        $("#" + name + "_country").attr("disabled", true);
        $("#" + name + "_state").attr("disabled", true);
        $("#" + name + "_country").val('-1').change();
    }
}

function addressCreateOD(isTrue, name) {
    $("#" + name + "_address").val('');
    $("#" + name + "_city").val('');
    $("#" + name + "_postal").val('');
    $("#" + name + "_state").val('').change();
    if (isTrue) {
        $("#" + name + "_address").attr("disabled", false);
        $("#" + name + "_city").attr("disabled", false);
        $("#" + name + "_postal").attr("disabled", false);
        $("#" + name + "_country").attr("disabled", false);
        $("#" + name + "_state").attr("disabled", false);
        $("#" + name + "_country").val('USA').change();

    } else {
        $("#" + name + "_address").attr("disabled", true);
        $("#" + name + "_city").attr("disabled", true);
        $("#" + name + "_postal").attr("disabled", true);
        $("#" + name + "_country").attr("disabled", true);
        $("#" + name + "_state").attr("disabled", true);
        $("#" + name + "_country").val('-1').change();
    }
}

function isHeadOffice(isTrue) {
    if (isTrue) {
        $(".head-office-fields").hide();
    } else {
        $(".head-office-fields").show();
    }
    $(".address-fields").show();
}

function triggerChangeOnSelectCountry(id, val) {
    $('#' + id).val(val);
    $('#' + id).trigger("change");
}


function selectOriginClient(client_id) {
    $.ajax({
        method: 'get',
        url: "/clients/origins",
        data: {client_id: client_id}
    }).done(function (data) {
        $("#origin_id").val(data.client_id).change();
        $("#origin_location_id").val(data.origins).change();
    })
}

function locationDetails(id) {
    $.ajax({
        method: 'get',
        url: "/api/locations/" + id
    }).done(function (data) {
        $("#address").val(data.address);
        $("#country").val(data.country).change();
        $("#state").val(data.state).change();
        $("#city").val(data.city);
        $("#postal").val(data.postal);
    })

}

function locationDetailsOD(id, name) {
    $.ajax({
        method: 'get',
        url: "/api/locations/" + id
    }).done(function (data) {
        $("#" + name + "_address").val(data.address);
        $("#" + name + "_country").val(data.country).change();
        $("#" + name + "_state").val(data.state).change();
        $("#" + name + "_city").val(data.city);
        $("#" + name + "_postal").val(data.postal);
    })

}

function clientLocation(id, name) {
    $.ajax({
        method: 'get',
        url: "/api/clients/" + id
    }).done(function (data) {
        $("#" + name + "_location_id").val(data.default_location.id).change();
    })

}

function getDistance() {
    var origin = $("#rate_origin_city").val() + " " + $("#rate_origin_state").val() + "," + $("#rate_origin_country").val();
    var destination = $("#rate_destination_city").val() + " " + $("#rate_destination_state").val() + "," + $("#rate_destination_country").val();
    $.ajax({
        method: 'get',
        url: "/api/locations/distance",
        data: {origin: origin, destination: destination}
    }).done(function (data) {
        $("#rate_miles").val((data.distance / 1000).toFixed(2));
        // var map = $('#map'),
        //    cval = data.img_url;
        //
        // $('<img id="map" src="'+ cval +'">').insertAfter( map );
        // map.remove();
    })
}

function setFieldMask(country_id, field_mask_id) {
    var str_val = $('#' + country_id).val();
    var selector = '#' + field_mask_id;
    if (str_val === "Canada") {
        $(selector).inputmask({mask: "A9A9A9"});
    } else if (str_val === "USA") {
        $(selector).inputmask({mask: "99999"});
    } else {
        $(selector).inputmask('remove');
    }
}

function filterTable(id) {
    $('#' + id + ' tfoot th').each(function () {
        var title = $(this).text();
        $(this).html('<input type="text" placeholder="Search ' + title + '" style="width: 100%;"/>');
    });

    // DataTable
    var table = $('#' + id).DataTable({
        "scrollX": true,
        "pageLength": 50,
        "drawCallback": function (settings) {
            $('[data-toggle="tooltip"]').tooltip({
                trigger: 'hover',
                html: true
            })
        },
    });

    // Apply the search
    table.columns().every(function () {
        var that = this;

        $('input', this.footer()).on('keyup change', function () {
            $('[data-toggle="tooltip"]').tooltip("hide");
            if (that.search() !== this.value) {
                that.search(this.value).draw();
            }
        });
    });
}

function loadContacts(client_type, controller, value, selected) {
    var this_id = "#" + controller + "_" + client_type + "_contact_id"
    var url = "/api/" + client_type + "_contacts"
    if (value) {
        url = url + "?" + client_type + "_id=" + value
    }
    $(this_id).empty().append('<option value="">Select Contact</option>');
    $.ajax({
        method: 'get',
        url: url
    }).done(function (data) {
        var array = data;
        if (array != '') {
            for (i in array) {
                if (array[i].id.toString() == selected.toString()) {
                    $(this_id).append("<option value='" + array[i].id + "' selected>" + array[i].full_name + "</option>");
                } else {
                    $(this_id).append("<option value='" + array[i].id + "'>" + array[i].full_name + "</option>");
                }
            }
        }
    })
}

function loadActivities(client_type, value, selected) {
    var this_id = "#rate_activity_id"
    var url = "/api/activities"
    if (value) {
        url = url + "?" + client_type + "_id=" + value
    }
    $(this_id).empty().append('<option value="">Select Activity</option>');
    $.ajax({
        method: 'get',
        url: url
    }).done(function (data) {
        var array = data;
        if (array != '') {
            for (i in array) {
                if (array[i].id.toString() == selected.toString()) {
                    $(this_id).append("<option value='" + array[i].id + "' selected>" + array[i].campaign_name + "</option>");
                } else {
                    $(this_id).append("<option value='" + array[i].id + "'>" + array[i].campaign_name + "</option>");
                }
            }
        }
    })
}

function hideExtensionNumber(controller, field) {
    var this_id = "#" + controller + "_" + field + "_extension_number";
    var phone_type = $("#" + controller + "_" + field + "_phone_type").val();

    if (phone_type === 'Land Line') {
        $(this_id).prop('disabled', false);
    } else {
        $(this_id).prop('disabled', true);
    }
}
