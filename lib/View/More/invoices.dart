import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/Search/invoice_search_model.dart';
import 'package:salonic/Model/invoices_model.dart';
import 'package:salonic/Model/order_model.dart';

class Invoices extends StatefulWidget{
  final String token;
  final int user_id;
  Invoices({this.token, this.user_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Bills_State();
  }

}
class Bills_State extends State<Invoices>{
  Future<List<InvoicesModel>> invoicesList;
  Future<List<InvoiceSearchModel>> invoice_search_List;
  TextEditingController controller = TextEditingController();
  bool searcch_status = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.token == StaticMethods.vistor_token) {
      invoicesList = null;
    } else {
      invoicesList =
          ApiProvider.getUserInvoices(widget.token, widget.user_id, context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    invoicesList = null;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: (){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MorePage()));
        },
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          AppLocalization.of(context).translate('bill'),
          style: TextStyle(fontFamily: AqarFont.font_family),
        ),
        backgroundColor: AppColor.primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 20),
                child:  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor.secondary_color,
                  ),
                  child:TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: AppLocalization.of(context).translate('invoice_search'),
                      hintStyle: TextStyle(
                        color: Color(0xFFBBBBBB),
                      ),
                      border: InputBorder.none,
                      prefixIcon: IconButton(
                        onPressed: () {
                          invoice_search_List = ApiProvider.invoice_search_fun(
                              widget.token, widget.user_id, controller.text.trim(),context );
                          setState(() {
                            searcch_status=true;
                          });
                        },
                        icon: Icon(
                          Icons.search,
                          color: AppColor.primary_color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height/1.4,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: searcch_status? Directionality(
                    textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
                    child: (invoice_search_List == null)
                        ? VistorMessage()
                        : FutureBuilder<List<InvoiceSearchModel>>(
                      future: invoice_search_List,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length != 0) {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child:  Card(
                                            shape: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFDCDCDC)),
                                            ),
                                            child:  Padding(
                                              padding: EdgeInsets.all(0),
                                              child: Table(
                                                textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.rtl : TextDirection.ltr,
                                                border: TableBorder.all(width: 1.0, color: Colors.grey),
                                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                                columnWidths: {
                                                  0: FlexColumnWidth(2),
                                                  1: FlexColumnWidth(1),
                                                },
                                                children: [
                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].salon.city.name} ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('city'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),
                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].paymentId} ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color:AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('bill_num'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),

                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].salon.name} ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('center_name'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),
                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].status=='Successful'?
                                                            AppLocalization.of(context).translate('sucess'): AppLocalization.of(context).translate('fail')}  ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('pay_status'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),
                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].amount}  ${AppLocalization.of(context).translate('sr')}  ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('bill_value'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),
                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].createdAt} ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('bill_date'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              return Directionality(
                                textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                      child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image(
                                      width:
                                      MediaQuery.of(context).size.width /
                                          3,
                                      height:
                                      MediaQuery.of(context).size.height /
                                          4,
                                      image: AssetImage(
                                          'images/background/salonic_logo.png'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      AppLocalization.of(context).translate('no_bills'),
                                      style: TextStyle(
                                          fontFamily: AqarFont.font_family,
                                          color: Color(0xFFC5ABAB),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21),
                                    )
                                  ],
                                ),
                              ),
                              );
                            }
                          } else {
                            return Directionality(
                              textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                    child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    height:
                                    MediaQuery.of(context).size.height /
                                        4,
                                    image: AssetImage(
                                        'images/background/salonic_logo.png'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    AppLocalization.of(context).translate('no_bills'),
                                    style: TextStyle(
                                        fontFamily: AqarFont.font_family,
                                        color: Color(0xFFC5ABAB),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21),
                                  )
                                ],
                              ),
                            ),
                            );
                          }
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ) : Directionality(
                    textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
                    child: (invoicesList == null)
                        ? VistorMessage()
                        : FutureBuilder<List<InvoicesModel>>(
                      future: invoicesList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length != 0) {

                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child:  Card(
                                            shape: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFDCDCDC)),
                                            ),
                                            child:  Padding(
                                              padding: EdgeInsets.all(0),
                                              child: Table(
                                                textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.rtl : TextDirection.ltr,
                                                border: TableBorder.all(width: 1.0, color: Colors.grey),
                                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                                columnWidths: {
                                                  0: FlexColumnWidth(2),
                                                  1: FlexColumnWidth(1),
                                                },
                                                children: [
                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].salon.city.name} ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('city'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),
                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].paymentId} ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color:AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('bill_num'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),

                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].salon.name} ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('center_name'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),
                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].status=='Successful'?
                                                            AppLocalization.of(context).translate('sucess'): AppLocalization.of(context).translate('fail')}  ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('pay_status'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),
                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].amount}  ${AppLocalization.of(context).translate('sr')}  ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('bill_value'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),
                                                  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            "${snapshot.data[index].createdAt} ",
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: AppColor.primary_color,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            AppLocalization.of(context).translate('bill_date'),
                                                            textScaleFactor: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontFamily: AqarFont.font_family,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ]),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              return Directionality(
                                textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                      child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image(
                                      width:
                                      MediaQuery.of(context).size.width /
                                          3,
                                      height:
                                      MediaQuery.of(context).size.height /
                                          4,
                                      image: AssetImage(
                                          'images/background/salonic_logo.png'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      AppLocalization.of(context).translate('no_bills'),
                                      style: TextStyle(
                                          fontFamily: AqarFont.font_family,
                                          color: Color(0xFFC5ABAB),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21),
                                    )
                                  ],
                                ),
                              ),
                              );
                            }
                          } else {
                            return Directionality(
                              textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                    child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    height:
                                    MediaQuery.of(context).size.height /
                                        4,
                                    image: AssetImage(
                                        'images/background/salonic_logo.png'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    AppLocalization.of(context).translate('no_bills'),
                                    style: TextStyle(
                                        fontFamily: AqarFont.font_family,
                                        color: Color(0xFFC5ABAB),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21),
                                  )
                                ],
                              ),
                            ),
                            );
                          }
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ));
  }

}