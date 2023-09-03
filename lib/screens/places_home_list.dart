
import '../providers/places_provider.dart';
import 'add_new_place.dart';
import '../widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesHomeListScreen extends ConsumerStatefulWidget {
  const PlacesHomeListScreen({super.key});

  @override
  ConsumerState<PlacesHomeListScreen> createState() =>
      _PlacesHomeListScreenState();
}

class _PlacesHomeListScreenState extends ConsumerState<PlacesHomeListScreen> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placesListProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(placesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const AddNewPlaceScreen())));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: FutureBuilder(
                future: _placesFuture,
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PlacesList(places: userPlaces),
              ))),
    );
  }
}
