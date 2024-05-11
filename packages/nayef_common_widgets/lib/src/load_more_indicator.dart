import 'package:flutter/material.dart';
import 'package:nayef_common_widgets/src/context_extension.dart';

class LoadMoreIndicator extends StatelessWidget {
  final bool isVisible;
  const LoadMoreIndicator({required this.isVisible, super.key});

  @override
  Widget build(BuildContext context) {
    if (isVisible) return const LinearProgressIndicator();
    return Padding(
      padding: EdgeInsets.only(bottom: context.padding.bottom),
    );
  }
}
