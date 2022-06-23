import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_2cs/config/config.dart';

Widget defaultTextButton({
  required void Function() onPressed,
  required String text,
  Color textColor = primaryColor,
}) =>
    TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
        ));

Widget defaultButton(
        {required void Function() onPressed,
        String icon = "assets/images/arrow.svg",
        String? text,
        bool reversed = false,
        bool rounded = false,
        bool showArrow = true,
        bool centerText = false,
        required BuildContext context,
        Color color = primaryColor,
        TextStyle textStyle = const TextStyle(
          fontSize: 17,
        )}) =>
    ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(rounded ? 33 : 12),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 22, vertical: text == null ? 20.5 : 17),
            elevation: 0),
        child: Row(
          mainAxisAlignment: text != null && !centerText
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (text != null)
              Flexible(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle,
                ),
              ),
            if (showArrow)
              Transform.rotate(
                angle: 0,
                child: SvgPicture.asset(
                  icon,
                  width: rounded ? 63 : 36.18,
                ),
              )
          ],
        ));

Widget defaultTextFormField({
  String? label,
  EdgeInsetsGeometry padding = const EdgeInsets.only(left: 33, right: 33),
  required String hint,
  bool obscureText = false,
  TextInputType? keyboardType,
  void Function(String?)? onSaved,
  void Function(String?)? onChanged,
  Widget? suffixIcon,
  String? Function(String?)? validator,
}) =>
    TextFormField(
      style: const TextStyle(fontSize: 17),
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSaved: onSaved,
      autocorrect: false,
      cursorHeight: 20,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusColor: primaryColor,
        suffixIcon: suffixIcon == null
            ? null
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  suffixIcon,
                ],
              ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: primaryColor,
              width: 1.5,
              style: BorderStyle.solid,
            )),
        labelText: label,
        hintText: hint,
        contentPadding: padding,
        labelStyle: const TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 6,
              style: BorderStyle.solid,
            )),
      ),
    );


Widget defaultFileFieled(
    {String text = '', required void Function()? onPressed}) =>
    Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.attach_file,
                color: primaryColor,
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                  color: primaryColor,
                  /*   fontSize: MediaQuery.of(context)
                  .size
                  .height /
                  65,*/
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      // height: MediaQuery.of(context).size.height / 6,
    );

errorSnackBar(context, errorText) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              errorText,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFAB0404),
    ));
Widget defaultCard({
  required Widget child,
  Color backGroundColor = Colors.white,
  EdgeInsets? margin,
  double padding = 14.0,
}) =>
    Card(
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: backGroundColor,
        elevation: 3,
        child: Padding(
            padding:
            EdgeInsets.symmetric(vertical: padding, horizontal: padding),
            child: child));