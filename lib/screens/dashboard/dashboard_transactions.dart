import 'package:flutter/material.dart';
import 'package:quick_shelter/models/TransactionListResponse.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';

import '../../colors.dart';
import '../../constants.dart';

class DashboardTransactions extends StatefulWidget {
    
  @override
  _DashboardTransactionsState createState() => _DashboardTransactionsState();
}

class _DashboardTransactionsState extends State<DashboardTransactions> {

  final QuickShelterRepository repo = QuickShelterRepository();
  List<TransactionListResponse> _propertyList = List<TransactionListResponse>();
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  String _prefUserFN;

   void _getTransactionList() async {
    print('Get Transaction List');
    //showLoadingDialog(context, _keyLoader);
    var _apiCall = repo.getTransactionList('0','10');

    await _apiCall.then((value) {
      print('donnned $value');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value != null) {
        setState(() => {
          _propertyList = value.getTransList,
          //print(_propertyList[0].listingID)
        });
      } else {
        //showInSnackBar(value.message);
        print('Failed to load transaction list');
      }
    });
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
           // (_propertyList.length>0)?
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemBuilder: _buildItemsForListView,
                itemCount: 3,
                scrollDirection: Axis.vertical,
              ),
            )
            // :
            //  Expanded(
            //   flex: 1,
            //   child: Text('No Record Found'),
            // )
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
          Navigator.pushNamed(ctxt, transactionDetailsRoute);
        },
        child: Container(
          margin: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('_propertyList[index].listing.property.title', style: TextStyle(color: appTextColorPrimary),),
              Icon(Icons.keyboard_arrow_right, color: appTextColorPrimary,),
            ],
          ),
        ),
      ),
    );
  }
}
