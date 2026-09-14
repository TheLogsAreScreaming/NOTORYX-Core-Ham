import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  runApp(const BastionBootstrapApp());
}

class BastionBootstrapApp extends StatelessWidget {
  const BastionBootstrapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bastion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0D0E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF18D7D0),
          brightness: Brightness.dark,
        ),
      ),
      home: const BastionStartupScreen(),
    );
  }
}

class BastionStartupScreen extends StatelessWidget {
  const BastionStartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF18D7D0), width: 5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.fort, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  'BASTION',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800, letterSpacing: 5),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Startup diagnostic build',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF18D7D0), fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  'If you can see this screen, the Android shell and Flutter runtime are healthy. We can then re-enable MeshCore services in controlled stages.',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.4, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
