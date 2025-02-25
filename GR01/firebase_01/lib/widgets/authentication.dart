import 'package:firebase_01/widgets/generic_widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc(
      {super.key,
      required this.loggedIn,
      required this.signOut
    });

  final bool loggedIn;
  final void Function() signOut;

  Widget _getLoginLogout(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 8),
        child: StyledButton(
          child: !loggedIn ? const Text('RSVP') : const Text('Logout'),
          onPressed: () {
            !loggedIn ? context.push('/sign-in') : signOut();
          },
        ),
      );

  Widget _getProfile(BuildContext context) => Visibility(
      visible: loggedIn,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 8),
        child: StyledButton(
          child: const Text('Profile'),
          onPressed: () {
            context.push('/profile');
          },
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getLoginLogout(context),
        _getProfile(context)
      ],
    );
  }
}
