import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nayef_common_widgets/src/context_extension.dart';

class UnderlineTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final bool isObscureText;
  final bool isDense;
  final String? errorMessage;
  final TextInputAction? textInputAction;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onChanged;
  final void Function()? onEditingComplete;
  final List<String>? autofillHints;
  final int? maxLines;
  final int? errorMaxLines;
  final bool isReadOnly;
  final bool isEnabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final Widget? prefix;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Color? textColor;
  final Color? enabledColor;
  final Color? disabledColor;
  final Color? errorColor;
  final Color? focusedColor;
  final Color? cursorColor;
  final FontWeight fontWeight;
  final Color? labelOrHintColor;
  final bool isHintText;
  const UnderlineTextField({
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
    this.enabledColor,
    this.disabledColor,
    this.errorColor,
    this.focusedColor,
    this.fontWeight = FontWeight.w500,
    this.cursorColor,
    this.labelOrHintColor,
    this.isHintText = false,
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
        color: textColor ?? context.colorScheme.surface,
      ),
      decoration: InputDecoration(
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: disabledColor ?? context.colorScheme.outline,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: enabledColor ?? context.colorScheme.outline,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: focusedColor ?? context.colorScheme.surface,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: errorColor ?? context.colorScheme.error,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: errorColor ?? context.colorScheme.error,
          ),
        ),
        errorText: errorMessage,
        errorMaxLines: errorMaxLines,
        suffixIcon: suffix,
        suffixIconConstraints: const BoxConstraints(minHeight: 12),
        labelText: !isHintText ? label : null,
        hintText: isHintText ? label : null,
        hintStyle: TextStyle(color: labelOrHintColor),
        prefixIcon: prefix,
        labelStyle: TextStyle(color: labelOrHintColor),
        isDense: isDense,
      ),
    );
  }
}
