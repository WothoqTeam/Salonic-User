import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';

import 'more_page.dart';

class ContactUs extends StatefulWidget {
  final String token;
  ContactUs({this.token});
  @override
  State<StatefulWidget> createState() {
    ('url : ${token}');
    // TODO: implement createState
    return ContactUs_state();
  }
}

class ContactUs_state extends State<ContactUs> {
  Future<List<SocialModel>> social_links;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    social_links = ApiProvider.getSocialLinks(widget.token, context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    social_links = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalization.of(context).translate('contact_us'),
          style: TextStyle(
            fontFamily: AqarFont.font_family,
            color: Color(0xFFFFFFFF),
          ),
        ),
        backgroundColor: AppColor.primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MorePage()));
          },
        ),
      ),
      body: Directionality(
        textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
        child: FutureBuilder<List<SocialModel>>(
          future: social_links,
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data.length != 0) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20,
                                    right: 20, top: 15, bottom: 15),
                                child: Row(
                                  children: <Widget>[
                                    Card(
                                      color: Color(0xFFF6F6F6),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Image.network(
                                          '${snapshot.data[index].logo}',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              14,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              14,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 10,left: 10),
                                      child: Text(
                                        '${snapshot.data[index].name}',
                                        style: TextStyle(
                                            fontFamily: AqarFont.font_family,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    setState(() {
                                      _launchURL(
                                          'mailto:${snapshot.data[index].link}');
                                    });
                                    break;
                                  case 1:
                                    _launchURL(
                                        'whatsapp://send?phone=${snapshot.data[index].link}');
                                    break;
                                  case 2:
                                    _launchURL(snapshot.data[index].link);
                                    break;
                                  case 3:
                                    _launchURL(
                                        'tel:${snapshot.data[index].link}');
                                    break;
                                }
                              },
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Directionality(
                      textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.link_off,
                                size: 80,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                AppLocalization.of(context).translate('no_social'),
                                style: TextStyle(
                                    fontFamily: AqarFont.font_family,
                                    color: Color(0xFFC5ABAB),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21),
                              )
                            ],
                          ),
                        ),
                      ));
                }
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
       ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
