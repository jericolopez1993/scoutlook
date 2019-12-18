$(function () {
  $.fn.dataTableExt.afnFiltering.push(function( oSettings, aData, iDataIndex ) {
    var column_index = $('#carrier_table_filter_column').val();
    var comparator = $('#carrier_table_filter_comparator').val();
    var value = $('#carrier_table_filter_value').val();

    if (value) {
      if (value.length > 0 && !isNaN(parseInt(value, 10))) {
        value = parseInt(value, 10);
        var row_data = parseInt(aData[column_index], 10);
        switch (comparator) {
          case 'eq':
            return row_data == value ? true : false;
            break;
          case 'gt':
            return row_data >= value ? true : false;
            break;
          case 'lt':
            return row_data <= value ? true : false;
            break;
          case 'ne':
            return row_data != value ? true : false;
            break;
        }
      }
    }
    return true;
  });

  var table = $('#carrier_table').dataTable({
    "processing": true,
    "serverSide": true,
    fixedHeader: true,
    "ajax": {
      "url": $('#carrier_table').data('source')
    },
    "scrollX": true,
    "pageLength": 50,
    "drawCallback": function(settings) {
        $('[data-toggle="tooltip"]').tooltip({
          trigger: 'hover',
          html: true
        })
        var api = this.api();
         nb_cols = api.columns().nodes().length;
         j = 6;
         while(j < nb_cols){
           console.log(j);
           if ([9, 10, 13, 14, 15].includes(j)) {
             var pageTotal = Math.round(api.column(j, {search: 'applied'}).data().sum() * 100) / 100;
               console.log(pageTotal);
             if (j===9) {
               $('#carrier_reefer_count').html(pageTotal);
             }else if(j===10) {
               $('#carrier_team_count').html(pageTotal);
             }else if(j===13) {
               $('#carrier_lw_count').html(pageTotal);
             }else if(j===14) {
               $('#carrier_1m_count').html(pageTotal);
             }else if(j===15) {
               $('#carrier_6m_count').html(pageTotal);
             }
           }
           j++;
         }
      },
    "pagingType": "full_numbers",
    "createdRow": function ( row, data, index ) {
      if (data.sales_priority == "<span class='text-indigo'>B</span>" && data.three_weeks_lapse == "true") {
        $(row).addClass('table-warning');
      }
    },

    "order": [[ 6, "desc" ], [ 7, "desc" ], [ 8, "desc" ], [ 9, "desc" ]],
    'columnDefs': [{
        'targets': 0,
        'checkboxes': {
          'selectRow': true
        }
      }],
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
    {column_number : 2, data: [{value: 1,label: 'Yes'}, {value: 0,label: 'No'}], filter_default_label: "Y/N", filter_reset_button_text: false},
    {column_number : 3, data: [{value: 1,label: 'Yes'}, {value: 0,label: 'No'}], filter_default_label: "Y/N", filter_reset_button_text: false},
    {column_number : 4, filter_type: "text", filter_reset_button_text: false},
    {column_number : 5, data: ['New', 'A', 'B', 'C', 'D', 'U'], filter_default_label: "Prior", filter_reset_button_text: false},
    {column_number : 6, filter_type: "text", filter_reset_button_text: false},
    {column_number : 7, filter_type: "text", filter_reset_button_text: false},
    {column_number : 8, filter_type: "text", filter_reset_button_text: false},
    {column_number : 9, filter_type: "text", filter_reset_button_text: false},
    {column_number : 10, filter_type: "text", filter_reset_button_text: false},
    {column_number : 11, filter_type: "text", filter_reset_button_text: false},
    {column_number : 12, data: ["Bronze", "Silver", "Gold", "Platinum", "Diamond", "No Tier Yet"], filter_default_label: "Tier", filter_reset_button_text: false},
    {column_number : 13, filter_type: "text", filter_reset_button_text: false},
    {column_number : 14, filter_type: "text", filter_reset_button_text: false},
    {column_number : 15, filter_type: "text", filter_reset_button_text: false},
    {column_number : 16, filter_type: "text", filter_reset_button_text: false},
    {column_number : 17, data: [{value: 1,label: 'Yes'}, {value: 0,label: 'No'}], filter_default_label: "Y/N", filter_reset_button_text: false},
    {column_number : 18, filter_type: "text", filter_reset_button_text: false},
    {column_number : 19, filter_type: "text", filter_reset_button_text: false},
    {column_number : 20, filter_type: "text", filter_reset_button_text: false},
    {column_number : 21, data: [{value: 1,label: 'Y'}, {value: 0,label: 'N'}], filter_default_label: "Y/N", filter_reset_button_text: false},
    {column_number : 22, data: [{value: 1,label: 'Y'}, {value: 0,label: 'N'}], filter_default_label: "Y/N", filter_reset_button_text: false},
    {column_number : 23, filter_type: "text", filter_reset_button_text: false}]);

    innerHTML = $( "#carrier_table_filter" ).html()
      operatorSearch = "&nbsp;&nbsp;|&nbsp;&nbsp;Operator Search:&nbsp;&nbsp;<select id='carrier_table_filter_column' class='form-control'><option value='6'>Reefers</option><option value='7'>Teams</option><option value='8'>DSL</option><option value='10'>1M</option><option value='11'>6M</option></select>&nbsp;<select id='carrier_table_filter_comparator' class='form-control'><option value='eq'>=</option><option value='gt'>&gt;=</option><option value='lt'>&lt;=</option><option value='ne'>!=</option></select><input type='text' class='form-control' id='carrier_table_filter_value' style='width: 10%;' '>"
      $( "#carrier_table_filter" ).append( operatorSearch );
      $('#carrier_table_filter_column').change(function () {
        table.draw();
      });
      $('#carrier_table_filter_comparator').change(function () {
        table.draw();
      });
      $('#carrier_table_filter_value').keyup(function () {
        table.draw();
      });

});
