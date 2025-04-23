// lib/models/trip.dart

class Destination {
  String name;
  String description;
  double cost;

  Destination({
    required this.name,
    required this.description,
    required this.cost,
  });

  @override
  String toString() {
    return '$name: $description - \$$cost';
  }
}

class Trip {
  String title;
  DateTime startDate;
  DateTime endDate;
  List<Destination> destinations = [];

  Trip({
    required this.title,
    required this.startDate,
    required this.endDate,
  });

  double get totalCost {
    double total = 0;
    for (var dest in destinations) {
      total += dest.cost;
    }
    return total;
  }

  void addDestination(Destination destination) {
    destinations.add(destination);
  }

  void showTripSummary() {
    print("Trip: $title");
    print("From: $startDate to $endDate");
    print("Destinations:");
    for (var dest in destinations) {
      print(dest);
    }
    print("Total Cost: \$${totalCost.toStringAsFixed(2)}");
  }
}
