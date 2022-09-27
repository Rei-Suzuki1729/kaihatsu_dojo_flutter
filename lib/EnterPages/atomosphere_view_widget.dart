import 'package:first_app/shared_definitions.dart';
import 'package:flutter/material.dart';
import 'package:first_app/LocalDataAccess/local_data_access.dart';

class AtomosphereViewWidget extends StatelessWidget {
  const AtomosphereViewWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final dm = DataManager();
    final atm = dm.getDataOf(Factors.atomosphere, dm.today());
    return Column(
      children: [
        Text(
          "Atomosphere : $atm",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
        )
      ],
    );
  }
}
