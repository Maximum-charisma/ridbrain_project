import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/record_cell.dart';
import 'package:ridbrain_project/services/constants.dart';
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
    setState(() {
      _records = result;
    });
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
                var record = _records[index];
                return RecordCell(record: record, onTap: () {});
              },
              childCount: _records.length,
            ),
          ),
        ],
      ),
    );
  }
}
