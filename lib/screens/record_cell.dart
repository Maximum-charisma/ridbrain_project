import 'package:flutter/material.dart';
import 'package:ridbrain_project/services/constants.dart';
import 'package:ridbrain_project/services/objects.dart';

class RecordCell extends StatelessWidget {
  const RecordCell({Key? key, required this.record, required this.onTap})
      : super(key: key);

  final Record record;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.fromLTRB(15, 5, 15, 10),
      child: Material(
        borderRadius: radius,
        color: record.getColor(),
        child: InkWell(
          onTap: () {
            onTap();
          },
          borderRadius: radius,
          child: Center(
            child: ListTile(
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(record.company.companyName.toString()),
                  Text(record.recordDate.toString())
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(record.getStatus()),
                ],
              ),
            ),
          ),
        ),
      ),
      decoration: const BoxDecoration(
        borderRadius: radius,
        boxShadow: shadow,
      ),
    );
  }
}
