import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluePage extends StatefulWidget {
  const BluePage({Key? key}) : super(key: key);

  @override
  _BluePageState createState() => _BluePageState();
}

class _BluePageState extends State<BluePage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamSubscription<List<ScanResult>>? scanSubscription;

  @override
  void initState() {
    super.initState();
    scan();
  }

  @override
  void dispose() {
    scanSubscription?.cancel();
    super.dispose();
  }

  scan() {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 100));

// Listen to scan results
    scanSubscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });

// Stop scanning
    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanning Devices'),
      ),
    );
  }
}
