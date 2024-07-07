import 'package:flutter/material.dart';

class Container_w extends StatefulWidget {
   Container_w({super.key,this.Titles = "",this.Subtitle = ""});
  String Titles;
  String Subtitle;

  @override
  State<Container_w> createState() => _Container_wState();
}

class _Container_wState extends State<Container_w> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          // color: Colors.red,
          width: MediaQuery.of(context).size.width*0.45,
          height: MediaQuery.of(context).size.height*0.11,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
            )],
            color: Colors.grey[350],
            borderRadius: BorderRadius.circular(18)
          ),
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(widget.Titles,),
              Text(widget.Subtitle,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget Cdecoration(){
    return
    Row(
      children: [
        Container(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width*0.45,
          height: MediaQuery.of(context).size.height*0.13,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
            )],
            color: Colors.red,
            borderRadius: BorderRadius.circular(18)
          ),
          child: Column(
            children: [
            Text(widget.Titles),
            Text(widget.Subtitle)
            ],
          ),
        )
      ],
    );
  }
}