import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../constants.dart';

class DashboardTransactions extends StatefulWidget {
  @override
  _DashboardTransactionsState createState() => _DashboardTransactionsState();
}

class _DashboardTransactionsState extends State<DashboardTransactions> {
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
                text: 'Tolulope',
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
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemBuilder: _buildItemsForListView,
                itemCount: 4,
                scrollDirection: Axis.vertical,
              ),
            )
          ],
        ),
      ),
    );
  }

  Card _buildItemsForListView(BuildContext context, int index) {
    return _propertItem(context);
  }

  Widget _propertItem(ctxt) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        splashColor: Colors.orange.withAlpha(30),
        onTap: () {
          print('Transaction tapped');
          //Navigator.pushNamed(ctxt, transactionDetailsRoute);
        },
        child: Container(
          margin: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Bungalow Semi Detached', style: TextStyle(color: appTextColorPrimary),),
              Icon(Icons.keyboard_arrow_right, color: appTextColorPrimary,),
            ],
          ),
        ),
      ),
    );
  }
}
