import 'package:flutter/material.dart';
import 'package:smart_home_control/features/devices/presentation/pages/devices_page.dart';

class AddNewDevicePage extends StatefulWidget {
  const AddNewDevicePage({super.key});

  @override
  State<AddNewDevicePage> createState() => _AddNewDevicePageState();
}

class _AddNewDevicePageState extends State<AddNewDevicePage> {
  final _formKey = GlobalKey<FormState>();
  Device newDevice = Device('', false);

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
                    labelText: 'Descrição',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green), // Cor da borda quando focado
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green), // Cor da borda quando não focado
                    ),
                  ),
                  onSaved: (value) {
                    newDevice.description = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    "É um sensor ou um atuador?",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: const Text('Sensor'),
                leading: Radio<bool>(
                  activeColor: Colors.green,
                  value: true,
                  groupValue: newDevice.isSensor,
                  onChanged: (bool? value) {
                    setState(() {
                      newDevice.isSensor = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Atuador'),
                leading: Radio<bool>(
                  activeColor: Colors.green,
                  value: false,
                  groupValue: newDevice.isSensor,
                  onChanged: (bool? value) {
                    setState(() {
                      newDevice.isSensor = value!;
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