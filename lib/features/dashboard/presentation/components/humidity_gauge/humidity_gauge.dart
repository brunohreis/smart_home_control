import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HumidityGauge extends StatelessWidget {
  final double humidityValue;

  const HumidityGauge({super.key, required this.humidityValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
      ),
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
