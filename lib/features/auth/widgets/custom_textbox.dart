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
  bool isObscure = true;
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  String? errorMessage;

  double passwordStrength = 0;
  String passwordStrengthText = '';

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        validateField();
      }
    });

    widget.controller?.addListener(() {
      if (widget.isPassword) checkPasswordStrength(widget.controller!.text);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasValue = widget.controller?.text.isNotEmpty ?? false;
    bool isValid = hasValue && errorMessage == null;

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
          child: buildTextFormField(context, hasValue, isValid),
        ),

        if (widget.isPassword && hasValue) buildPasswordStrengthBar(),

        if (errorMessage != null && errorMessage!.isNotEmpty)
          buildErrorMessage(context),
      ],
    );
  }

  void validateField() {
    final value = widget.controller?.text;
    final error = widget.validator?.call(value);
    setState(() {
      errorMessage = error;
    });
    fieldKey.currentState?.validate();
  }

  void checkPasswordStrength(String value) {
    double strength = 0;

    if (value.isEmpty) {
      strength = 0;
    } else if (value.length < 6) {
      strength = 0.25;
    } else if (value.length < 8) {
      strength = 0.5;
    } else {
      final hasLetters = RegExp(r'[A-Za-z]').hasMatch(value);
      final hasNumbers = RegExp(r'\d').hasMatch(value);
      final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

      if ((hasLetters && hasNumbers && hasSpecial)) {
        strength = 1.0;
      } else {
        strength = 0.75;
      }
    }

    setState(() {
      passwordStrength = strength;
    });
  }

  OutlineInputBorder border(Color color, {double width = 2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  TextFormField buildTextFormField(
    BuildContext context,
    bool hasValue,
    bool isValid,
  ) {
    return TextFormField(
      key: fieldKey,
      focusNode: focusNode,
      obscureText: widget.isPassword ? isObscure : false,
      controller: widget.controller,
      validator: (value) {
        final error = widget.validator?.call(value);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => errorMessage = error);
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
        suffixIcon: buildSuffixIcon(hasValue, isValid),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
      ),
    );
  }

  Padding buildErrorMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 4),
      child: Text(
        errorMessage!,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Color strengthColor() {
    if (passwordStrength <= 0.4) return AppColors.textboxErrorColor;
    if (passwordStrength <= 0.75) return AppColors.yellowColor;
    return AppColors.textboxOkColor;
  }

  Text strengthText() {
    if (passwordStrength <= 0.4) {
      return Text(
        "Password is Weak",
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(color: AppColors.textboxErrorColor),
      );
    }
    if (passwordStrength <= 0.75) {
      return Text(
        "Password is Medium",
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(color: AppColors.yellowColor),
      );
    }
    return Text(
      "Password is Strong",
      style: Theme.of(
        context,
      ).textTheme.bodyLarge!.copyWith(color: AppColors.textboxOkColor),
    );
  }

  Padding buildPasswordStrengthBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: passwordStrength,
            backgroundColor: Colors.grey[300],
            color: strengthColor(),
            minHeight: 3,
          ),
          strengthText(),
        ],
      ),
    );
  }

  Widget? buildSuffixIcon(bool hasValue, bool isValid) {
    return widget.isPassword
        ? IconButton(
            icon: Icon(
              isObscure ? Icons.visibility_off : Icons.visibility,
              color: AppColors.blueColor,
            ),
            onPressed: () => setState(() => isObscure = !isObscure),
          )
        : (hasValue
              ? (isValid
                    ? const Icon(
                        Icons.check_circle,
                        color: AppColors.textboxOkColor,
                      )
                    : const Icon(
                        Icons.cancel,
                        color: AppColors.textboxErrorColor,
                      ))
              : null);
  }
}
