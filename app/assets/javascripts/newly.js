jQuery(document).ready(function() {
  function getDates(startDate, stopDate) {
    var dateArray = [];
    var currentDate = moment(startDate);
    var stopDate = moment(stopDate);
    while (currentDate <= stopDate) {
        dateArray.push( moment(currentDate).format('MM/DD/YYYY') )
        currentDate = moment(currentDate).add(1, 'days');
    }
    return dateArray;
}

  function generate_styling_carriers (created_at, interview){
    arr_date = getDates(moment().subtract(7, 'days'), moment());
    if (created_at){
      if (arr_date.includes(created_at)) {
        if (interview === "<i class='text-success'>Yes</i>") {
          return "bg-lightgreen";
        }else{
          return "bg-white";
        }
      }else if (!arr_date.includes(created_at)) {
        if (interview === "<i class='text-success'>Yes</i>") {
          return "bg-lightblue";
        }else{
          return "bg-lightpink";
        }
      }else{
        return "bg-lightpink";
      }
    }else{
        return "bg-lightpink"
    }
  }

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
    "createdRow": function ( row, data, index ) {
      row_class = generate_styling_carriers(data.first_load_date, data.interview);
      $(row).addClass(row_class);
    },
    "pagingType": "full_numbers",
    "order": [[13, "asc"]],
    'columnDefs': [{
        'targets': 0,
        'checkboxes': {
          'selectRow': true
        }
      }],
    "pageLength": 50,
    "columns": [
      {"data": "mc_number"},
      {"data": "first_load_date"},
      {"data": "loads_lw"},
      {"data": "loads_2w"},
      {"data": "loads_3w"},
      {"data": "loads_4w"},
      {"data": "loads_5w"},
      {"data": "loads_6w"},
      {"data": "carrier_name"},
      {"data": "contact"},
      {"data": "sales_priority"},
      {"data": "relationship_owner"},
      {"data": "last_os"},
      {"data": "last_ds"},
      {"data": "mc_number"},
      {"data": "current_tier"},
      {"data": "power_units"},
      {"data": "reefers"},
      {"data": "teams"},
      {"data": "interview"},
      {"data": "gross_margin"},
      {"data": "wolfbyte"},
      {"data": "wk"}
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
    {column_number : 10, data: ["Bronze", "Silver", "Gold", "Platinum", "Diamond", "No Tier Yet"], filter_default_label: "Tier", filter_reset_button_text: false},
    {column_number : 11, filter_type: "text", filter_reset_button_text: false},
    {column_number : 12, filter_type: "text", filter_reset_button_text: false},
    {column_number : 13, filter_type: "text", filter_reset_button_text: false},
    {column_number : 14, filter_type: "text", filter_reset_button_text: false},
    {column_number : 15, filter_type: "text", filter_reset_button_text: false},
    {column_number : 16, filter_type: "text", filter_reset_button_text: false},
    {column_number : 17, filter_type: "text", filter_reset_button_text: false},
    {column_number : 18, filter_type: "text", filter_reset_button_text: false},
    {column_number : 19, data: [{value: 1,label: 'Yes'}, {value: 0,label: 'No'}], filter_default_label: "Y/N", filter_reset_button_text: false},
    {column_number : 20, filter_type: "text", filter_reset_button_text: false},
    {column_number : 21, data: [{value: 1,label: 'Yes'}, {value: 0,label: 'No'}], filter_default_label: "Y/N", filter_reset_button_text: false},
    {column_number : 22, filter_type: "text", filter_reset_button_text: false}]);
});
