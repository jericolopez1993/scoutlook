jQuery(document).ready(function() {
  $('#demotion-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    fixedHeader: true,
    "ajax": {
      "url": $('#demotion-datatable').data('source')
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
      {"data": "mc_number"},
      {"data": "carrier_name"},
      {"data": "current_tier"},
      {"data": "previous_tier"},
      {"data": "highest_tier"},
      {"data": "highest_tier_date"},
      {"data": "gross_margin"},
      {"data": "load_last_week"},
      {"data": "load_last_month"},
      {"data": "load_last_3_months"},
      {"data": "load_last_6_months"},
      {"data": "primary_phone"},
      {"data": "secondary_phone"},
      {"data": "sales_priority"},
      {"data": "relationship_owner"},
      {"data": "days_since"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  }).yadcf([
    {column_number : 0, filter_type: "text", filter_reset_button_text: false},
    {column_number : 1, filter_type: "text", filter_reset_button_text: false},
    {column_number : 2, data: ["Bronze", "Silver", "Gold", "Platinum", "Diamond", "No Tier Yet"], filter_default_label: "Tier", filter_reset_button_text: false},
    {column_number : 3, data: ["Bronze", "Silver", "Gold", "Platinum", "Diamond", "No Tier Yet"], filter_default_label: "Tier", filter_reset_button_text: false},
    {column_number : 4, data: ["Bronze", "Silver", "Gold", "Platinum", "Diamond", "No Tier Yet"], filter_default_label: "Tier", filter_reset_button_text: false},
    {column_number : 5, filter_type: "text", filter_reset_button_text: false},
    {column_number : 6, filter_type: "text", filter_reset_button_text: false},
    {column_number : 7, filter_type: "text", filter_reset_button_text: false},
    {column_number : 8, filter_type: "text", filter_reset_button_text: false},
    {column_number : 9, filter_type: "text", filter_reset_button_text: false},
    {column_number : 10, filter_type: "text", filter_reset_button_text: false},
    {column_number : 11, filter_type: "text", filter_reset_button_text: false},
    {column_number : 12, filter_type: "text", filter_reset_button_text: false},
    {column_number : 13, data: ['New', 'A', 'B', 'C', 'D', 'U'], filter_default_label: "Status", filter_reset_button_text: false},
    {column_number : 14, filter_type: "text", filter_reset_button_text: false},
    {column_number : 15, filter_type: "text", filter_reset_button_text: false}]);
});
