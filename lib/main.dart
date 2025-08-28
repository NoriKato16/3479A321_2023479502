import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 35, 190, 53),
        ),
      ),
      home: const MyHomePage(title: '2023479502'),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _color = Colors.cyanAccent;
  final Color _newColor = Colors.red;

  void _incrementCounter() => setState(() {
    _counter++;
  });

  void _decrementCounter() => setState(() {
    _counter--;
  });

  void _restartCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _setColor() {
    setState(() {
      if (_color != Colors.green) {
        _color = Colors.green;
      } else {
        _color = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    logger.d("Logger is working!");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var persistentFooterButtons = [
      FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: _newColor,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
      FloatingActionButton(
        onPressed: _decrementCounter,
        tooltip: 'Decrementar',
        child: const Icon(Icons.remove),
      ),
      FloatingActionButton(
        onPressed: _restartCounter,
        tooltip: 'Restaurar',
        child: const Icon(Icons.refresh),
      ),
      FloatingActionButton(
        onPressed: _setColor,
        backgroundColor: _color,
        tooltip: 'Custom Action',
        child: const Icon(Icons.star),
      ),
    ];
    var scaffold = Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Pixel Art sobre una grilla personalizable'),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(
                    'assets/Pixel-Art-Hot-Pepper-2-1.webp',
                    width: 400,
                  ),
                  Image.asset('assets/Pixel-Art-Pizza-2.webp', width: 400),
                  Image.asset('assets/Pixel-Art-Watermelon-3.webp', width: 400),
                ],
              ),
            ),

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: _color,
        tooltip: 'Increment',
        child: const Icon(Icons.home),
      ),
      persistentFooterButtons: persistentFooterButtons,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
    return scaffold;
  }
}
