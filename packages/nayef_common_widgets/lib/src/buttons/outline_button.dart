import 'package:flutter/material.dart';
import 'package:nayef_common_widgets/src/buttons/button_loading_indicator.dart';
import 'package:nayef_common_widgets/src/context_extension.dart';

class OutlineButton extends StatelessWidget {
  final bool isLoading;
  final String label;
  final void Function()? onClick;
  final double radius;
  final double progressSize;
  final double progressStrokeWidth;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets innerPadding;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final bool fillWidth;
  final bool isCompact;
  final double stroke;
  final TextScaler? textScaler;
  const OutlineButton({
    required this.label,
    super.key,
    this.onClick,
    this.isLoading = false,
    this.radius = 12,
    this.innerPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.progressSize = 12,
    this.progressStrokeWidth = 2,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.backgroundColor,
    this.foregroundColor,
    this.fillWidth = true,
    this.isCompact = false,
    this.prefixIcon,
    this.stroke = 1,
    this.prefix,
    this.suffixIcon,
    this.textScaler,
    this.suffix,
  })  : assert(
          prefixIcon == null || prefix == null,
          'You can only provide either prefixIcon or prefix, not both',
        ),
        assert(
          suffixIcon == null || suffix == null,
          'You can only provide either suffixIcon or suffix, not both',
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            fillWidth ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
        children: [
          _PrimaryButton(
            onClick: onClick,
            radius: radius,
            innerPadding: innerPadding,
            isLoading: isLoading,
            progressSize: progressSize,
            progressStrokeWidth: progressStrokeWidth,
            backgroundColor: backgroundColor ?? context.colorScheme.background,
            foregroundColor: foregroundColor ?? context.colorScheme.primary,
            isCompact: isCompact,
            stroke: stroke,
            child: _ButtonRowRow(
              prefixIcon: prefixIcon,
              label: label,
              fontSize: fontSize,
              fontWeight: fontWeight,
              prefix: prefix,
              suffix: suffix,
              suffixIcon: suffixIcon,
              textScaler: textScaler,
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonRowRow extends StatelessWidget {
  const _ButtonRowRow({
    required this.prefixIcon,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.textScaler,
  });

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final TextScaler? textScaler;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 4),
        if (prefixIcon != null) Icon(prefixIcon, size: 20),
        if (prefix != null) prefix!,
        if (prefix != null || prefixIcon != null) const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            textScaler: textScaler,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
        if (suffix != null || suffixIcon != null) const SizedBox(width: 4),
        if (suffixIcon != null) Icon(suffixIcon, size: 20),
        if (suffix != null) suffix!,
        const SizedBox(width: 4),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.onClick,
    required this.radius,
    required this.innerPadding,
    required this.isLoading,
    required this.progressSize,
    required this.progressStrokeWidth,
    required this.child,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.isCompact,
    required this.stroke,
  });

  final void Function()? onClick;
  final double radius;
  final EdgeInsets innerPadding;
  final bool isLoading;
  final double progressSize;
  final double progressStrokeWidth;
  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;
  final double stroke;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onClick,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        visualDensity: isCompact ? VisualDensity.compact : null,
        disabledBackgroundColor: backgroundColor.withOpacity(0.5),
        disabledForegroundColor: foregroundColor.withOpacity(0.5),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(color: foregroundColor, width: stroke),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: innerPadding,
      ),
      child: isLoading
          ? ButtonLoadingIndicator(
              progressSize: progressSize,
              progressStrokeWidth: progressStrokeWidth,
              foregroundColor: foregroundColor,
            )
          : child,
    );
  }
}
