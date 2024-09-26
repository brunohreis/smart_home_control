import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperatureGauge extends StatelessWidget {
  final double temperatureValue;

  const TemperatureGauge({super.key, required this.temperatureValue});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      title: const GaugeTitle(
        text: 'Temperature',
        textStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
        alignment: GaugeAlignment.center,
      ),
      axes: <RadialAxis>[
        RadialAxis(
          minimum: -10,
          maximum: 50.1,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: -10,
              endValue: 5,
              color: Colors.blue,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 5,
              endValue: 20,
              color: Colors.green,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 20,
              endValue: 35,
              color: Colors.orange,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 35,
              endValue: 50,
              color: Colors.red,
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: temperatureValue,
              needleColor: Colors.blueGrey,
              knobStyle: KnobStyle(color: Colors.blueGrey),
              needleLength: 0.5,
              needleStartWidth: 0.5,
              needleEndWidth: 2.0,
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                '${temperatureValue.toStringAsFixed(1)}°C',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              angle: 90,
              positionFactor: 0.7,
            ),
          ],
        ),
      ],
    );
  }
}
