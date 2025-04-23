import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'package:intl/intl.dart';

class TripSummaryPage extends StatelessWidget {
  const TripSummaryPage({super.key});

  String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final trip = ModalRoute.of(context)!.settings.arguments as Trip;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Summary'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(
            icon: Icons.card_travel,
            title: 'Trip Title',
            content: trip.title,
          ),
          _buildCard(
            icon: Icons.calendar_month,
            title: 'Dates',
            content: '${formatDate(trip.startDate)} - ${formatDate(trip.endDate)}',
          ),
          _buildCard(
            icon: Icons.attach_money,
            title: 'Total Cost',
            content: '\$${trip.totalCost.toStringAsFixed(2)}',
            contentColor: Colors.teal,
          ),
          _buildCard(
            icon: Icons.location_on,
            title: 'Destinations',
            contentWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: trip.destinations.map((d) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.place, size: 16, color: Colors.teal),
                    const SizedBox(width: 6),
                    Text(d.name, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    String? content,
    Color? contentColor,
    Widget? contentWidget,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.teal, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                  const SizedBox(height: 8),
                  contentWidget ??
                      Text(
                        content ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: contentColor ?? Colors.black,
                        ),
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
