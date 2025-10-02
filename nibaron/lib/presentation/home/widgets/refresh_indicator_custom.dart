import 'package:flutter/material.dart';

class RefreshIndicatorCustom extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const RefreshIndicatorCustom({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).cardColor,
      strokeWidth: 2.5,
      child: child,
    );
  }
}
