import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView(
      {super.key,
      this.items = const [
        Clothing(
          name: 'T-Shirt',
          photoUrl: 'assets/images/tshirt.webp',
          description: 'A comfortable cotton t-shirt in various colors.',
          price: 19.99,
        ),
        Clothing(
          name: 'Jeans',
          photoUrl: 'assets/images/jeans.jpeg',
          description: 'Classic denim jeans with a slim fit.',
          price: 49.99,
        ),
        Clothing(
          name: 'Sneakers',
          photoUrl: 'assets/images/sneakers.jpeg',
          description: 'Stylish sneakers for casual wear.',
          price: 59.99,
        ),
        Clothing(
          name: 'Jacket',
          photoUrl: 'assets/images/jacket.webp',
          description: 'A warm, lightweight jacket for cooler days.',
          price: 79.99,
        ),
        Clothing(
          name: 'Cap',
          photoUrl: 'assets/images/cap.jpg',
          description: 'A trendy cap to complete your outfit.',
          price: 14.99,
        ),
      ]});

  static const routeName = '/';

  final List<Clothing> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('211047'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
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
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text(item.name),
              leading: const CircleAvatar(
                // Display the Flutter Logo image asset.
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SampleItemDetailsView(item: item),
                  ),
                );
              });
        },
      ),
    );
  }
}
