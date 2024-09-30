import 'package:flutter/material.dart';
import '../../../devices/presentation/pages/devices_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  final List<Device> _devices = [
    Device(1, "Sensor de temperatura DHT11", true, 0),
    Device(2, "Sensor de temperatura DHT11", true, 0),
    Device(3, "Sensor de umidade DHT11", true, 1),
    Device(4, "Sensor de umidade DHT11", true, 1),
    Device(5, "Relé conectado ao ar-condicionado da sala", false, 2),
    Device(6, "Relé conectado ao portão da garagem", false, 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.dashboard,
          color: Colors.green,
        ),
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,  // Define que haverá duas colunas
                  mainAxisSpacing: 10.0,  // Espaçamento vertical entre os itens
                  crossAxisSpacing: 10.0,  // Espaçamento horizontal entre os itens
                  childAspectRatio: 1.17,  // Proporção dos itens (pode ajustar conforme o design)
                ),
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  final device = _devices[index];
                  return Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              device.description,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            device.getCorrespondingWidget(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
