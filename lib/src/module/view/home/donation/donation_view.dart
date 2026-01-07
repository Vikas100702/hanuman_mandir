import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';

class DonationView extends StatelessWidget {
  const DonationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveHeight(30, 50),
        horizontal: context.responsiveWidth(40, 60),
      ),
      child: Center(
        child: Row(
          children: [
            Image.asset("assets/images/bg-hanuman-ji.png"),
            const SizedBox(width: 180),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jai Shri Ram! Jai Hanuman!",
                  style: GoogleFonts.breeSerif(
                    color: const Color(0xFFFBBA76),
                    fontSize: context.responsiveSize(20, 28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Sri Hanuman Mandir\nTemple Improvements Project",
                  style: GoogleFonts.breeSerif(
                    color: AppColors.white,
                    fontSize: context.responsiveSize(20, 28),
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveWidth(25, 40),
                      vertical: context.responsiveHeight(18, 25),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // foregroundColor: Color(0xFFFBBA76),
                    backgroundColor: const Color(0xFFFBBA76),
                  ),
                  child: Text(
                    "DONATE",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.breeSerif(
                      color: AppColors.black,
                      fontSize: context.responsiveSize(15, 20),
                    ),
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
