import 'package:task10_figma_auth/core/utils/app_string.dart';

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) return AppString.emailEmpty;

  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  if (!emailRegex.hasMatch(value)) return AppString.emailInvalid;
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return AppString.passwordEmpty;

  final passRegex = RegExp(r'^(?=.*[!@#\$&*^~]).{8,}$');
  if (!passRegex.hasMatch(value)) {
    return AppString.passwordError;
  }
  return null;
}

String? requiredValidator(String? value) {
  if (value == null || value.isEmpty) return AppString.requiredField;
  return null;
}
