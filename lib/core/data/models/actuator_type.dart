enum ActuatorType {
  Rele1Canal,         // Relé de 1 canal
  Lampada,            // Lâmpada comum
  Rele2Canais,        // Relé de 2 canais
  Rele4Canais,        // Relé de 4 canais
  ServoMotor,         // Servo motor
  MotorDC,            // Motor DC
  MotorPassoAPasso,   // Motor de passo a passo
  Ventilador,         // Ventilador
  FechaduraEletrica,  // Fechadura elétrica
  CortinaAutomatica,  // Cortina automática
  BombaDeAgua,        // Bomba de água
  AlarmeDeSeguranca,  // Alarme de segurança
  LuminariaInteligente, // Luminária inteligente
  ChuveiroEletrico,   // Chuveiro elétrico
  CompressorDeAr,     // Compressor de ar
  MotorHidraulico,    // Motor hidráulico
  PonteH,             // Ponte H
}

extension ActuatorTypeExtension on ActuatorType {
  int get value {
    switch (this) {
      case ActuatorType.Rele1Canal:
        return 1;
      case ActuatorType.Lampada:
        return 2;
      case ActuatorType.Rele2Canais:
        return 3;
      case ActuatorType.Rele4Canais:
        return 4;
      case ActuatorType.ServoMotor:
        return 5;
      case ActuatorType.MotorDC:
        return 6;
      case ActuatorType.MotorPassoAPasso:
        return 7;
      case ActuatorType.Ventilador:
        return 8;
      case ActuatorType.FechaduraEletrica:
        return 9;
      case ActuatorType.CortinaAutomatica:
        return 10;
      case ActuatorType.BombaDeAgua:
        return 11;
      case ActuatorType.AlarmeDeSeguranca:
        return 12;
      case ActuatorType.LuminariaInteligente:
        return 13;
      case ActuatorType.ChuveiroEletrico:
        return 14;
      case ActuatorType.CompressorDeAr:
        return 15;
      case ActuatorType.MotorHidraulico:
        return 16;
      case ActuatorType.PonteH:
        return 17;
    }
  }
}
