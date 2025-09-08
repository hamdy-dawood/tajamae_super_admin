import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String? text;
  final Icon? icon;
  final Widget? widget;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? color;
  final Color? fontColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final TextStyle? textStyle;
  final bool isBorderButton;
  final bool isGradient;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? borderColor;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
    this.widget,
    this.color,
    this.splashColor,
    this.highlightColor,
    this.width,
    this.fontColor = Colors.white,
    this.textStyle,
    this.height,
    this.isBorderButton = false,
    this.borderRadius,
    this.padding,
    this.borderColor,
    this.fontSize,
    this.fontWeight,
    this.isGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 50,
      decoration: BoxDecoration(
        gradient:
            isGradient
                ? const LinearGradient(
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(254, 145, 29, 1),
                    Color.fromRGBO(9, 147, 167, 1),
                  ],
                )
                : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        border:
            isBorderButton
                ? Border.all(color: borderColor ?? Colors.black38)
                : null,
      ),
      child: MaterialButton(
        onPressed: onTap,
        elevation: 0,
        // splashColor: splashColor ?? AppColors.primary.withOpacity(.1),
        //  highlightColor: highlightColor ?? AppColors.primary.withOpacity(.1),
        highlightElevation: 0,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        color: color,
        child:
            text != null
                ? FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: text!,
                    color: fontColor!,
                    fontWeight: fontWeight ?? FontWeight.w700,
                    fontSize: fontSize!,
                  ),
                )
                : icon ?? widget,
      ),
    );
  }
}
