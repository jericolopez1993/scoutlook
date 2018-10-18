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
//= require turbolinks
//= require vendor/pace.min
//= require vendor/jquery-3.3.1.min
//= require vendor/jquery-ui.min
//= require vendor/bootstrap.bundle.min
//= require vendor/jquery.slimscroll.min
//= require vendor/js.cookie
//= require vendor/default
//= require vendor/apps.min
//= require vendor/jquery.dataTables
//= require vendor/dataTables.buttons.min
//= require vendor/buttons.bootstrap.min
//= require vendor/buttons.flash.min
//= require vendor/jszip.min
//= require vendor/pdfmake.min
//= require vendor/vfs_fonts.min
//= require vendor/buttons.html5.min
//= require vendor/buttons.print.min.js
//= require vendor/dataTables.responsive.min
//= require vendor/table-manage-buttons.demo.min
//= require vendor/parsley.min
//= require vendor/highlight.common
//= require vendor/render.highlight
//= require vendor/jquery.gritter
//= require vendor/switchery.min
//= require vendor/form-slider-switcher.demo
//= require vendor/countries
//= require vendor/jquery.chained
//= require vendor/bootstrap-datepicker.min
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
(function() {
  $(document).on('turbolinks:before-cache', function() {
    var dataTable;
    dataTable = $($.fn.dataTable.tables(true)).DataTable();
    if (dataTable !== null) {
      dataTable.destroy();
      return dataTable = null;
    }
    
  });

}).call(this);
$(document).on('turbolinks:load', function(){
  activityOutcomeFields($("#activity_activity_type").val());
  sameHeadOffice($('[data-change="check-switchery-state-text"]').prop('checked'));
  isHeadOffice($('[data-change="check-switchery-state-same-office"]').prop('checked'));
  shipmentFields($('input[type=radio][name="master_invoice[shipment_entry]"]:checked').val());
  addressCreate($('[data-change="check-switchery-state-new-location"]').prop('checked'));
  addressCreateOD($('[data-change="check-switchery-state-new-location-origin"]').prop('checked'), 'origin');
  addressCreateOD($('[data-change="check-switchery-state-new-location-destination"]').prop('checked'), 'destination');
  addressCreateQuickS($('[data-change="check-switchery-state-new-location-quick-destination"]').prop('checked'), 'quick_destination');

  $("#origin_location_id").chained("#origin_id");
  $("#destination_location_id").chained("#destination_id");

	$('.datepicker-autoClose').datepicker({
		todayHighlight: true,
		autoclose: true,
    orientation: 'auto bottom'
	});
  $(".combo-dropdown").select2({
    tags: true,
    createTag: function (params) {
      return {
        id: params.term,
        text: params.term,
        newOption: true
      }
    },
     templateResult: function (data) {
      var $result = $("<span>a</span>");
      $result.text(data.text);

      if (data.newOption) {
        $result.append(" <em>(new)</em>");
      }

      return $result;
    }
  })
  $( ".combo-dropdown" ).change(function() {
    params = $(this).val();
        $.ajax({
          method: 'post',
          url: "/api/locations",
          data: {location: {name: params}}
        }).done(function(data) {
          return {
            id: data.id,
            text: data.name,
            newOption: true
          }
        })
  });

  $(function(){
      Inputmask().mask(document.querySelectorAll("input"));

      $("#activity_activity_type").change(function(){
        activityOutcomeFields($(this).val());
      });

      $(document).on('change', '[data-change="check-switchery-state-text"]', function() {
        sameHeadOffice($(this).prop('checked'));
    	});
      $(document).on('change', '[data-change="check-switchery-state-same-office"]', function() {
        isHeadOffice($(this).prop('checked'));
    	});
      $(document).on('change', '[data-change="check-switchery-state-new-location"]', function() {
        $("#address").val('');
        $("#city").val('');
        $("#postal").val('');
        $("#country").val('-1').change();
        $("#state").val('').change();
        addressCreate($(this).prop('checked'));
      });

      $(document).on('change', '[data-change="check-switchery-state-new-location-origin"]', function() {
        addressCreateOD($(this).prop('checked'), 'origin');
      });
      $(document).on('change', '[data-change="check-switchery-state-new-location-destination"]', function() {
        addressCreateOD($(this).prop('checked'), 'destination');
      });
      $(document).on('change', '[data-change="check-switchery-state-new-location-quick-destination"]', function() {
        addressCreateQuickS($(this).prop('checked'), 'quick_destination');
      });
      $('input[type=radio][name="master_invoice[shipment_entry]"]').change(function() {
          shipmentFields(this.value);
      });

      $("#master_invoice_shipper_id").change(function(){
        clientLocation($(this).val(), 'origin');
      });

      $('.total_charge_fields').keyup(function() {
          addTotalNumbers('total_charge_fields', 'shipment_total_charge');
          addTotalNumbers('total_charge_fields', 'master_invoice_total_charge_shipment');
      });
      $('.total_charge_with_tax_fields').keyup(function() {
          addTotalNumbers('total_charge_with_tax_fields', 'shipment_total_charge_with_tax');
          addTotalNumbers('total_charge_with_tax_fields', 'master_invoice_total_charge_with_tax');
      });

      // $("#origin_location_id, #destination_location_id").change(function(){
      //   var origin = $("#origin_location_id").val();
      //   var destination = $("#destination_location_id").val();
      //   getDistance(origin, destination);
      // });

      $("#location_id").change(function(){
        locationDetails($(this).val());
      });
      $("#origin_location_id").change(function(){
        locationDetailsOD($(this).val(), 'origin');
      });
      $("#destination_location_id").change(function(){
        locationDetailsOD($(this).val(), 'destination');
      });
      $("#quick_destination_id").change(function(){
        locationDetailsOD($(this).val(), 'quick_destination');
      });
  });

});



function activityOutcomeFields(actype) {
  if (actype === 'Engagement') {
      $(".outcome-fields").show();
      $(".activity_buttons").hide();
      $(".engagement-fields").show();
      $(".loop-fields").hide();
  }else if (actype === 'Loop') {
      $(".outcome-fields").show();
      $(".activity_buttons").hide();
      $(".engagement-fields").hide();
      $(".loop-fields").show();
  }else{
      $(".outcome-fields").hide();
      $(".activity_buttons").show();

  }
}

function sameHeadOffice(isTrue) {
  if (isTrue) {
    $(".address-fields").hide();
  }else{
    $(".address-fields").show();
  }
}

function addressCreate(isTrue) {
  if (isTrue) {
    $(".location-fields").hide();
    $("#address").attr("disabled", false);
    $("#city").attr("disabled", false);
    $("#postal").attr("disabled", false);
    $("#country").attr("disabled", false);
    $("#state").attr("disabled", false);

  }else{
    $(".location-fields").show();
    $("#address").attr("disabled", true);
    $("#city").attr("disabled", true);
    $("#postal").attr("disabled", true);
    $("#country").attr("disabled", true);
    $("#state").attr("disabled", true);
  }
}
function addressCreateQuickS(isTrue, name) {
  $("#"+ name +"_address").val('');
  $("#"+ name +"_city").val('');
  $("#"+ name +"_postal").val('');
  $("#"+ name +"_country").val('-1').change();
  $("#"+ name +"_state").val('').change();
  if (isTrue) {
    $("#"+ name +"_id").attr("disabled", true);
    $("#"+ name +"_address").attr("disabled", false);
    $("#"+ name +"_city").attr("disabled", false);
    $("#"+ name +"_postal").attr("disabled", false);
    $("#"+ name +"_country").attr("disabled", false);
    $("#"+ name +"_state").attr("disabled", false);

  }else{
    $("#"+ name +"_id").attr("disabled", false);
    $("#"+ name +"_address").attr("disabled", true);
    $("#"+ name +"_city").attr("disabled", true);
    $("#"+ name +"_postal").attr("disabled", true);
    $("#"+ name +"_country").attr("disabled", true);
    $("#"+ name +"_state").attr("disabled", true);
  }
}
function addressCreateOD(isTrue, name) {
  $("#"+ name +"_address").val('');
  $("#"+ name +"_city").val('');
  $("#"+ name +"_postal").val('');
  $("#"+ name +"_country").val('-1').change();
  $("#"+ name +"_state").val('').change();
  if (isTrue) {
    $("."+ name +"-location-fields").hide();
    $("#"+ name +"_address").attr("disabled", false);
    $("#"+ name +"_city").attr("disabled", false);
    $("#"+ name +"_postal").attr("disabled", false);
    $("#"+ name +"_country").attr("disabled", false);
    $("#"+ name +"_state").attr("disabled", false);

  }else{
    $("."+ name +"-location-fields").show();
    $("#"+ name +"_address").attr("disabled", true);
    $("#"+ name +"_city").attr("disabled", true);
    $("#"+ name +"_postal").attr("disabled", true);
    $("#"+ name +"_country").attr("disabled", true);
    $("#"+ name +"_state").attr("disabled", true);
  }
}

function isHeadOffice(isTrue) {
  if (isTrue) {
    $(".head-office-fields").hide();
  }else{
    $(".head-office-fields").show();
  }
  $(".address-fields").show();
}

function tiggerChangeOnSelectCountry(id, val) {
  $('#'+id).val(val);
  $('#'+id).trigger("change");
}

function shipmentFields(shipmentEntry) {
  console.log(shipmentEntry);
  if (shipmentEntry == 'single shipment') {
    $(".shipment-fields").show();
  }
  else {
    $(".shipment-fields").hide();
  }
}

function addTotalNumbers(className, id) {
  var total_num = 0;
  $('.'+className).each(function(){
    if ($(this).val() != ""){
        total_num = total_num + parseFloat($(this).val().replace('$ ','').replace(/,/g,""));
    }
  })
    $('#'+id).val(total_num);
}

function selectOriginClient(client_id) {
  $.ajax({
    method: 'get',
    url: "/clients/origins",
    data: {client_id: client_id}
  }).done(function(data) {
    $("#origin_id").val(data.client_id).change();
    $("#origin_location_id").val(data.origins).change();
  })
}

function locationDetails(id) {
  $.ajax({
    method: 'get',
    url: "/api/locations/"+id
  }).done(function(data) {
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
    url: "/api/locations/"+id
  }).done(function(data) {
    $("#"+ name +"_address").val(data.address);
    $("#"+ name +"_country").val(data.country).change();
    $("#"+ name +"_state").val(data.state).change();
    $("#"+ name +"_city").val(data.city);
    $("#"+ name +"_postal").val(data.postal);
  })

}

function clientLocation(id, name) {
  $.ajax({
    method: 'get',
    url: "/api/clients/"+id
  }).done(function(data) {
    console.log(data.default_location.id)
    $("#"+ name +"_location_id").val(data.default_location.id).change();
  })

}

function getDistance(origin, destination){
  $.ajax({
    method: 'get',
    url: "/api/locations/distance",
    data: {origin: origin, destination: destination}
  }).done(function(data) {
    $("#distance").val((data.distance / 1000).toFixed(2));
  })
}
