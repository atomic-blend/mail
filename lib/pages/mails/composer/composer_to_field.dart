import 'package:flutter/cupertino.dart';

class ComposerToField extends StatelessWidget {
  final List<String>? emails;
  final Function(String)? onSelected;
  const ComposerToField({super.key, required this.emails, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      fallbackHeight: 50,
    );
  }
}
