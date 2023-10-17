import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:mywedding/guest_book_message.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationState extends ChangeNotifier {
  //the init() is called everytime an instance of the application state is called
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  //it is often used to listen to changes in firestore collection and receive updates when documents in that collection are added
  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  List<GuestBookMessageToUi> _guestBookMessages = [];
  List<GuestBookMessageToUi> get guestBookMessages => _guestBookMessages;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    //setting up firebase configure authentication providers
    FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

    FirebaseAuth.instance.userChanges().listen(
      (user) {
        if (user != null) {
          _loggedIn = true;

          //specifying which firebase collection i am essentially subscribing  to listen to in the firestore querry and the order in which i want to receive the data in the ui
          _guestBookSubscription = FirebaseFirestore.instance
              .collection("guestbook")
              .orderBy("timestamp", descending: true)
              //it uses the .snapshots() to get  a stream of querry snapshots .when the firestore data changes, this listener is called with the updated snapshot.
              .snapshots()
              .listen(
            (snapshot) {
              _guestBookMessages = [];
              for (final document in snapshot.docs)
                _guestBookMessages.add(
                  GuestBookMessageToUi(
                    name: document.data()["name"] as String,
                    message: document.data()["text"] as String,
                  ),
                );
            },
          );
          notifyListeners();
        } else {
          _loggedIn = false;
          _guestBookMessages = [];
          _guestBookSubscription?.cancel();
        }
        notifyListeners();
      },
    );
  }

  //pushes everything to the DB
  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (!_loggedIn) {
      throw Exception("Must be logged in to view message");
    }
    return FirebaseFirestore.instance
        .collection("guestbook")
        .add(<String, dynamic>{
      "text": message,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "name": FirebaseAuth.instance.currentUser!.displayName,
      //reference to the auto generated unique id, provided by our firebase
      "userId": FirebaseAuth.instance.currentUser!.uid
    });
  }
}
