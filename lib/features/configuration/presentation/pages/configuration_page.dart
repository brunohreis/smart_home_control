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
            const Text('Configuration'),
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
              ? const Center(child: Text('No ESP devices found.'))
              : ListView.builder(
                  itemCount: _espList.length,
                  itemBuilder: (context, index) {
                    final esp = _espList[index];
                    return ListTile(
                      leading: const Icon(Icons.memory, color: Colors.green),
                      title: Text(
                        esp.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(esp.macAddress),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDeletion(esp),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEsp,
        tooltip: "Add a new ESP",
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _confirmDeletion(EspModel esp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this ESP?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeEsp(esp);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
