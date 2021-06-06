App.cable.subscriptions.create({
        channel: "RemindersChannel",
        code: "example"
    },

    {
        connected: function() {
            console.log("connected");
        },

        disconnected: function() {
            console.log("disconnected");
        },

        rejected: function() {
            console.log("rejected");
        },

        received: function(data) {
            reminder = JSON.parse(data['data']);
            var url = "";
            var model = "";
            var name = "";
            if (reminder['carrier_id']) {
                model = "Carrier";
                name = reminder['carrier_name'];
                url = "/carriers/" + reminder['carrier_id'];
            } else if (reminder['shipper_id']) {
                model = "Shipper";
                name = reminder['shipper_name'];
                url = "/shippers/" + reminder['shipper_id'];
            } else if (reminder['activity_id']) {
                model = "Activity";
                if (reminder['activity_shipper_id']) {
                    name = reminder['activity_shipper_name'];
                } else if (reminder['activity_carrier_id']) {
                    name = reminder['activity_carrier_name'];
                }
                url = "/activities/" + reminder['activity_id'];
            }

            var reminder_model_name = '<b>' + model + ':</b> ' + name + '<br/>';
            var reminder_time = '<b>Time:</b> ' + reminder['reminder_date_str'] + '<br/>';
            var reminder_type = '<b>Type:</b> ' + reminder['reminder_type'] + '<br/>';
            var reminder_notes = '<b>Notes:</b> ' + reminder['notes'];

            var reminder_text = reminder_model_name + reminder_time + reminder_type + reminder_notes;
            addToReminderBox(reminder['id'], reminder_text);
            addReminderBoxCount();
            slideDownReminderBox();

            $.gritter.add({
                title: 'REMINDER',
                text: reminder_text,
                sticky: false,
                time: 8000,
                class_name: 'my-sticky-class'
            });
            //
            // Swal.fire({
            //     title: 'Reminder!',
            //     html: reminder_text,
            //     icon: 'warning',
            //     showDenyButton: true,
            //     showCancelButton: true,
            //     confirmButtonText: 'Go to ' + model,
            //     cancelButtonText: 'Ignore',
            //     denyButtonText: 'Delete',
            // }).then((result) => {
            //     var action_taken = 0;
            //     var id = reminder['id'];
            //
            //     if (result.isConfirmed) {
            //       action_taken = 1
            //     } else if (result.isDenied) {
            //       action_taken = 2
            //     } else if (result.isDismissed) {
            //       action_taken = 3
            //     }
            //
            //     $.ajax({
            //         method: 'get',
            //         url: "/reminders/update_from_cable",
            //         data: {
            //             id: id,
            //             action_taken: action_taken
            //         }
            //     }).done(function(data) {
            //         reminder = data;
            //
            //         if (result.isConfirmed) {
            //             var url = "";
            //
            //             if (reminder['carrier_id']) {
            //                 url = "/carriers/" + reminder['carrier_id'];
            //             } else if (reminder['shipper_id']) {
            //                 url = "/shippers/" + reminder['shipper_id'];
            //             } else if (reminder['activity_id']) {
            //                 url = "/activities/" + reminder['activity_id'];
            //             }
            //
            //             window.open(url, '_blank');
            //         }
            //     });
            // });
        }
    }
);