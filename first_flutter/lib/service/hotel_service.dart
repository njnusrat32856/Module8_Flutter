import 'dart:convert';

import 'package:test_flutter/model/hotel.dart';
import 'package:http/http.dart' as http;

class HotelService {

  final String apiUrl = 'http://localhost:8080/api/hotel/';

  Future<List<Hotel>> fetchHotels() async {

    final response = await http.get(Uri.parse(apiUrl));

    print(response.statusCode);

    if (response.statusCode == 200 ) {
      final List<dynamic> hotelJson = json.decode(response.body);

      return hotelJson.map((json) => Hotel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hotels');
    }

  }
}