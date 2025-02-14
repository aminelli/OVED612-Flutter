import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;

import 'firebase_options.dart';
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

  int _attendees = 0;
  int get attendees => _attendees;

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  StreamSubscription<DocumentSnapshot>? _attendingSubscription;
  Attending _attending = Attending.unknow;
  Attending get attending => _attending;
  set attending(Attending attending) {
    final userDoc = FirebaseFirestore.instance
        .collection('attendees')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    userDoc.set(<String, dynamic>{'attending': attending == Attending.yes});
  }

  static Map<String, dynamic> defaultValues = <String, dynamic>{
    'event_date': '14 Febbraio 2025',
    'enable_free': false,
    'call_to_action': 'Iscriviti',
  };

  // ignore: prefer_final_fields
  bool _enableFree = defaultValues['enable_free'] as bool;
  bool get enableFree => _enableFree;

  String _callToAction = defaultValues['call_to_action'] as String;
  String get callToAction => _callToAction;

  String _eventDate = defaultValues['event_date'] as String;
  String get eventDate => _eventDate;

  Future<void> init() async {
    // Inizializzazione app per connessione a servizi Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Inizializzazione libreria UI FirebaseUIAuth per aggangio a provider Auth
    FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

    // Recupero del numero di utenti che desiderano partecipare all'evento
    FirebaseFirestore.instance
        .collection('attendees')
        .where('attending', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _attendees = snapshot.docs.length;
      notifyListeners();
    });

    // Gestione dell'utente (loggato si/no)
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _emailVerified = user.emailVerified;
        // Aggancio dello streaming dei messaggi sull'evento
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = [];
          for (final doc in snapshot.docs) {
            _guestBookMessages.add(
              GuestBookMessage(
                name: doc.data()['name'] as String,
                message: doc.data()['message'] as String,
              ),
            );
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
        //_attending = Attending.unknow;
        _guestBookSubscription?.cancel();
        _attendingSubscription?.cancel();
      }
      notifyListeners();
    });
  }


  Future<void> refreshLoggedInUser() async {
    final currentUser =  FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }
    await currentUser.reload();
  }


  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (!_loggedIn) {
      throw Exception("L'utente deve essere loggato");
    }

    return FirebaseFirestore.instance
    .collection('guestbook')
    .add(<String, dynamic>{
      'message': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });

  }


}
