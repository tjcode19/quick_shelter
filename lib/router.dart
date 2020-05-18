import 'package:flutter/material.dart';
import 'package:quick_shelter/screens/identity_card.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/reg_complete.dart';
import 'screens/verify_phone.dart';
import 'screens/get_started.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/welcome.dart';
import 'constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  switch (settings.name) {
    case welcomeRoute:
      return MaterialPageRoute(builder: (context) => WelcomePage());
    case getStartedRoute:
      return MaterialPageRoute(builder: (context) => GetStarted());
    case loginRoute:
      return MaterialPageRoute(builder: (context) => Login());
    case signUpRoute:
      return MaterialPageRoute(builder: (context) => SignUp());
    case verifyPhoneRoute:
      return MaterialPageRoute(builder: (context) => VerifyPhone());
    case identityCardRoute:
      return MaterialPageRoute(builder: (context) => IdentityCard());
    case regCompletedRoute:
      return MaterialPageRoute(builder: (context) => RegCompleted());
    case dashboardRoute:
      return MaterialPageRoute(builder: (context) => Dashboard());
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
