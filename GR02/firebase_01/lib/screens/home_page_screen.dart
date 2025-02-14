import 'package:firebase_01/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../assets/image_assets.dart';
import '../widgets/generic_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  

  Consumer<ApplicationState> _getGalendar() => Consumer<ApplicationState>(
    builder: (context, appstate, _) => IconAndDetail(
      Icons.calendar_today, appstate.eventDate,
    ),
  );

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: const Text('Buon San Valentino')),
      body: ListView(
        children: <Widget>[
          ImagesManager.getHomeImage(),
          const SizedBox(height: 8),
          _getGalendar() 
        ],
      ),
    );
  }


}
