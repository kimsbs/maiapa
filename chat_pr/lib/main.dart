import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_pr/screen/home_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'database/drift_database.dart';
import 'package:get_it/get_it.dart';


void main() {
  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(Home());
}

// Execute HomeScreen
class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '마이아파',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Builder(
        builder: (context) {
          return AnimatedSplashScreen(
            splashIconSize: MediaQuery.of(context).size.height,
            duration: 1000,
            nextScreen: HomePage(),
            splash: Center(
              child: Container(
                child: AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(seconds: 1),
                  child: Image.asset('asset/img/SScreen1.png'),
                ),
              ),
            ),
          );
        }
      ),
      //HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: FutureBuilder(
        future: checkPermission(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == '위치 권한이 허가되었습니다.') {
            return Center(
              // Call screen/home_screen/HomeScreen()
              child: HomeScreen(),
            );
          }
          return Center(
            child: Text(snapshot.data),
          );
        },
      ),
    );
  }

  // Check Permission for the Google map
  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 활성화해주세요.';
    }

    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }

    if (checkedPermission == LocationPermission.deniedForever) {
      return '설정에서 앱의 위치 권한을 허가해주세요.';
    }
    print('check Permission successed');
    return '위치 권한이 허가되었습니다.';
  }
}
