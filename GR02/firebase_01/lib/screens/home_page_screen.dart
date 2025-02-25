import 'package:firebase_01/app_state.dart';
import 'package:firebase_01/widgets/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../assets/image_assets.dart';
import '../widgets/generic_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Consumer<ApplicationState> _getGalendar() => Consumer<ApplicationState>(
        builder: (context, appstate, _) => IconAndDetail(
          Icons.calendar_today,
          appstate.eventDate,
        ),
      );

  Consumer<ApplicationState> _getAuth() => Consumer<ApplicationState>(
        builder: (context, appState, _) => AuthFunc(
            loggedIn: appState.loggedIn,
            signOut: () {
              FirebaseAuth.instance.signOut();
            }),
      );

  Divider _getDivider() => const Divider(
        height: 8,
        thickness: 1,
        indent: 8,
        endIndent: 8,
        color: Colors.grey,
      );

  Consumer<ApplicationState> _getEventActions() => Consumer<ApplicationState>(
    builder:(context, appState, _) => Paragraph(appState.callToAction),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buon San Valentino')),
      body: ListView(
        children: <Widget>[
          ImagesManager.getHomeImage(),
          const SizedBox(height: 8),
          _getGalendar(),
          const IconAndDetail(Icons.location_city, 'Milano'),
          _getAuth(),
          _getDivider(),
          const Header("Cosa faremo ? "),
          _getEventActions()
        ],
      ),
    );
  }
}
