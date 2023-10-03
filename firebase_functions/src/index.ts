
// import {onRequest} from "firebase-functions/v2/https";
// import * as logger from "firebase-functions/logger";


// export const helloGorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

export const checkForUpcomingEvents = functions.pubsub.schedule('every 5 minutes').onRun(async context => {
    const now = new Date();
    const eventsRef = admin.firestore().collection('events');
    const snapshot = await eventsRef.where('startdate', '<=', now).get();

    snapshot.docs.forEach(doc => {
        const event = doc.data();
        const startTime = new Date((event.startdate as admin.firestore.Timestamp).seconds * 1000 + event.starttime);
        if (startTime <= now) {
            sendNotification(event);
        }
    });
});

function sendNotification(event: any) {
    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: 'Upcoming Event!',
            body: `Event ${event.name} is coming up at ${event.starttime}`,
        },
    };

    admin.messaging().sendToTopic('events', payload);
}


