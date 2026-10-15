import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_loading_indicator.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final bool showArrow;
  final Widget? icon;
  final Widget? leadingIcon;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.showArrow = true,
    this.icon,
    this.leadingIcon,
    this.width,
    this.height = 54.0,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null && !isLoading;
    final bgColor = backgroundColor ?? (isOutlined ? Colors.transparent : AppColors.espresso);
    final fgColor = textColor ?? (isOutlined ? AppColors.espresso : Colors.white);

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isEnabled ? onPressed : null,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: fgColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: _buildChild(fgColor),
            )
          : ElevatedButton(
              onPressed: isEnabled ? onPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: bgColor,
                foregroundColor: fgColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: _buildChild(fgColor),
            ),
    );
  }

  Widget _buildChild(Color fg) {
    if (isLoading) {
      return AppLoadingIndicator(size: 22, color: fg);
    }

    final prefixIcon = icon ?? leadingIcon;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (prefixIcon != null) ...[
          prefixIcon,
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: fg,
            letterSpacing: 0.2,
          ),
        ),
        if (showArrow) ...[
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_forward_rounded,
            size: 18,
            color: fg,
          ),
        ],
      ],
    );
  }
}
