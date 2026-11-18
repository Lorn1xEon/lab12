
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

class CornerProvider extends ChangeNotifier {
  final List<double> corners = [0, 0, 0, 0];

  void changeCorner(int index, double value) {
    corners[index] = value;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Corner configurator'),
        centerTitle: true
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContainerPreview(),
            SizedBox(height: 40),
            CornerSliders(),
          ],
        ),
      ),
    );
  }
}

class ContainerPreview extends StatelessWidget {
  const ContainerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final corners = context.watch<CornerProvider>().corners;

    return Center(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(corners[0]),
            topRight: Radius.circular(corners[1]),
            bottomLeft: Radius.circular(corners[2]),
            bottomRight: Radius.circular(corners[3]),
          ),
        ),
      ),
    );
  }
}

class CornerSliders extends StatelessWidget {
  const CornerSliders({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CornerProvider>();
    final names = [
      'Top left',
      'Top right',
      'Bottom left',
      'Bottom right',
    ];

    return Column(
      children: List.generate(4, (index) {
        return Column(
          children: [
            Text(
              '${names[index]}: ${provider.corners[index].round()}',
            ),
            Slider(
              value: provider.corners[index],
              min: 0,
              max: 75,
              divisions: 75,
              onChanged: (value) {
                provider.changeCorner(index, value);
              },
            ),
          ],
        );
      }),
    );
  }
}
