import 'package:flutter/material.dart';

import 'data_storage.dart';
import 'storage_items.dart';

class EditRecord extends StatefulWidget {
  StorageService storageService = StorageService();
  final StorageItem item;
  EditRecord({super.key, required this.item});

  @override
  State<EditRecord> createState() => _EditRecordState();
}

class _EditRecordState extends State<EditRecord> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(hintText: "Update Email"),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: "Update Password"),
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(_passwordController.text);
                    },
                    child: const Text('Update')))
          ],
        ),
      ),
    );
    ;
  }
}

class AddRecord extends StatelessWidget {
  AddRecord({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(hintText: 'Add Email/ID/Phone Number:'),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(hintText: 'Add Password:'),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  StorageItem item = StorageItem(
                      _emailController.text, _passwordController.text);
                  Navigator.of(context).pop(item);
                },
                child: const Text('Add')),
          )
        ],
      ),
    );
  }
}
