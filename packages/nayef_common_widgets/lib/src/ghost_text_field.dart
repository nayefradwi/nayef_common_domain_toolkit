import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nayef_common_widgets/src/context_extension.dart';

class GhostTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final bool isObscureText, isDense;
  final String? errorMessage;
  final TextInputAction? textInputAction;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onChanged;
  final void Function()? onEditingComplete;
  final List<String>? autofillHints;
  final int? maxLines, errorMaxLines;
  final bool isReadOnly, isEnabled, autofocus;
  final FocusNode? focusNode;
  final Widget? prefix;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Color? textColor, cursorColor;
  final FontWeight fontWeight;
  const GhostTextField({
    required this.label,
    super.key,
    this.controller,
    this.keyboardType,
    this.suffix,
    this.isObscureText = false,
    this.isDense = true,
    this.errorMessage,
    this.textInputAction,
    this.onSubmitted,
    this.onEditingComplete,
    this.autofillHints = const [],
    this.maxLines = 1,
    this.errorMaxLines = 2,
    this.isReadOnly = false,
    this.onChanged,
    this.isEnabled = true,
    this.autofocus = false,
    this.inputFormatters,
    this.focusNode,
    this.prefix,
    this.textCapitalization = TextCapitalization.none,
    this.textColor,
    this.fontWeight = FontWeight.w500,
    this.cursorColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: textCapitalization,
      focusNode: focusNode,
      autofocus: autofocus,
      enabled: isEnabled,
      readOnly: isReadOnly,
      onChanged: onChanged,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      controller: controller,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      obscureText: isObscureText,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      cursorColor: cursorColor,
      style: TextStyle(
        fontWeight: fontWeight,
        color: textColor ?? context.colorScheme.onBackground,
      ),
      decoration: InputDecoration(
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        errorText: errorMessage,
        errorMaxLines: errorMaxLines,
        suffixIcon: suffix,
        suffixIconConstraints: const BoxConstraints(minHeight: 12),
        labelText: label,
        prefix: prefix,
        labelStyle: TextStyle(color: context.colorScheme.onSecondary),
        isDense: isDense,
      ),
    );
  }
}
