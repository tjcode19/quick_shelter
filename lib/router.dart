import 'package:flutter/material.dart';
import 'get_started.dart';
import 'login.dart';
import 'signup.dart';
import 'welcome.dart';
import 'constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  switch (settings.name) {
    case welcomeRoute:
      return MaterialPageRoute(builder: (context) => WelcomePage());
    case getStartedRoute:
      return MaterialPageRoute(builder: (context) => GetStarted() );
    case loginRoute:
      return MaterialPageRoute(builder: (context) => Login());
    case signUpRoute:
      return MaterialPageRoute(builder: (context) => SignUp());
    // case basicInfoRoute:
    //   return MaterialPageRoute(builder: (context) => BasicInfo());
    // case updateKYCRoute:
    //   return MaterialPageRoute(builder: (context) => UpdateKYC());
    // case addBVNRoute:
    //   return MaterialPageRoute(builder: (context) => AddBVN());
    // case passwordRoute:
    //   return MaterialPageRoute(builder: (context) => PasswordSettings());
    // case cardSettingsRoute:
    //   return MaterialPageRoute(builder: (context) => CardSettings());
    // case availableCardsRoute:
    //   return MaterialPageRoute(builder: (context) => AvailableCards());
    // case loanRequestOneRoute:
    //   return MaterialPageRoute(builder: (context) => LoanRequestOne());
    // case loanRequestTwoRoute:
    //   return MaterialPageRoute(builder: (context) => LoanRequestTwo());
    // case loanRequestThreeRoute:
    //   return MaterialPageRoute(builder: (context) => LoanRequestThree());
    // case loanRequestFourRoute:
    //   return MaterialPageRoute(builder: (context) => LoanRequestFour());
    // case loginPassRoute:
    //   return MaterialPageRoute(builder: (context) => LoginPass());
    // case loginRoute:
    //   return MaterialPageRoute(builder: (context) => Login());
    default:
      return MaterialPageRoute(builder: (context) => WelcomePage());
  }
}
