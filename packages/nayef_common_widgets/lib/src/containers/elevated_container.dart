import 'package:flutter/cupertino.dart';
import 'package:nayef_common_widgets/src/context_extension.dart';

class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final Color? shadowColor;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final double blurRadius;
  final BoxConstraints constraints;
  const ElevatedContainer({
    required this.child,
    super.key,
    this.shadowColor,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(8),
    this.margin,
    this.borderRadius = 8,
    this.constraints = const BoxConstraints(maxWidth: 166),
    this.blurRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      constraints: constraints,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.background,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: shadowColor ?? context.colorScheme.shadow,
          width: 0.7,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? context.colorScheme.shadow,
            blurRadius: blurRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}
