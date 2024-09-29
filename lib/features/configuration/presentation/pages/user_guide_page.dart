import 'package:flutter/material.dart';

class UserGuidePage extends StatelessWidget {
  const UserGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guia do Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'Bem-vindo ao Guia do Usuário!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Nesta seção, você encontrará informações sobre como usar o aplicativo.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              '1. **Configuração de Dispositivos**:'
              '\n   - Adicione seus dispositivos ESP32 na tela de configuração.'
              '\n   - Você pode excluir dispositivos indesejados clicando no ícone de lixeira.'
              '\n   - Para obter o MAC do seu ESP32, utilize o seguinte código no seu sketch:'
              '\n     ```'
              '\n     Serial.println(WiFi.macAddress());'
              '\n     ```',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '2. **Como Ligar Sensores ao ESP32**:'
              '\n   - O ESP32 possui várias entradas e saídas (GPIO) que você pode usar para conectar sensores.'
              '\n   - Aqui está uma visão geral da pinagem da placa ESP32:'
              '\n     - **D0 - D39**: Pinos digitais que podem ser usados como entradas ou saídas.'
              '\n     - **A0 - A3**: Pinos analógicos que podem ser usados para ler sensores analógicos.'
              '\n     - **5V**: Saída de energia para sensores que precisam de alimentação.'
              '\n   - Para conectar um sensor (por exemplo, um sensor de temperatura DHT11):'
              '\n     1. Conecte o pino de dados do sensor ao pino GPIO 4 do ESP32.'
              '\n     2. Conecte o pino VCC do sensor ao pino de 5V do ESP32.'
              '\n     3. Conecte o pino GND do sensor ao GND do ESP32.'
              '\n   - Certifique-se de que a biblioteca necessária para o sensor esteja incluída no seu código.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '3. **Visualização de Dados**:'
              '\n   - Monitore os sensores conectados aos seus dispositivos ESP32 na tela de Dashboard.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '4. **Alertas**:'
              '\n   - Configure alertas para notificar sobre condições específicas.'
              '\n   - Você pode gerenciar esses alertas na seção de Configuração.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Para mais informações, consulte a documentação oficial do projeto.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
