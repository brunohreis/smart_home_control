import 'package:flutter/material.dart';

class BooleanDevice extends StatefulWidget {
  final bool value;

  const BooleanDevice({super.key, required this.value});

  @override
  State<BooleanDevice> createState() => _BooleanDeviceState();
}

class _BooleanDeviceState extends State<BooleanDevice> {
  late bool currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Garage',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
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
                },
              ),
              Text(
                currentValue ? 'Open' : 'Close',
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
    );
  }

  Color _getBoolColor(bool value) {
    return value ? Colors.green : Colors.red;
  }
}
