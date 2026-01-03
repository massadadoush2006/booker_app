import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddApartmentScreen extends StatelessWidget {
  const AddApartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Apartment'),
        centerTitle: true,
        automaticallyImplyLeading: false,  
      ),
      body: const Center(
        child: Text('Add Apartment Screen (Placeholder)'),
      ),
    );
  }
}