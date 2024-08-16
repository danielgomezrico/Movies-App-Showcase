import 'dart:math';

import 'package:flutter/material.dart';

class ShadowSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  ShadowSliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    this.isShadowEnabled = true,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;
  final bool isShadowEnabled;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    if (overlapsContent && isShadowEnabled) {
      return SizedBox.expand(
        child: Material(
          elevation: 2,
          child: child,
        ),
      );
    } else {
      return SizedBox.expand(child: child);
    }
  }

  @override
  bool shouldRebuild(ShadowSliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
