import 'package:flutter/material.dart';

class CongratulationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.amberAccent,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.1, bottom: size.height * 0.1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Container(
                  child: Text("おめでとう", style: TextStyle(color: Colors.black, fontSize: 40),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
