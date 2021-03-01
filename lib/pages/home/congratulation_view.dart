import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hot_and_cold/pages/home/home_page.dart';
import 'package:jpec_base/extensions/extension.dart';

class CongratulationView extends StatelessWidget {
  static const  text = """
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eget ipsum eu arcu porttitor congue. Donec porta sodales porta. Aliquam sagittis felis eget suscipit eleifend. Pellentesque sollicitudin ultrices augue, at tempor tellus volutpat ac. Curabitur in placerat eros. Ut ligula nunc, scelerisque eu tortor hendrerit, suscipit lobortis justo. Donec non commodo dolor. Aenean consequat, eros non lacinia porta, quam sem congue nulla, eu laoreet arcu ipsum in tortor. Phasellus luctus pretium ipsum in ornare. Sed eget aliquet nisl. Vivamus viverra felis purus, et aliquet lectus suscipit in. Nam congue eleifend nisi at tempus. Nunc id egestas eros, ac eleifend mauris.

Integer eu cursus nisl, eget consequat lacus. Morbi lobortis arcu eu pellentesque pellentesque. Mauris non dui lorem. Phasellus ut lectus consequat, semper neque vitae, iaculis justo. Donec laoreet efficitur lorem, ac pulvinar quam vehicula non. Donec quis velit lacus. Vestibulum enim ligula, consequat ac odio in, posuere congue risus. Nam tristique nec dui vitae mollis. Duis dignissim lectus eget tincidunt vestibulum. Donec in ligula neque. Cras id placerat dui, at pulvinar metus.

Proin sed libero at velit pulvinar sagittis sed non ipsum. Ut nec consequat mauris. Praesent a turpis non ante rhoncus vestibulum id in nibh. Fusce faucibus et metus eu lobortis. Etiam malesuada sit amet ante id ullamcorper. Etiam quis risus at ligula pretium cursus vitae a ex. In hac habitasse platea dictumst. Vivamus luctus sapien eget arcu porta iaculis. Ut dui purus, ultrices non lobortis nec, vulputate nec tellus. Morbi pharetra condimentum mollis. Phasellus commodo lacus sed purus finibus, at venenatis augue mattis. Phasellus neque ante, euismod eu eros a, sollicitudin gravida elit. Nulla a ligula a tortor mattis accumsan in non est. Fusce sit amet venenatis felis, vitae tristique tortor. Donec in purus sit amet tellus egestas eleifend quis et eros.

Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum sit amet sodales libero. Quisque semper mi odio, quis auctor turpis ultricies porta. Sed at aliquam diam. Morbi a eleifend elit. Duis quis lacinia augue, id egestas neque. Sed non arcu sed orci fermentum suscipit a quis ante. Nullam ac augue massa.

Proin efficitur imperdiet purus, vel porta urna aliquet aliquam. Vivamus finibus neque a ex tincidunt, eu dictum turpis viverra. Fusce et dapibus sem. Donec aliquam maximus diam. In dapibus venenatis elit, vitae fermentum erat placerat ut. Quisque imperdiet ornare auctor. Donec lacinia ac ante eu porta. Nam in feugiat justo. Fusce interdum interdum nisl. Sed tempor tempor turpis non hendrerit. Praesent elit ligula, malesuada id nulla at, faucibus sodales lacus. Curabitur in aliquet massa. Ut in dictum neque.


  """;


  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.blueGrey,
      child: SafeArea(
        child: Padding(
          // padding: EdgeInsets.only(left: phoneSize.width * 0.05, right: phoneSize.width * 0.05, top: phoneSize.height * 0.1, bottom: phoneSize.height * 0.1),
          padding: EdgeInsets.only(left: context.phoneSize.width * 0.05, right: context.phoneSize.width * 0.05, top: context.phoneSize.height * 0.1, bottom: context.phoneSize.height * 0.1),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [      BoxShadow(
                color: Colors.white.withOpacity(0.7),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(HomePage.routeName);
                  },
                  child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Félicitations!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 32),),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Container(
                            child: Text(text, style: TextStyle(color: Colors.black),),
                          ),
                          Text("Jtm")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
