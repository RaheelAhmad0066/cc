import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_animations.dart';
import '../../../core/widgets/app_button.dart';

class OnboardingPhotoGuideStep extends StatelessWidget {
  final VoidCallback onComplete;

  const OnboardingPhotoGuideStep({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(22.w, 4.h, 22.w, 14.h),
      child: Column(
        children: [
          AppAnimations.fadeInUp(
            key: const ValueKey('photo-guide-heading'),
            slideDistance: 20,
            duration: const Duration(milliseconds: 450),
            child: _heading(),
          ),
          SizedBox(height: 14.h),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final portraitHeight = (constraints.maxHeight * 0.47)
                    .clamp(190.0, 310.0)
                    .toDouble();
                return Column(
                  children: [
                    AppAnimations.fadeInUp(
                      key: const ValueKey('photo-guide-portrait'),
                      delay: const Duration(milliseconds: 90),
                      duration: const Duration(milliseconds: 450),
                      slideDistance: 16,
                      child: _PortraitFrame(height: portraitHeight),
                    ),
                    SizedBox(height: 12.h),
                    const Expanded(child: _PhotoTips()),
                    SizedBox(height: 10.h),
                    const _PrivacyNote(),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          AppAnimations.fadeInUp(
            key: const ValueKey('photo-guide-camera-button'),
            delay: const Duration(milliseconds: 250),
            duration: const Duration(milliseconds: 420),
            slideDistance: 14,
            child: AppButton(
              text: 'Open camera',
              showArrow: true,
              height: 46.h,
              onPressed: () => _showPickerNotice(context),
            ),
          ),
          SizedBox(height: 8.h),
          AppAnimations.fadeInUp(
            key: const ValueKey('photo-guide-gallery-button'),
            delay: const Duration(milliseconds: 330),
            duration: const Duration(milliseconds: 420),
            slideDistance: 14,
            child: SizedBox(
              width: double.infinity,
              height: 44.h,
              child: OutlinedButton(
                onPressed: () => _showPickerNotice(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimaryLight,
                  side: BorderSide(color: AppColors.cardBorderSelected),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Choose from photos',
                  style: GoogleFonts.poppins(fontSize: 12.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heading() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.playfairDisplay(
              fontSize: 27.sp,
              height: 1.08,
              color: AppColors.textPrimaryLight,
            ),
            children: [
              const TextSpan(text: 'One selfie.\nA more personal '),
              TextSpan(
                text: 'MuseAI.',
                style: GoogleFonts.playfairDisplay(
                  color: AppColors.accentRose,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          'A clear selfie helps us analyse your unique features\nand create personalised recommendations.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 10.sp,
            height: 1.35,
            color: AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  void _showPickerNotice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Camera and photo selection are not connected yet.'),
      ),
    );
  }
}

class _PortraitFrame extends StatelessWidget {
  final double height;

  const _PortraitFrame({required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.r),
      child: SizedBox(
        width: height * 0.78,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/Freckled Beauty Scan Portrait 1.png',
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  child: child,
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(13),
              child: CustomPaint(painter: _CornerGuidePainter()),
            ),
          ],
        ),
      ),
    );
  }
}

class _CornerGuidePainter extends CustomPainter {
  const _CornerGuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    const length = 23.0;
    const inset = 2.0;
    final corners = [
      (Offset(inset, inset), 1.0, 1.0),
      (Offset(size.width - inset, inset), -1.0, 1.0),
      (Offset(inset, size.height - inset), 1.0, -1.0),
      (Offset(size.width - inset, size.height - inset), -1.0, -1.0),
    ];
    for (final (origin, dx, dy) in corners) {
      final path = Path()
        ..moveTo(origin.dx + length * dx, origin.dy)
        ..lineTo(origin.dx, origin.dy)
        ..lineTo(origin.dx, origin.dy + length * dy);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CornerGuidePainter oldDelegate) => false;
}

class _PhotoTips extends StatelessWidget {
  const _PhotoTips();

  static const _tips = [
    (icon: Icons.wb_sunny_outlined, title: 'Face natural light'),
    (icon: Icons.face_retouching_natural, title: 'Keep your full face visible'),
    (icon: Icons.visibility_off_outlined, title: 'Remove sunglasses'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < _tips.length; index++) ...[
          if (index > 0)
            Container(
              width: 1,
              height: 68.h,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              color: AppColors.borderLight,
            ),
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 19.r,
                  backgroundColor: AppColors.accentRoseSoft,
                  child: Icon(
                    _tips[index].icon,
                    size: 19.r,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  _tips[index].title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 10.sp,
                    height: 1.1,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  index == 0
                      ? 'Best results in daylight.'
                      : index == 1
                      ? 'No hats or hair covering your face.'
                      : 'Show your natural features.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 7.5.sp,
                    height: 1.2,
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _PrivacyNote extends StatelessWidget {
  const _PrivacyNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: AppColors.accentRoseSoft,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lock_outline,
            size: 17.r,
            color: AppColors.accentRose,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Your selfie is only used to create your analysis and previews. You can delete it anytime.',
              style: GoogleFonts.poppins(
                fontSize: 8.5.sp,
                height: 1.3,
                color: AppColors.textPrimaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
