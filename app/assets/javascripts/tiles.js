function addDateToLoadForm(date, tile_tab_id) {
  $('#new_load').trigger("reset");
  $('.new-load-origin-multiple').val(null).trigger('change');
  $('.new-load-destination-multiple').val(null).trigger('change');
  $("#new_load").find("#last_load_date").datepicker('update', date);
  $("#new_load").find("#last_del_date").datepicker('update', date);
  $("#new_load").find("#load_tile_tile_tab_id").val(tile_tab_id)
  getTileOptions(date, tile_tab_id, "truck", "new_load", "");
  $('.datepicker_last_del_date').datepicker('setStartDate', date);
  $("#newLoadForm").modal('show');
}

function addDateToTruckForm(date, tile_tab_id) {
  $('#new_truck').trigger("reset");
  $('.new-truck-origin-multiple').val(null).trigger('change');
  $('.new-truck-destination-multiple').val(null).trigger('change');
  $("#new_truck").find("#last_load_date").datepicker('update', date);
  $("#new_truck").find("#last_del_date").datepicker('update', date);
  $("#new_truck").find("#truck_tile_tile_tab_id").val(tile_tab_id)
  $('.datepicker_last_truck_date').datepicker('setStartDate', date);
  $("#newTruckForm").modal('show');
}

function getTileOptions(load_date, tile_tab_id, tile_type, form_id, selected) {
  $.ajax({
    url: "/api/" + tile_type + "_tiles",
    data: {
      load_date: load_date,
      tile_tab_id: tile_tab_id
    },
    type: "GET",
    success: function(response) {
      items = '<option value=""></option>';
      $.each(response, function(i, channel) {
        if (selected.toString() == channel.id.toString()) {
          items += "<option value='" + channel.id + "' selected>" + channel.location_with_uniq_id + "</option>";
        } else {
          items += "<option value='" + channel.id + "'>" + channel.location_with_uniq_id + "</option>";
        }
      })
      $("#" + form_id + "_tile_id").html(items);
    }
  });
}

function getStatusOptions(tile_id, form_id, selected) {
  with_truck = ['Covered', 'Dispatched'];
  without_truck = ['Open', 'Priority', 'Stranded', 'Dropped', 'Forecast'];
  var items = '<option value=""></option>';
  if (tile_id == "") {
    for (i = 0; i < without_truck.length; i++) {
      if (selected == without_truck[i]) {
        items += "<option value='" + without_truck[i] + "' selected>" + without_truck[i] + "</option>";
      } else {
        items += "<option value='" + without_truck[i] + "'>" + without_truck[i] + "</option>";
      }
    }
  } else {
    for (i = 0; i < with_truck.length; i++) {
      if (selected == with_truck[i]) {
        items += "<option value='" + with_truck[i] + "' selected>" + with_truck[i] + "</option>";
      } else {
        items += "<option value='" + with_truck[i] + "'>" + with_truck[i] + "</option>";
      }
    }
  }
  $("#" + form_id + "_status").html(items);
}

function callProcessingModal() {
  $('#processing-modal').modal('toggle'); //before post
  // Post data
  setTimeout(function() {
    $('#processing-modal').modal('toggle'); // after post
  }, 1000);
}
var handleTile = function() {
  $(function() {
    $(".new-load-origin-multiple").select2({placeholder: "Select origins", allowClear: true, dropdownParent: $("#new_load")});
    $(".new-load-destination-multiple").select2({placeholder: "Select destinations", allowClear: true, dropdownParent: $("#new_load")});
    $(".new-truck-origin-multiple").select2({placeholder: "Select origins", allowClear: true, dropdownParent: $("#new_truck")});
    $(".new-truck-destination-multiple").select2({placeholder: "Select destinations", allowClear: true, dropdownParent: $("#new_truck")});
    $(".sortable-truck").sortable({
      connectWith: '.sortable-truck',
      cursor: 'move',
      placeholder: 'placeholder',
      forcePlaceholderSize: true,
      opacity: 0.4,
      stop: function(event, ui) {

        $.ajax({
          method: "PUT",
          url: "/api/truck_tiles/" + $(ui.item).data('id'),
          data: {
            load_date: $(ui.item).parent().parent().data('date')
          }
        }).done(function(data) {
          $("div#sortableKanbanBoards").html(data);
        });
      }
    }).disableSelection();
    $(".sortable-load").sortable({
      connectWith: '.sortable-load',
      cursor: 'move',
      placeholder: 'placeholder',
      forcePlaceholderSize: true,
      opacity: 0.4,
      stop: function(event, ui) {
        $.ajax({
          method: "PUT",
          url: "/api/load_tiles/" + $(ui.item).data('id'),
          data: {
            load_date: $(ui.item).parent().parent().data('date')
          }
        }).done(function(data) {
          $("div#sortableKanbanBoards").html(data);
        });
      }
    }).disableSelection();
    $(".load_tile_truck_tile_id").change(function() {
      getStatusOptions($(this).val(), $(this).data("form_id"), "");
    });
    $('.datepicker_last_load_date').datepicker({
      format: 'mm/dd/yyyy',
      autoclose: true,
      orientation: 'auto bottom'
    }).on('changeDate', function(e) {
      getTileOptions($(this).val(), $("#load_tile_tile_tab_id").val(), "truck", $(this).data("form_id"), "")
    });
    $('.datepicker_last_del_date').datepicker({
      format: 'mm/dd/yyyy',
      autoclose: true,
      orientation: 'auto bottom'
    });
    $('.datepicker_last_truck_date').datepicker({
      format: 'mm/dd/yyyy',
      autoclose: true,
      orientation: 'auto bottom'
    });
  });
};

var Tiles = function() {
  "use strict";


  return {
    //main function
    init: function() {
      this.initInitialTiles();
    },
    initInitialTiles: function() {
      handleTile();

    }
  };
}();
