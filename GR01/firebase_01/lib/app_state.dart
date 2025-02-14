import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_01/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/widgets.dart';

import 'models/guest_book_message.dart';

enum Attending { yes, no, unknow }

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  bool _emailVerified = false;
  bool get emailVerified => _emailVerified;

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;

  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  int _attendees = 0;
  int get attendees => _attendees;

  StreamSubscription<DocumentSnapshot>? _attendingSubscription;
  Attending _attending = Attending.unknow;
  Attending get attending => _attending;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

    FirebaseFirestore.instance
        .collection('attendees')
        .where('attending', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _attendees = snapshot.docs.length;
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _emailVerified = user.emailVerified;

        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
              _guestBookMessages = [];
              for (final document in snapshot.docs) {
                _guestBookMessages.add(GuestBookMessage(
                  name: document.data()['name'] as String,
                  message: document.data()['message'] as String,
                  //message: document.data()['text'] as String,
                ));
              }
              notifyListeners();
            });

        _attendingSubscription = FirebaseFirestore.instance
            .collection('attendees')
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
              if (snapshot.data() != null) {
                _attending = snapshot.data()!['attending'] as bool
                    ? Attending.yes
                    : Attending.no;
              } else {
                _attending = Attending.unknow;
              }
              notifyListeners();
            });

      } else {
        _loggedIn = false;
        _emailVerified = false;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
        _attendingSubscription?.cancel();
      }
      notifyListeners();
    });
  }
}
