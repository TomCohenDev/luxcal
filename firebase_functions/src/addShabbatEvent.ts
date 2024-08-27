import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';


export const addShabbatEvent = functions.pubsub
    .schedule('every Monday 00:00')
    .timeZone('America/New_York') // replace with your timezone, e.g., "Asia/Jerusalem"
    .onRun(async (context) => {
        const db = admin.firestore();
        const eventsCollection = db.collection('events');

        const currentDate = new Date();
        currentDate.setHours(0, 0, 0, 0); // Normalize today's date

        // Calculate the day of the week (0 = Sunday, 1 = Monday, ..., 6 = Saturday)
        const currentDayOfWeek = currentDate.getDay();

        // Calculate how many days until the next Friday
        const daysUntilFriday = (5 - currentDayOfWeek + 7) % 7;
        const daysUntilSaturday = (6 - currentDayOfWeek + 7) % 7;

        // Create event details for the next 4 weeks
        const shabbatEvents = [];
        for (let i = 0; i < 4; i++) {
            const startDate = new Date(currentDate);
            startDate.setDate(currentDate.getDate() + daysUntilFriday + (i * 7)); // Calculate the next Friday
            startDate.setHours(17, 0, 0, 0); // Friday 17:00

            const endDate = new Date(currentDate);
            endDate.setDate(currentDate.getDate() + daysUntilSaturday + (i * 7)); // Calculate the next Saturday
            endDate.setHours(21, 0, 0, 0); // Saturday 21:00

            const eventId = startDate.getTime().toString();

            const event = {
                id: eventId,
                title: "Shabbat",
                description: "",
                startDate: admin.firestore.Timestamp.fromDate(startDate),
                endDate: admin.firestore.Timestamp.fromDate(endDate),
                color: 4285187691, // Lime Green
                hebrewFormat: false,
            };

            shabbatEvents.push(event);
        }

        // Add events to Firestore if they don't already exist
        const batch = db.batch();
        for (const event of shabbatEvents) {
            const eventDoc = await eventsCollection.doc(event.id).get();
            if (!eventDoc.exists) {
                const eventRef = eventsCollection.doc(event.id);
                batch.set(eventRef, event);
            }
        }

        // Commit the batch operation
        await batch.commit();
        console.log('Shabbat events successfully added for the next 4 weeks.');
    });
