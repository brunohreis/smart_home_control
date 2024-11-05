import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_control/core/data/models/devices_list_model.dart';
import 'package:smart_home_control/core/data/models/device_model.dart';
import 'add_new_device_page.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {

  @override
  void initState() {
    super.initState();

    // Carrega a lista de dispositivos ao inicializar a página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DevicesListModel>(context, listen: false).loadDevicesList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DevicesListModel>(
      builder: (context, dlm, child) {

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
                  children: dlm.devices.map((device) {
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
                                            // O dispositivo é removido da lista de dispositivos e do bd
                                            dlm.deleteDevice(device);

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
            onPressed: () async {
              DeviceModel? newDevice = await Navigator.push<DeviceModel>(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNewDevicePage(),
                ),
              );

              if (newDevice != null) {
                setState(() {
                  // TODO: Implementar uma seleção do esp a ser passado como parâmetro real
                  dlm.insertDevice(newDevice, 1);
                });
              }
            },
            tooltip: "Adicionar um novo dispositivo",
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
