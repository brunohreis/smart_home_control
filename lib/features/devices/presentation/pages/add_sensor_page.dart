import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/models/sensor_model.dart';
import 'package:smart_home_control/core/data/models/sensor_type.dart';
import 'package:uuid/uuid.dart';

class AddSensorPage extends StatefulWidget {
  final String espId;

  const AddSensorPage({super.key, required this.espId});

  @override
  State<AddSensorPage> createState() => _AddSensorPageState();
}

class _AddSensorPageState extends State<AddSensorPage> {
  final _formKey = GlobalKey<FormState>();
  late SensorModel newSensor;

  @override
  void initState() {
    super.initState();
    var uuid = Uuid();
    newSensor = SensorModel(
      id: uuid.v4(),
      name: '',
      pin1: 0,
      pin2: null,
      type: SensorType.DHT11,
      espId: widget.espId,
      isDigital: false,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, newSensor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Sensor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nome do Sensor',
                      labelStyle: TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    onSaved: (value) => newSensor.name = value!,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Insira um nome'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Pin 1',
                      labelStyle: TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green), // Cor da borda quando focado
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Colors.green), // Cor da borda quando não focado
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => newSensor.pin1 = int.parse(value!),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Insira o Pin 1'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Pin 2 (Opcional)',
                      labelStyle: TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green), // Cor da borda quando focado
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Colors.green), // Cor da borda quando não focado
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => newSensor.pin2 =
                        value != null && value.isNotEmpty
                            ? int.parse(value)
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButtonFormField<SensorType>(
                    decoration: const InputDecoration(
                      labelText: 'Tipo do Sensor',
                      labelStyle: TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green), // Cor da borda quando focado
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Colors.green), // Cor da borda quando não focado
                      ),
                    ),
                    value: newSensor.type,
                    items: SensorType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        newSensor.type = value!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: CheckboxListTile(
                      title: const Text('É Digital?'),
                      value: newSensor.isDigital,
                      activeColor:
                          Colors.green, // Cor do checkbox quando marcado
                      checkColor:
                          Colors.white, // Cor do ícone de "check" no checkbox
                      onChanged: (value) {
                        setState(() {
                          newSensor.isDigital = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        tooltip: 'Adicionar Sensor',
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
