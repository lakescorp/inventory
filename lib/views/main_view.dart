import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:inventory/constants/routes.dart';
import 'package:inventory/views/storage_view.dart';
import 'package:inventory/views/user_settings.dart';
import 'dart:developer' as Logger show log; // Use Logger.log() instead of print()

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        clipBehavior: Clip.none, // Do not clip shadow
        scrolledUnderElevation: 0.0, // Do not change color on scroll
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                blurRadius: 10.0,
                spreadRadius: 1.0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Search for storages or items',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Favourites',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, favouritesRoute);
                    },
                    child: Text(
                      'See more...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 250,
                child: Center(child: Text('Nothing')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Places',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      )),
                  TextButton(
                    onPressed: () {
                      Logger.log('TODO: See more...');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StorageView()));
                    },
                    child: Text(
                      'See more...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 250,
                child: Center(child: Text('Nothing')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recently viewed',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      )),
                  TextButton(
                    onPressed: () {
                      Logger.log('TODO: See more...');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserSettingsView()));
                    },
                    child: Text(
                      'See more...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 250,
                child: Center(child: Text('Nothing')),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.category),
            label: 'Add an item',
            onTap: () {
              // Handle your logic here
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.storage),
            label: 'Add a storage',
            onTap: () {
              // Handle your logic here
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.place),
            label: 'Add a plcace',
            onTap: () {
              // Handle your logic here
            },
          ),
        ],
      ),
    );
  }
}
