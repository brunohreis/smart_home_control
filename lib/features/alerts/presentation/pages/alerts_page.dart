import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/firebase/firebase_service.dart';
import 'package:smart_home_control/core/data/models/alert_model.dart';
import 'package:smart_home_control/features/alerts/presentation/pages/add_alert_page.dart';
import 'package:smart_home_control/features/ui/toast/toast.dart'; // Importa a página de adicionar alertas

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  final FirebaseService _firebaseService = FirebaseService();
  List<AlertModel> alerts = [];

  @override
  void initState() {
    super.initState();
    _loadAlerts();
  }

  // Método para adicionar um novo alerta
  Future<void> _addAlert() async {
    final newAlert = await Navigator.push<AlertModel>(
      context,
      MaterialPageRoute(builder: (context) => const AddAlertPage()),
    );

    if (newAlert != null) {
      try {
        print('Alert to add: $newAlert');
        final addedAlert = await _firebaseService.addAlert(newAlert);
        UiToast.showToast(
            "Alerta para ${newAlert.sensorName} adicionado com sucesso", ToastType.success);
        setState(() {
          alerts.add(newAlert); // Adiciona o novo alerta à lista
        });
      } catch (e) {
        print('***Err: $e');
        UiToast.showToast('Failed to add Alert: $e', ToastType.error);
      }
    }
  }

  Future<void> _loadAlerts() async {
    try {
      final _alerts = await _firebaseService.getAlerts();
      print('Alertas: $_alerts');
      setState(() {
        alerts = _alerts;
      });
    } catch (e) {
      print('Erro ao carregar alertas: $e');
    }
  }

  Future<void> _deleteAlert(AlertModel alert) async {
    try {
      await _firebaseService.deleteAlert(alert.sensorId);
      setState(() {
        alerts.remove(alert);
      });
    } catch (e) {
      print('Erro ao excluir alerta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.notifications,
          color: Colors.green,
        ),
        title: const Text('Alertas'),
      ),
      body: alerts.isEmpty
          ? const Center(child: Text('Nenhum alerta registrado'))
          : ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.notifications, color: Colors.green),
                          const SizedBox(width: 12.5),
                          Expanded(
                            child: Text(
                              alert.sensorName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _deleteAlert(alert),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Valor: ${alert.value}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAlert,
        tooltip: 'Adicionar Alerta',
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
