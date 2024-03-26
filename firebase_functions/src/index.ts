// import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { sendHolidayNotification } from './sendHolidayNotification';
import { notifyUpcomingEvents } from './notifyUpcomingEvents';





admin.initializeApp();

export { sendHolidayNotification, notifyUpcomingEvents };