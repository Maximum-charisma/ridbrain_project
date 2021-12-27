import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/record_cell.dart';
import 'package:ridbrain_project/screens/record_screen.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/objects.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';

class AcceptOrdersScreen extends StatefulWidget {
  const AcceptOrdersScreen({Key? key}) : super(key: key);

  @override
  _AcceptOrdersScreenState createState() => _AcceptOrdersScreenState();
}

class _AcceptOrdersScreenState extends State<AcceptOrdersScreen> {
  List<Record> _records = [];

  void _updateList(String token) async {
    var result = await Network.getActiveRecords(token);
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
        print("object");
        setState(() {
          _records[index] = record;
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
                'Принятые заявки',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return RecordCell(
                  record: _records[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordScreen(
                          record: _records[index],
                          update: _updateRecord,
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: _records.length,
            ),
          ),
        ],
      ),
    );
  }
}
