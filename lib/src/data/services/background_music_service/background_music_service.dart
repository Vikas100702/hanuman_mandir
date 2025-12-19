import 'dart:convert';

import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/module/model/background_music/background_music_model.dart';
import 'package:http/http.dart' as http;

class BackgroundMusicService {
  Future<BackgroundMusicModel> fetchBackgroundMusicServiceData() async {
    try {
      final Uri url = Uri.parse(Endpoints.baseUrl);

      final Map<String, dynamic> requestBody = {
        "componentConfig": {
          "moduleName": "Background Music",
          "aspectType": "backgroundMusic",
          "query": {"aspectType": "backgroundMusic", "status": "ACTIVE"},
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

        return BackgroundMusicModel.fromJson(jsonResponse);
      } else {
        throw Exception(
          "Error: Failed to load background music. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Exception in FBackground Music: $e");
    }
  }
}
