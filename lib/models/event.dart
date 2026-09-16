class Event {
  final String title;
  final DateTime? date;
  final String location;
  final String notes;
  final String? category;

  Event({
    required this.title,
    required this.date,
    required this.location,
    required this.notes,
    required this.category,
  });
}