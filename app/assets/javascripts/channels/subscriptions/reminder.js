App.cable.subscriptions.create(
  { channel: "RemindersChannel", code: "example" },

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
      if (reminder['carrier_id']){
        model = "Carrier";
        name = reminder['carrier_name'];
        url = "/carriers/" + reminder['carrier_id'];
      }else if (reminder['shipper_id']){
        model = "Shipper";
        name = reminder['shipper_name'];
        url = "/shippers/" + reminder['shipper_id'];
      }else if (reminder['activity_id']){
        model = "Activity";
        if (reminder['activity_shipper_id']) {
          name = reminder['activity_shipper_name'];
        }else if (reminder['activity_carrier_id']) {
          name = reminder['activity_carrier_name'];
        }
        url = "/activities/" + reminder['activity_id'];
      }

      var reminder_model_name = model + ': ' + name + '<br/>';
      var reminder_time = 'Time: ' + reminder['reminder_date'] + '<br/>';
      var reminder_type = 'Type: ' + reminder['reminder_type'] + '<br/>';
      var reminder_notes = 'Notes: ' + reminder['notes'];

      var reminder_text = reminder_model_name + reminder_time + reminder_type + reminder_notes;


      swal({
        title: 'Reminder!',
        text: reminder_text,
        icon: 'warning',
        buttons: {
          cancel: {
            text: 'Ignore',
            value: false,
            visible: true,
            className: 'btn btn-default',
            closeModal: true,
          },
          delete: {
            text: 'Delete',
            value: true,
            visible: true,
            className: 'btn btn-danger',
            closeModal: true
          },
          confirm: {
            text: 'Go to ' + model,
            value: true,
            visible: true,
            className: 'btn btn-warning',
            closeModal: true
          }
        }
      }).then((isConfirm) => {
        if (isConfirm) {
          window.location = url;
        }
      });
    }
  }
);
