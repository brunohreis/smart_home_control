import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/firebase/firebase_service.dart';
import 'package:smart_home_control/core/data/models/alert_model.dart';
import 'package:smart_home_control/core/data/models/sensor_model.dart';
import 'package:smart_home_control/core/data/models/sensor_type.dart';

class AddAlertPage extends StatefulWidget {
  const AddAlertPage({super.key});

  @override
  State<AddAlertPage> createState() => _AddAlertPageState();
}

class _AddAlertPageState extends State<AddAlertPage> {
  final FirebaseService _espService = FirebaseService();
  final _formKey = GlobalKey<FormState>();

  late String selectedSensorId = ''; // Inicialização segura
  late AlertModel newAlert;

  List<SensorModel> sensors = [];

  @override
  void initState() {
    super.initState();
    newAlert = AlertModel(
      sensorId: '',
      sensorName: '',
      value: 0,
    );
    _getSensors();
  }

  Future<void> _getSensors() async {
    try {
      final _sensors = await _espService.getSensors();
      setState(() {
        sensors = _sensors;
        if (sensors.isNotEmpty) {
          selectedSensorId = sensors.first.id;
          newAlert.sensorName = sensors.first.name;
          newAlert.sensorId = sensors.first.id;
        }
      });
    } catch (e) {
      print('Erro ao buscar sensores: $e');
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, newAlert); // Retorna o objeto alerta
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Alerta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown para selecionar o sensor
                if (sensors.isEmpty)
                  const Center(child: CircularProgressIndicator())
                else
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Selecionar Sensor',
                        labelStyle: TextStyle(color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      value: selectedSensorId,
                      items: sensors.map((sensor) {
                        return DropdownMenuItem(
                          value: sensor.id,
                          child: Text(sensor.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSensorId = value!;
                          newAlert.sensorId = value;
                          final selectedSensor = sensors.firstWhere(
                              (sensor) => sensor.id == value,
                              orElse: () => SensorModel(
                                  id: '', name: '', type: SensorType.NTC, espId: ''));
                          newAlert.sensorName = selectedSensor.name;
                        });
                      },
                    ),
                  ),

                // Campo de valor
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Valor do Alerta',
                      labelStyle: TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if (value != null && value.isNotEmpty) {
                        newAlert.value = double.parse(value);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira um valor';
                      }
                      final parsedValue = double.tryParse(value);
                      if (parsedValue == null) {
                        return 'Insira um valor numérico válido';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        tooltip: 'Adicionar Alerta',
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
