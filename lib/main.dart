import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import 'data_storage.dart';
import 'item_card.dart';
import 'record_operations.dart';
import 'storage_items.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<StorageItem> _items;
  final StorageService _dataStorageService = StorageService();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    initizeList();
    // _loadCSV();
  }

  void initizeList() async {
    _items = await _dataStorageService.readAllSecureData();
    _loading = false;
    setState(() {});
  }

  void _loadCSV() async {
    final rawData = ("assets/test.csv");
    List<List> listData = const CsvToListConverter().convert(_items as String?);
    setState(() {
      _items = listData.cast<StorageItem>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 67, 80, 165),
        title: Text(
          "Custom Password Manager",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : _items.isEmpty
                ? const Text(
                    "Add data in secure storage to display here.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                : ListView.builder(
                    itemCount: _items.length,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (context, index) {
                      return ItemCard(item: _items[index]);
                    }),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
          ),
          ElevatedButton(
              onPressed: () {
                // String csv = const ListToCsvConverter()
                //     .convert(_items.cast<List?>().toList());
                // _loadCSV();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 67, 80, 165),
                  fixedSize: Size(140, 40)),
              child: Text(
                'Backup',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )),
          SizedBox(
            width: 140,
          ),
          FloatingActionButton(
            onPressed: () async {
              final StorageItem? newItem = await showDialog(
                  context: context, builder: (_) => AddRecord());

              if (newItem != null) {
                _dataStorageService.writeSecureData(newItem).then((value) {
                  setState(() {
                    _loading = true;
                  });
                });

                initizeList();
              }
            },
            backgroundColor: Color.fromARGB(255, 67, 80, 165),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
