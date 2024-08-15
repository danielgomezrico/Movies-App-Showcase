import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ChangeNotifierValue<T extends ChangeNotifier> extends StatelessWidget {
  const ChangeNotifierValue({
    required this.value,
    required this.builder,
    super.key,
  });

  final T value;
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: value,
      child: Consumer<T>(builder: (context, value, child) {
        return builder(context, value);
      }),
    );
  }
}
