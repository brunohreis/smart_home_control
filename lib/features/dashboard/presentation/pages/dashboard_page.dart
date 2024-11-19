import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/data/models/devices_list_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    super.initState();

    // Carrega a lista de dispositivos ao inicializar a página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DevicesListModel>(context, listen: false).loadDevicesList();
    });
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
            title: const Text('Dashboard'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: dlm.devices.map((device) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 14, // Define a largura para duas colunas
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
                              device.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            device.getCorrespondingWidget(),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      }
    );
  }
}
