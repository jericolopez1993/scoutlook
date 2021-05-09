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
      url = "";
      model = "";
      name = "";
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

      swal({
        title: 'Reminder!',
        text: 'You have to ' + reminder['reminder_type'] + ' ' + name,
        icon: 'warning',
        buttons: {
          cancel: {
            text: 'Ignore',
            value: false,
            visible: true,
            className: 'btn btn-default',
            closeModal: true,
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
