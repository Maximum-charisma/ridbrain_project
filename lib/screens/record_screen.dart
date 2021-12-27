import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/services/extentions.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/objects.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';

class RecordScreen extends StatefulWidget {
  RecordScreen({Key? key, required this.record}) : super(key: key);

  final Record record;
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DriverProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Заявка',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              child: Material(
                child: InkWell(
                  onTap: () async {
                    var status = RecordStatus(
                      status: StatusRecord.two,
                      date: DateTime.now().secondsSinceEpoch(),
                    );
                    var history = widget.record.recordHistory;
                    history.add(status);

                    var result = await Network(context).confirmRecord(
                        provider.driver.driverToken,
                        widget.record.recordId.toString(),
                        jsonEncode(provider.driver),
                        jsonEncode(history));
                  },
                  child: Text('Отправить'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
