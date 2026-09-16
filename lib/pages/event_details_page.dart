import 'package:flutter/material.dart';
import '../models/event.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;

  const EventDetailsPage({
    super.key,
    required this.event,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpNext',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA479E2),
          ),
        ),
      ),

      body: SingleChildScrollView(
          child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Image.asset(
              getCategoryImage(event.category),
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),

            Text(
              event.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              event.date == null
                  ? 'No date selected'
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
            ),

            const SizedBox(height: 12),

            Text(
              event.location.isEmpty
                  ? 'No location'
                  : event.location,
            ),

            const SizedBox(height: 12),

            Text(
              event.notes.isEmpty
                  ? 'No notes'
                  : event.notes,
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFA479E2)),
                foregroundColor: WidgetStatePropertyAll<Color>(
                  Colors.black,
                ),
                minimumSize: WidgetStatePropertyAll<Size>(
                  Size(0, 60),
                ),
              ),
              child: const Text('Delete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          ),
          ),
          ),
        ),
      ),
    );
  }
}