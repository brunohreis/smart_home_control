import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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
  final macMaskFormatter = MaskTextInputFormatter(mask: '##:##:##:##:##:##', filter: {'#': RegExp(r'[0-9A-Fa-f]')});

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

  String? _macValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um MAC válido';
    }

    // Remove qualquer formatação de máscara (coloca em caixa alta e verifica se o formato é válido)
    String macWithoutMask = value.replaceAll(":", "").toUpperCase();
    if (macWithoutMask.length != 12 || !RegExp(r'^[0-9A-F]+$').hasMatch(macWithoutMask)) {
      return 'MAC inválido. Deve ser no formato XX:XX:XX:XX:XX:XX';
    }

    return null; // Retorna nulo se for válido
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar novo ESP'),
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
                  inputFormatters: [macMaskFormatter], 
                  textCapitalization: TextCapitalization.characters,
                  onSaved: (value) {
                    newDevice.macAddress = value!.toUpperCase();
                  },
                  validator: _macValidator,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        tooltip: "Adicionar o ESP",
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }

}