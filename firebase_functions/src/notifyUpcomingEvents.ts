import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';


export const notifyUpcomingEvents = functions.pubsub.schedule('every 24 hours').onRun(async (context) => {
    const db = admin.firestore();
    const eventsRef = db.collection('events');

    // Get tomorrow's date range
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    tomorrow.setHours(0, 0, 0, 0); // Start of tomorrow
    const endOfTomorrow = new Date(tomorrow);
    endOfTomorrow.setDate(tomorrow.getDate() + 1);

    // Query for events happening tomorrow
    const snapshot = await eventsRef.where('startDate', '>=', tomorrow).where('startDate', '<', endOfTomorrow).get();
    if (snapshot.empty) {
        console.log('No events happening tomorrow.');
        return;
    }

    // Fetch user notification tokens
    const tokens = await fetchUserNotificationTokens();
    if (tokens.length === 0) {
        console.log('No user tokens available for notifications.');
        return;
    }

    // Prepare notifications for each event happening tomorrow
    const messages = snapshot.docs.map(doc => {
        const event = doc.data();
        return {
            notification: {
                title: 'Upcoming Event!',
                body: `${event.title} is happening tomorrow.`,
            },
            tokens: tokens, // Send to all tokens
        };
    });

    // Send notifications
    for (const message of messages) {
        admin.messaging().sendMulticast(message)
            .then((response) => {
                console.log(`Successfully sent message for event: ${message.notification.title}`);
            })
            .catch((error) => {
                console.error('Error sending message:', error);
            });
    }
});

async function fetchUserNotificationTokens(): Promise<string[]> {
    const db = admin.firestore();
    const usersRef = db.collection('users');
    const snapshot = await usersRef.get();
    const tokens: string[] = [];

    snapshot.forEach(doc => {
        const token = doc.data().fcmToken;
        if (token) {
            tokens.push(token);
        }
    });

    return tokens;
}
