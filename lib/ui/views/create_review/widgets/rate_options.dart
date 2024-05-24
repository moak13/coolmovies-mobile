import 'package:flutter/material.dart';

import 'rate_card.dart';

class RateOptions extends StatefulWidget {
  final List<int> rates;
  final ValueChanged<int> onSelected;
  final String? Function(int?)? validator;

  const RateOptions({
    super.key,
    required this.rates,
    required this.onSelected,
    this.validator,
  });

  @override
  State<RateOptions> createState() => _RateOptionsState();
}

class _RateOptionsState extends State<RateOptions> {
  int? _rate;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FormField<int>(
      validator: widget.validator,
      initialValue: 0,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final rate = widget.rates.elementAt(index);
                  return Ink(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: state.hasError
                            ? theme.colorScheme.error
                            : Colors.transparent,
                      ),
                    ),
                    child: RateCard(
                      rate: rate,
                      isSelected: rate == _rate,
                      onTap: () {
                        _rate = rate;
                        widget.onSelected.call(rate);
                        state.didChange(rate);
                        setState(() {});
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 5,
                  );
                },
                itemCount: widget.rates.length,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Builder(
              builder: (context) {
                if (state.hasError) {
                  return Text(
                    state.errorText ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }
}
