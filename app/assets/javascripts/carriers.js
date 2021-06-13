function initCarrierTable() {

    $.fn.dataTableExt.afnFiltering.push(function (oSettings, aData, iDataIndex) {
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
        'language': {
            'loadingRecords': '&nbsp;',
            'processing': '<i class="fa fa-spinner fa-pulse fa-2x fa-fw"></i> Loading...'
        },
        fixedHeader: true,
        "ajax": {
            "url": $('#carrier_table').data('source'),
            "dataSrc": function (json) {
                $('#carrier_reefer_count').html(json.reefers_sum);
                $('#carrier_team_count').html(json.teams_sum);
                $('#carrier_lw_count').html(json.loads_lws_sum);
                $('#carrier_1m_count').html(json.one_m_sum);
                $('#carrier_6m_count').html(json.six_m_sum);
                return json.data;
            },
            beforeSend: function () {
                // Here, manually add the loading message.
                $('#carrier_table > tbody').html(
                    '<tr class="odd">' +
                    '<td valign="top" colspan="24" class="dataTables_empty">Loading&hellip;</td>' +
                    '</tr>'
                );
            }
        },
        "rowCallback": function (row, data) {
            if (data.sales_priority == "<span class='text-indigo'>B</span>" && data.three_weeks_lapse) {
                $(row).addClass('table-warning');
            }
        },
        "scrollX": true,
        "pageLength": 50,
        "drawCallback": function (settings) {
            $('[data-toggle="tooltip"]').tooltip({
                trigger: 'hover',
                html: true
            });
        },
        "pagingType": "full_numbers",
        "createdRow": function (row, data, index) {
            if (data.sales_priority == "<span class='text-indigo'>B</span>" && data.three_weeks_lapse == "true") {
                $(row).addClass('table-warning');
            }
        },

        "order": [[6, "desc"], [7, "desc"], [8, "desc"], [9, "desc"]],
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
    });

    $("#carrier_table_filter").html("<div style='display: inline-block;'><table><tr><td>Teams:</td><td id='teams_range'></td><td>LW:</td><td id='lws_range'></td></tr><tr><td>Reefers:</td><td id='reefers_range'></td><td>1M:</td><td id='1ms_range'></td></tr><tr><td>DSL:</td><td id='dsls_range'></td><td>6M:</td><td id='6ms_range'></td></tr></table></div>");


    table.yadcf([
            {
                column_number: 1,
                filter_type: "range_number",
                filter_reset_button_text: false,
                filter_container_id: "lws_range"
            },
            {
                column_number: 2,
                filter_type: "range_number",
                filter_reset_button_text: false,
                filter_container_id: "1ms_range"
            },
            {
                column_number: 3,
                filter_type: "range_number",
                filter_reset_button_text: false,
                filter_container_id: "6ms_range"
            },
            {
                column_number: 4,
                filter_type: "text",
                filter_reset_button_text: false
            },
            {
                column_number: 5,
                filter_type: "text",
                filter_reset_button_text: false
            },
            {
                column_number: 6,
                filter_type: "text",
                filter_reset_button_text: false
            },
            {
                column_number: 7,
                data: ['New', 'A', 'B', 'C', 'D', 'U'],
                filter_default_label: "Prior",
                filter_reset_button_text: false
            },
            {
                column_number: 8,
                filter_type: "text",
                filter_reset_button_text: false
            },
            {
                column_number: 10,
                filter_type: "text",
                filter_reset_button_text: false
            },
            {
                column_number: 11,
                filter_type: "text",
                filter_reset_button_text: false
            },
            {
                column_number: 12,
                filter_type: "text",
                filter_reset_button_text: false
            },
            {
                column_number: 13,
                filter_type: "range_number",
                filter_reset_button_text: false,
                filter_container_id: "reefers_range"
            },
            {
                column_number: 14,
                filter_type: "range_number",
                filter_reset_button_text: false,
                filter_container_id: "teams_range"
            },
            {
                column_number: 15,
                filter_type: "range_number",
                filter_reset_button_text: false,
                filter_container_id: "dsls_range"
            },
            {
                column_number: 16,
                data: [{value: 1, label: 'Yes'}, {value: 0, label: 'No'}],
                filter_default_label: "Y/N",
                filter_reset_button_text: false
            },
            {
                column_number: 17,
                data: [{value: 1, label: 'Yes'}, {value: 0, label: 'No'}],
                filter_default_label: "Y/N",
                filter_reset_button_text: false
            },
            {
                column_number: 18,
                filter_type: "date"
            },
            {
                column_number: 19,
                data: [{value: 1, label: 'Y'}, {value: 0, label: 'N'}],
                filter_default_label: "Y/N",
                filter_reset_button_text: false
            },
            {
                column_number: 20,
                data: [{value: 1, label: 'Y'}, {value: 0, label: 'N'}],
                filter_default_label: "Y/N",
                filter_reset_button_text: false
            },
            {
                column_number: 21,
                filter_type: "text",
                filter_reset_button_text: false
            },
            {
                column_number: 22,
                data: [{value: 1, label: 'Y'}, {value: 0, label: 'N'}],
                filter_default_label: "Y/N",
                filter_reset_button_text: false
            }],
        {
            externally_triggered: true
        });

    $('#overall_search').click(function () {
        var search_term = encodeURI($("#datatable-search").val());
        var from_lanes_values = $("#from_lanes").val().toString();
        var to_lanes_values = $("#to_lanes").val().toString();
        var lane_values = from_lanes_values + "-" + to_lanes_values;

        table.api().search(search_term);
        table.api().columns(9).search(lane_values);
        yadcf.exFilterExternallyTriggered(table);
    });

    $("#from_lanes").select2({
        placeholder: "From",
        allowClear: true,
        width: 'resolve'
    });

    $("#to_lanes").select2({
        placeholder: "To",
        allowClear: true,
        width: 'resolve'
    });
}

function filterme() {
    var categories = $('input:checkbox[name="category"]:checked').map(function () {
        return '^' + this.value + '\$';
    }).get().join('|');
    table.search(categories, 5, true, false, false, false).draw();
    // table.fnFilter();

    var userCategories = $('input:checkbox[name="category"]').map(function () {
        return $(this).prop("checked");
    }).get().join(',');
    $.ajax({
        method: "PUT",
        url: "/api/users/" + user_id,
        data: {
            carrier_categories: userCategories
        }
    }).done(function (data) {});
}

$(function () {
    $(".multiple-select2").select2({
        placeholder: "Select commodities",
        allowClear: true
    });

    $(".origin-multiple-select2").select2({
        placeholder: "Select origins",
        allowClear: true
    });

    $(".destination-multiple-select2").select2({
        placeholder: "Select destinations",
        allowClear: true
    });

    $('#send-mail-btn').on('click', function () {
        var carriers_selected = $('#' + table_type + '_table').DataTable().column(0).checkboxes.selected();
        if (carriers_selected.join(",") != "") {
            $.redirect('/carriers/compose_mail', {'ids': carriers_selected.join(",")});
        }
    });

    $('#send-text-btn').on('click', function () {
        var carriers_selected = $('#' + table_type + '_table').DataTable().column(0).checkboxes.selected();
        if (carriers_selected.join(",") != "") {
            $.redirect('/carriers/compose_sms', {'ids': carriers_selected.join(",")});
        }
    });
});
