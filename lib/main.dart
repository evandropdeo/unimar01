import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

void main() {
  runApp(const MyApp());
}

const audioPath = "assets/JamMaster.mp3";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unimar v 1.0',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 15, 8, 150)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pagina da hora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String formattedDate =
      DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  bool _isPlaying = false;

  void _playAudio() {
    if (_isPlaying) {
      _assetsAudioPlayer.pause();
    } else {
      _assetsAudioPlayer.open(
        Audio(audioPath),
        autoStart: true,
      );
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Horário atual:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            //Text(
            //  formattedDate,
            //  style: Theme.of(context).textTheme.headlineMedium,
            //),
            TimerBuilder.periodic(const Duration(seconds: 1),
                alignment: Duration.zero, builder: (context) {
              String formattedDate =
                  DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());
              return Text(
                formattedDate,
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
            ElevatedButton(
              onPressed: _playAudio,
              child: Text(
                _isPlaying ? 'Pause Audio' : 'Play Audio',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
