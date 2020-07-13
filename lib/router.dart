import 'package:flutter/material.dart';
import 'package:quick_shelter/screens/dashboard/change_password.dart';
import 'package:quick_shelter/screens/dashboard/dashboard_add_property2.dart';
import 'package:quick_shelter/screens/dashboard/file_upload.dart';
import 'package:quick_shelter/screens/dashboard/property_listing_details.dart';
import 'package:quick_shelter/screens/dashboard/property_listings.dart';
import 'package:quick_shelter/screens/dashboard/search_result.dart';
import 'package:quick_shelter/screens/forgot_password.dart';
import 'screens/dashboard/add_property_step_2.dart';
import 'screens/dashboard/add_property_step_3.dart';
import 'screens/dashboard/basic_info.dart';
import 'screens/dashboard/collection_property_details.dart';
import 'screens/dashboard/dashboard_add_property.dart';
import 'screens/dashboard/profile.dart';
import 'screens/dashboard/property_details.dart';
import 'screens/dashboard/search_property.dart';
import 'screens/dashboard/transaction_details.dart';
import 'screens/identity_card.dart';
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
    case addPropertyRoute:
      return MaterialPageRoute(builder: (context) => DashboardAddProp());
    case addProperty2Route:
      var propDetails = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => DashboardAddProp2(
                propData: propDetails,
              ));
    case addPropertyStep2Route:
      var propertyID = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddPropStep2(
                propertyData: propertyID,
              ));
    case addPropertyStep3Route:
      var propertyID = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddPropStep3(
                propertyData: propertyID,
              ));
    case profileRoute:
      return MaterialPageRoute(builder: (context) => Profile());
    case propDetailsRoute:
      var propertyDetails = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PropertyDetails(
                propertyDetails: propertyDetails,
              ));
    case transactionDetailsRoute:
      var propertyDetails = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => TransactionDetails(
                propertyDetails: propertyDetails,
              ));
    case collPropDetailsRoute:
      var propertyDetails = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => CollPropertyDetails(
                propDetails: propertyDetails,
              ));
    case propertyListingsRoute:
      var propertyDetails = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => PropertyListings(
          propDetails: propertyDetails,
        ),
      );
    case propertyListingDetailsRoute:
      var propertyDetails = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => PropertyListingDetails(
          propDetails: propertyDetails,
        ),
      );
    case personalInfoRoute:
      return MaterialPageRoute(builder: (context) => BasicInfo());
    case searchPropRoute:
      return MaterialPageRoute(builder: (context) => SearchProp());
    case searchResultRoute:
      var propertyList = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => SearchResult(
                propertyList: propertyList,
              ));
    case fileUploadRoute:
      return MaterialPageRoute(builder: (context) => FileUpload());
    case changePasswordRoute:
      return MaterialPageRoute(builder: (context) => ChangePassword());
    case forgotPasswordRoute:
      return MaterialPageRoute(builder: (context) => ForgotPassword());
    default:
      return MaterialPageRoute(builder: (context) => WelcomePage());
  }
}
