import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/record_cell.dart';
import 'package:ridbrain_project/screens/record_screen.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/objects.dart';

import '../services/prefs_handler.dart';

class NewOrdersScreen extends StatefulWidget {
  const NewOrdersScreen({Key? key}) : super(key: key);

  @override
  _NewOrdersScreenState createState() => _NewOrdersScreenState();
}

class _NewOrdersScreenState extends State<NewOrdersScreen> {
  List<Record> _records = [];

  void _updateList(String token) async {
    var result = await Network.getRecords(token);
    if (mounted) {
      setState(() {
        _records = result;
      });
    }
  }

  void _updateRecord(Record record) {
    var index = 0;
    for (var item in _records) {
      if (item.recordId == record.recordId) {
        setState(() {
          _records.removeAt(index);
        });
        break;
      }
      index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DriverProvider>(context);

    if (_records.isEmpty) {
      _updateList(provider.driver.driverToken);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 80,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Новые заявки',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var record = _records[index];
                return RecordCell(
                    record: record,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordScreen(
                              record: record,
                              update: _updateRecord,
                            ),
                          ));
                    });
              },
              childCount: _records.length,
            ),
          ),
        ],
      ),
    );
  }
}
