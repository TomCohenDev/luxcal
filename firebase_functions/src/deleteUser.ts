import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as corsLib from 'cors';

const cors = corsLib({ origin: true });

export const deleteUser = functions.https.onRequest((req, res) => {
  // Wrap the function with the CORS middleware.
  cors(req, res, async () => {
    // Handle preflight OPTIONS requests.
    if (req.method === 'OPTIONS') {
      res.set('Access-Control-Allow-Methods', 'POST');
      res.set('Access-Control-Allow-Headers', 'Content-Type');
      res.status(204).send('');
      return;
    }

    // Only allow POST requests.
    if (req.method !== 'POST') {
      res.status(405).send('Method Not Allowed');
      return;
    }

    // Extract the uid from the request body.
    const { uid } = req.body;
    if (!uid) {
      res.status(400).json({ error: 'Missing uid parameter.' });
      return;
    }

    try {
      // Delete the user from Firebase Authentication.
      await admin.auth().deleteUser(uid);
      // Optionally, delete user-related Firestore documents here if needed.
      res.status(200).json({ message: `User ${uid} deleted successfully.` });
    } catch (error) {
      let errorMessage = 'An unknown error occurred.';
      if (error instanceof Error) {
        errorMessage = error.message;
      }
      res.status(500).json({ error: errorMessage });
    }
  });
});