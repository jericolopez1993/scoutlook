function initActivitiesTable() {

  var table = $('#activities_table').dataTable({
    "processing": true,
    "serverSide": true,
    fixedHeader: true,
    "ajax": {
      "url": $('#activities_table').data('source'),
      "dataSrc": function ( json ) {
        return json.data;
      }
    },
    "rowCallback": function (row, data) {
    },
    "scrollX": true,
    "pageLength": 50,
    "drawCallback": function(settings) {
        $('[data-toggle="tooltip"]').tooltip({
          trigger: 'hover',
          html: true
        });
      },
    "pagingType": "full_numbers",
    "order": [[ 2, "asc" ]],
    "columns": [
      {"data": "actions"},
      {"data": "sp"},
      {"data": "name"},
      {"data": "location_state"},
      {"data": "loads_per_week"},
      {"data": "date_opened"},
      {"data": "date_closed"},
      {"data": "outcome"},
      {"data": "notes"},
      {"data": "activity_type"},
      {"data": "status"},
      {"data": "reason"}
    ]
  }).yadcf([
      {column_number : 1, filter_type: "text", filter_reset_button_text: false},
      {column_number : 2, filter_type: "text", filter_reset_button_text: false},
      {column_number : 3, filter_type: "text", filter_reset_button_text: false},
      {column_number : 4, filter_type: "text", filter_reset_button_text: false},
      {column_number : 5, filter_type: "text", filter_reset_button_text: false},
      {column_number : 6, filter_type: "text", filter_reset_button_text: false},
      {column_number : 7, filter_type: "text", filter_reset_button_text: false},
      {column_number : 8, filter_type: "text", filter_reset_button_text: false},
      {column_number : 9, filter_type: "text", filter_reset_button_text: false},
      {column_number : 10, data: [{value: 1,label: 'Open'}, {value: 0,label: 'Closed'}], filter_default_label: "Y/N", filter_reset_button_text: false},
      {column_number : 11, filter_type: "text", filter_reset_button_text: false}]);
}
