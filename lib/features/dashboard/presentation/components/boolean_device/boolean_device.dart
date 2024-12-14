import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/firebase/firebase_service.dart';
import 'package:smart_home_control/core/data/models/actuator_data.dart';
import 'package:smart_home_control/core/data/models/actuator_model.dart';

class BooleanDevice extends StatefulWidget {
  final bool value;
  final ActuatorModel actuator; // Adiciona o ID do atuador

  const BooleanDevice({super.key, required this.value, required this.actuator});

  @override
  State<BooleanDevice> createState() => _BooleanDeviceState();
}

class _BooleanDeviceState extends State<BooleanDevice> {
  final FirebaseService _espService = FirebaseService();
  late bool currentValue;
  late ActuatorModel actuator;

  @override
  void initState() {
    super.initState();
    currentValue = widget.value;
    actuator = widget.actuator;
  }

  // Função que chama a API de publishMessage
  Future<void> _publishCommand() async {
    String command = currentValue
        ? "turnOn"
        : "turnOff"; // Define o comando com base no estado do toggle
    ActuatorData actuatorData = ActuatorData(
      actuatorId: actuator.id,
      timestamp: DateTime.now(),
      command: command,
    );

    // Converte o ActuatorData para JSON e chama a função publishMessage
    await _espService.publishMessage(
        "/esp32/${actuator.macAddress}/actuators_data/",
        jsonEncode(actuatorData.toMap()));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                  value: currentValue,
                  activeColor: Colors.green,
                  inactiveTrackColor: Colors.red,
                  onChanged: (bool newValue) {
                    setState(() {
                      currentValue = newValue;
                    });
                    _publishCommand();
                  },
                ),
                Text(
                  currentValue ? 'On' : 'Off',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _getBoolColor(currentValue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getBoolColor(bool value) {
    return value ? Colors.green : Colors.red;
  }
}
