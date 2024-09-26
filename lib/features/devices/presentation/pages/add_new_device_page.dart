import 'package:flutter/material.dart';
import 'package:smart_home_control/features/devices/presentation/pages/devices_page.dart';

class AddNewDevicePage extends StatefulWidget {
  final List<Device> devices;

  const AddNewDevicePage({super.key, required this.devices});

  @override
  State<AddNewDevicePage> createState() => _AddNewDevicePageState();
}

class _AddNewDevicePageState extends State<AddNewDevicePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: const Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }

}