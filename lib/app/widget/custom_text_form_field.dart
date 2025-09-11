import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tajamae_super_admin/app/widget/svg_icons.dart';

import '../utils/colors.dart';
import '../utils/constance.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String title, icon;
  final double titleFontSize;
  final double? hintFontSize, errorFontSize;
  final FontWeight? titleFontWeight;
  final Color? titleColor;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Color? filledColor;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFieldSubmitted;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final bool readOnly, isLastInput;
  final int? maxLines, maxLength;
  final Color? borderColor;
  final Color? hintColor;
  final TextStyle? textStyle;
  final AutovalidateMode? autoValidateMode;
  final double borderRadius;
  final FontWeight? hintWeight;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;

  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.title = '',
    this.icon = '',
    this.titleFontSize = 13,
    this.hintFontSize,
    this.errorFontSize,
    this.titleColor,
    this.titleFontWeight,
    this.suffixIcon,
    this.keyboardType,
    this.prefixIcon,
    this.readOnly = false,
    this.isLastInput = false,
    this.validator,
    this.controller,
    this.hintText,
    this.maxLines,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.borderColor,
    this.textStyle,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.filledColor,
    this.borderRadius = 8,
    this.initialValue,
    this.inputFormatters = const [],
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.textInputAction,
    this.hintColor,
    this.hintWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                if (icon.isNotEmpty)
                  SvgIcon(icon: icon, color: AppColors.black, height: 20),
                SizedBox(width: 5),
                if (title.isNotEmpty)
                  CustomText(
                    text: title,
                    color: titleColor ?? AppColors.black,
                    fontSize: titleFontSize,
                    fontWeight: titleFontWeight ?? FontWeight.w400,
                  ),
              ],
            ),
          ),
        TextFormField(
          mouseCursor: MouseCursor.defer,
          focusNode: focusNode,
          initialValue: initialValue,
          controller: controller,
          inputFormatters: inputFormatters,
          validator: validator,
          autovalidateMode: autoValidateMode,
          onTap: onTap,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          textAlign: textAlign,
          style: textStyle ??
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: AppConstance.appFontName,
              ),
          readOnly: readOnly,
          textInputAction: textInputAction ??
              (isLastInput ? TextInputAction.done : TextInputAction.next),
          obscureText: obscureText,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            fillColor: filledColor ?? AppColors.white,
            hintStyle: TextStyle(
              color: hintColor ?? AppColors.grey,
              fontWeight: hintWeight ?? FontWeight.w400,
              fontSize: hintFontSize ?? 14,
              fontFamily: AppConstance.appFontName,
            ),
            errorStyle: TextStyle(
              color: AppColors.red,
              fontWeight: FontWeight.w400,
              fontSize: errorFontSize ?? 0,
              fontFamily: AppConstance.appFontName,
            ),
            counterStyle: const TextStyle(fontSize: 0),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 1,
                color: borderColor ?? AppColors.border,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 1,
                color: borderColor ?? AppColors.border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 1,
                color: borderColor ?? AppColors.primary,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 1,
                color: borderColor ?? AppColors.primary,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(width: 1, color: AppColors.red),
            ),
          ),
        ),
      ],
    );
  }
}
