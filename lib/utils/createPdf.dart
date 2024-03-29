import 'dart:io';

import 'package:flutter_share/flutter_share.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:quick_shelter/utils/commonFunctions.dart';

Widget detailsRow(String tag, var value) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          tag,
          textScaleFactor: 2,
          style: TextStyle(fontSize: 12, color: PdfColor.fromHex('#707070')),
        ),
        (tag != 'Price')
            ? Text(
                value,
                textScaleFactor: 2,
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            : RichText(
                textScaleFactor: 2,
                text: TextSpan(
                  text: 'NGN ',
                  style: TextStyle(
                    fontSize: 10,
                    color: PdfColor.fromHex('#707070'),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: (value != 'NA')
                          ? formatMoney(value).withoutFractionDigits
                          : '0',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                    TextSpan(
                      text: '.00',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: PdfColor.fromHex('#707070'),
                      ),
                    )
                  ],
                ),
              ),
      ],
    );

reportView(context, dataDet) async {
  final Document pdf = Document();

  pdf.addPage(Page(
      pageFormat: PdfPageFormat.a4,
      build: (Context context) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(10.0),
            color: PdfColor.fromHex('#FF9300'),
            child: Row(
              children: [
                // PdfLogo(),
                // SizedBox(width: 15),
                Text("Quick Shelter",
                    textScaleFactor: 2,
                    style: TextStyle(
                        color: PdfColor.fromHex('#ffffff'), fontSize: 15)),
              ],
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Transaction Details',
                textScaleFactor: 2,
                style: TextStyle(fontSize: 15),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                decoration: BoxDecoration(
                  color: PdfColor.fromHex('#D7F7DF'),
                ),
                child: Text(
                  'Sucess',
                  style: TextStyle(
                      color: PdfColor.fromHex('#019D32'), fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const BoxDecoration(
              border: BoxBorder(
                  bottom: true, width: 0.5, color: PdfColors.orangeAccent),
            ),
          ),
          SizedBox(height: 30),
          detailsRow('Property Owner', dataDet['name']),
          SizedBox(height: 15),
          detailsRow('Customer', dataDet['customer']),
          SizedBox(height: 15),
          detailsRow('Price', dataDet['price']),
          SizedBox(height: 15),
          detailsRow('Payment ID', '67654567878'),
          SizedBox(height: 15),
          detailsRow('Payment Date', '25th July, 2020'),
          SizedBox(height: 45),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const BoxDecoration(
              border:
                  BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey),
            ),
            child: Text('Quick Shelter, 2020',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)),
          )
        ]);
        // Center
      }));

  // pdf.addPage(MultiPage(
  //     pageFormat:
  //         PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     header: (Context context) {
  //       if (context.pageNumber == 1) {
  //         return null;
  //       }
  //       return Container(
  //           alignment: Alignment.centerRight,
  //           margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
  //           padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
  //           decoration: const BoxDecoration(
  //               border:
  //                   BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
  //           child: Text('Report',
  //               style: Theme.of(context)
  //                   .defaultTextStyle
  //                   .copyWith(color: PdfColors.grey)));
  //     },
  //     // footer: (Context context) {
  //     //   return Container(
  //     //       alignment: Alignment.centerRight,
  //     //       margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
  //     //       child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
  //     //           style: Theme.of(context)
  //     //               .defaultTextStyle
  //     //               .copyWith(color: PdfColors.grey)));
  //     // },
  //     build: (Context context) => <Widget>[
  //           Header(
  //               level: 0,
  //               child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: <Widget>[
  //                     Text('Payment Receipt', textScaleFactor: 2),
  //                     PdfLogo()
  //                   ])),
  //           Header(level: 1, text: 'What is Lorem Ipsum?'),
  //           Paragraph(
  //               text:
  //                   'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
  //           Paragraph(
  //               text:
  //                   'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using "Content here, content here", making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for "lorem ipsum" will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'),
  //           Header(level: 1, text: 'Where does it come from?'),
  //           Paragraph(
  //               text:
  //                   'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
  //           Paragraph(
  //               text:
  //                   'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
  //           Padding(padding: const EdgeInsets.all(10)),
  //           Table.fromTextArray(context: context, data: const <List<String>>[
  //             <String>['Year', 'Ipsum', 'Lorem'],
  //             <String>['2000', 'Ipsum 1.0', 'Lorem 1'],
  //             <String>['2001', 'Ipsum 1.1', 'Lorem 2'],
  //             <String>['2002', 'Ipsum 1.2', 'Lorem 3'],
  //             <String>['2003', 'Ipsum 1.3', 'Lorem 4'],
  //             <String>['2004', 'Ipsum 1.4', 'Lorem 5'],
  //             <String>['2004', 'Ipsum 1.5', 'Lorem 6'],
  //             <String>['2006', 'Ipsum 1.6', 'Lorem 7'],
  //             <String>['2007', 'Ipsum 1.7', 'Lorem 8'],
  //             <String>['2008', 'Ipsum 1.7', 'Lorem 9'],
  //           ]),
  //         ]));
  //save PDF
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(pdf.save());

  //OpenFile.open(path);

  shareFile(path);
  // material.Navigator.of(context).push(
  //   material.MaterialPageRoute(
  //     builder: (_) => PdfViewerPage(path: path),
  //   ),
  // );
}

Future<void> shareFile(path) async {
    // List<dynamic> docs = await DocumentsPicker.pickDocuments;
    // if (docs == null || docs.isEmpty) return null;

    await FlutterShare.shareFile(
      title: 'Example share',
      text: 'Example share text',
      filePath: path,
    );
  }
