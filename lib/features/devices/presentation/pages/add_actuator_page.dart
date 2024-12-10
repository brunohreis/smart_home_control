import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/models/actuator_model.dart';
import 'package:smart_home_control/core/data/models/actuator_type.dart';

class AddActuatorPage extends StatefulWidget {
  final String espId;

  const AddActuatorPage({super.key, required this.espId});

  @override
  State<AddActuatorPage> createState() => _AddActuatorPageState();
}

class _AddActuatorPageState extends State<AddActuatorPage> {
  final _formKey = GlobalKey<FormState>();
  late ActuatorModel newActuator;

  @override
  void initState() {
    super.initState();
    newActuator = ActuatorModel(
      id: '',
      name: '',
      outputPin: 0,
      typeActuator: ActuatorType.Rele1Canal,
      espId: widget.espId,
      isDigital: false,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, newActuator);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Atuador'),
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
                      labelText: 'ID do Atuador',
                      labelStyle: TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    onSaved: (value) => newActuator.id = value!,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Insira um ID válido'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nome do Atuador',
                      labelStyle: TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    onSaved: (value) => newActuator.name = value!,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Insira um nome'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Pin de Saída',
                      labelStyle: TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) =>
                        newActuator.outputPin = int.parse(value!),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Insira o Pin de Saída'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButtonFormField<ActuatorType>(
                    decoration: const InputDecoration(
                      labelText: 'Tipo de Atuador',
                      labelStyle: TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    value: newActuator.typeActuator,
                    items: ActuatorType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        newActuator.typeActuator = value!;
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
                      value: newActuator.isDigital,
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          newActuator.isDigital = value!;
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
        tooltip: 'Adicionar Atuador',
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
