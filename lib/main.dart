import 'package:flutter/material.dart';
import 'package:reso_weather_states_builder/data/weather_repository.dart';
//import 'package:reso_weather_states_builder/pages/weather_search_page.dart';
import 'package:reso_weather_states_builder/state/weather_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

final weatherStore =
    RM.inject<WeatherStore>(() => WeatherStore(FakeWeatherRepository()));

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Login Screen',
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggedIn = false;

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  void _setLoginStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('is_logged_in', value);

    setState(() {
      _isLoggedIn = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoggedIn ? const HomeScreen() : LoginButton(_setLoginStatus),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function(bool) setLoginStatus;

  const LoginButton(this.setLoginStatus, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setLoginStatus(true);
      },
      child: const Text('Login'),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Welcome to the home screen',
      style: TextStyle(fontSize: 24),
    );
  }
}






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
