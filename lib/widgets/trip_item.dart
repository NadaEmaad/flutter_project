import 'package:flutter/material.dart';
import 'package:travell_app/screens/trip_detail_screen.dart';
import '../models/trip.dart';

class TripItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final TripType tripType;
  final Season season;
  // final Function removeItem;

  const TripItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.tripType,
    required this.season,
    // @required this.removeItem,
  });

  String get seasonText {
    switch (season) {
      case Season.winter:
        return 'شتاء';
      case Season.spring:
        return 'ربيع';
      case Season.summer:
        return 'صيف';
      case Season.autumn:
        return 'خريف';
      default:
        return 'غير معروف';
    }
  }

  String get tripTypeText {
    switch (tripType) {
      case TripType.exploration:
        return 'استكشاف';
      case TripType.recovery:
        return 'نقاهة';
      case TripType.activities:
        return 'انشطة';
      case TripType.therapy:
        return 'معالجة';
      default:
        return 'غير معروف';
    }
  }

  void selectTrip(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
          TripDetailScreen.screenRoute,
          arguments: id,
        )
        .then((value) => print(
            value)); /* 
        .then((result) {
      if (result != null) {
        removeItem(result);
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectTrip(context),
      splashColor: Theme.of(context).backgroundColor,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 250,
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: const [0.6, 1],
                    ),
                  ),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextIcon(
                    tripTypeText: '$duration أيام',
                    icon: Icons.today,
                  ),
                  TextIcon(
                    tripTypeText: seasonText,
                    icon: Icons.wb_sunny,
                  ),
                  TextIcon(
                    tripTypeText: tripTypeText,
                    icon: Icons.family_restroom,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextIcon extends StatelessWidget {
  const TextIcon({
    Key? key,
    required this.tripTypeText,
    required this.icon,
  }) : super(key: key);

  final String tripTypeText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(tripTypeText),
      ],
    );
  }
}
