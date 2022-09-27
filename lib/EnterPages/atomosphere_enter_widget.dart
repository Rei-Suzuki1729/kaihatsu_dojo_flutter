import 'package:first_app/LocalDataAccess/local_data_access.dart';
import 'package:first_app/shared_definitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 気圧の入力画面です
class AtomosphereEnterWidget extends StatefulWidget {
  const AtomosphereEnterWidget({super.key});
  @override
  _AtomosphereEnterWidgetState createState() => _AtomosphereEnterWidgetState();
}

class _AtomosphereEnterWidgetState extends State<AtomosphereEnterWidget> {
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
                "current atomosphere",
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
                child: Text("hPa"),
              )
            ],
          ),
          TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                final dm = DataManager();
                dm.writeData(
                    Factors.atomosphere, int.parse(txtcontroller.text));
                setState(() {});
              },
              child: const Text("Enter"))
        ]));
  }
}
