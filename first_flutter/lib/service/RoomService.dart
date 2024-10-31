import 'dart:convert';

import 'package:test_flutter/model/hotel.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/model/room.dart';

class RoomService {

  Future<Hotel> fetchHotelById(int hotelId) async {

    final String url = 'http://localhost:8080/api/hotel/$hotelId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return Hotel.fromJson(data);
    } else {
      throw Exception('Failed to load hotel data');
    }
  }

  Future<List<Room>> fetchRoomByHotelId(int hotelId) async {

    final String url = 'http://localhost:8080/api/room/r/searchroombyid?hotelid=$hotelId';
    
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      if (data is List) {
        return data.map((room) => Room.fromJson(room as Map<String, dynamic>)).toList();
      } else if (data is Map) {
        return [Room.fromJson(data as Map<String, dynamic>)];
      } else {
        throw Exception('unexpected data format');
      }
    } else {
      throw Exception('Failed to load room data: ${response.statusCode}');
    }
  }

}