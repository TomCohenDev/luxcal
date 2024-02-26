import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerService {
  final StreamController<double> _linePoseController =
      StreamController<double>.broadcast();
  Stream<double> get linePoseStream => _linePoseController.stream;

  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  double kp = 0.08; // Proportional gain
  double ki = 0.8; // Integral gain
  double kd = 0.001; // Derivative gain
  double linePose = 0;
  double previousError = 0;
  double integral = 0;

  AccelerometerService() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      _onAccelerometerEvent(event);
    });
  }

  void _onAccelerometerEvent(AccelerometerEvent event) {
    var wantedPose =
        event.z < 0 ? -(event.y - 9.807) * 0.1 : (event.y - 9.807) * 0.1;
    double error = wantedPose - linePose;
    double proportional = kp * error;
    integral += ki * error;
    double derivative = kd * (error - previousError);
    double output = proportional + integral + derivative;
    previousError = error;

    linePose = output.clamp(-1.0, 1.0); // Clamp the value to a specific range

    _linePoseController.add(linePose);
  }

  void dispose() {
    _accelerometerSubscription.cancel();
    _linePoseController.close();
  }
}
