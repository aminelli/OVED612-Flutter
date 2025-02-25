import 'package:firebase_01/app_state.dart';
import 'package:firebase_01/assets/image_assets.dart';
import 'package:firebase_01/widgets/generic_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../widgets/authentication.dart';
import '../widgets/guest_book.dart';
import '../widgets/yes_no_selection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Consumer<ApplicationState> _getCalendar() => Consumer<ApplicationState>(
      builder: (context, appState, _) =>
          IconAndDetail(Icons.calendar_today, appState.eventDate));

  Consumer<ApplicationState> _getAuth() => Consumer<ApplicationState>(
      builder: (context, appState, _) => AuthFunc(
            loggedIn: appState.loggedIn,
            signOut: () {
              FirebaseAuth.instance.signOut();
            },
          ));

  Divider _getDivider() => const Divider(
        height: 8,
        thickness: 1,
        indent: 8,
        endIndent: 8,
        color: Colors.grey,
      );

  Consumer<ApplicationState> _getParagraph() => Consumer<ApplicationState>(
        builder: (context, appState, _) => Paragraph(appState.callToAction),
      );

  List<Widget> _getLoggedInDiscussion(ApplicationState appState) => [
        YesNoSelection(
          state: appState.attending,
          onSelection: (attending) => appState.attending = attending,
        ),
        const Header('Discussione'),
        GuestBook(
            messages: appState.guestBookMessages,
            addMessage: (message) => appState.addMessageToGuestBook(message))
      ];

  Paragraph _getAttendees(attendees) => switch (attendees) {
        1 => const Paragraph("1 persona partecipa"),
        >= 2 => Paragraph('$attendees persone partecipano'),
        _ => const Paragraph("Nessuno Partecipa")
      };

  Consumer<ApplicationState> _getContent() => Consumer<ApplicationState>(
        builder: (context, appState, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getAttendees(appState.attendees),
              if (appState.loggedIn) ..._getLoggedInDiscussion(appState)
            ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('San Valentino')),
      body: ListView(
        children: <Widget>[
          ImagesManager.getHomeImage(),
          const SizedBox(
            height: 8,
          ),
          _getCalendar(),
          const IconAndDetail(Icons.location_city, 'Milano'),
          _getAuth(),
          _getDivider(),
          const Header("Cosa Faremo"),
          _getParagraph(),
          _getContent()
        ],
      ),
    );
  }
}
