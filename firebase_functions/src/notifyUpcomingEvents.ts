import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';


export const notifyUpcomingEvents = functions.pubsub.schedule('every 24 hours').onRun(async (context) => {
    const db = admin.firestore();
    const eventsRef = db.collection('events');

    // Get today's and tomorrow's date range
    const today = new Date();
    today.setHours(0, 0, 0, 0); // Start of today
    const endOfToday = new Date(today);
    endOfToday.setDate(today.getDate() + 1);

    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);
    const endOfTomorrow = new Date(tomorrow);
    endOfTomorrow.setDate(tomorrow.getDate() + 1);

    // Query for events happening today
    const todaySnapshot = await eventsRef.where('startDate', '>=', today).where('startDate', '<', endOfToday).get();
    // Query for events happening tomorrow
    const tomorrowSnapshot = await eventsRef.where('startDate', '>=', tomorrow).where('startDate', '<', endOfTomorrow).get();

    if (todaySnapshot.empty && tomorrowSnapshot.empty) {
        console.log('No events happening today or tomorrow.');
        return;
    }

    // Prepare notifications for each event happening today
    if (!todaySnapshot.empty) {
        const todayMessages = todaySnapshot.docs.map(doc => {
            const event = doc.data();
            return {
                notification: {
                    title: 'Event Today!',
                    body: `${event.title} is happening today.`,
                },
                topic: 'notifications',
            };
        });

        // Send notifications for today
        for (const message of todayMessages) {
            admin.messaging().send(message)
                .then((response) => {
                    console.log(`Successfully sent message for event: ${message.notification.title}`);
                })
                .catch((error) => {
                    console.error('Error sending message:', error);
                });
        }
    }

    // Prepare notifications for each event happening tomorrow
    if (!tomorrowSnapshot.empty) {
        const tomorrowMessages = tomorrowSnapshot.docs.map(doc => {
            const event = doc.data();
            return {
                notification: {
                    title: 'Upcoming Event!',
                    body: `${event.title} is happening tomorrow.`,
                },
                topic: 'notifications',
            };
        });

        // Send notifications for tomorrow
        for (const message of tomorrowMessages) {
            admin.messaging().send(message)
                .then((response) => {
                    console.log(`Successfully sent message for event: ${message.notification.title}`);
                })
                .catch((error) => {
                    console.error('Error sending message:', error);
                });
        }
    }
});

