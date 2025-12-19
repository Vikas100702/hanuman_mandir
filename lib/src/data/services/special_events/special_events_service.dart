import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/module/model/special_events/special_events_model.dart';

class SpecialEventsService {
  Future<SpecialEventsModel?> fetchSpecialEventsServiceData() async {
    try {
      final Uri url = Uri.parse(Endpoints.baseUrl);

      final Map<String, dynamic> requestBody = {
        "componentConfig": {
          "moduleName": "Flash News",
          "aspectType": "flashNews",
          "query": {"aspectType": "flashNews", "status": "ACTIVE"},
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

      if(response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        return SpecialEventsModel.fromJson(jsonResponse);
      } else {
        throw Exception(
          "Error: Failed to load Special Events. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Exception in Special Events Model: $e");
    }
  }
}
