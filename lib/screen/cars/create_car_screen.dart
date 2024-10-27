import 'package:flutter/material.dart';

class CreateCarScreen extends StatefulWidget {
  const CreateCarScreen({super.key});

  @override
  State<CreateCarScreen> createState() => _CreateCarScreenState();
}

class _CreateCarScreenState extends State<CreateCarScreen> {
  final _formKey = GlobalKey<FormState>();
  String _carName = '';
  String _carModel = '';
  double _carPrice = 0.0;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Car Name: $_carName');
      print('Car Model: $_carModel');
      print('Car Price: $_carPrice');
      

      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Car Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a car name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _carName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Car Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a car model';
                  }
                  return null;
                },
                onChanged: (value) {
                  _carModel = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Car Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a car price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onChanged: (value) {
                  _carPrice = double.tryParse(value) ?? 0.0;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Create Car'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}