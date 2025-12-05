import 'package:flutter/material.dart';
import 'package:task10_figma_auth/core/theme/app_colors.dart';
import 'package:task10_figma_auth/core/utils/app_string.dart';
import 'package:task10_figma_auth/features/welcome/welcome_screen.dart';
import 'package:task10_figma_auth/widgets/custom_button.dart';

class CodeDialog extends StatelessWidget {
  const CodeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.codeTitle,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              AppString.codeMessage,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                    width: 50,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.textboxBgColor,
                      border: Border.all(color: AppColors.textboxBorderColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: CustomButton(
                    label: AppString.confirmButton,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => WelcomeScreen()),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    label: AppString.cancelButton,
                    bgColor: AppColors.whiteColor,
                    textColor: AppColors.blueColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
