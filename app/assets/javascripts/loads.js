function initLoadTable() {
  $('#loads-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    fixedHeader: true,
    "ajax": {
      "url": $('#loads-datatable').data('source')
    },
    "scrollX": true,
    "drawCallback": function( settings ) {
      $('[data-toggle="tooltip"]').tooltip({
          trigger: 'hover',
          html: true
      })
    },
    "pagingType": "full_numbers",
    "order": [[1, "desc"]],
    "columns": [
      {"data": "load_number"
      // "render": function(data, type, row, meta){
      //         if(type === 'display'){
      //             data = '<a href="/loads/' + data + '">' + data + '</a>';
      //         }
      //
      //         return data;
      //      }},
      },
      {"data": "ship_date"},
      {"data": "customer"},
      {"data": "origin"},
      {"data": "os"},
      {"data": "destination"},
      {"data": "ds"},
      {"data": "mc_number"},
      {"data": "carrier"},
      {"data": "curr"},
      {"data": "ttt"},
      {"data": "billing"},
      {"data": "mileage"},
      {"data": "ttt_rpm"},
      {"data": "bill_rpm"},
      {"data": "gm"},
      {"data": "gmper"},
      {"data": "cust_sys"},
      {"data": "carr_sys"},
      {"data": "gross_margin"},
      {"data": "exchange_rate"},
      {"data": "sales"},
      {"data": "dispatch"},
      {"data": "truck"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  }).yadcf([
    {column_number : 0, filter_type: "text", filter_reset_button_text: false},
    {column_number : 1, filter_type: "text", filter_reset_button_text: false},
    {column_number : 2, filter_type: "text", filter_reset_button_text: false},
    {column_number : 3, filter_type: "text", filter_reset_button_text: false},
    {column_number : 4, filter_type: "text", filter_reset_button_text: false},
    {column_number : 5, filter_type: "text", filter_reset_button_text: false},
    {column_number : 6, filter_type: "text", filter_reset_button_text: false},
    {column_number : 7, filter_type: "text", filter_reset_button_text: false},
    {column_number : 8, filter_type: "text", filter_reset_button_text: false},
    {column_number : 9, filter_type: "text", filter_reset_button_text: false},
    {column_number : 10, filter_type: "text", filter_reset_button_text: false},
    {column_number : 11, filter_type: "text", filter_reset_button_text: false},
    {column_number : 12, filter_type: "text", filter_reset_button_text: false},
    {column_number : 13, filter_type: "text", filter_reset_button_text: false},
    {column_number : 14, filter_type: "text", filter_reset_button_text: false},
    {column_number : 15, filter_type: "text", filter_reset_button_text: false},
    {column_number : 16, filter_type: "text", filter_reset_button_text: false},
    {column_number : 17, filter_type: "text", filter_reset_button_text: false},
    {column_number : 18, filter_type: "text", filter_reset_button_text: false},
    {column_number : 19, filter_type: "text", filter_reset_button_text: false},
    {column_number : 20, filter_type: "text", filter_reset_button_text: false},
    {column_number : 21, filter_type: "text", filter_reset_button_text: false},
    {column_number : 22, filter_type: "text", filter_reset_button_text: false},
    {column_number : 23, filter_type: "text", filter_reset_button_text: false}]);
}
