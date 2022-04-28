import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();
const db = admin.firestore();

export const CleanAnonUsers = functions
    .region("europe-west2")
    .pubsub
    .schedule("0 3 * * *")
    .timeZone("Europe/Belfast")
    .onRun(() => {
      // deletes all the anon users in the Authentication
      admin
          .auth()
          .listUsers(50)
          .then(function(listUsersResult) {
            listUsersResult.users.forEach(function(userRecord) {
              if (userRecord.providerData.length === 0) {
                admin.auth().deleteUser(userRecord.uid)
                    .then(function() {
                      console.log("Successfully deleted user");
                    })
                    .catch(function(error) {
                      console.log("Error deleting user:", error);
                    });
              }
            });
          })
          .catch(function(error) {
            console.log("Error listing users:", error);
          });

      // deletes all the anon users in the firestore
      const userQuery = db
          .collection("users")
          .where("displayName", "==", "guest");
      userQuery.get().then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
          doc.ref.delete();
        });
      });
    });

export const cleanUsersInBuildings = functions
    .region("europe-west2")
    .pubsub
    .schedule("0 3 * * *")
    .timeZone("Europe/Belfast")
    .onRun(() => {
      db
          .collection("usersInBuildings")
          .listDocuments().then((val) => {
            val.map((val) => {
              val.delete();
            });
          });
    });

export const cleanUsersInRooms = functions
    .region("europe-west2")
    .pubsub
    .schedule("0 3 * * *")
    .timeZone("Europe/Belfast")
    .onRun(() => {
      db
          .collection("usersInRooms")
          .listDocuments().then((val) => {
            val.map((val) => {
              val.delete();
            });
          });
    });
