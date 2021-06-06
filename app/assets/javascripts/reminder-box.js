jQuery(document).ready(function () {
    $("#messagebody").animate({scrollTop: $("#messagebody")[0].scrollHeight}, 'slow');

    $(document).on('click', '.panel-heading span.icon_minim', function (e) {
        triggerReminderBox();
    });
    $(document).on('focus', '.panel-footer input.chat_input', function (e) {
        var $this = $(this);
        if ($('#minim_chat_window').hasClass('panel-collapsed')) {
            $this.parents('.panel').find('.panel-body').slideDown();
            $('#minim_chat_window').removeClass('panel-collapsed');
            $('#minim_chat_window').removeClass('glyphicon-plus').addClass('glyphicon-minus');
        }
    });
    $(document).on('click', '#new_chat', function (e) {
        var size = $(".chat-window:last-child").css("margin-left");
        size_total = parseInt(size) + 400;
        alert(size_total);
        var clone = $("#chat_window_1").clone().appendTo(".container");
        clone.css("margin-left", size_total);
    });
    $(document).on('click', '.icon_close', function (e) {
        //$(this).parent().parent().parent().parent().remove();
        $("#chatbox").hide();
    });


    $(document).on('click', '.goto_button', function (){
        var id = $(this).data("id");
        updateActionTaken(id, 1)
    });
    $(document).on('click', '.delete_button', function (){
        var id = $(this).data("id");
        updateActionTaken(id, 2);
    });
    $(document).on('click', '.ignore_button', function (){
        var id = $(this).data("id");
        updateActionTaken(id, 3);
    });

});

function triggerReminderBox() {
    var $this = $('#chatbox .panel-heading span.icon_minim');
    if (!$this.hasClass('panel-collapsed')) {
        slideUpReminderBox();
    } else {
        slideDownReminderBox();
    }
}

function slideUpReminderBox(){
    var $this = $('#chatbox .panel-heading span.icon_minim');
    $this.parents('.panel').find('.panel-body').slideUp();
    $this.addClass('panel-collapsed');
    $this.removeClass('fa-minus').addClass('fa-plus');
}

function slideDownReminderBox(){
    var $this = $('#chatbox .panel-heading span.icon_minim');
    $this.parents('.panel').find('.panel-body').slideDown();
    $this.removeClass('panel-collapsed');
    $this.removeClass('fa-plus').addClass('fa-minus');
}

function addReminderBoxCount() {
    var reminder_count_element = $('#reminder_box_count_badge');
    var reminder_count = parseInt(reminder_count_element.text(), 10) + 1;
    reminder_count_element.html(reminder_count)
}

function subReminderBoxCount() {
    var reminder_count_element = $('#reminder_box_count_badge');
    var reminder_count = parseInt(reminder_count_element.text(), 10) - 1;
    reminder_count_element.html(reminder_count)
}

function addToReminderBox(id, content) {
    var body = '<div class="row msg_container base_sent" id="reminder_container_' + id + '">' +
        '<div class="col-md-2 col-xs-2 text-warning" style="margin: auto;">' +
        '<i class="fas fa-4x fa-exclamation-circle"></i>' +
        '</div>' +
        '<div class="col-md-10 col-xs-10 ">' +
        '<div class="messages msg_sent">' +
        '<p>' + content + '</p>' +
        '<p>' +
        '<button class=\'btn btn-purple btn-xs goto_button\' data-id="' + id + '">Goto</button>\n' +
        '<button class=\'btn btn-danger btn-xs delete_button\' data-id="' + id + '">Delete</button>\n' +
        '<button class=\'btn btn-grey btn-xs ignore_button\' data-id="' + id + '">Ignore</button>    </p>' +
        '</div>' +
        '</div>' +
        '</div>';
        $(body).appendTo("#messagebody");
        $("#messagebody").animate({scrollTop: $("#messagebody")[0].scrollHeight}, 'slow');
}


function updateActionTaken(id, action_taken) {
    $.ajax({
        method: 'get',
        url: "/reminders/update_from_cable",
        data: {id: id, action_taken: action_taken}
    }).done(function(data) {
        var reminder = data;

        if (action_taken === 1) {
            var url = "";

            if (reminder['carrier_id']){
                url = "/carriers/" + reminder['carrier_id'];
            }else if (reminder['shipper_id']){
                url = "/shippers/" + reminder['shipper_id'];
            }else if (reminder['activity_id']){
                url = "/activities/" + reminder['activity_id'];
            }

            window.open(url, '_blank');
        }

        $('#reminder_container_' + id).remove();
        subReminderBoxCount();

        var reminder_count_element = $('#reminder_box_count_badge');
        var reminder_count = parseInt(reminder_count_element.text(), 10);

        if (reminder_count === 0) {
            slideUpReminderBox();
        }

    });
}