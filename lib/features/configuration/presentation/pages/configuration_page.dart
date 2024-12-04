import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_control/core/data/firebase/firebase_service.dart';
import 'package:smart_home_control/core/data/models/esp_model.dart';
import 'package:smart_home_control/features/configuration/presentation/pages/new_esp_page.dart';
import 'package:smart_home_control/features/configuration/presentation/pages/user_guide_page.dart';
import 'package:smart_home_control/features/ui/toast/toast.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final FirebaseService _espService = FirebaseService();
  List<EspModel> _espList = [];
  bool _isLoading = false;

  Future<void> _loadEspList() async {
    setState(() => _isLoading = true);
    try {
      final espList = await _espService.getEspList();
      setState(() {
        _espList = espList;
      });
    } catch (e) {
      UiToast.showToast('Failed to load ESPs: $e', ToastType.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _addEsp() async {
    var newEsp = await Navigator.push<EspModel>(
      context,
      MaterialPageRoute(
        builder: (context) => const NewEspPage(),
      ),
    );

    if (newEsp != null) {
      setState(() => _isLoading = true);
      try {
        final addedEsp = await _espService.addEsp(newEsp);
        UiToast.showToast(
            "${newEsp.name} adicionado com sucesso", ToastType.success);
        setState(() {
          _espList.add(addedEsp);
        });
      } catch (e) {
        UiToast.showToast('Failed to add ESP: $e', ToastType.error);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _removeEsp(EspModel esp) async {
    setState(() => _isLoading = true);
    try {
      await _espService.deleteEsp(esp.id);
      UiToast.showToast("${esp.name} excluído com sucesso", ToastType.success);
      setState(() {
        _espList.remove(esp);
      });
    } catch (e) {
      UiToast.showToast(
          e.toString().replaceAll("Exception:", ""), ToastType.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Método de logout
  Future<void> logout() async {
    try {
      // Deslogar o usuário do Firebase
      await FirebaseAuth.instance.signOut();

      // Remover o token dos SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('bearer_token');
      await prefs.remove('user_uid');

      // Redirecionar para a tela de login
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer logout: ${e.toString()}')),
      );
    }
  }

  void _navigateToUserGuide() {
    print("***LogOut***");
    logout();
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const UserGuidePage()),
    // );
  }

  @override
  void initState() {
    super.initState();
    _loadEspList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.settings,
          color: Colors.green,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Configurações'),
            IconButton(
              icon: const Icon(
                Icons.info,
                color: Colors.grey,
              ),
              tooltip: 'User Guide',
              onPressed: _navigateToUserGuide,
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _espList.isEmpty
              ? const Center(child: Text('Nenhum ESP encontrado'))
              : ListView.builder(
                  itemCount: _espList.length,
                  itemBuilder: (context, index) {
                    final esp = _espList[index];
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
                              const Icon(Icons.memory, color: Colors.green),
                              const SizedBox(width: 12.5),
                              Expanded(
                                child: Text(
                                  esp.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  _confirmDeletion(esp);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'MAC: ${esp.macAddress}',
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
        onPressed: _addEsp,
        tooltip: "Adicionar novo ESP",
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _confirmDeletion(EspModel esp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Tem certeza que deseja excluir este ESP?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeEsp(esp);
            },
            child: const Text('Deletar'),
          ),
        ],
      ),
    );
  }
}
