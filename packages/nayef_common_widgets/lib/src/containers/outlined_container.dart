import 'package:flutter/material.dart';
import 'package:nayef_common_widgets/src/context_extension.dart';

class OutlinedContainer extends StatelessWidget {
  const OutlinedContainer({
    required this.child,
    this.padding = const EdgeInsets.all(8),
    this.margin = EdgeInsets.zero,
    this.borderRadius = 8,
    super.key,
    this.height,
    this.width,
    this.color,
    this.borderWidth = 0.7,
  });

  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double borderRadius;
  final double? height;
  final double? width;
  final Color? color;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? context.colorScheme.background,
        border: Border.all(
          color: context.colorScheme.outline,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
