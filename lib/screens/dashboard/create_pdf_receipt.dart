import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:quick_shelter/utils/createPdf.dart';

class CreatePdf extends StatefulWidget {

   final String path;
  const CreatePdf({Key key, this.path}) : super(key: key);
  @override
  _CreatePdfState createState() => _CreatePdfState();
}

class _CreatePdfState extends State<CreatePdf> {

  //String path = widget.path;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
    //   body: PDFViewerScaffold(
    //   path: path,
    // )
    );
  }
}
