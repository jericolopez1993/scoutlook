function addDateToLoadForm(date, tile_tab_id) {
  $("#new_load").find("#last_load_date").datepicker('update', date);
  $("#new_load").find("#load_tile_tile_tab_id").val(tile_tab_id)
  getTileOptions(date, tile_tab_id, "truck")
  $("#newLoadForm").modal('show');
}

function addDateToTruckForm(date, tile_tab_id) {
  $("#new_truck").find("#last_load_date").datepicker('update', date);
  $("#new_truck").find("#truck_tile_tile_tab_id").val(tile_tab_id)
  $("#newTruckForm").modal('show');
}

function getTileOptions(load_date, tile_tab_id, tile_type) {
  $.ajax({
    url: "/api/" + tile_type + "_tiles",
    data: {
      load_date: load_date,
      tile_tab_id: tile_tab_id
    },
    type: "GET",
    success: function(response) {
      var items = '<option value=""></option>';
      $.each(response, function(i, channel) {
        items += "<option value='" + channel.id + "'>" + channel.location_with_uniq_id + "</option>";
      });
      $("#load_tile_" + tile_type + "_tile_id").html(items);
    }
  });
}

var handleTile = function() {
  $(function() {
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
        }).done(function(data) {});
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
        }).done(function(data) {});
      }
    }).disableSelection();
    $(".load_tile_truck_tile_id").change(function() {
      if ($(this).val() == "") {
        $(".without_truck").show();
        $(".with_truck").hide();
      } else {
        $(".without_truck").hide();
        $(".with_truck").show();
      }
    });
    $('.datepicker_last_load_date').datepicker({
      format: 'dd/mm/yyyy',
      autoclose: true,
      orientation: 'auto bottom'
    }).on('changeDate', function(e) {
      getTileOptions($(this).val(), $("#load_tile_tile_tab_id").val(), "truck")
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
