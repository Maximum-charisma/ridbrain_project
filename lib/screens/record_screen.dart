import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/services/convert_date.dart';
import 'package:ridbrain_project/services/extentions.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/objects.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({
    Key? key,
    required this.record,
    required this.update,
  }) : super(key: key);

  final Record record;
  final Function(Record record) update;

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late Record _record;

  void _confirmRecord(Driver driver) async {
    var status = RecordStatus(
      status: StatusRecord.two,
      date: DateTime.now().secondsSinceEpoch(),
    );
    var history = widget.record.recordHistory;
    history.add(status);

    var result = await Network(context).confirmRecord(
      driver.driverToken,
      widget.record.recordId.toString(),
      jsonEncode(driver),
      jsonEncode(history),
    );

    if (result) {
      setState(() {
        _record.recordHistory = history;
        _record.recordStatus = StatusRecord.two;
      });
      widget.update(_record);
    }
  }

  void _changeStatus(StatusRecord newStatus, String token) async {
    var status = RecordStatus(
      status: newStatus,
      date: DateTime.now().secondsSinceEpoch(),
    );
    var history = widget.record.recordHistory;
    history.add(status);

    var result = await Network.changeRecordStatus(
      token,
      _record.recordId.toString(),
      newStatus.name,
      jsonEncode(history),
    );

    if (result) {
      setState(() {
        _record.recordHistory = history;
        _record.recordStatus = newStatus;
      });
      widget.update(_record);
    }
  }

  Widget _button(String label, StatusRecord newStatus, String token) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ElevatedButton(
        child: Text(label),
        onPressed: () => _changeStatus(newStatus, token),
      ),
    );
  }

  Widget _getButton(Driver driver) {
    switch (widget.record.recordStatus) {
      case StatusRecord.one:
        return Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            child: const Text("Принять заявку"),
            onPressed: () => _confirmRecord(driver),
          ),
        );
      case StatusRecord.two:
        return _button("На загрузке", StatusRecord.three, driver.driverToken);
      case StatusRecord.three:
        return _button("На выгрузке", StatusRecord.four, driver.driverToken);
      case StatusRecord.four:
        return _button("Выполнена", StatusRecord.five, driver.driverToken);
      case StatusRecord.five:
        return const SizedBox.shrink();
      case StatusRecord.six:
        return const SizedBox.shrink();
    }
  }

  void _openMap(BuildContext context, double latitude, double longitude) async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      await launch(
        "maps://?q=$latitude,$longitude",
      );
    } else {
      await launch(
        "geo:$latitude,$longitude",
      );
    }
  }

  @override
  void initState() {
    _record = widget.record;
    super.initState();
  }

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
              height: 90,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _record.company.companyName,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    _record.company.companyLocation.address,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                child: const Text("Проложить маршрут"),
                onPressed: () => _openMap(
                  context,
                  _record.company.companyLocation.latitude,
                  _record.company.companyLocation.longitude,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var status = _record.recordHistory[index];
                return SizedBox(
                  height: 55,
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: status.getColor(),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(status.getLabel()),
                          Text(
                            ConvertDate(context).fromUnix(
                              status.date,
                              "dd.MM.yyyy HH:mm",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              childCount: _record.recordHistory.length,
            ),
          ),
          SliverToBoxAdapter(
            child: _getButton(provider.driver),
          ),
        ],
      ),
    );
  }
}
