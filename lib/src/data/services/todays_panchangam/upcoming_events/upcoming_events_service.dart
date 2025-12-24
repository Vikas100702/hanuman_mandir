import 'dart:convert';

import 'package:hanuman_mandir/src/module/model/todays_panchangam/upcoming_events/upcoming_events_model.dart';
import 'package:http/http.dart' as http;
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';

class UpcomingEventsService {
  Future<UpcomingEventsModel?> fetchUpcomingEventsServiceData() async {
    try {
      final Uri url = Uri.parse(Endpoints.baseUrl);

      final Map<String, dynamic> requestBody = {
        "componentConfig": {
          "query": {
            "aspectType": "ServiceSetup",
            "serviceCategoryTypes": "EVENTS",
            "sourceTypes": "WEBSITE",
            "status": "ACTIVE",
            "\$expr": {
              "\$eq": ["\$parentService", ""],
            },
          },
          "moduleName": "Temple Services",
          "aspectType": "ServiceSetup",
          "collectionType": "Business",
          "productID": "62c807133d9ee4045ab78d4d",
          "clientID": "636109798c12b64690508d12",
          "skip": 0,
          "next": 1024,
        },
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if(response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        return UpcomingEventsModel.fromJson(jsonResponse);
      } else {
        throw Exception("ERROR: Failed to load Upcoming Events. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Exception in Upcoming Events Model: $e");
    }
  }
}
