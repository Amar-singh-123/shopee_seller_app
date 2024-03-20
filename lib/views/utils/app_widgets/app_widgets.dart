import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';


class AppWidgets {
  BuildContext context;

  AppWidgets({required this.context});

  nextScreenPush({required BuildContext context, required Widget screen}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  }

  nextScreenPushReplacement(
      {required BuildContext context, required Widget screen}) {
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  }

  Widget elevatedButton(String text, {required void Function()? onPressed}) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }

  Widget sizedBox({Widget? child, double? height, double? width}) {
    return SizedBox(
      height: height,
      width: width,
      child: child,
    );
  }

  Widget textFormField(
      {void Function()? onTap,
        String? Function(String?)? validator,
        required TextEditingController? controller,
        required TextInputType? keyboardType,
        required String? labelText,
        Widget? prefixIcon,
        bool? enabled,
        Color? cursorColor,
        Widget? suffixIcon,
        int? maxLength,
        required TextInputAction? textInputAction,
        void Function(String?)? onSaved,
        bool obscureText = false}) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onTap: onTap,
      keyboardType: keyboardType,
      enabled: enabled,
      cursorColor: cursorColor,
      obscureText: obscureText,
      textInputAction: textInputAction,
      onSaved: onSaved,
      maxLength: maxLength,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorStyle: const TextStyle(fontSize: 13.0),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  PreferredSizeWidget? appBarView(
      {Widget? title,
        Color? backgroundColor,
        double? elevation,
        bool? centerTitle,
        Widget? leading,
        double? titleSpacing,
        PreferredSizeWidget? bottom,
        ShapeBorder? shape,
        Widget? flexibleSpace,
        TextStyle? titleTextStyle,
        IconThemeData? iconThem,
        List<Widget>? actions,
        double? toolbarHeight}) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      leading: leading,
      titleSpacing: titleSpacing,
      bottom: bottom,
      shape: shape,
      flexibleSpace: flexibleSpace,
      actions: actions,
      titleTextStyle: titleTextStyle,
      toolbarHeight: toolbarHeight,
      iconTheme: iconThem,
    );
  }

  Widget iconButton(
      {required void Function()? onPressed, required Widget icon}) {
    return IconButton(onPressed: onPressed, icon: icon);
  }

  Widget pinPut(
      {required TextEditingController? controller,
        required String? Function(String?)? validator,
        bool autofocus = false,
        required TextInputAction? textInputAction}) {
    return Pinput(
      controller: controller,
      length: 6,
      validator: validator,
      textInputAction: textInputAction,
      autofocus: autofocus,
    );
  }

  Widget containerButton(String text,{double? width,double? height,void Function()? onTap}){
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.lightBlueAccent),
        width: width,
        height: height,
        child: Center(child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),
      ),
    );
  }
}
