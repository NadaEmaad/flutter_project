import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../widgets/trip_item.dart';

class CategoryTripsScreen extends StatefulWidget {
  static const screenRoute = '/categroy-trips';

  final List<Trip> availableTrips;

  const CategoryTripsScreen(this.availableTrips, {super.key});

  @override
  CategoryTripsScreenState createState() => CategoryTripsScreenState();
}

class CategoryTripsScreenState extends State<CategoryTripsScreen> {
  late String categoryTitle;
  late List<Trip> displayTrips;

  @override
  void initState() {
    //...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgument =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArgument['id'];
    categoryTitle = routeArgument['title']!;
    displayTrips = widget.availableTrips.where((trip) {
      return trip.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeTrip(String tripId) {
    setState(() {
      displayTrips.removeWhere((trip) => trip.id == tripId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return TripItem(
            id: displayTrips[index].id,
            title: displayTrips[index].title,
            imageUrl: displayTrips[index].imageUrl,
            duration: displayTrips[index].duration,
            tripType: displayTrips[index].tripType,
            season: displayTrips[index].season,
            // removeItem: _removeTrip,
          );
        },
        itemCount: displayTrips.length,
      ),
    );
  }
}
