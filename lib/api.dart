import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_ap/key.dart';
import 'package:weather_ap/model/weather_model.dart';

class Weather_Api {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<ApiResponse> getCurrentWeather(String location) async {
    // if (location.isEmpty) {
    //   throw ArgumentError("Location cannot be empty.");
    // }

    final String apiUrl = "$baseUrl?key=$apikey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('location') && data.containsKey('current')) {
          return ApiResponse.fromJson(data);
        } else {
          throw Exception("Invalid data structure in API response.");
        }
      } else if (response.statusCode == 404) {
        throw Exception("Location not found.");
      } else if (response.statusCode == 401) {
        throw Exception("Invalid API key.");
      } else if (response.statusCode == 500) {
        throw Exception("Internal server error. Please try again later.");
      } else {
        throw Exception("Failed to load weather data: ${response.reasonPhrase}");
      }
    } on http.ClientException catch (e) {
      throw Exception("Network error: $e");
    } on FormatException catch (e) {
      throw Exception("Data parsing error: $e");
    } catch (e) {
      throw Exception("Oops, something went wrong: $e");
    }
  }
}
