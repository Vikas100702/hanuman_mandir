import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/module/model/todays_panchangam/temple_schedule/temple_schedule_model.dart';

class TempleScheduleService {
  Future<TempleScheduleModel?> fetchTempleScheduleServiceData() async {
    try {
      final Uri url = Uri.parse(Endpoints.baseUrl);

      final Map<String, dynamic> requestBody = {
        "componentConfig": {
          "moduleName": "Daily Schedule",
          "aspectType": "dailySchedule",
          "query": {"aspectType": "dailySchedule", "status": "ACTIVE"},
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

      if(response.statusCode== 201) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        return TempleScheduleModel.fromJson(jsonResponse);
      } else {
        throw Exception(
          "Error: Failed to load Temple Schedule. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Exception in Temple Schedule Model: $e");
    }
  }
}
