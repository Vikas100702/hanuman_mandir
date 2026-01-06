import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';

class SpiritualLoader extends StatefulWidget {
  final double size;

  const SpiritualLoader({super.key, this.size = 80});

  @override
  State<SpiritualLoader> createState() => _SpiritualLoaderState();
}

class _SpiritualLoaderState extends State<SpiritualLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Stack(
          alignment: .center,
          children: [
            // Outer Glowing Aura (Rotating)
            RotationTransition(
              turns: _animationController,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      AppColors.primaryRed.withValues(alpha: 0.1),
                      AppColors.gold.withValues(alpha: 0.6),
                      AppColors.primaryRed.withValues(alpha: 0.1),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              width: widget.size * 1,
              height: widget.size * 1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Image.asset(
                "assets/images/left_header_logo.png",
                fit: .contain,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),

        Text(
          "Surrender to the Creator's will;\nthe most beautiful blessings takes time to unfold.",
          textAlign: .center,
          style: TextStyle(
            color: Colors.red,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
