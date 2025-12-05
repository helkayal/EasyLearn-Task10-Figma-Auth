import 'package:flutter/material.dart';
import 'package:task10_figma_auth/core/utils/app_string.dart';
import 'package:task10_figma_auth/features/auth/presentation/forgot_password_screen.dart';
import 'package:task10_figma_auth/features/auth/utils/validation.dart';
import 'package:task10_figma_auth/features/auth/widgets/custom_textbox.dart';
import 'package:task10_figma_auth/features/auth/widgets/social_signin.dart';
import 'package:task10_figma_auth/features/home/home_screen.dart';
import 'package:task10_figma_auth/widgets/custom_button.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

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
                AppString.signinTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 22),
              Text(
                AppString.signinMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 40),
              CustomTextbox(
                labelText: AppString.email,
                hintText: AppString.textHint,
                controller: emailCtrl,
                validator: requiredValidator,
              ),
              SizedBox(height: 20),
              CustomTextbox(
                labelText: AppString.password,
                hintText: AppString.passwordHint,
                isPassword: true,
                controller: passCtrl,
                validator: requiredValidator,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    AppString.forgotPasswordLink,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              SizedBox(height: 15),
              CustomButton(
                label: AppString.signinButton,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                },
              ),
              Spacer(),
              SocialSignin(
                label: AppString.googleSignin,
                icon: "assets/images/icGoogle.png",
                onPressed: () {},
              ),
              SizedBox(height: 15),
              SocialSignin(
                label: AppString.facebookSignin,
                icon: "assets/images/icFacebook.png",
                onPressed: () {},
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
