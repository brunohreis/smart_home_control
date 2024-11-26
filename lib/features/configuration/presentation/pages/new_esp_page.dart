import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/models/esp_model.dart';
import 'package:uuid/uuid.dart';

class NewEspPage extends StatefulWidget {
  const NewEspPage({super.key});

  @override
  State<NewEspPage> createState() => _NewEspPageState();
}

class _NewEspPageState extends State<NewEspPage> {
  final _formKey = GlobalKey<FormState>();
  late EspModel newDevice;

  @override
  void initState() {
    super.initState();
    var uuid = Uuid();
    newDevice = EspModel(id: uuid.v4(), macAddress: '', name: ''); // Inicializa newDevice aqui
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Retorna o novo dispositivo para a página anterior
      Navigator.pop(context, newDevice);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new ESP32'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  onSaved: (value) {
                    newDevice.name = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'MAC',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green), // Cor da borda quando focado
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green), // Cor da borda quando não focado
                    ),
                  ),
                  onSaved: (value) {
                    newDevice.macAddress = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        tooltip: "Adicionar o dispositivo",
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }

}