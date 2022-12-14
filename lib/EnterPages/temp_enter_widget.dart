import 'package:first_app/LocalDataAccess/local_data_access.dart';
import 'package:first_app/shared_definitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 気圧の入力画面です
class TemperatureEnterWidget extends StatefulWidget {
  const TemperatureEnterWidget({super.key});
  @override
  _TemperatureEnterWidgetState createState() => _TemperatureEnterWidgetState();
}

class _TemperatureEnterWidgetState extends State<TemperatureEnterWidget> {
  final txtcontroller = TextEditingController();
  var atomosphere = 0;
  void enterAtm() {}
  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.headline1!;
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "current temperature",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
              )),
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: txtcontroller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.right,
              )),
              const SizedBox(
                child: Text("ºC"),
              )
            ],
          ),
          TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                final dm = DataManager();
                try {
                  dm.writeData(
                      Factors.temperature, int.parse(txtcontroller.text));
                } catch (err) {
                  return;
                }
                setState(() {});
              },
              child: const Text("Enter"))
        ]));
  }
}
