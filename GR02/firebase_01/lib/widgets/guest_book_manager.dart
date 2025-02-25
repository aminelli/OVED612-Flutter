import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/guest_book_message.dart';
import 'generic_widgets.dart';

class GuestBookManager extends StatefulWidget {
  const GuestBookManager(
      {super.key, required this.messages, required this.addMessage});

  final List<GuestBookMessage> messages;
  final FutureOr<void> Function(String message) addMessage;

  @override
  State<StatefulWidget> createState() => _GuestBookManagerState();
}

class _GuestBookManagerState extends State<GuestBookManager> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Form _getForm() => Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                decoration:
                    const InputDecoration(hintText: 'Scrivi un messaggio'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserire un messaggio per continuare';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 8),
            StyledButton(
                child: const Row(
                  children: [
                    Icon(Icons.send),
                    SizedBox(width: 4),
                    Text('Invia')
                  ],
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await widget.addMessage(_controller.text);
                    _controller.clear();
                  }
                }),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _getForm(),
        ),
        const SizedBox(height: 8),
        for (var message in widget.messages) 
          Paragraph('${message.name}: ${message.message}'),
        const SizedBox(height: 8),        
      ],
    );
  }
}
