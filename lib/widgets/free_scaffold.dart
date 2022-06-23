import 'package:flutter/material.dart';

class FreeScaffold extends StatelessWidget {
  final Scaffold scaffold;
  final List<Widget> background;
  const FreeScaffold(
      {Key? key, required this.background, required this.scaffold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [...background, scaffold],
      ),
    );
  }
}
