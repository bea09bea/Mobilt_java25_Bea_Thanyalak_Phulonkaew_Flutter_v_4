import 'package:flutter/material.dart';
import '../models/event.dart';
import 'create_event_page.dart';
import 'event_details_page.dart';
import '../widgets/event_card.dart';

class HomePage extends StatefulWidget  {

  //konstruktor
  const HomePage({super.key});

  //Skapar homepage state
  //_homepagestate håller reda på data som kan förändras
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Event> events = [];

  //openCreateEvent() körs när crete new event knapp trycks
  //async väntar på användaren
  Future<void> openCreateEvent() async {

    //öppna CreateEventPage och vänta på tills sidan skicka tillbaka ett event från formuläret
    final newEvent = await Navigator.push<Event>(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateEventPage(),
      ),
    );

    //kolla om det skapades ett nytt event
    if (newEvent != null) {

      //lägger till datan från formuläret i listan -> events = []
      setState(() {
        events.add(newEvent);
      });
    }
  }

  //strukturen för innehållet i homepage
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

      body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //subtitel
            const Text(
              'Things to look forward to:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            //"content-container" med eventcard om det skapas
            Expanded(
              child: events.isEmpty
                  ? const Center(
                child: Text(
                  'No events yet',
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];

                  //hämta layout från widget/event_card
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: EventCard(
                      event: event,
                      onTap: () async {
                        final deleted = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailsPage(
                              event: event,
                            ),
                          ),
                        );

                        if (deleted == true) {
                          setState(() {
                            events.remove(event);
                          });
                      }
                    },
                    ),
                  );
                },
              ),
            ),

            // Visar att det finns mer innehåll text
            if (events.length > 1)
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    '↓ Scroll to see more',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            //Skapa ny event knapp
            ElevatedButton(
              onPressed: openCreateEvent,
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFA479E2)),
                foregroundColor: WidgetStatePropertyAll<Color>(
                  Colors.black,
                ),
                minimumSize: WidgetStatePropertyAll<Size>(
                  Size(0, 60),
                ),
              ),
              child: const Text('Create new event',
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
  );
  }
}