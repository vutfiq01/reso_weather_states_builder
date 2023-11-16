import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reso_weather_states_builder/data/model/contact.dart';
import 'package:reso_weather_states_builder/data/weather_repository.dart';
import 'package:reso_weather_states_builder/pages/contact_page.dart';
//import 'package:reso_weather_states_builder/pages/weather_search_page.dart';
import 'package:reso_weather_states_builder/state/weather_store.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final weatherStore =
    RM.inject<WeatherStore>(() => WeatherStore(FakeWeatherRepository()));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.initFlutter('hive_db');
  Hive.registerAdapter<Contact>(ContactAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.box('contacts').compact();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive Tutorial',
      home: FutureBuilder(
        future: Hive.openBox(
          'contacts',
          compactionStrategy: (
            int totalEntries,
            int numberOfDeletedEntries,
          ) {
            return numberOfDeletedEntries > 20;
          },
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const ContactPage();
            }
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Flutter Login Screen',
//       home: LoginScreen(),
//     );
//   }
// }

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _isLoggedIn = false;

//   void _checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

//     setState(() {
//       _isLoggedIn = isLoggedIn;
//     });
//   }

//   void _setLoginStatus(bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     await prefs.setBool('is_logged_in', value);

//     setState(() {
//       _isLoggedIn = value;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _isLoggedIn ? const HomeScreen() : LoginButton(_setLoginStatus),
//       ),
//     );
//   }
// }

// class LoginButton extends StatelessWidget {
//   final Function(bool) setLoginStatus;

//   const LoginButton(this.setLoginStatus, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         setLoginStatus(true);
//       },
//       child: const Text('Login'),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Text(
//       'Welcome to the home screen',
//       style: TextStyle(fontSize: 24),
//     );
//   }
// }






// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late TextEditingController textController;
//   static const String dataKey = 'persist_data';
//   var prefsSavedValue = '';

//   @override
//   void initState() {
//     textController = TextEditingController();
//     super.initState();
//     getValue();
//   }

//   void getValue() async {
//     var prefs = await SharedPreferences.getInstance();
//     prefsSavedValue = prefs.getString(dataKey) ?? 'No Data Saved';
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Material App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Shared Preference'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextField(
//                   controller: textController,
//                   decoration: InputDecoration(
//                       hintText: 'Type data',
//                       label: const Text('Persistant Data'),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16.0))),
//                 ),
//                 const SizedBox(
//                   height: 11.0,
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     var data = textController.text.toString();
//                     textController.clear();
//                     var prefs = await SharedPreferences.getInstance();
//                     await prefs.setString(dataKey, data);
//                     prefsSavedValue =
//                         prefs.getString(dataKey) ?? 'No Data Saved';

//                     setState(() {});
//                   },
//                   child: const Text('Save Data'),
//                 ),
//                 const SizedBox(
//                   height: 11.0,
//                 ),
//                 Text('Shared Preference Data: $prefsSavedValue'),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: StateBuilder<WeatherStore>(
//         observe: () => weatherStore,
//         builder: (context, weatherStoreRM) {
//           return const WeatherSearchPage();
//         },
//       ),
//     );
//   }
// }
