import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import fetch from 'node-fetch';


export const sendHolidayNotification = functions.pubsub.schedule('every 24 hours').onRun(async (context) => {
    const apiUrl = 'https://www.hebcal.com/hebcal/?v=1&cfg=json&maj=on&min=on&mod=on&nx=on&year=now&month=x&ss=on&mf=on&c=on&geo=none&m=50&s=on';

    try {
        const response = await fetch(apiUrl);
        const data = (await response.json()) as HolidayApiResponse;
        
        const today = new Date();
        today.setHours(0, 0, 0, 0); // Normalize today's date
        
        const tomorrow = new Date(today);
        tomorrow.setDate(today.getDate() + 1);
        
        // Filter holidays for today and tomorrow
        const todayHolidays = data.items.filter(item => {
            const holidayDate = new Date(item.date);
            holidayDate.setHours(0, 0, 0, 0); // Normalize holiday date
            return holidayDate.getTime() === today.getTime();
        });
        
        const tomorrowHolidays = data.items.filter(item => {
            const holidayDate = new Date(item.date);
            holidayDate.setHours(0, 0, 0, 0); // Normalize holiday date
            return holidayDate.getTime() === tomorrow.getTime();
        });

        // Prepare notifications for today
        if (todayHolidays.length > 0) {
            const todayMessage = {
                notification: {
                    title: 'Holiday Today!',
                    body: `Don't forget about ${todayHolidays[0].title} today.`,
                },
                topic: 'notifications',
            };

            // Send notifications for today
            await admin.messaging().send(todayMessage);
        }
        
        // Prepare notifications for tomorrow
        if (tomorrowHolidays.length > 0) {
            const tomorrowMessage = {
                notification: {
                    title: 'Upcoming Holiday!',
                    body: `Don't forget about ${tomorrowHolidays[0].title} tomorrow.`,
                },
                topic: 'notifications',
            };

            // Send notifications for tomorrow
            await admin.messaging().send(tomorrowMessage);
        }

        console.log('Successfully sent holiday notifications');
    } catch (error) {
        console.error("Failed to fetch holidays or send notifications", error);
    }
});

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
