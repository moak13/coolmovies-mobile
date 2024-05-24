import 'package:flutter/material.dart';

class RateCard extends StatelessWidget {
  final int? rate;
  final bool isSelected;
  final VoidCallback? onTap;
  const RateCard({
    super.key,
    this.rate,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.amberAccent : Colors.grey.shade400,
        border: Border.all(
          color: isSelected ? Colors.redAccent : Colors.transparent,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(8),
            child: Text(
              rate.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
