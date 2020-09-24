import 'package:flutter/material.dart';
import 'package:quick_shelter/screens/dashboard/add_property_listing.dart';
import 'package:quick_shelter/screens/dashboard/change_password.dart';
import 'package:quick_shelter/screens/dashboard/create_pdf_receipt.dart';
import 'package:quick_shelter/screens/dashboard/dashboard_add_property2.dart';
import 'package:quick_shelter/screens/dashboard/edit_property_details.dart';
import 'package:quick_shelter/screens/dashboard/edit_property_listing.dart';
import 'package:quick_shelter/screens/dashboard/edit_property_photos.dart';
import 'package:quick_shelter/screens/dashboard/file_upload.dart';
import 'package:quick_shelter/screens/dashboard/identification.dart';
import 'package:quick_shelter/screens/dashboard/payment_webview.dart';
import 'package:quick_shelter/screens/dashboard/property_edit_main.dart';
import 'package:quick_shelter/screens/dashboard/property_listings_details.dart';
import 'package:quick_shelter/screens/dashboard/trans_details_photos.dart';
import 'package:quick_shelter/screens/dashboard/transaction_success.dart';
import 'package:quick_shelter/screens/dashboard/user_prop_details_documents.dart';
import 'package:quick_shelter/screens/dashboard/user_property_details.dart';
import 'package:quick_shelter/screens/dashboard/property_listings.dart';
import 'package:quick_shelter/screens/dashboard/search_result.dart';
import 'package:quick_shelter/screens/dashboard/user_property_documents_edit.dart';
import 'package:quick_shelter/screens/forgot_password.dart';
import 'package:quick_shelter/screens/public/search_property.dart';
import 'package:quick_shelter/screens/public/search_result.dart';
import 'package:quick_shelter/screens/splashscreen.dart';
import 'screens/dashboard/add_property_step_2.dart';
import 'screens/dashboard/add_property_step_3.dart';
import 'screens/dashboard/add_property_step_4.dart';
import 'screens/dashboard/basic_info.dart';
import 'screens/dashboard/collection_property_details.dart';
import 'screens/dashboard/dashboard_add_property.dart';
import 'screens/dashboard/profile.dart';
import 'screens/dashboard/property_details.dart';
import 'screens/dashboard/search_property.dart';
import 'screens/dashboard/transaction_details.dart';
import 'screens/dashboard/user_prop_details_photos.dart';
import 'screens/identity_card.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/public/collection_property_details_searched.dart';
import 'screens/public/property_details.dart';
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
    case addPropertyStep4Route:
      var propertyID = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddPropStep4(
                propertyData: propertyID,
              ));
    case addPropStep3Route:
      var propertyID = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddPropStep3(
                propDetails: propertyID,
              ));
    case profileRoute:
      return MaterialPageRoute(builder: (context) => Profile());
    case propDetailsRoute:
      var propertyDetails = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PropertyDetails(
                propertyDetails: propertyDetails,
              ));
    case propDetailsPublicRoute:
      var propertyDetails = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PropertyDetailsP(
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
        ),
      );
      case searchedPropDetailsRoute:
      var propertyDetails = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => CollPropertyDetailsSearched(
          propDetails: propertyDetails,
        ),
      );
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
        builder: (context) => PropertyListingDeatils(
          propDetails: propertyDetails,
        ),
      );
    case userPropertyDetailsRoute:
      var propertyDetails = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => UserPropertyDetails(
          propDetails: propertyDetails,
        ),
      );
    case editPropDetailsRoute:
      var propertyDetails = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => EditPropDetails(
          propDetails: propertyDetails,
        ),
      );
    case editPropListingRoute:
      //var propertyDetails = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => EditPropListing(),
      );
    case identificationRoute:
      //var propertyDetails = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => Identification(),
      );
    case editPropMainRoute:
      var propertyDetails = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => PropertyEditMain(
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
        ),
      );
    case searchPropPubRoute:
      return MaterialPageRoute(builder: (context) => SearchPropPub());
    case searchResultPubRoute:
      var propertyList = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => SearchResultPub(
          propertyList: propertyList,
        ),
      );
    case addPropertyListingRoute:
      var propertyList = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => AddPropListing(
          propDetails: propertyList,
        ),
      );
    case fileUploadRoute:
      return MaterialPageRoute(builder: (context) => FileUpload());
    case changePasswordRoute:
      return MaterialPageRoute(builder: (context) => ChangePassword());
    case forgotPasswordRoute:
      return MaterialPageRoute(builder: (context) => ForgotPassword());
    case paymentWebviewRoute:
      var paymentData = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PaymentWebview(paymentData: paymentData));
    case transSuccessRoute:
      var paymentData = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => TransSuccess(transDetails: paymentData));
    case transDetailPhotosRoute:
      var propData = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => TransDetailsPhotos(
          propDetails: propData,
        ),
      );
    case userPropDetailPhotosRoute:
      var propData = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => UserPropDetailsPhotos(
          propDetails: propData,
        ),
      );
    case userPropDetailDocRoute:
      var propData = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => UserPropDetailsDoc(
          propDetails: propData,
        ),
      );
    case userPropDocEditRoute:
      var propData = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => UserPropDocEdit(
          propertyData: propData,
        ),
      );
    case createPdfRoute:
      var propData = settings.arguments;
      return MaterialPageRoute(builder: (context) => CreatePdf());
    case editPropPhotosRoute:
      var propData = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => EditPropertyPhotos(
          propertyData: propData,
        ),
      );
    case splashScreenRoute:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    default:
      return MaterialPageRoute(builder: (context) => WelcomePage());
  }
}
