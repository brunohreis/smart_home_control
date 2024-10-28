import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_home_control/core/data/models/esp_model.dart';

import '../models/device_model.dart';
class DatabaseOperations{
  dynamic db;
  DatabaseOperations(){
    this.db = FirebaseFirestore.instance;
  }
  Future<void> addEsp(EspModel esp) async {
    final microcontroladores = FirebaseFirestore.instance.collection('esps');
    await microcontroladores.doc(esp.id).set({
      'id': esp.id,
      'mac': esp.mac,
      'nome': esp.name,
    });
  }
  Future<List<EspModel>> getEsps() async {
    final querySnapshot = await db.collection('esps').get();
    List<Map<String, dynamic>> maps = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<EspModel> esps = List.empty();
    for(int i=0; i < maps.length; i++){
      var map = maps[i];
      esps.add(EspModel.fromMap(map));
    }
    return esps;
  }
  Future<void> deleteEsp(String id) async {
    final esp = db.collection('esps').doc(id);

    // Primeiro, os dispositivos pertencentes à Esp são deletados
    final devices = await esp.collection('devices').get();
    for (var device in devices.docs) {
      await device.reference.delete();
    }

    // Depois, a esp também é deletada
    await esp.delete();
  }
  Future<void> addDevice(EspModel esp, DeviceModel device) async {
    final dispositivos = db
        .collection('esps')
        .doc(esp.id)
        .collection('devices');

    await dispositivos.doc(device.id).set({
      'id': device.id,
      'descricao': device.description,
      'éSensor': device.type,
      'indiceTipo': device.,
    });
  }


}