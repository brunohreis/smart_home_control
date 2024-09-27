import 'package:flutter/material.dart';

import 'add_new_device_page.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final List<Device> _devices = [
    Device("Sensor de temperatura e umidade DHT11", true),
    Device("Relé conectado ao ar-condicionado da sala", false),
    Device("Sensor de fumaça", true)
  ];

  void removeDeviceFromDataset(Device device){
    // Aqui virá a lógica de remoção do dispositivo no banco de dados
  }

  void removeDevice(Device device) {
    setState(() {
      // Aqui vai a lógica de remoção do dispositivo no banco de dados
      _devices.remove(device); // Ao remover da lista, a tela é atualizada
    });
  }

  void addDeviceToDataset(Device device) {
    // Aqui virá a lógica de inserção do dispositivo no banco de dados
  }

  Future<void> _addDevice() async {
    // Navega para a AddNewDevicePage e aguarda o retorno de um novo dispositivo
    final newDevice = await Navigator.push<Device>(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewDevicePage(),
      ),
    );

    // Se o dispositivo retornado não for nulo, adiciona à lista de dispositivos da página
    if (newDevice != null) {
      addDeviceToDataset(newDevice);
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
                                device.isSensor ? "Sensor" : "Atuador",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.3)),

                            Text(
                                device.description,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),

                      // Espaçador para empurrar o botão "Excluir" para a direita
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
                                      Navigator.pop(context, 'Delete');
                                      removeDevice(device);
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

class Device {
  String description;
  bool isSensor;
  Device(this.description, this.isSensor);
}
