import 'package:flutter/material.dart';
import 'package:task10_figma_auth/core/utils/app_string.dart';
import 'package:task10_figma_auth/features/auth/presentation/login_screen.dart';
import 'package:task10_figma_auth/features/auth/presentation/signup_screen.dart';
import 'package:task10_figma_auth/widgets/custom_nutton.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme txtTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Welcome.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120),
            Text(AppString.welcomeTitle, style: txtTheme.titleLarge),
            const SizedBox(height: 22),
            Text(AppString.letsGetStarted, style: txtTheme.bodyLarge),
            Spacer(),
            Text(AppString.existingCustomer, style: txtTheme.bodyLarge),
            const SizedBox(height: 12),
            CustomButton(
              label: AppString.signinButton,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
            Row(
              children: [
                Text(AppString.newCustomer, style: txtTheme.bodyLarge),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: Text(
                    AppString.createNewAccount,
                    style: txtTheme.titleMedium,
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
