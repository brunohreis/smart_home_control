enum SensorType {
  DHT11,        // Sensor de Temperatura e Umidade (comum)
  DHT22,        // Sensor de Temperatura e Umidade (comum)
  AM2302,       // Sensor de Temperatura e Umidade (comum)
  CCS811,       // Sensor de Qualidade do Ar (comum)
  MH_Z19B,      // Sensor de CO2 (comum)
  MQ135,        // Sensor de Gás (comum)
  MQ9,          // Sensor de Gás (comum)
  HC_SR501,     // Sensor de Movimento PIR (comum)
  RCWL0516,     // Sensor de Movimento Radar (comum)
  VL53L0X,      // Sensor de Distância a Laser (comum)
  Ultrasonic,   // Sensor Ultrassônico de Distância (comum)
  Maxbotix,     // Sensor Ultrassônico de Distância (comum)
  TSL2561,      // Sensor de Luz Digital (comum)
  APDS9960,     // Sensor de Cor, Luz e Proximidade (comum)
  SW420,        // Sensor de Vibração (comum)
  HX711,        // Sensor de Célula de Carga (comum)
  YFS201,       // Sensor de Fluxo de Água (comum)
  PH_SENSOR,    // Sensor de pH
  MAX30100,     // Sensor de Oximetria (comum)
  NTC           // Sensor de Temperatura NTC (comum)
}

extension SensorTypeExtension on SensorType {
  int get value {
    switch (this) {
      case SensorType.DHT11:
        return 1;
      case SensorType.DHT22:
        return 2;
      case SensorType.AM2302:
        return 3;
      case SensorType.CCS811:
        return 4;
      case SensorType.MH_Z19B:
        return 5;
      case SensorType.MQ135:
        return 6;
      case SensorType.MQ9:
        return 7;
      case SensorType.HC_SR501:
        return 8;
      case SensorType.RCWL0516:
        return 9;
      case SensorType.VL53L0X:
        return 10;
      case SensorType.Ultrasonic:
        return 11;
      case SensorType.Maxbotix:
        return 12;
      case SensorType.TSL2561:
        return 13;
      case SensorType.APDS9960:
        return 14;
      case SensorType.SW420:
        return 15;
      case SensorType.HX711:
        return 16;
      case SensorType.YFS201:
        return 17;
      case SensorType.PH_SENSOR:
        return 18;
      case SensorType.MAX30100:
        return 19;
      case SensorType.NTC:
        return 20;
    }
  }
}
