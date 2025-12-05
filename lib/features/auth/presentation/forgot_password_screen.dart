import 'package:flutter/material.dart';
import 'package:task10_figma_auth/core/utils/app_string.dart';
import 'package:task10_figma_auth/features/auth/utils/validation.dart';
import 'package:task10_figma_auth/features/auth/widgets/code_dialog.dart';
import 'package:task10_figma_auth/features/auth/widgets/custom_textbox.dart';
import 'package:task10_figma_auth/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppString.backButton)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                AppString.forgotPasswordTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 22),
              Text(
                AppString.forgotPasswordMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 80),
              CustomTextbox(
                labelText: AppString.email,
                hintText: AppString.textHint,
                controller: emailCtrl,
                validator: requiredValidator,
              ),
              SizedBox(height: 30),
              CustomButton(
                label: AppString.continueButton,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return CodeDialog();
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
