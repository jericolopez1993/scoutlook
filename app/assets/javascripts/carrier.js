jQuery(document).ready(function() {
  $('#customer_table').dataTable({
    "processing": true,
    "serverSide": true,
    fixedHeader: true,
    "ajax": {
      "url": $('#customer_table').data('source')
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
      {"data": "id"},
      {"data": "c_reminder_date"},
      {"data": "interview"},
      {"data": "wolfbyte"},
      {"data": "relationship_owner_name"},
      {"data": "sales_priority"},
      {"data": "mc_number"},
      {"data": "company_name"},
      {"data": "power_units"},
      {"data": "reefers"},
      {"data": "teams"},
      {"data": "c_mc_latest_date_load_days"},
      {"data": "c_mc_latest_date_tier"},
      {"data": "loads_lw"},
      {"data": "c_mc_latest_date_last_month"},
      {"data": "c_mc_latest_date_last_6_months"},
      {"data": "c_lane_origin"},
      {"data": "blacklisted"},
      {"data": "poc_name"},
      {"data": "primary_phone"},
      {"data": "contact_email"},
      {"data": "approved"},
      {"data": "complete_record"},
      {"data": "date_opened"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
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
});
