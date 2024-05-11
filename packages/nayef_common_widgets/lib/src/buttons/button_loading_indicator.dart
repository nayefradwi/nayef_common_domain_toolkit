import 'package:flutter/material.dart';
import 'package:nayef_common_widgets/src/context_extension.dart';

class ButtonLoadingIndicator extends StatelessWidget {
  const ButtonLoadingIndicator({
    required this.progressSize,
    required this.progressStrokeWidth,
    super.key,
    this.foregroundColor,
  });

  final double progressSize;
  final double progressStrokeWidth;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: progressSize,
      width: progressSize,
      child: CircularProgressIndicator(
        strokeWidth: progressStrokeWidth,
        color: foregroundColor ?? context.colorScheme.onPrimary,
      ),
    );
  }
}
