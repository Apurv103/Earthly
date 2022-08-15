import 'package:C1O2/helpers/colors.dart';
import 'package:C1O2/screens/Authentication/login_screen.dart';
import 'package:C1O2/screens/home/startScreen.dart';
import 'package:C1O2/screens/reduce/reduce_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import './screens/result/result_screen.dart';
import './screens/calculator/user_inputs.dart';
import './screens/calculator/user_input_questions.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Questions())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Earthly',
        theme: ThemeData(
          fontFamily: "Orbitron",
          primarySwatch: Colors.indigo,
          cursorColor: ColorPallete.color3,
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: ColorPallete.color3,
            )),
          ),

          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
        //initialRoute: routes.LoginScreen,
        // home: ResultScreen(
        //         activityName: "Household",
        //         userEmission: 70,
        //         averageEmission: 50,
        //       ),//HomeScreen.routeName,
       // routes: {
          //LoginScreen.routeName: (context) => LoginScreen(),
          //StartScreen.routeName: (context) => StartScreen(),
          //UserInputs.routeName: (context) => UserInputs(),
          //ReduceEmissionScreen.routeName: (context) => ReduceEmissionScreen(),
        //},
        // initialRoute: StartScLogireen.routeName,
        // home: ResultScreen(
        //         activityName: "Household",
        //         userEmission: 70,
        //         averageEmission: 50,
        //       ),//HomeScreen.routeName,
        // routes: {
        // //  LoginScreen.routeName: (context) => LoginScreen(),
        //   StartScreen.routeName: (context) => StartScreen(),
        //   UserInputs.routeName: (context) => UserInputs(),
        //   ReduceEmissionScreen.routeName: (context) => ReduceEmissionScreen(),
        // },
      ),
    );
  }
}
