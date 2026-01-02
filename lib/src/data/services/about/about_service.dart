import 'package:hanuman_mandir/src/module/model/about/about_model.dart';

class AboutService {
  Future<AboutModel?> fetchAboutServiceData() async {
    try {
      // STATIC JSON RESPONSE
      final Map<String, dynamic> response = {
        "statusCode": "201",
        "message": "Success",
        "data": [
          {
            "title": "About Sri Hanuman Mandir",
            "description": "March 29, 2010 was a special day for Hanuman devotees of Atlanta as the Hanuman Temple, Alpharetta came in to existence with the grace of God amidst customary deity installation rituals of Sri Bhakthanjaneya Swamy Pratishta mahotsavam. The Hanuman Prana Pratishta was performed on this day by Sri Satyanarayanacharyulu Dittakavi and Srimannarayana Puranam.\n\nShri Seshavatharam Puranam Garu was founder priest of the temple. Since its inception 15 years ago, there have been many blessings and miracles in every penny, devotee and puja performed. When the temple doors opened for first time, made an announcement as whoever makes a donation of \$1000 and above will be made a trustee of the temple. The response was overwhelming.\n\nOver 20 people came forward, including some priests from other temples that helped financially during initial days. With the grace of God, temple was able to repay all loans in a timely fashion. With the financial support of trustees, temple quickly surpass the break-even point.",
            "imageUrl": "assets/images/jai_sri_ram.jpg"
          },

          // 2. About Founder Section
          {
            "title": "About Temple Founder",
            "description": "March 29, 2010 was a special day for Hanuman devotees of Atlanta as the Hanuman Temple, Alpharetta came in to existence with the grace of God amidst customary deity installation rituals of Sri Bhakthanjaneya Swamy Pratishta mahotsavam. The Hanuman Prana Pratishta was performed on this day by Sri Satyanarayanacharyulu Dittakavi and Srimannarayana Puranam.\n\nShri Seshavatharam Puranam Garu was founder priest of the temple. Since its inception 15 years ago, there have been many blessings and miracles in every penny, devotee and puja performed.",
            "imageUrl": "assets/images/founder_of_sri_hanuman_temple.jpg"
          }
        ]
      };

      return AboutModel.fromJson(response);
    } catch (e) {
      throw Exception("Exception in About Service: $e");
    }
  }
}