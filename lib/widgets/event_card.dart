import 'package:flutter/material.dart';
import '../models/event.dart';
import '../pages/event_details_page.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final String? category;
  final VoidCallback? onTap;

  const EventCard({
    super.key,
    required this.event,
    this.category,
    this.onTap,
    //required Future<Null> Function() onTap,
  });

  String getCategoryImage(String? category) {
    switch (category) {
      case 'Music':
        return 'assets/images/music.jpg';
      case 'Sport':
        return 'assets/images/sport.jpg';
      case 'Celebration':
        return 'assets/images/celebration.jpg';
      case 'Travel':
        return 'assets/images/travel.jpg';
      case 'Other':
        return 'assets/images/default.jpg';
      default:
        return 'assets/images/default.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            getCategoryImage(event.category),
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),

          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                event.date == null ? 'No date selected'
                  : '${DateTime(
                      event.date!.year,
                      event.date!.month,
                      event.date!.day,
                    ).difference(
                      DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                      ),
                  ).inDays} days left',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}