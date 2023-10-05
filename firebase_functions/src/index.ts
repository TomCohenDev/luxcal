// import * as functions from "firebase-functions";
// import * as admin from "firebase-admin";

// admin.initializeApp();

// interface EventData {
//   startdate: admin.firestore.Timestamp;
//   title: string;
// }

// export const checkForUpcomingEvents = functions.pubsub
//   .schedule("every 5 minutes")
//   .onRun(async () => { // Removed "_"
//     const now = new Date();
//     const eventsRef = admin.firestore().collection("events");
//     const snapshot = await eventsRef.where("startdate", "<=", now).get();

//     snapshot.docs.forEach((doc) => {
//       const event = doc.data() as EventData;
//       const startTime = event.startdate.toDate();
//       if (startTime <= now) {
//         sendNotification(event);
//       }
//     });
//   });

// /**
//  * Sends notification for the given event.
//  *
//  * @param {EventData} event - The event for which the notification is to be
//  */
// function sendNotification(event: EventData) {
//   const payload: admin.messaging.MessagingPayload = {
//     notification: {
//       title: "Upcoming Event!",
//       body: `Event ${event.title} is coming up at ${
//         event.startdate.toDate().toLocaleString()
//       }`, // Split line to fit within character limit
//     },
//   };

//   admin.messaging().sendToTopic("events", payload);
// }
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

import serviceAccount from
  "../luxcal-75a29-firebase-adminsdk-saiyh-3a23fb1972.json";

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

export const sendNotificationToEventSubscribers =
functions.https.onRequest(async (req, res) => {
  // Define your notification payload
  const payload: admin.messaging.MessagingPayload = {
    notification: {
      title: "Your Notification Title",
      body: "Your Notification Body",
    },
  };

  try {
    // Send the notification to all users subscribed to the "events" topic
    await admin.messaging().sendToTopic("events", payload);
    res.status(200).send("Notifications sent successfully.");
  } catch (error) {
    console.error("Error sending the notification", error);
    res.status(500).send(error);
  }
});
