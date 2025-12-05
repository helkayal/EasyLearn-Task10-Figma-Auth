import 'package:flutter/material.dart';
import 'package:task10_figma_auth/core/theme/app_colors.dart';

class SocialSignin extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback onPressed;

  const SocialSignin({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.blueColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          spacing: 10,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.20),
            Image.asset(icon, height: 20, width: 20, fit: BoxFit.cover),
            Text(label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
