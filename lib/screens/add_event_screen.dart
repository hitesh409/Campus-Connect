// screens/event_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_connect_app/providers/user_provider.dart';
import 'package:campus_connect_app/utils/util.dart'; // Import your utility functions
import 'package:cloud_firestore/cloud_firestore.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final TextEditingController _eventNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    final userRole = user?.userrole ?? 'DefaultRole';

    if (userRole != 'Faculty') {
      // User is not a faculty member, show an error message or navigate back
      showSnackBar('Only faculty members can access this screen.', context);

      // If you want to navigate back, you can use Navigator.pop(context);
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('You do not have permission to access this screen.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _eventNameController,
              decoration: InputDecoration(labelText: 'Event Name'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _submitEvent(context),
              child: Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitEvent(BuildContext context) async {
    final eventName = _eventNameController.text.trim();
    if (eventName.isEmpty) {
      // Show an error message or snackbar indicating empty event name
      showSnackBar('Event name cannot be empty.', context);
    } else {
      // Implement the logic to create the event
      // Assuming you have a FirestoreMethods class
      try {
        // await FirestoreMethods().createEvent(
        //   userId: user.uid,
        //   eventName: eventName,
        //   // Add other event details as needed
        // );

        // Show a success message
        showSnackBar('Event created successfully!', context);

        // Clear the text field after successful creation
        _eventNameController.clear();
      } catch (error) {
        // Handle errors (e.g., show an error message)
        showSnackBar('Error creating event: $error', context);
      }
    }
  }
}
