import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tajamae_super_admin/app/widget/svg_icons.dart';

import '../utils/colors.dart';
import '../utils/constance.dart';
import 'custom_text.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({
    super.key,
    required this.onInputChanged,
    this.validator,
    this.isLastInput = false,
    this.readOnly = false,
    this.hint = "",
    this.isoCode = "IQ",
    this.autoValidate = AutovalidateMode.onUserInteraction,
    this.onTap,
    this.title = "",
    this.icon = "",
    this.titleColor,
    this.titleFontSize = 13,
    this.titleFontWeight,
    this.controller,
    this.onFieldSubmitted,
    this.focusNode,
    this.errorFontSize,
    this.suffixIcon,
  });

  final Function(PhoneNumber)? onInputChanged;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final bool isLastInput, readOnly;
  final String hint;
  final String title, icon;
  final Color? titleColor;
  final double titleFontSize;
  final FontWeight? titleFontWeight;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? errorFontSize;
  final String? isoCode;
  final AutovalidateMode autoValidate;
  final VoidCallback? onTap;
  final void Function(String?)? onFieldSubmitted;
  final Widget? suffixIcon;

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
        Localizations.override(
          context: context,
          locale: Locale("en"),
          child: IntlPhoneField(
            focusNode: focusNode,
            onSubmitted: onFieldSubmitted,
            readOnly: readOnly,
            controller: controller,
            onTap: onTap,
            initialCountryCode: isoCode,
            onChanged: onInputChanged,
            validator: validator,
            invalidNumberMessage: "رقم الهاتف غير صحيح",
            autovalidateMode: autoValidate,
            showDropdownIcon: false,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: AppConstance.appFontName,
            ),
            textInputAction:
                isLastInput ? TextInputAction.done : TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            // dropdownIcon: const Icon(
            //   Icons.keyboard_arrow_down,
            //   color: Color(0xff7F7F7F),
            //   size: 30,
            // ),
            flagsButtonPadding: EdgeInsets.symmetric(horizontal: 12),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              counterStyle: const TextStyle(fontSize: 0),
              enabled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 1, color: AppColors.border),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 1, color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.primary,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.primary,
                ),
              ),
              errorStyle: TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.w400,
                fontSize: errorFontSize ?? 0,
                fontFamily: AppConstance.appFontName,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.grey2,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: AppConstance.appFontName,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
