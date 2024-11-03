import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/models/esp_model.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/boolean_device/boolean_device.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/humidity_gauge/humidity_gauge.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/temperature_gauge/temperature_gauge.dart';

import 'package:smart_home_control/core/data/models/device_model.dart';
import 'package:smart_home_control/core/data/models/device_type.dart';
import 'package:smart_home_control/core/data/repositories/device_repository.dart';
import '../../../../core/data/sqlite/sqlite.dart';
import 'add_new_device_page.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  //late DeviceRepository _deviceRepository;
  List<DeviceModel> _devices = [];

  @override
  void initState() {
    super.initState();
    //_deviceRepository = DeviceRepository();
    _loadDevicesList();
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

  void removeDevice(DeviceModel device) async {
    // deleta o dispositivo do banco de dados
    int rowsDeleted = await SQLiteHelper.deleteDevice(device.id);
    if(rowsDeleted != 0){
      setState(() {
        _devices.remove(device);
      });
    }
  }

  Future<void> _addDevice() async {
    final newDevice = await Navigator.push<DeviceModel>(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewDevicePage(),
      ),
    );

    if (newDevice != null) {
      //await _deviceRepository.saveDevice(newDevice);
      // TODO: No segundo parâmetro da função create device, o parâmetro real deverá ser o id da esp selecionada em configuration_page
      int id = await SQLiteHelper.createDevice(newDevice, 1);
      print("Device created with id : $id");
      setState(() {
        _devices.add(newDevice);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.devices,
          color: Colors.green,
        ),
        title: const Text('Devices'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: _devices.map((device) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Aumenta o espaço entre cada um dos containers
                  padding: const EdgeInsets.all(16.0), // Espaçamento interno maior para aumentar a altura
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Colors.grey.shade300, // Cor da borda
                      width: 1.5, // Espessura da borda
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // Sombra leve
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Sombra deslocada para baixo
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.device_hub, color: Colors.green),
                      const SizedBox(width: 12.5), // Espaçamento entre o ícone e os textos
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              device.isSensor() ? "Sensor" : "Atuador",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.3)),

                            Text(
                              device.name,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 1,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.red, // Cor de fundo do botão
                          radius: 20, // Define o tamanho do botão
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.white,
                            iconSize: 20,
                            tooltip: "Excluir o dispositivo",
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Do you really want to delete the device?'),
                                content: const Text('This action cannot be undone.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      removeDevice(device);
                                      Navigator.pop(context, 'Delete');
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDevice,
        tooltip: "Adicionar um novo dispositivo",
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
