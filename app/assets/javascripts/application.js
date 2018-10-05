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
//= require inputmask
//= require jquery.inputmask
//= require inputmask.extensions
//= require inputmask.date.extensions
//= require inputmask.phone.extensions
//= require inputmask.numeric.extensions
//= require inputmask.regex.extensions
//= require tinymce
//= require_tree .
$(document).on('turbolinks:load', function(){
  activityOutcomeFields($("#activity_activity_type").val());
  sameHeadOffice($('[data-change="check-switchery-state-text"]').prop('checked'));
  isHeadOffice($('[data-change="check-switchery-state-same-office"]').prop('checked'));
  shipmentFields($('input[type=radio][name="master_invoice[shipment_entry]"]:checked').val());
  $("#origin_location_id").chained("#origin_id");
  $("#destination_location_id").chained("#destination_id");
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

      $('input[type=radio][name="master_invoice[shipment_entry]"]').change(function() {
          shipmentFields(this.value);
      });

      $('.total_charge_fields').keyup(function() {
          addTotalNumbers('total_charge_fields', 'shipment_total_charge');
          addTotalNumbers('total_charge_fields', 'master_invoice_total_charge_shipment');
      });
      $('.total_charge_with_tax_fields').keyup(function() {
          addTotalNumbers('total_charge_with_tax_fields', 'shipment_total_charge_with_tax');
          addTotalNumbers('total_charge_with_tax_fields', 'master_invoice_total_charge_with_tax');
      });

      $("#origin_location_id, #destination_location_id").change(function(){
        var origin = $("#origin_location_id").val();
        var destination = $("#destination_location_id").val();
        getOriginDestination(origin, destination);
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

function getOriginDestination(origin, destination){
  $.ajax({
    method: 'get',
    url: "/client_locations/origin_destination",
    data: {origin: origin, destination: destination}
  }).done(function(data) {
    getDistanceLocation(data.origin, data.destination);
  })
}

function getDistanceLocation(origin, destination) {
  $.ajax({
    url: "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=" + origin + "&destinations=" + destination + "&key=AIzaSyCbFFNkesD-8_F4lMdyihwqpARlDYmG6k0",

  }).done(function(data) {
    console.log(data)
  })
}
