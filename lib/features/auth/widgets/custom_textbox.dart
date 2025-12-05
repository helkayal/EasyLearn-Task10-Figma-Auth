import 'package:flutter/material.dart';
import 'package:task10_figma_auth/core/theme/app_colors.dart';

class CustomTextbox extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final double? width;
  final double? height;
  final bool isPassword;

  const CustomTextbox({
    super.key,
    this.hintText,
    this.controller,
    this.width,
    this.height,
    this.labelText,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomTextbox> createState() => _CustomTextboxState();
}

class _CustomTextboxState extends State<CustomTextbox> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: widget.width ?? double.infinity,
          height: widget.height ?? 50,
          child: TextFormField(
            obscureText: widget.isPassword ? _obscure : false,
            validator: widget.validator,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText ?? '',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              filled: true,
              // fillColor: AppColors.textboxBgColor,
              fillColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.error)) {
                  return AppColors.textboxErrorColor.withValues(alpha: 0.2);
                }
                if (states.contains(WidgetState.focused)) {
                  return AppColors.textboxFocusColor.withValues(alpha: 0.2);
                }
                return AppColors.textboxBgColor;
              }),

              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.blueColor,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.textboxBorderColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.textboxFocusColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.textboxErrorColor,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.textboxErrorColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
