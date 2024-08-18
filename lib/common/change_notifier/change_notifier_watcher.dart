import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ChangeNotifierWatcher<T extends ChangeNotifier> extends StatelessWidget {
  const ChangeNotifierWatcher({
    required this.create,
    required this.builder,
    super.key,
  });

  final T Function() create;
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => create(),
      builder: (context, child) {
        // TODO(danielgomezrico): Avoid a general consumer to avoid rebuilds
        return Consumer<T>(builder: (context, value, child) {
          return builder(context, value);
        });
      },
    );
  }
}
