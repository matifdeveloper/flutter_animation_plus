import 'package:flutter/material.dart';
import 'package:flutter_animation_plus/animations/animations.dart';
import 'package:flutter_animation_plus/flutter_animation_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScalingAnimation(
                duration: Duration(seconds: 1),
                repeat: true,
                child: Text(
                  "Scaling Animation",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              RotatingAnimation(
                duration: Duration(seconds: 1),
                repeat: true,
                child: Text(
                  "Rotating Animation",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
