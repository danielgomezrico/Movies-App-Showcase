import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_flutter/common/theme/custom_asset.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(CustomAsset.loading);
  }
}
