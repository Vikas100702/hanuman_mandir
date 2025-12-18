import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/module/model/banner/banner_model.dart';

class BannerService {
  Future<BannerModel?> fetchBannerServiceData() async {
    try {
      final Uri url = Uri.parse(Endpoints.baseUrl);

      final Map<String, dynamic> requestBody = {
        "componentConfig": {
          "moduleName": "Header Settings",
          "aspectType": "headerSettings",
          "query": {"aspectType": "headerSettings"},
          "productID": "62c807133d9ee4045ab78d4d",
          "clientID": "636109798c12b64690508d12",
          "skip": 0,
          "next": 1220,
        },
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        return BannerModel.fromJson(jsonResponse);
      } else {
        throw Exception(
          "Error: Failed to load header settings. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Exception in Header Settings: $e");
    }
  }
}
