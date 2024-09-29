import 'package:flutter/material.dart';
import 'package:smart_home_control/features/configuration/presentation/pages/new_esp_page.dart';
import 'package:smart_home_control/features/configuration/presentation/pages/user_guide_page.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final List<ESP32> _espList = [
    ESP32("00:1A:2B:3C:4D:5E"),
    ESP32("AC:DE:48:00:11:22"),
  ];

  void removeEspFromDataset(ESP32 esp) {
    // Lógica de remoção do ESP
  }

  void removeEsp(ESP32 esp) {
    setState(() {
      _espList.remove(esp);
    });
  }

  void addEspToDataset(ESP32 esp) {
    // Lógica de adição de esp
  }

  Future<void> _addEsp() async {
    final newEsp = await Navigator.push<ESP32>(
        context,
        MaterialPageRoute(
          builder: (context) => NewEspPage(),
        ));

    if (newEsp != null) {
      addEspToDataset(newEsp);
      setState(() {
        _espList.add(newEsp);
      });
    }
  }

  void _navigateToUserGuide() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const UserGuidePage()), // Navegando para a tela do guia do usuário
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.settings,
          color: Colors.green,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Configuration'),
            IconButton(
              icon: const Icon(
                Icons.info,
                color: Colors.grey,
              ),
              tooltip: 'Guia do Usuário',
              onPressed: _navigateToUserGuide,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: _espList.asMap().entries.map((entry) {
                int index = entry.key; // Índice do ESP
                ESP32 device = entry.value; // ESP32 correspondente

                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.memory, color: Colors.green),
                      const SizedBox(width: 12.5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ESP32 - ${index + 1}', // Use index + 1 para começar a contagem em 1
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.3),
                            ),
                            Text(
                              device.macAddress,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 1),
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 20,
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.white,
                            iconSize: 20,
                            tooltip: "Excluir este ESP",
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                    'Do you really want to delete the device?'),
                                content:
                                    const Text('This action cannot be undone.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Delete');
                                      removeEsp(device);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
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
        onPressed: _addEsp,
        tooltip: "Adicionar um novo ESP",
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
