import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HumidityGauge extends StatelessWidget {
  final double humidityValue;

  const HumidityGauge({super.key, required this.humidityValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Humidity',
          style: TextStyle(
            fontSize: 20.0, 
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '${humidityValue.toStringAsFixed(1)}%',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _getHumidityColor(humidityValue),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        SfLinearGauge(
          minimum: 0,
          maximum: 100,
          orientation: LinearGaugeOrientation.horizontal,
          markerPointers: [
            LinearShapePointer(
              value: humidityValue,
              shapeType: LinearShapePointerType.invertedTriangle,
              color: Colors.blueGrey,
            ),
          ],
          barPointers: [
            LinearBarPointer(
              value: humidityValue,
              thickness: 5,
              color: Colors.blueGrey,
            ),
          ],
          axisLabelStyle: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          majorTickStyle: const LinearTickStyle(length: 10),
          minorTickStyle: const LinearTickStyle(length: 5),
        ),
      ],
    );
  }

  Color _getHumidityColor(double humidityValue) {
    if (humidityValue < 30) {
      return Colors.red;
    } else if (humidityValue < 60) {
      return Colors.orange;
    } else if (humidityValue < 80) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }
}
