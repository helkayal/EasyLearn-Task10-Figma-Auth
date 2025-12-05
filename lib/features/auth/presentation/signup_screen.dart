import 'package:flutter/material.dart';
import 'package:task10_figma_auth/core/theme/app_colors.dart';
import 'package:task10_figma_auth/core/utils/app_string.dart';
import 'package:task10_figma_auth/features/auth/presentation/signin_screen.dart';
import 'package:task10_figma_auth/features/auth/utils/validation.dart';
import 'package:task10_figma_auth/features/auth/widgets/custom_textbox.dart';
import 'package:task10_figma_auth/widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  bool agree = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppString.backButton)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  AppString.signupTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 22),
                Text(
                  AppString.signupMessage,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 40),
                CustomTextbox(
                  labelText: AppString.name,
                  hintText: AppString.textHint,
                  controller: nameCtrl,
                  validator: requiredValidator,
                ),

                const SizedBox(height: 20),

                CustomTextbox(
                  labelText: AppString.email,
                  hintText: AppString.textHint,
                  controller: emailCtrl,
                  validator: emailValidator,
                ),

                const SizedBox(height: 20),

                CustomTextbox(
                  labelText: AppString.password,
                  hintText: AppString.passwordHint,
                  isPassword: true,
                  controller: passCtrl,
                  validator: passwordValidator,
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        value: agree,
                        onChanged: (val) {
                          setState(() => agree = val ?? false);
                        },
                        activeColor: AppColors.blueColor,
                        checkColor: AppColors.whiteColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppString.agreeTerms,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                CustomButton(
                  label: AppString.signupButton,
                  onPressed: () {
                    FocusScope.of(context).unfocus();

                    final valid = formKey.currentState!.validate();

                    if (!agree) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You have to ${AppString.agreeTerms}"),
                          backgroundColor: AppColors.textboxErrorColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                      setState(() {});
                    }

                    if (valid && agree) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SigninScreen(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
