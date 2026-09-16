import 'package:flutter/material.dart';
import 'event_details_page.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

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

class _CreateEventPageState extends State<CreateEventPage> {

  //Flutter klass som används för att kontrollera input från formulär
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final notesController = TextEditingController();
  final categoryController = TextEditingController();

  // ? betyder att datum och kategori kan vara null
  DateTime? selectedDate;
  String? selectedCategory;

  //när sidan inte används -> städa bort controllers för att frigöra resurser
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    notesController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpNext',
          style: TextStyle(
            fontSize: 24,
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

              const Text(
                'Create new event',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // Title
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter event name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              // Category
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Music',
                    child: Text('Music'),
                  ),
                  DropdownMenuItem(
                    value: 'Sport',
                    child: Text('Sport'),
                  ),
                  DropdownMenuItem(
                    value: 'Celebration',
                    child: Text('Celebration'),
                  ),
                  DropdownMenuItem(
                    value: 'Travel',
                    child: Text('Travel'),
                  ),
                  DropdownMenuItem(
                    value: 'Other',
                    child: Text('Other'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),

              if (selectedCategory != null)
                Image.asset(
                  getCategoryImage(selectedCategory),
                  height: 150,
                ),

              const SizedBox(height: 16),

              // Date
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Select a date',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: selectDate,
                  ),
                ),
                controller: TextEditingController(
                  text: selectedDate == null
                      ? ''
                      : '${selectedDate!.day}/${selectedDate!
                      .month}/${selectedDate!.year}',
                ),
              ),

              const SizedBox(height: 16),

              // Location
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'Enter location',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              // Notes
              TextFormField(
                controller: notesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Add some notes...',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 24),

              // Create button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isEmpty) {
                      return;
                    }

                    final newEvent = Event(
                      title: titleController.text,
                      date: selectedDate,
                      location: locationController.text,
                      notes: notesController.text,
                      category: selectedCategory,
                    );

                    Navigator.pop(context, newEvent);
                  }, style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFA479E2)),
                    foregroundColor: WidgetStatePropertyAll<Color>(
                      Colors.black,
                  ),
                ),
                  child: const Text('Create event',
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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