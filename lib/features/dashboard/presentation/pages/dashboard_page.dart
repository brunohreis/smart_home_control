import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_control/core/data/firebase/firebase_service.dart';
import 'package:smart_home_control/core/data/models/devices_model.dart';
import 'package:smart_home_control/features/ui/toast/toast.dart';

import '../../../../core/data/models/devices_list_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final FirebaseService _espService = FirebaseService();
  DevicesModel _devicesList = DevicesModel(sensors: [], actuators: []); // Inicialização correta
  bool _isLoading = false;

  Future<void> _loadDevicesList() async {
    setState(() => _isLoading = true);
    try {
      final devicesList = await _espService.getDevices();
      setState(() {
        _devicesList = devicesList;
        // _isExpanded = {for (var i = 0; i < devicesList.length; i++) i: false};
      });
    } catch (e) {
      UiToast.showToast('Failed to load ESPs: $e', ToastType.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDevicesList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DevicesListModel>(
      builder: (context, dlm, child) {
        return Scaffold(
          appBar: AppBar(
            leading: const Icon(
              Icons.dashboard,
              color: Colors.green,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dashboard'),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.green),
                  onPressed: () async {
                    await _loadDevicesList();
                    UiToast.showToast('Devices reloaded', ToastType.success);
                  },
                ),
              ],
            ),
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sensores',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: (_devicesList.sensors ?? []).map((sensor) {
                            return SizedBox(
                              width: (MediaQuery.of(context).size.width / 2) - 14,
                              child: Card(
                                color: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        sensor.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      sensor.getCorrespondingWidget(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Atuadores',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: (_devicesList.actuators ?? []).map((actuator) {
                            return SizedBox(
                              width: (MediaQuery.of(context).size.width / 2) - 14,
                              child: Card(
                                color: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        actuator.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      actuator.getCorrespondingWidget(actuator),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
