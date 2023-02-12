import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final Function(String?)? onSubmitted;
  final Function()? onTap;
  final String Function(String?)? validator;
  final FocusNode? focusNode;
  final bool? isDigitOnly;
  final TextEditingController? textController;

  final TextInputAction? textInputAction;
  final bool? isPasswordField;
  CustomInput({
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.textController,
    this.isDigitOnly,
    this.onTap,
    this.focusNode,
    this.validator,
    this.textInputAction,
    this.isPasswordField,
  });

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;

    return Container(
      // margin: EdgeInsets.symmetric(
      //   vertical: 8.0,
      //   horizontal: 24.0,
      // ),
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(12.0)),
      child: TextFormField(
        controller: textController,
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSaved: onSubmitted,
        validator: validator,
        textInputAction: textInputAction,
        onTap: onTap,
        keyboardType: isDigitOnly == true ? TextInputType.number : null,
        inputFormatters: isDigitOnly == true
            ? [
                FilteringTextInputFormatter.digitsOnly,
              ]
            : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black38,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          ),
          // prefixIcon: Icon(
          //   Icons.person,
          //   color: Colors.grey,
          // ),
        ),
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
