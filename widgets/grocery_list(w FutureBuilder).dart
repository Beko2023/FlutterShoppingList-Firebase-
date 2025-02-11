// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shopping_list_app/data/categories.dart';
// import 'package:shopping_list_app/models/grocery_item.dart';
// import 'package:shopping_list_app/widgets/new_item.dart';
// import 'package:http/http.dart' as http;

// class GroceryList extends StatefulWidget {
//   const GroceryList({super.key});

//   @override
//   State<GroceryList> createState() => _GroceryListState();
// }

// class _GroceryListState extends State<GroceryList> {
//   List<GroceryItem> _groceryItems = [];
//   late Future<List<GroceryItem>> _loadedItems;
//   String? _error;
//   @override
//   void initState() {
//     super.initState();
//     _loadedItems = _loadItems();
//   }

//   void _removeItem(GroceryItem item) async {
//     final index = _groceryItems.indexOf(item);
//     setState(() {
//       _groceryItems.remove(item);
//     });
//     final url = Uri.https(
//         "flutterexpensetracker-7112b-default-rtdb.europe-west1.firebasedatabase.app",
//         'shopping-list/${item.id}.json');
//     final response = await http.delete(url);
//     if (response.statusCode >= 400) {
//       setState(() {
//         _groceryItems.insert(index, item);
//       });
//     }
//   }

//   Future<List<GroceryItem>> _loadItems() async {
//     final url = Uri.https(
//         "flutterexpensetracker-7112b-default-rtdb.europe-west1.firebasedatabase.app",
//         'shopping-list.json');

//     final response = await http.get(url);
//     if (response.statusCode >= 400) {
//       throw Exception('Failed to fetch grocery items. Please try again later.');
//     }

//     if (response.body == 'null') {
//       return [];
//     }

//     final Map<String, dynamic> listData = json.decode(response.body);
//     final List<GroceryItem> loadedItems = [];

//     for (final item in listData.entries) {
//       final category = categories.entries
//           .firstWhere(
//               (catItem) => catItem.value.title == item.value['category'])
//           .value;
//       loadedItems.add(
//         GroceryItem(
//           id: item.key,
//           name: item.value['name'],
//           quantity: item.value['quantity'],
//           category:
//               category, //instead of just the title which we passed w the post method, we need the category object back, hence going through the trouble of using the firstWhere method to pass in the Category object in GroceryItem.
//         ),
//       );
//     }
//     return loadedItems;
//   }

//   void _addItem() async {
//     final newItem = await Navigator.of(context).push<GroceryItem>(
//       MaterialPageRoute(
//         builder: (ctx) => const NewItem(),
//       ),
//     );

//     if (newItem == null) {
//       return;
//     }

//     setState(() {
//       _groceryItems.add(newItem);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Your Groceries"), actions: [
//         IconButton(onPressed: _addItem, icon: const Icon(Icons.add)),
//       ]),
//       body: FutureBuilder(
//         future: _loadedItems,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 snapshot.error.toString(),
//               ),
//             );
//           }
//           if (snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text("No Items Available",
//                   style: TextStyle(
//                     fontSize: 20,
//                   )),
//             );
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) => Dismissible(
//               key: ValueKey(snapshot.data![index]),
//               onDismissed: (direction) {
//                 _removeItem(snapshot.data![index]);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Item removed")));
//               },
//               child: ListTile(
//                 title: Text(snapshot.data![index].name),
//                 leading: Container(
//                     width: 24,
//                     height: 24,
//                     color: snapshot.data![index].category.color),
//                 trailing: Text(
//                   snapshot.data![index].quantity.toString(),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
