
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CornerProvider(),
      child: const MyApp(),
    ),
  );
}

// Клас для керування станом
class CornerProvider extends ChangeNotifier {
  double topLeft = 50;
  double topRight = 0;
  double bottomLeft = 50;
  double bottomRight = 0;

  void changeTopLeft(double value) {
    topLeft = value;
    notifyListeners();
  }

  void changeTopRight(double value) {
    topRight = value;
    notifyListeners();
  }

  void changeBottomLeft(double value) {
    bottomLeft = value;
    notifyListeners();
  }

  void changeBottomRight(double value) {
    bottomRight = value;
    notifyListeners();
  }
}

// Головний додаток
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider Lab 12',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF7FF),
      ),
      home: const HomePage(),
    );
  }
}

// Головна сторінка
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hordiienko Roman IPZ-32'),
        centerTitle: true,
        backgroundColor: const Color(0xFFD3B8F8),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40),
            BlueContainerSection(),
            SizedBox(height: 60),
            SlidersSection(),
          ],
        ),
      ),
    );
  }
}

// Окремий віджет для синього контейнера
class BlueContainerSection extends StatelessWidget {
  const BlueContainerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CornerProvider>();

    return Center(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(provider.topLeft),
            topRight: Radius.circular(provider.topRight),
            bottomLeft: Radius.circular(provider.bottomLeft),
            bottomRight: Radius.circular(provider.bottomRight),
          ),
        ),
      ),
    );
  }
}

// Окремий віджет із чотирма слайдерами
class SlidersSection extends StatelessWidget {
  const SlidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CornerProvider>();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: RadiusSlider(
                label: 'TL',
                value: provider.topLeft,
                onChanged: provider.changeTopLeft,
              ),
            ),
            Expanded(
              child: RadiusSlider(
                label: 'TR',
                value: provider.topRight,
                onChanged: provider.changeTopRight,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: RadiusSlider(
                label: 'BL',
                value: provider.bottomLeft,
                onChanged: provider.changeBottomLeft,
              ),
            ),
            Expanded(
              child: RadiusSlider(
                label: 'BR',
                value: provider.bottomRight,
                onChanged: provider.changeBottomRight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Кастомний віджет одного слайдера
class RadiusSlider extends StatelessWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const RadiusSlider({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$label: ${value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 13),
        ),
        Slider(
          value: value,
          min: 0,
          max: 75,
          activeColor: Colors.deepPurple,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
