import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import fetch from 'node-fetch';

export const sendHolidayNotification = functions.pubsub.schedule('every 24 hours').onRun(async (context) => {
    const year = new Date().getFullYear();
    const apiUrl = `https://www.hebcal.com/hebcal?v=1&cfg=json&maj=on&year=${year}&month=x`;

    try {
        const response = await fetch(apiUrl);
        const data = (await response.json()) as HolidayApiResponse; // Type assertion here
        
        const today = new Date();
        today.setHours(0, 0, 0, 0); // Normalize today's date

        const upcomingHolidays = data.items.filter((item) => {
            const holidayDate = new Date(item.date);
            holidayDate.setHours(0, 0, 0, 0); // Normalize holiday date
            // Check if the holiday is within the next 24 hours
            return holidayDate.getTime() === today.getTime();
        });

        if (upcomingHolidays.length > 0) {
            const tokens = await fetchUserNotificationTokens();

            const messages = tokens.map((token: string) => ({
                notification: {
                    title: 'Upcoming Holiday!',
                    body: `Don't forget about ${upcomingHolidays[0].title} tomorrow.`,
                },
                token: token,
            }));

            // Send notifications to all tokens
            admin.messaging().sendAll(messages)
                .then((response) => {
                    console.log('Successfully sent messages:', response);
                })
                .catch((error) => {
                    console.log('Error sending messages:', error);
                });
        }
    } catch (error) {
        console.error("Failed to fetch holidays or send notifications", error);
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
// Define the structure of your API response
interface HolidayApiResponse {
    title: string;
    items: HolidayItem[];
}

interface HolidayItem {
    title: string;
    date: string; // assuming date is in ISO format like "2024-03-23"
    // Add any other properties you expect to receive
}
