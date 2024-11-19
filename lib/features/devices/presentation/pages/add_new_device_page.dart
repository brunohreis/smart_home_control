import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/models/device_model.dart';
import 'package:smart_home_control/core/data/models/device_type.dart';

class AddNewDevicePage extends StatefulWidget {
  const AddNewDevicePage({super.key});

  @override
  State<AddNewDevicePage> createState() => _AddNewDevicePageState();
}

class _AddNewDevicePageState extends State<AddNewDevicePage> {
  final _formKey = GlobalKey<FormState>();
  late DeviceModel newDevice;

  @override
  void initState() {
    super.initState();
    newDevice = DeviceModel(id: 0, name: '', type: DeviceType.temperature); // Inicializa com um tipo padrão
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
        title: const Text('Adicionar Novo Dispositivo'),
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
                      borderSide: BorderSide(color: Colors.green), // Cor da borda quando focado
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green), // Cor da borda quando não focado
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
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    "Qual é o tipo de dispositivo?",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: const Text('Sensor de Temperatura'),
                leading: Radio<DeviceType>(
                  activeColor: Colors.green,
                  value: DeviceType.temperature,
                  groupValue: newDevice.type,
                  onChanged: (DeviceType? value) {
                    setState(() {
                      newDevice.type = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Sensor de Umidade'),
                leading: Radio<DeviceType>(
                  activeColor: Colors.green,
                  value: DeviceType.humidity,
                  groupValue: newDevice.type,
                  onChanged: (DeviceType? value) {
                    setState(() {
                      newDevice.type = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Relé'),
                leading: Radio<DeviceType>(
                  activeColor: Colors.green,
                  value: DeviceType.relay,
                  groupValue: newDevice.type,
                  onChanged: (DeviceType? value) {
                    setState(() {
                      newDevice.type = value!;
                    });
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