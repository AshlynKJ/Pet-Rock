import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:life_of_rocks/camera__page.dart';
import 'package:life_of_rocks/creation__page.dart';
import 'package:life_of_rocks/home__page.dart';
import 'package:life_of_rocks/user_data_model.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';

late List<CameraDescription> cameras;

final AudioPlayer player = AudioPlayer();

void main() async {
  // stuff so we can use the camera later
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  await player.setUrl('https://www2.cs.uic.edu/~i101/SoundFiles/StarWars60.wav');
  await player.setLoopMode(LoopMode.all);
  player.play();

  runApp(ChangeNotifierProvider(
      create: (context) {
        
      var model = UserDataModel();
      model.initFromPrefs();
      return model;
    
      } , child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool first = true;
  
  Future<void> _first() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    first = prefs.getBool('fLaunch') ?? true;
  }

  @override
  void initState() {
    super.initState();
    _initializeFirstLaunch();
  }

  Future<void> _initializeFirstLaunch() async {
  await _first();
  setState(() {});
}

  Future<void> complete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('fLaunch', false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: !first
            ? const App()
            : Scaffold(
              body: SafeArea(
                minimum: const EdgeInsets.all(50.0),
                child: OrientationBuilder(builder: (context, orientation) {
                    return Flex(
                      direction: orientation == Orientation.portrait
                  ? Axis.vertical
                  : Axis.horizontal,
                      children: [
                          
                          Expanded(
                            child: GestureDetector(
                              child: Center(
                                child: 
                              Text('Tap Here!', style: Theme.of(context).textTheme.headlineLarge)),
                              onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CreationPage()),
                              );
                              complete();
                              _initializeFirstLaunch();
                            }),
                          ),
                        
                      
                    ]);
                  }),
              ),
            ));
  }
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life of Rock',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Your Pet Rock'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
          bottom: const TabBar(
            tabs: [
              Tab(text: "home"),
              Tab(text: "camera"),
            ],
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(16.0),
          child: TabBarView(children: [
            const HomePage(),
            CameraPage(cameras: cameras),
          ]),
        ),
      ),
    );
  }
}
