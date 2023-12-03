import 'package:flutter/material.dart';

import 'house.dart';
import 'floors_list_page.dart';

/// Displays a list of Houses.
class HousesListPage extends StatelessWidget {
  const HousesListPage({
    super.key,
    this.items = const [
      House(1, 'first'),
      House(2, 'second'),
      House(3, 'third')
    ], //mock data
  });

  static const routeName = '/houses';

  final List<House> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () => {},
          child: const Text('Add house'),
        ),
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'housesListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text(item.name),
              leading: const Text('House'),
              onTap: () {
                // Navigate to the floors page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(
                  context,
                  FloorsListPage.routeName,
                );
              });
        },
      ),
    );
  }
}
