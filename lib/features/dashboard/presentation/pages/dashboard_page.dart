import 'package:flutter/material.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/boolean_device/boolean_device.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/humidity_gauge/humidity_gauge.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/temperature_gauge/temperature_gauge.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.dashboard,
          color: Colors.green,
        ),
        title: const Text('Dashboard')
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 150, // Defina uma altura menor para reduzir o tamanho da linha
                    child: TemperatureGauge(temperatureValue: 35),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 150, // A altura é aplicada para ambos os gráficos
                    child: TemperatureGauge(temperatureValue: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Espaçamento entre as linhas
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 150, // Ajuste a altura para a segunda linha também
                    child: HumidityGauge(humidityValue: 60),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: HumidityGauge(humidityValue: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Espaçamento entre as linhas
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 150, // Ajuste a altura para a segunda linha também
                    child: BooleanDevice(value: true),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: BooleanDevice(value: false),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
