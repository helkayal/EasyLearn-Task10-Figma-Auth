import 'package:flutter/material.dart';
import 'package:task10_figma_auth/core/theme/app_colors.dart';

class SocialSignin extends StatefulWidget {
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
  State<SocialSignin> createState() => _SocialSigninState();
}

class _SocialSigninState extends State<SocialSignin> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Color bgColor = isPressed
        ? AppColors.blueColor.withValues(alpha: .2)
        : Colors.transparent;

    return InkWell(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onPressed();
      },
      onTap: widget.onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: AppColors.blueColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          spacing: 10,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.20),
            Image.asset(widget.icon, height: 20, width: 20, fit: BoxFit.cover),
            Text(widget.label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
