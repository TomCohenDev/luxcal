import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:revampedai/aaasrc/blocs/onboarding/onboarding_bloc.dart';
import 'package:revampedai/aaasrc/models/sizes_model.dart';

class PostOutfitSuggestionCall {
  static Future<http.Response?> postMeasurement({
    required int num_outfits,
    required String occasion,
    required String face_image_base64,
    required String top_size,
    required String bottom_size,
    required String skin_color,
  }) async {
    // Define the request body
    Map<String, dynamic> requestBody = {
      "num_outfits": num_outfits,
      "occasion": occasion,
      "access_key": "f413d0cc-f0c1-475f-b5bc-a4e2f8",
      "secret_key": "16763712291",
      "top_size": top_size,
      "bottom_size": bottom_size,
      "skin_color": skin_color,
      "face_image": face_image_base64
    };

    // Convert the request body to JSON
    String requestBodyJson = json.encode(requestBody);

    try {
      print("=================Get Outfit Suggestions API");
      // Make the POST request
      final response = await http.post(
        Uri.parse('https://be.revamped.ai/api/get-outfit'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );

      // Check the response status
      if (response.statusCode == 200) {
        if (response.body == 'fail to find face') {
          print('Failed to get outfits. Error: fail to find face');
          return null;
        } else if (response.body == 'list index out of range') {
          print('Failed to get outfits. Error: list index out of range');
          return null;
        } else {
          print('get outfits posted successfully');
          return response;
        }
      } else {
        // Request failed
        print('Failed to get outfits. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error occurred during the request: $e');
    }
    return null;
  }
}
