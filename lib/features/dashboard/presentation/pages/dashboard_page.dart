import 'package:flutter/material.dart';
import '../../../../core/data/models/device_model.dart';
import '../../../../core/data/sqlite/sqlite.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<DeviceModel> _devices = [];

  @override
  void initState() {
    super.initState();
    _loadDevicesList(); // Carregar a lista de ESPs quando a tela é inicializada
  }

  Future<void> _loadDevicesList() async {
    //final devices = await _deviceRepository.getDeviceList();
    //TODO: Implementar uma seleção da esp a ter os seus dispositivos carregados nessa página (essa seleção ocorrerá na página configuration_page), que terá o seu id passado por parâmetro na função readAllDevices
    List<DeviceModel> aux = await SQLiteHelper.readAllDevices(1);

    // a lista de dispositivos é ordenada de acordo com o tipo de dispositivo, para que visualizações parecidas fiquem pŕoximas
    aux.sort();

    setState(() {
      _devices = aux;
    });
  }

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
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _devices.map((device) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 14, // Define a largura para duas colunas
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          device.name,
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
            }).toList(),
          ),
        ),
      ),
    );
  }
}
