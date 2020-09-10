import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'router.dart' as router;


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp,]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Shelter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.green,
        hintColor: Color.fromRGBO(226, 208, 195, 1),
        primaryColor: Colors.orange,
        highlightColor: Color.fromRGBO(226, 208, 195, 1),
        fontFamily: "Product-Sans",
        accentColor: Color.fromRGBO(226, 208, 195, 1),
        cursorColor: Color.fromRGBO(226, 208, 195, 1),
        disabledColor: Color.fromRGBO(226, 208, 195, 1),
        
        
        textTheme: TextTheme(
          button: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, ),
          bodyText1: TextStyle(fontSize: 15.0, color:Colors.white,),        
        ),        
      ),

      onGenerateRoute: router.generateRoute,
      initialRoute:splashScreenRoute,
      // home: Login(),
    );
  }
}
