jQuery(document).ready(function() {
  $('#loads-datatable').dataTable({
    "processing": true,
    "serverSide": true,
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
  });
});
