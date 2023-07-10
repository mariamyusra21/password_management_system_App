import 'package:flutter/material.dart';
import 'package:pms_password_storage/record_operations.dart';

import 'data_storage.dart';
import 'storage_items.dart';

class ItemCard extends StatefulWidget {
  StorageItem item;

  ItemCard({required this.item, Key? key}) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _visibility = false;
  StorageService storageService = StorageService();
  //TODO: Initialize the StorageService instance

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          tileColor: Colors.grey,
          onLongPress: () {
            setState(() {
              _visibility = !_visibility;
            });
          },
          title: Text(
            widget.item.email_id.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          subtitle: Visibility(
              visible: _visibility,
              child: Text(
                widget.item.password.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
          trailing: Wrap(
            spacing: 10,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final String updatedValue = await showDialog(
                      context: context,
                      builder: (_) => EditRecord(item: widget.item));
                  if (updatedValue.isNotEmpty) {
                    // 2
                    storageService
                        .writeSecureData(
                            StorageItem(widget.item.email_id, updatedValue))
                        .then((value) {
                      // 3
                      widget.item =
                          StorageItem(widget.item.email_id, updatedValue);
                      setState(() {});
                    });
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await storageService.deleteSecureData(widget.item);
                },
              ),
            ],
          ),
        ));
  }
}
