function initReminderTable() {
  $('#reminder-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    fixedHeader: true,
    "ajax": {
      "url": $('#reminder-datatable').data('source')
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
      {"data": "actions"},
      {"data": "carrier_id"},
      {"data": "shipper_id"},
      {"data": "campaign_name"},
      {"data": "user_name"},
      {"data": "reminder_type"},
      {"data": "next_reminder_date"},
      {"data": "completed"},
      {"data": "last_reminded"},
      {"data": "notes"},
      {"data": "created_at"}

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
    {column_number : 10, filter_type: "text", filter_reset_button_text: false}]);
}
