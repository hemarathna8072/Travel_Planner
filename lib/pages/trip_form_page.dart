import 'package:flutter/material.dart';
import '../models/trip.dart';

class TripFormPage extends StatefulWidget {
  @override
  _TripFormPageState createState() => _TripFormPageState();
}

class _TripFormPageState extends State<TripFormPage>
    with SingleTickerProviderStateMixin {
  final _titleController = TextEditingController();
  final _destinationNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 7));

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _slideAnimation =
        Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _destinationNameController.dispose();
    _descriptionController.dispose();
    _costController.dispose();
    super.dispose();
  }

  void _submitTrip() {
    String title = _titleController.text;
    String destName = _destinationNameController.text;
    String description = _descriptionController.text;
    double cost = double.tryParse(_costController.text) ?? 0.0;

    Trip trip = Trip(
      title: title,
      startDate: startDate,
      endDate: endDate,
    );

    Destination destination = Destination(
      name: destName,
      description: description,
      cost: cost,
    );

    trip.addDestination(destination);

    Navigator.pushNamed(context, '/summary', arguments: trip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Trip Planner"),
        backgroundColor: Colors.teal.withOpacity(0.7),
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/fonts/image.png',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  width: 600, // Square shape width
                  height: 400, // Square shape height
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 4),
                      )
                    ],
                  ),
                  child: ListView(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: "Trip Title"),
                      ),
                      SizedBox(height: 20),
                      Text("Add Destination",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      TextField(
                        controller: _destinationNameController,
                        decoration:
                            InputDecoration(labelText: "Destination Name"),
                      ),
                      TextField(
                        controller: _descriptionController,
                        decoration:
                            InputDecoration(labelText: "Description"),
                      ),
                      TextField(
                        controller: _costController,
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(labelText: "Estimated Cost"),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        icon: Icon(Icons.add_location_alt_outlined),
                        label: Text("Add Destination"),
                        onPressed: _submitTrip,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Change button color
                          foregroundColor: Colors.teal, // Text color
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
