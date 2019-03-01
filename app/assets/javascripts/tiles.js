function addDateToLoadForm(date, tile_tab_id) {
  $("#new_load").find("#last_load_date").datepicker('update', date);
  $("#new_load").find("#load_tile_tile_tab_id").val(tile_tab_id)
  $("#newLoadForm").modal('show');
}
function addDateToTruckForm(date, tile_tab_id) {
  $("#new_truck").find("#last_load_date").datepicker('update', date);
  $("#new_truck").find("#truck_tile_tile_tab_id").val(tile_tab_id)
  $("#newTruckForm").modal('show');
}

var handleTile = function() {
  $(function () {
    $( ".sortable-truck" ).sortable({
          connectWith: '.sortable-truck',
          cursor: 'move',
        placeholder: 'placeholder',
        forcePlaceholderSize: true,
        opacity: 0.4,
            stop: function(event, ui) {

              $.ajax({
                method: "PUT",
                url: "/api/truck_tiles/"+$(ui.item).data('id'),
                data: {
                  load_date: $(ui.item).parent().parent().data('date')
                }
              }).done(function (data) {
              });
            }
     }).disableSelection();
     $( ".sortable-load" ).sortable({
           connectWith: '.sortable-load',
           cursor: 'move',
        placeholder: 'placeholder',
        forcePlaceholderSize: true,
        opacity: 0.4,
             stop: function(event, ui) {
               $.ajax({
                 method: "PUT",
                 url: "/api/load_tiles/"+$(ui.item).data('id'),
                 data: {
                   load_date: $(ui.item).parent().parent().data('date')
                 }
               }).done(function (data) {
               });
             }
      }).disableSelection();
   });
};

var Tiles = function () {
	"use strict";


	return {
		//main function
		init: function () {
			this.initInitialTiles();
		},
		initInitialTiles: function() {
			handleTile();

		}
  };
}();
