import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBdQ1SefQXmlGe_snvzGZEG2RuGcA3b6Yk",
      authDomain: "gdid-19a24.firebaseapp.com",
      databaseURL: "https://gdid-19a24-default-rtdb.firebaseio.com",
      projectId: "gdid-19a24",
      storageBucket: "gdid-19a24.appspot.com",
      messagingSenderId: "655039977599",
      appId: "1:655039977599:web:c55a26bcdec1280bfd074a",
      measurementId: "G-SWRLFBWL78",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Application(),
    );
  }
}

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late final DatabaseReference _reference;
  late final DatabaseReference _rainSensorReference;
  late final DatabaseReference _waterSensorReference;
  late final DatabaseReference _distanceSensorReference;
  late final DatabaseReference _colorSensorReference;
  late final DatabaseReference _gasSensorReference; // Reference for gas detection

  bool _status7 = false;
  double _rainPercentage = 0.0;
  String _waterLevel = "Low";
  double _distance = 0.0;
  int _red = 0, _green = 0, _blue = 0;
  bool _gasDetected = false; // State variable for gas detection

  @override
  void initState() {
    super.initState();
    _reference = FirebaseDatabase.instance.ref();
    _rainSensorReference = _reference.child('sensor/rain');
    _waterSensorReference = _reference.child('sensor/water');
    _distanceSensorReference = _reference.child('sensor/distance');
    _colorSensorReference = _reference.child('sensor/color');
    _gasSensorReference = _reference.child('sensor/gas_detected'); // Initialize gas detection reference

    // Firebase listener for gas detection
    _gasSensorReference.onValue.listen((event) {
      final data = event.snapshot.value as bool?;
      setState(() {
        _gasDetected = data ?? false;
      });
    });

    // Firebase listeners for other sensor data
    _rainSensorReference.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _rainPercentage = data['rain_percentage'];
      });
    });

    _waterSensorReference.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _waterLevel = data['water_level'];
      });
    });

    _distanceSensorReference.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _distance = data['distance'];
      });
    });

    _colorSensorReference.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _red = data['red'];
        _green = data['green'];
        _blue = data['blue'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6D1900),
        title: const Text(
          "Control LED and Sensor Data",
          style: TextStyle(
            fontSize: 30,
            color: Color(0xE1E9E5E3),
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xFF111100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    FlutterSwitch(
                      width: 150.0,
                      height: 70.0,
                      toggleSize: 50.0,
                      value: _status7,
                      borderRadius: 30.0,
                      padding: 2.0,
                      activeToggleColor: const Color(0xFF952907),
                      inactiveToggleColor: const Color(0xFFE7A261),
                      activeSwitchBorder: Border.all(
                        color: const Color(0xFFAC2F09),
                        width: 6.0,
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: const Color(0xFFE7A261),
                        width: 6.0,
                      ),
                      activeColor: const Color(0xFFC8A989),
                      inactiveColor: Colors.white,
                      activeIcon: const Icon(
                        Icons.lightbulb,
                        color: Color(0xFFFBC513),
                      ),
                      inactiveIcon: const Icon(
                        Icons.lightbulb,
                        color: Color(0xFF908865),
                      ),
                      onToggle: (val) {
                        setState(() {
                          _status7 = val;
                          final newState = val ? 'on' : 'off';
                          _reference.child('output').child('state').set(newState);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Rain detected: ${_rainPercentage.toStringAsFixed(2)}%',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Water level: $_waterLevel',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Distance: ${_distance.toStringAsFixed(2)} cm',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Color (RGB): R = $_red, G = $_green, B = $_blue',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Gas detected: ${_gasDetected ? 'Yes' : 'No'}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
