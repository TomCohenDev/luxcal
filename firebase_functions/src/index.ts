// import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { sendHolidayNotification } from './sendHolidayNotification';
import { notifyUpcomingEvents } from './notifyUpcomingEvents';
import { sendNewsNotification } from './sendNewsNotification';





admin.initializeApp();

export { sendHolidayNotification, notifyUpcomingEvents, sendNewsNotification };