import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';

class MyFavouriteSlider extends StatefulWidget {
  final List<String> data;
  MyFavouriteSlider(this.data) : super();

  _MyFavouriteSliderState createState() {
    ('gallery : ${data}');
    return _MyFavouriteSliderState();
  }
}

class _MyFavouriteSliderState extends State<MyFavouriteSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.data.length,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        initialPage: 0,
      ),
      itemBuilder: (BuildContext context, index) {
        if (widget.data.length != 0) {
          return Image.network(
            '${widget.data[index]}',
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  child: Image(
                    image: AssetImage('images/offer/sa.jpg'),
                    height: MediaQuery.of(context).size.width / 3,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
