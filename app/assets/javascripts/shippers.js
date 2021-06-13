function initShipperTable() {
  var table = $('#shipper_table').dataTable({
    "processing": true,
    "serverSide": true,
    fixedHeader: true,
    "ajax": {
      "url": $('#shipper_table').data('source'),
      "dataSrc": function ( json ) {
        return json.data;
      }
    },
    "rowCallback": function (row, data) {
      if (data.sales_priority == "<span class='text-indigo'>B</span>" && data.three_weeks_lapse){
        $(row).addClass('table-warning');
      }
    },
    "scrollX": true,
    "pageLength": 50,
    "drawCallback": function(settings) {
        $('[data-toggle="tooltip"]').tooltip({
          trigger: 'hover',
          html: true
        })
      },
    "pagingType": "full_numbers",
    "createdRow": function ( row, data, index ) {
      if (data.sales_priority == "<span class='text-indigo'>B</span>" && data.three_weeks_lapse == "true") {
        $(row).addClass('table-warning');
      }
    },

    "order": [[ 1, "asc" ], [ 2, "asc" ]],
    'columnDefs': [{
        'targets': 0,
        'checkboxes': {
          'selectRow': true
        }
      }],
    "columns": [
      {"data": "id"},
      {"data": "c_reminder_date"},
      {"data": "relationship_owner_name"},
      {"data": "sales_priority"},
      {"data": "company_name"},
      {"data": "state"},
      {"data": "pdm_name"},
      {"data": "primary_phone"},
      {"data": "c_lane_origin"},
      {"data": "contact_email"},
      {"data": "approved"},
      {"data": "complete_record"},
      {"data": "date_opened"},
      {"data": "load_last_month"},
      {"data": "load_last_6_month"},
      {"data": "city"},
      {"data": "loads_per_month"},
      {"data": "commodities"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  }).yadcf([
    {column_number : 1, filter_type: "text", filter_reset_button_text: false},
    {column_number : 2, filter_type: "text", filter_reset_button_text: false},
    {column_number : 3, data: ['New', 'A', 'B', 'C', 'D', 'U'], filter_default_label: "Prior", filter_reset_button_text: false},
    {column_number : 4, filter_type: "text", filter_reset_button_text: false},
    {column_number : 5, filter_type: "text", filter_reset_button_text: false},
    {column_number : 6, filter_type: "text", filter_reset_button_text: false},
    {column_number : 7, filter_type: "text", filter_reset_button_text: false},
    {column_number : 8, filter_type: "text", filter_reset_button_text: false},
    {column_number : 9, filter_type: "text", filter_reset_button_text: false},
    {column_number : 10, data: [{value: 1,label: 'Y'}, {value: 0,label: 'N'}], filter_default_label: "Y/N", filter_reset_button_text: false},
    {column_number : 11, data: [{value: 1,label: 'Y'}, {value: 0,label: 'N'}], filter_default_label: "Y/N", filter_reset_button_text: false},
    {column_number : 12, filter_type: "text", filter_reset_button_text: false},
    {column_number : 13, filter_type: "text", filter_reset_button_text: false},
    {column_number : 14, filter_type: "text", filter_reset_button_text: false},
    {column_number : 15, filter_type: "text", filter_reset_button_text: false},
    {column_number : 16, filter_type: "text", filter_reset_button_text: false},
    {column_number : 17, filter_type: "text", filter_reset_button_text: false}]);
}
