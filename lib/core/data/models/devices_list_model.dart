import 'package:flutter/foundation.dart';

import '../sqlite/sqlite.dart';
import 'device_model.dart';

class DevicesListModel extends ChangeNotifier {
  List<DeviceModel> devices = [];

  loadDevicesList() async {
    //final devices = await _deviceRepository.getDeviceList();
    //TODO: Implementar uma seleção da esp a ter os seus dispositivos carregados nessa página (essa seleção ocorrerá na página configuration_page), que terá o seu id passado por parâmetro na função readAllDevices
    devices = await SQLiteHelper.readAllDevices(1);

    notifyListeners();
  }

  insertDevice(DeviceModel newDevice, int espId) async {
    //await _deviceRepository.saveDevice(newDevice);
    // TODO: No segundo parâmetro da função create device, o parâmetro real deverá ser o id da esp selecionada em configuration_page

    int id = await SQLiteHelper.createDevice(newDevice, espId);
    print("Device created with id : $id");

    // O novo dispositivo é adicionado à lista em memória principal
    devices.add(newDevice);

    // Ordena para melhorar a visualização
    sort();

    // As páginas ouvintes são notificadas para que sejam recarregadas com as informações atualizadas
    notifyListeners();
  }

  deleteDevice(DeviceModel device) async {
    //O dispositivo é deletado da tabela
    int rowsDeleted = await SQLiteHelper.deleteDevice(device.id);
    print("Rows deleted: $rowsDeleted");

    //O dispositivo é deletado da memória principal
    devices.remove(device);

    // Ordena para melhorar a visualização
    sort();

    // As páginas ouvintes são notificadas para que sejam recarregadas com as informações atualizadas
    notifyListeners();
  }

  updateDevice(DeviceModel newDevice){
    //O dispositivo é atualizado na tabela
    SQLiteHelper.updateDevice(newDevice);

    /* TODO: implementar a atualização do dispositivo na lista
          Alternativa 1: remover o dispositivo antigo, e adicionar o novo
          Alternativa 2: usar devices.set(int index) - não sei se existe para a classe List usada atualmente
     */

    // Ordena para melhorar a visualização
    sort();

    // As páginas ouvintes são notificadas para que sejam recarregadas com as informações atualizadas
    notifyListeners();
  }

  sort() {
    // a lista de dispositivos é ordenada de acordo com o tipo de dispositivo, para que visualizações parecidas fiquem pŕoximas
    devices.sort();
  }
}