import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final bool showLabel;
  final TextInputType keyboardType;
  final Color labelColor;
  final double radius;
  final String icon;
  final String? suffixText;
  final String? Function(String?)? validator;
  final bool readOnly;

  const AppTextField(
      {super.key,
      required this.label,
      required this.hintText,
      this.controller,
      this.isPassword = false,
      this.showLabel = true,
      this.keyboardType = TextInputType.text,
      this.labelColor = Colors.white,
      this.radius = 30,
      this.icon = '',
      this.suffixText,
      this.validator,
      this.readOnly = false});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.showLabel,
          child: Visibility(
            visible: widget.icon.isNotEmpty,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(widget.radius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      widget.icon,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: widget.labelColor,
                  ),
                ),
              ],
            ),
            replacement: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: widget.labelColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          readOnly: widget.readOnly, // 👈 هنا

          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
            prefixIcon: widget.readOnly
                ? IconButton(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
            suffixText: widget.suffixText,
            suffixStyle: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}
