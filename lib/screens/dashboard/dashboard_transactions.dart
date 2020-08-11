import 'package:flutter/material.dart';
import 'package:quick_shelter/models/TransactionListResponse.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';

import '../../colors.dart';
import '../../constants.dart';

class DashboardTransactions extends StatefulWidget {
  @override
  _DashboardTransactionsState createState() => _DashboardTransactionsState();
}

class _DashboardTransactionsState extends State<DashboardTransactions> {
  final QuickShelterRepository repo = QuickShelterRepository();
  List<Data> _propertyList = List<Data>();
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String _prefUserFN;

  void _getTransactionList() async {
    print('Get Transaction List');
    //showLoadingDialog(context, _keyLoader);
    var _apiCall = repo.getTransactionList('0', '100');

    await _apiCall.then((value) {
      print('TransList DONE ${value.responseCode}');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {

        value.data..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        setState(() => {
              _propertyList = value.data,
              print('TarnsList: ${_propertyList.length}')
            });
      } else {
        //showInSnackBar(value.message);
        print('Failed to load transaction list');
      }
    },
       onError: (e) {
     // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
     print('Failed to load transaction list ${e.toString()}');
   }
    );
  }

  Future _getUserProfile() async {
    _prefUserFN = await _sharedPreferenceQS.getSharedPrefs(String, 'userFN');
    setState(() {
      _prefUserFN = _prefUserFN;
    });
  }

  @override
  void initState() {
    super.initState();
    _getTransactionList();
    _getUserProfile();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {

    //   await showLoadingDialog(context, _keyLoader);
    // });
  }

  @override
  Widget build(BuildContext context) {
    /*24 is for notification bar on Android*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Container(
          padding: EdgeInsets.all(8),
          child: ClipOval(
            child: Material(
              color: appTextColorPrimary2, // button color
              child: InkWell(
                splashColor: Colors.orange[100], // inkwell color
                child: Image.asset(
                  'assets/images/person.png',
                  color: appSecondaryColor,
                  height: 24.0,
                  width: 24.0,
                ),
                onTap: () {
                  Navigator.pushNamed(context, profileRoute);
                },
              ),
            ),
          ),
        ),
        actions: <Widget>[],
        title: RichText(
          text: TextSpan(
            text: 'Hi, ',
            style: TextStyle(fontSize: 16, color: appTextColorPrimary),
            children: <TextSpan>[
              TextSpan(
                text: '$_prefUserFN',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Transactions',
                style: TextStyle(color: appSecondaryColor, fontSize: 18.0),
              ),
            ),
            const SizedBox(height: 20),
            (_propertyList.length > 0)
                ? Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemBuilder: _buildItemsForListView,
                      itemCount: _propertyList.length,
                      scrollDirection: Axis.vertical,
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: Text('No Record Found'),
                  )
          ],
        ),
      ),
    );
  }

  Card _buildItemsForListView(BuildContext context, int index) {
    return _propertItem(context, index);
  }

  Widget _propertItem(ctxt, index) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        splashColor: Colors.orange.withAlpha(30),
        onTap: () {
          print('Transaction tapped');
          Navigator.pushNamed(ctxt, transactionDetailsRoute, arguments: _propertyList[index]);
        },
        child: Container(
          margin: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  (_propertyList[index].listing.property.title != null)
                      ? _propertyList[index].listing.property.title
                      : 'Property',
                  softWrap: true,
                  style: TextStyle(color: appTextColorPrimary),
                ),
              ),
              const SizedBox(width:3),
              Icon(
                Icons.keyboard_arrow_right,
                color: appTextColorPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
