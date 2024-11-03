import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/models/esp_model.dart';
import 'package:smart_home_control/core/data/repositories/esp_repository.dart';
import 'package:smart_home_control/core/data/sqlite/sqlite.dart';
import 'package:smart_home_control/features/configuration/presentation/pages/new_esp_page.dart';
import 'package:smart_home_control/features/configuration/presentation/pages/user_guide_page.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  //final EspRepository _espRepository = EspRepository();
  List<EspModel> _espList = [];

  Future<void> removeEsp(EspModel esp) async {
    await SQLiteHelper.deleteEsp(esp.id); // deleta a esp do banco de dados
    setState((){
      _espList.remove(esp); // remove a esp da lista que é usada para visualização
    });
  }

  Future<void> _loadEspList() async {
    //final espList = await _espRepository.getEspList();
    List<EspModel> aux = await SQLiteHelper.readAllEsps();
    setState(() {
      _espList = aux;
    });
  }

  void addEspToList(EspModel esp) {
    setState(() {
      _espList.add(esp);
    });
  }

  Future<void> _addEsp() async {
    var newEsp = await Navigator.push<EspModel>(
      context,
      MaterialPageRoute(
        builder: (context) => NewEspPage(),
      )
    );

    if (newEsp != null) {
      //await _espRepository.saveEsp(newEsp); // Salvar no repositório
      int id = await SQLiteHelper.createEsp(newEsp); // insere no bd sqlite e recebe o id gerado
      newEsp.id = id; // o objeto esp passa a armazenar o seu id correspondente no banco de dados
      addEspToList(newEsp); // a esp é adicionada à lista usada para visualização
    }
  }

  void _navigateToUserGuide() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserGuidePage()), // Navegando para a tela do guia do usuário
    );
  }

  @override
  void initState() {
    super.initState();
    _loadEspList(); // Carregar a lista de ESPs quando a tela é inicializada
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
                EspModel curEsp = entry.value; // ESP32 correspondente

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
                              curEsp.name, // Use index + 1 para começar a contagem em 1
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.3),
                            ),
                            Text(
                              curEsp.mac,
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
                                      removeEsp(curEsp);
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
