import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';


export const sendNewsNotification = functions.firestore
    .document('news/{newsId}')
    .onCreate(async (snap, context) => {
        const newValue = snap.data();

        // Extract the title and content from the new document
        const title = newValue?.headline || 'New News Update';
        const content = newValue?.content || 'Check out the latest news in LuxCal!';

        // Create a notification message
        const message = {
            notification: {
                title: title,
                body: content,
            },
            topic: 'notifications',
        };

        try {
            // Send the notification
            await admin.messaging().send(message);
            console.log('Notification sent successfully:', title);
        } catch (error) {
            console.error('Error sending notification:', error);
        }
    });
