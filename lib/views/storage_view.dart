import 'package:flutter/material.dart';
import 'dart:developer' as Logger show log; // Use Logger.log() instead of print()

class StorageView extends StatefulWidget {
  const StorageView({super.key});

  @override
  State<StorageView> createState() => _StorageViewState();
}

class _StorageViewState extends State<StorageView> {
  var _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Favourites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Placeholder(),//Image.asset('path_to_image'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: IconButton(
                          icon: Icon(_isFavourite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined),
                          onPressed: () {
                            setState(() {
                              _isFavourite = !_isFavourite;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Add button functionality here
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: IconButton(
                          icon: const Icon(Icons.move_down),
                          onPressed: () {
                            // Add button functionality here
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    Logger.log('TODO: Go to the parent view');
                  },
                  child: Text('Parent'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'TODO: storage details',
                  style: TextStyle(fontSize: 24),
                ),
                const Row(
                  children: [
                    Text('Storages',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        )),
                  ],
                ),
                const Row(
                  children: [
                    Text('Items',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
