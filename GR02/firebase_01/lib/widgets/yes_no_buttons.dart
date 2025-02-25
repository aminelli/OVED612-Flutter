import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../app_state.dart';
import 'generic_widgets.dart';

class YesNoButtons extends StatelessWidget {
  const YesNoButtons({
    super.key,
    required this.state,
    required this.onSelection,
  });

  final Attending state;
  final void Function(Attending selection) onSelection;

  Widget _getYesButton(String label) {
    final void Function() onSelectionPressed = ()=> onSelection(Attending.yes);
 
    switch(state) {
      case Attending.yes:
        return FilledButton(onPressed: onSelectionPressed, child: Text(label));
      case Attending.no:
        return TextButton(onPressed: onSelectionPressed, child:  Text(label));
      default:
        return StyledButton(onPressed: onSelectionPressed, child:  Text(label));
      }
  }

  Widget _getNoButton(String label) {
     final void Function() onSelectionPressed = ()=> onSelection(Attending.no);

    switch(state) {
      case Attending.yes:
        return TextButton(onPressed: onSelectionPressed, child:  Text(label));
      case Attending.no:
        return FilledButton(onPressed: onSelectionPressed, child:  Text(label));
      default:
        return StyledButton(onPressed: onSelectionPressed, child:  Text(label));
      }
  }
    


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        _getYesButton('SI'),
        const SizedBox(width: 8),
        _getNoButton('NO'),
      ])
    );    
  }
}
