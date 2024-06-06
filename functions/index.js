const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendTowerNotification = functions.database
    .ref("/towers/{towerId}/requests/{requestId}")
    .onCreate((snapshot, context) => {
      const towerId = context.params.towerId;
      const request = snapshot.val();
      const payload = {
        notification: {
          title: "New Help Request",
          body: `Driver's phone number: ${request.driverPhoneNumber}`,
        },
      };

      return admin.messaging().sendToTopic(towerId, payload)
          .then((response) => {
            console.log("Successfully sent message:", response);
          })
          .catch((error) => {
            console.log("Error sending message:", error);
          });
    });
