
import 'package:flutter/material.dart';
import 'package:test_flutter/model/hotel.dart';
import 'package:test_flutter/page/room_details_page.dart';
import 'package:test_flutter/service/hotel_service.dart';

class AllHotelViewPage extends StatefulWidget {
  const AllHotelViewPage({super.key});

  @override
  State<AllHotelViewPage> createState() => _AllHotelViewPageState();
}

class _AllHotelViewPageState extends State<AllHotelViewPage> {

  late  Future<List<Hotel>> futureHotels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureHotels = HotelService().fetchHotels();
    print(futureHotels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Hotel>>(
        future: futureHotels,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'),);
          } else if (snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Hotels Available'),);
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final hotel = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: hotel.image != null
                              ? Image.network("http://localhost:8080/images/hotel/${hotel.image}")
                              : Icon(Icons.hotel),
                          title: Text(hotel.name ?? 'Unnamed Hotel'),
                          subtitle: Text(hotel.address ?? 'No Address Available'),
                          trailing: Text('${hotel.minPrice} - ${hotel.maxPrice}'),
                        ),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (hotel.id != null) {
                                    Navigator.push(
                                      context,
                                    MaterialPageRoute(
                                        builder: (context) => RoomDetailsPage(hotel: hotel)
                                    ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Hotel Id is missing. Cannot load rooms')),
                                    );
                                  }
                                  print('Book Now Clicked For Hotel: ${hotel.name}');
                                },
                                child: Text('View Room'),
                              style: ElevatedButton.styleFrom(),
                            ),
                        )
                      ],
                    ),
                  );
                }
            );
          }
        },
      ),
    );
  }
}
