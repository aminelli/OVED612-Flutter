import 'dart:async';

import 'package:firebase_01/models/guest_book_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'generic_widgets.dart';

class GuestBook extends StatefulWidget {
  const GuestBook(
      {super.key, required this.messages, required this.addMessage});

  final List<GuestBookMessage> messages;
  final FutureOr<void> Function(String message) addMessage;

  @override
  State<StatefulWidget> createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Lascia un messagio',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Inserisci il tuo messaggio per continuare';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                StyledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.addMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('INVIA'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        for (var message in widget.messages)
          Paragraph('${message.name}: ${message.message}'),
        const SizedBox(height: 8),
      ],
    );
  }
}
