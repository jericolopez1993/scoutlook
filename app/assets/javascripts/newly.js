jQuery(document).ready(function() {
  $('#newly-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    fixedHeader: true,
    "ajax": {
      "url": $('#newly-datatable').data('source')
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
      {"data": "interview"},
      {"data": "wolfbyte"},
      {"data": "sales_priority"},
      {"data": "relationship_owner"},
      {"data": "mc_number"},
      {"data": "carrier_name"},
      {"data": "current_tier"},
      {"data": "power_units"},
      {"data": "reefers"},
      {"data": "teams"},
      {"data": "contact"},
      {"data": "last_os"},
      {"data": "last_ds"},
      {"data": "wk"},
      {"data": "first_load_date"},
      {"data": "gross_margin"},
      {"data": "loads_lw"},
      {"data": "loads_2w"},
      {"data": "loads_3w"},
      {"data": "loads_4w"},
      {"data": "loads_5w"},
      {"data": "loads_6w"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  }).yadcf([
    {column_number : 0, data: [{value: 1,label: 'Yes'}, {value: 0,label: 'No'}], filter_default_label: "Y/N", filter_reset_button_text: false},
    {column_number : 1, data: [{value: 1,label: 'Yes'}, {value: 0,label: 'No'}], filter_default_label: "Y/N", filter_reset_button_text: false},
    {column_number : 2, filter_type: "text", filter_reset_button_text: false},
    {column_number : 3, filter_type: "text", filter_reset_button_text: false},
    {column_number : 4, filter_type: "text", filter_reset_button_text: false},
    {column_number : 5, filter_type: "text", filter_reset_button_text: false},
    {column_number : 6, data: ["Bronze", "Silver", "Gold", "Platinum", "Diamond", "No Tier Yet"], filter_default_label: "Tier", filter_reset_button_text: false},
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
    {column_number : 20, filter_type: "text", filter_reset_button_text: false}]);
});
