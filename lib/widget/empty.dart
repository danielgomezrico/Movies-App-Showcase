import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_flutter/common/theme/custom_asset.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Lottie.asset(CustomAsset.emptyAnimation, height: 300, width: 300),
        Text(
          'No movies found',
          style: theme.textTheme.headlineSmall
              ?.copyWith(color: theme.colorScheme.onSurface),
        ),
      ],
    );
  }
}
