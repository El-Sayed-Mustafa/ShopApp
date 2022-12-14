import 'package:flutter/material.dart';

class SittingScreen extends StatelessWidget {
  const SittingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Sitting Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
