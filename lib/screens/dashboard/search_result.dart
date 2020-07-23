import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_shelter/models/GetAllProperties.dart';
import 'package:quick_shelter/utils/commonFunctions.dart';

import '../../colors.dart';
import '../../constants.dart';

class SearchResult extends StatefulWidget {
  final propertyList;
  const SearchResult({Key key, this.propertyList}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

List<GetAllPropData> searchedPropList;  
  
  @override
  void initState() {
    super.initState();
    searchedPropList = widget.propertyList;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Search results',
                      style:
                          TextStyle(color: appSecondaryColor, fontSize: 20.0),
                    ),
                    Text(
                      '${searchedPropList.length} results',
                      style:
                          TextStyle(color: appColorSecondary, fontSize: 17.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: OutlineButton(
                        padding: EdgeInsets.all(6),
                        color: Colors.white,
                        highlightedBorderColor: Colors.white,
                        borderSide: BorderSide(color: appColorSecondary),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15))),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 3, 4, 4),
                          child: Text(
                            searchedPropList[0].listingType,
                            style: TextStyle(
                                color: appColorSecondary, fontSize: 13),
                          ),
                        ),
                        onPressed: () {
                          //showSnackBar("OutlineButton with Shape");
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                          backgroundColor: appSecondaryColor,
                          child: Icon(
                            Icons.tune,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: size.height,
                child: CustomScrollView(
                  primary: false,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(0),
                      sliver: SliverGrid.count(
                        crossAxisSpacing: 5,
                        childAspectRatio: ((itemWidth + 10) / (itemHeight)),
                        mainAxisSpacing: 1,
                        crossAxisCount: 2,
                        children:
                          searchedPropList.map((e)=>
                              _propertItem(searchedPropList.indexOf(e), context)).toList(),

                          
                          //_propertItem(context),
                          //_propertItem(context),
                        
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _propertItem(int index, ctxt) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        splashColor: Colors.orange.withAlpha(30),
        onTap: () {
          print('Card tapped.');
          Navigator.pushNamed(ctxt, collPropDetailsRoute);
        },
        child: Container(
          margin: EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/prop.png',
                width: 175,
                height: 123,
                fit: BoxFit.cover,
              ),
              Container(
                width: 172,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),                    
                    RichText(
                        text: TextSpan(
                          text: '₦ ',
                          style: TextStyle(
                              fontSize: 13, color: appSecondaryColorLight),
                          children: <TextSpan>[
                            TextSpan(
                              text: (searchedPropList[index].price != null)?
                              formatMoney(searchedPropList[index].price.toDouble()).withoutFractionDigits:'0',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: appTextColorPrimary,
                              ),
                            ),
                            TextSpan(
                              text: '.00',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                color: appSecondaryColorLight,
                              ),
                            )
                          ],
                        ),
                      ),
                    const SizedBox(height: 5),
                    Text(
                      'Studio Apartment',
                      style:
                          TextStyle(fontSize: 13, color: appTextColorPrimary),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 2.0),
                          child: Icon(
                            Icons.location_on,
                            size: 10,
                            color: Colors.orange,
                          ),
                        ),
                        Container(
                          child: Expanded(
                            child: Text(
                              searchedPropList[index].property.location,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/bed.svg',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        Text('3 Bed',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0)),
                        const SizedBox(width: 15),
                        SvgPicture.asset(
                          'assets/icons/bath.svg',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        Text('2 Bath',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
