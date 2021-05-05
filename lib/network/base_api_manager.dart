import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

enum CovidCareEndpoints { savePatient, getPatients, markAsComplete }

extension CovidCareEpToString on CovidCareEndpoints {
  String get string {
    switch (this) {
      case CovidCareEndpoints.getPatients:
        return "/api/getPatients";
      case CovidCareEndpoints.savePatient:
        return "/api/savePatientDetails";
      case CovidCareEndpoints.markAsComplete:
        return "/api/patientAttended";
    }
  }
}

class BaseAPIManager {
  final String host = "indiacovidcare.wl.r.appspot.com";

  Future<http.Response> post(CovidCareEndpoints ep, Map<String, dynamic> body,
      Map<String, dynamic>? params) async {
    try {
      // final String url = baseUrl + ep.string;
      final Uri uri = Uri.https(host, ep.string, params);
      log('URL ${uri}');
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(body).toString());
      print('POST RESPONSE: ${response.statusCode} ${response.body}');
      return response;
    } catch (error) {
      return Future.error('HTTP POST REQUEST ERROR: $error');
    }
  }

  Future<http.Response> get(CovidCareEndpoints ep) async {
    try {
      final Uri uri = Uri.https(host, ep.string);
      final response = await http.get(uri);
      // print('GET RESPONSE: ${response.statusCode}  ${response.body}');
      if (response.statusCode != 200) {
        return Future.error('HTTP GET REQUST ERROR: $response');
      }
      return response;
    } catch (error) {
      return Future.error('HTTP GET REQUET ERROR: $error');
    }
  }
}
