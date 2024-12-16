// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_control/core/data/models/devices_list_model.dart';
import 'package:smart_home_control/core/routes/app_routes.dart';
import 'package:smart_home_control/features/login/components/auth.dart';
import 'package:smart_home_control/features/ui/toast/toast.dart';
import 'package:smart_home_control/firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // Aqui você pode adicionar o código para processar a notificação no background
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configuração do Firebase Cloud Messaging
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

  // Verifique se há um token salvo nos SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('bearer_token');

  // Solicita permissão para notificações no iOS
  // if (await FirebaseMessaging.instance.isSupported()) {
  //   NotificationSettings settings =
  //       await FirebaseMessaging.instance.requestPermission();
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print("Permissão concedida para notificações");
  //   } else {
  //     print("Permissão não concedida");
  //   }
  // }

  // Obtenha o token do dispositivo para notificação
  // String? fcmToken = await FirebaseMessaging.instance.getToken();
  // print("Token do dispositivo: $fcmToken");

  // // Gerenciar mensagens recebidas em primeiro plano
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Mensagem recebida enquanto app está em primeiro plano: ${message.notification?.title}');
  //   // Aqui você pode mostrar uma notificação ou tomar outras ações
  //   // Exibe a mensagem no formato de toast com base no tipo
  //   UiToast.showToast(
  //     message.notification?.title ?? 'Nova mensagem',
  //     ToastType.warning, // Você pode alterar para outro tipo, como error ou warning
  //   );
  // });

  runApp(
    ChangeNotifierProvider(
      create: (context) => DevicesListModel(),
      child: MyApp(userToken: token),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? userToken;
  const MyApp({super.key, this.userToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Adiciona a chave global ao MaterialApp
      initialRoute: userToken != null ? AppRoutes.home : AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
      home: AuthCheck(),
      debugShowCheckedModeBanner: false,
    );
  }
}
