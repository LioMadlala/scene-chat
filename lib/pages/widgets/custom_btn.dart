import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final bool? outlineBtn;
  final Color? textColor;
  final bool? isLoading;
  final bool? isDisabled;
  const CustomBtn({
    super.key,
    this.text,
    this.onPressed,
    this.outlineBtn,
    this.isLoading,
    this.isDisabled,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    bool outlineBtn = this.outlineBtn ?? false;
    bool isLoading = this.isLoading ?? false;

    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Container(
        height: 50.0,
        decoration: isDisabled == true
            ? BoxDecoration(
                color: Colors.grey,
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(
                  6.0,
                ),
              )
            : BoxDecoration(
                color: outlineBtn ? Colors.transparent : Colors.black,
                border: Border.all(
                  color: isDisabled == true ? Colors.black : Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(
                  6.0,
                ),
              ),
        // margin: EdgeInsets.symmetric(
        //   horizontal: 24.0,
        //   vertical: 8.0,
        // ),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text",
                  style: TextStyle(
                    fontSize: 13.0,
                    color: outlineBtn ? Colors.white : textColor,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
