import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:tajamae_super_admin/app/widget/svg_icons.dart';

import '../utils/colors.dart';
import '../utils/constance.dart';
import 'custom_text.dart';

class OtpFormField extends StatelessWidget {
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
  final TextStyle? textStyle;
  final AutovalidateMode? autoValidateMode;
  final double borderRadius;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;

  const OtpFormField({
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
        Center(
          child: Localizations.override(
            context: context,
            locale: const Locale("en"),
            child: Pinput(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              length: 6,
              controller: controller,
              defaultPinTheme: _buildPinTheme(context),
              focusedPinTheme: _buildPinTheme(context, focused: true),
              errorPinTheme: _buildPinTheme(context, hasError: true),
              validator: validator,
              errorTextStyle: TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.w400,
                fontSize: errorFontSize ?? 0,
                fontFamily: AppConstance.appFontName,
              ),
            ),
          ),
        ),
      ],
    );
  }

  PinTheme _buildPinTheme(
    BuildContext context, {
    bool focused = false,
    bool hasError = false,
  }) {
    return PinTheme(
      height: 55,
      width: 55,
      textStyle: TextStyle(
        color: AppColors.black,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: "Semi Bold",
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          width: 1,
          color: hasError
              ? AppColors.red
              : focused
                  ? AppColors.primary
                  : AppColors.border,
        ),
      ),
    );
  }
}
