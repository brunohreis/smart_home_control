# Smart Home Control
**Descrição Geral:**
O **SmartHomeControl** é um aplicativo móvel projetado para controlar e monitorar sensores e atuadores conectados a um ESP32, utilizando comunicação via MQTT. O aplicativo oferece uma plataforma para gerenciamento completo da automação residencial, onde o usuário pode configurar dispositivos, monitorar o ambiente em tempo real, definir alertas e personalizar modos de operação, como "Férias", "Trabalho" e "Em Casa". A aplicação também inclui uma interface de login para garantir a segurança dos dados e das configurações.

**Funcionalidades Principais:**

1. **Monitoramento de Sensores:**
    - **Exibição em Tempo Real:** Os dados coletados pelos sensores conectados ao ESP32 são exibidos em tempo real, permitindo ao usuário acompanhar o status de diferentes aspectos do ambiente.
    - **Histórico de Dados:** Gráficos e históricos dos dados para cada sensor, permitindo a análise e o acompanhamento ao longo do tempo.
2. **Controle de Atuadores:**
    - **Ação Direta:** O usuário pode ativar ou desativar atuadores diretamente pelo app, como ligar/desligar lâmpadas ou abrir/fechar portões.
    - **Automação:** Programação de ações automáticas baseadas nas condições dos sensores, como acender as luzes ao detectar presença.
3. **Configuração de Alertas:**
    - **Definição de Limites:** O usuário pode definir alertas para quando os valores dos sensores atingirem limites pré-estabelecidos, como alta temperatura ou presença de fumaça.
    - **Notificações:** Notificações push são enviadas para alertas críticos, garantindo que o usuário seja informado imediatamente.
4. **Modos de Operação Personalizados:**
    - **Modos Predefinidos:** Modos como "Férias", "Trabalho" e "Em Casa" podem ser ativados, cada um com comportamentos específicos para os sensores e atuadores.
    - **Personalização:** O usuário pode adicionar, editar e remover modos personalizados, definindo ações automáticas e horários específicos para cada modo.
5. **Gerenciamento de Dispositivos:**
    - **Adição e Remoção:** O aplicativo permite adicionar e remover sensores e atuadores, configurando parâmetros MQTT para cada dispositivo.
    - **Configuração Fácil:** Interface intuitiva para configurar e nomear dispositivos, facilitando a organização e o controle.
6. **Autenticação de Usuários:**
    - **Segurança:** Tela de login para garantir acesso seguro às configurações e aos dispositivos conectados.
    - **Múltiplos Usuários:** Suporte a diferentes níveis de acesso para múltiplos usuários.
7. **Painel de Controle Central:**
    - **Visão Geral:** Exibição de uma visão geral dos dispositivos conectados e do status atual dos modos e alertas.
    - **Acesso Rápido:** Facilita a ativação/desativação de modos e a visualização de alertas ativos.

**Exemplos de Sensores e Atuadores Utilizados:**

1. **Controle de Portão Eletrônico:**
    - **Sensor:** Sensor Magnético Reed Switch, que detecta se o portão está aberto ou fechado.
    - **Atuador:** Relé Controlado por Wi-Fi, que aciona o motor para abrir ou fechar o portão.
2. **Monitoramento de Portas e Janelas:**
    - **Sensor:** Sensor de Contato Magnético, utilizado para detectar a abertura e fechamento de portas e janelas.
3. **Controle de Iluminação:**
    - **Sensor:** Sensor de Luminosidade (LDR), que mede o nível de luz ambiente e automatiza as lâmpadas.
    - **Atuador:** Relé ou Módulo de Dimmer, para ligar, desligar ou ajustar a intensidade das lâmpadas.
4. **Sensores de Presença:**
    - **Sensor:** Sensor PIR (Infravermelho Passivo), capaz de identificar a presença de pessoas e animais.
    - **Aplicação:** Pode acionar lâmpadas automaticamente ou ativar alarmes quando detectar movimento.
5. **Controle de Temperatura e Umidade:**
    - **Sensor:** DHT11/DHT22, que monitora temperatura e umidade do ambiente.
    - **Atuador:** Relé para Controle de Aquecedores ou Ventiladores, ativando ou desativando com base nos valores detectados.
6. **Sensores de Fumaça/Gás:**
    - **Sensor:** MQ-2, que detecta a presença de fumaça ou gases perigosos.
    - **Atuador:** Sistema de Alarme ou Ventilação Automática, que pode ser ativado em caso de detecção de gases.
7. **Monitoramento de Consumo de Energia:**
    - **Sensor:** Sensor de Corrente (ACS712), que monitora o consumo de energia de dispositivos conectados.
    - **Atuador:** Relé para Desligamento Automático, que desliga equipamentos que ultrapassem um limite de consumo.

## Prototipação

### **1. Tela de Login**

- **Funcionalidades:**
    - **Campo de E-mail:** Campo para inserção do e-mail do usuário.
    - **Campo de Senha:** Campo para inserção da senha.
    - **Botão "Entrar":** Realiza a autenticação e acessa o dashboard.
    - **Link "Esqueceu sua senha?":** Redireciona para a recuperação de senha.
    - **Botão "Registrar-se":** Direciona para a tela de registro de novos usuários.

### **2. Tela Inicial (Dashboard)**

- **Funcionalidades:**
    - **Cabeçalho:** Exibe o nome do aplicativo e ícone de perfil do usuário.
    - **Visão Geral dos Sensores:** Mostra o status em tempo real dos sensores, como temperatura, portão, presença, etc.
    - **Botões de Modos Rápidos:** Acesso rápido para ativar modos como "Férias", "Trabalho", e "Em Casa".
    - **Seção de Alertas Recentes:** Exibe os alertas ativos ou recentes.

### **3. Tela de Sensores**

- **Funcionalidades:**
    - **Lista de Sensores:** Exibe todos os sensores conectados, como reed switches, sensores de luminosidade, sensores de presença, etc.
    - **Botão "Adicionar Sensor":** Permite adicionar novos sensores ao sistema.
    - **Gráficos e Histórico:** Ao clicar em um sensor, exibe dados históricos e gráficos.

### **4. Tela de Controle de Atuadores**

- **Funcionalidades:**
    - **Lista de Atuadores:** Exibe atuadores como relés para controle de lâmpadas, portões, etc., com opções para ligar/desligar.
    - **Botão "Adicionar Atuador":** Permite adicionar novos atuadores ao sistema.
    - **Ação Direta:** Interface para ativar/desativar dispositivos diretamente do app.

### **5. Tela de Modos de Operação**

- **Funcionalidades:**
    - **Lista de Modos:** Exibe modos como "Férias", "Trabalho", e "Em Casa" com opções para ativar, editar ou excluir.
    - **Botão "Adicionar Modo":** Permite criar novos modos personalizados.
    - **Configuração de Modos:** Interface para definir comportamentos automáticos e horários para cada modo.

### **6. Tela de Configuração de Alertas**

- **Funcionalidades:**
    - **Lista de Alertas:** Mostra todos os alertas configurados para os sensores, como temperatura alta, presença detectada, etc.
    - **Botão "Adicionar Alerta":** Permite criar novos alertas configurando limites de sensores e ações automáticas.
    - **Notificações Push:** Configuração de notificações para alertas críticos.

### **7. Tela de Gerenciamento de Dispositivos**

- **Funcionalidades:**
    - **Lista de Dispositivos:** Exibe todos os dispositivos conectados (sensores e atuadores) com opções para configurar MQTT, renomear e adicionar novos.
    - **Botão "Adicionar Dispositivo":** Interface para adicionar novos dispositivos ao sistema.
    - **Configuração de MQTT:** Opção para configurar os parâmetros MQTT de cada dispositivo.
