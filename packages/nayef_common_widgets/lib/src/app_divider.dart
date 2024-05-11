import 'package:flutter/material.dart';
import 'package:nayef_common_widgets/src/context_extension.dart';

class AppDivider extends StatelessWidget {
  final double? thickness;
  final Color? color;
  const AppDivider({super.key, this.thickness, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? context.colorScheme.outline,
      thickness: thickness,
    );
  }
}

class PaddedAppDivider extends StatelessWidget {
  final double? thickness;
  final EdgeInsets padding;
  const PaddedAppDivider({
    super.key,
    this.thickness,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: AppDivider(thickness: thickness),
    );
  }
}
