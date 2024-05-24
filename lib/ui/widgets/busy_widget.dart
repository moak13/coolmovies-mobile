import 'package:flutter/material.dart';

class BusyWidget extends StatelessWidget {
  const BusyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
