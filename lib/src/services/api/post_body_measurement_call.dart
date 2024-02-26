import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:revampedai/aaasrc/blocs/onboarding/onboarding_bloc.dart';
import 'package:revampedai/aaasrc/models/sizes_model.dart';

class PostBodyMeasurementCall {
  static Future<http.Response?> postMeasurement(
      {required String height, required String imageBase64}) async {
    // Define the request body
    Map<String, dynamic> requestBody = {
      'height': int.parse(height),
      'debug': 1,
      'image': imageBase64,
    };

    // Convert the request body to JSON
    String requestBodyJson = json.encode(requestBody);

    try {
      print("=================Measurment API");
      // Make the POST request
      final response = await http.post(
        Uri.parse('https://api.revamped.ai/bodymeasurement'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );

      // Check the response status
      if (response.statusCode == 200) {
        if (response.body == 'fail to find face') {
          print('Failed to post measurement. Error: fail to find face');
          return null;
        } else if (response.body == 'list index out of range') {
          print('Failed to post measurement. Error: list index out of range');
          return null;
        } else {
          print('Measurement posted successfully');
          return response;
        }
      } else {
        // Request failed
        print(
            'Failed to post measurement. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error occurred during the request: $e');
    }
    return null;
  }
}
