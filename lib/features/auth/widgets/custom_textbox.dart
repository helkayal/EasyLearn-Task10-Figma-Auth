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
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _validate();
      }
    });
  }

  void _validate() {
    final value = widget.controller?.text;
    final error = widget.validator?.call(value);
    setState(() {
      _errorMessage = error;
    });
    _fieldKey.currentState?.validate();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  OutlineInputBorder border(Color color, {double width = 2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: width),
    );
  }

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
            key: _fieldKey,
            focusNode: _focusNode,
            obscureText: widget.isPassword ? _obscure : false,
            controller: widget.controller,
            validator: (value) {
              final error = widget.validator?.call(value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() => _errorMessage = error);
                }
              });
              return error;
            },

            decoration: InputDecoration(
              filled: true,
              fillColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.error)) {
                  return AppColors.textboxErrorColor.withValues(alpha: .2);
                }
                if (states.contains(WidgetState.focused)) {
                  return AppColors.textboxFocusColor.withValues(alpha: .2);
                }
                return AppColors.textboxBgColor;
              }),

              hintText: widget.hintText ?? '',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              errorStyle: const TextStyle(height: 0, fontSize: 0),

              enabledBorder: border(AppColors.textboxBorderColor),
              focusedBorder: border(AppColors.textboxFocusColor),
              errorBorder: border(AppColors.textboxErrorColor),
              focusedErrorBorder: border(AppColors.textboxErrorColor),

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
            ),
          ),
        ),

        if (_errorMessage != null && _errorMessage!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              _errorMessage!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
      ],
    );
  }
}
