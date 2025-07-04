function initCustomerTable() {

  $.fn.dataTableExt.afnFiltering.push(function( oSettings, aData, iDataIndex ) {
    var column_index = $('#customer_table_filter_column').val();
    var comparator = $('#customer_table_filter_comparator').val();
    var value = $('#customer_table_filter_value').val();

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

  var table = $('#customer_table').dataTable({
    "processing": true,
    "serverSide": true,
    'language': {
            'loadingRecords': '&nbsp;',
            'processing': '<i class="fa fa-spinner fa-pulse fa-2x fa-fw"></i> Loading...'
        },
    fixedHeader: true,
    "ajax": {
      "url": $('#customer_table').data('source'),
      "dataSrc": function ( json ) {
        console.log(json);
        $('#customer_reefer_count').html(json.reefers_sum);
        $('#customer_team_count').html(json.teams_sum);
        $('#customer_lw_count').html(json.loads_lws_sum);
        $('#customer_1m_count').html(json.one_m_sum);
        $('#customer_6m_count').html(json.six_m_sum);
        return json.data;
      },
      beforeSend: function(){
        // Here, manually add the loading message.
        $('#carrier_table > tbody').html(
          '<tr class="odd">' +
            '<td valign="top" colspan="24" class="dataTables_empty">Loading&hellip;</td>' +
          '</tr>'
        );
      }
    },
    "rowCallback": function (row, data) {
      console.log(data.sales_priority == "<span class='text-indigo'>B</span>");
      console.log(data.three_weeks_lapse);
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

    "order": [[ 6, "desc" ], [ 7, "desc" ], [ 8, "desc" ], [ 9, "desc" ]],
    'columnDefs': [{
        'targets': 0,
        'checkboxes': {
          'selectRow': true
        }
      }],
    "columns": [
      {"data": "id"},
      {"data": "loads_lw"},
      {"data": "c_mc_latest_date_last_month"},
      {"data": "c_mc_latest_date_last_6_months"},
      {"data": "mc_number"},
      {"data": "company_name"},
      {"data": "relationship_owner_name"},
      {"data": "sales_priority"},
      {"data": "power_units"},
      {"data": "c_lane_origin"},
      {"data": "poc_name"},
      {"data": "primary_phone"},
      {"data": "contact_email"},
      {"data": "reefers"},
      {"data": "teams"},
      {"data": "c_mc_latest_date_load_days"},
      {"data": "approved"},
      {"data": "complete_record"},
      {"data": "date_opened"},
      {"data": "wolfbyte"},
      {"data": "interview"},
      {"data": "c_reminder_date"},
      {"data": "blacklisted"}
    ]
  })
    $( "#customer_table_filter" ).html( "<div style='display: inline-block;'><table><tr><td>Teams:</td><td id='teams_range'></td><td>LW:</td><td id='lws_range'></td></tr><tr><td>Reefers:</td><td id='reefers_range'></td><td>1M:</td><td id='1ms_range'></td></tr><tr><td>DSL:</td><td id='dsls_range'></td><td>6M:</td><td id='6ms_range'></td></tr></table></div>" );
    table.yadcf([
      {column_number : 1, filter_type: "range_number", filter_reset_button_text: false, filter_container_id: "lws_range"},
      {column_number : 2, filter_type: "range_number", filter_reset_button_text: false, filter_container_id: "1ms_range"},
      {column_number : 3, filter_type: "range_number", filter_reset_button_text: false, filter_container_id: "6ms_range"},
      {column_number : 4, filter_type: "text", filter_reset_button_text: false},
      {column_number : 5, filter_type: "text", filter_reset_button_text: false},
      {column_number : 6, filter_type: "text", filter_reset_button_text: false},
      {column_number : 7, data: ['New', 'A', 'B', 'C', 'D', 'U'], filter_default_label: "Prior", filter_reset_button_text: false},
      {column_number : 8, filter_type: "text", filter_reset_button_text: false},
      {column_number : 10, filter_type: "text", filter_reset_button_text: false},
      {column_number : 11, filter_type: "text", filter_reset_button_text: false},
      {column_number : 12, filter_type: "text", filter_reset_button_text: false},
      {column_number : 13, filter_type: "range_number", filter_reset_button_text: false, filter_container_id: "reefers_range"},
      {column_number : 14, filter_type: "range_number", filter_reset_button_text: false, filter_container_id: "teams_range"},
      {column_number : 15, filter_type: "range_number", filter_reset_button_text: false, filter_container_id: "dsls_range"},
      {column_number : 16, data: [{value: 1,label: 'Yes'}, {value: 0,label: 'No'}], filter_default_label: "Y/N", filter_reset_button_text: false},
      {column_number : 17, data: [{value: 1,label: 'Yes'}, {value: 0,label: 'No'}], filter_default_label: "Y/N", filter_reset_button_text: false},
      {column_number : 18, filter_type: "date"},
      {column_number : 19, data: [{value: 1,label: 'Y'}, {value: 0,label: 'N'}], filter_default_label: "Y/N", filter_reset_button_text: false},
      {column_number : 20, data: [{value: 1,label: 'Y'}, {value: 0,label: 'N'}], filter_default_label: "Y/N", filter_reset_button_text: false},
      {column_number : 21, filter_type: "text", filter_reset_button_text: false},
      {column_number : 22, data: [{value: 1,label: 'Y'}, {value: 0,label: 'N'}], filter_default_label: "Y/N", filter_reset_button_text: false}]);

    $('#datatable-search').keyup(function(){
      search_term = encodeURI($(this).val());
      table.fnFilter(search_term);
    })
    $("#from_lanes, #to_lanes").on('keyup change click', function() {
      var from_lanes_values = $("#from_lanes").val().toString();
      var to_lanes_values = $("#to_lanes").val().toString();
      var lane_values = from_lanes_values + "-" + to_lanes_values;

      table.api().columns(9).search(lane_values).draw();
    });
    $
    $("#from_lanes").select2({
      placeholder: "From",
      allowClear: true,
      width: 'resolve'});
    $("#to_lanes").select2({
      placeholder: "To",
      allowClear: true,
      width: 'resolve'});
}
