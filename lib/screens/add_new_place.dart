import 'dart:io';

import '../models/place.dart';
import '../providers/places_provider.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlaceScreen extends ConsumerStatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  ConsumerState<AddNewPlaceScreen> createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends ConsumerState<AddNewPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  void _savePlace() {
    final enteredText = _titleController.text;
    if (enteredText.trim().isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }
    ref
        .read(placesListProvider.notifier)
        .addNewPlace(enteredText, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  const SizedBox(height: 16),
                  ImageInput(
                    onSelectImage: (image) {
                      _selectedImage = image;
                    },
                  ),
                  const SizedBox(height: 16),
                  LocationInput(
                    onSelectLocation: (location) {
                      _selectedLocation = location;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: _savePlace,
                    label: const Text('Add Place'),
                  )
                ],
              ))),
    );
  }
}
