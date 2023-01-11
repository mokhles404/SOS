import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'catogories.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: InkWell(
                onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> category(type: "VTT",))),
                child: Container(
            width: size.width,
            decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/vtt1.png"), fit: BoxFit.cover)),
            child:  Center(
                  child: Text("VTT",
                      style: GoogleFonts.racingSansOne(
                          color: Colors.white60,
                          fontSize: 48,
                          fontWeight: FontWeight.w900))),
          ),
              )),
          Container(
              width: size.width,
              alignment: Alignment.center,
              decoration:  BoxDecoration(
                  color: Colors.grey.shade300,
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Color(0xff350F01),
                  //     Color(0xffA0ABAF),
                  //   ],
                  //   // stops: [
                  //   //
                  //   // ]
                  // )
              ),
              height: 60,
              child: CustomText()),
          Expanded(
              child: InkWell(
                onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> category(type: "rondo",))),

                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.srgbToLinearGamma(),

                          image: AssetImage("assets/rondo.png"), fit: BoxFit.cover)),
                  child:  Center(
                      child: Text("randonnée",
                          style: GoogleFonts.racingSansOne(
                              color: Colors.white60,
                              fontSize: 48,
                              fontWeight: FontWeight.w900))),
                ),
              )),

        ],
      ),
    );
  }

  Widget CustomText() {
    return Container(

      child: DefaultTextStyle(
        style: const TextStyle(
            fontSize: 16.0,  color: Color(0xff068484),fontFamily: "Racerz"),
        child: AnimatedTextKit(
          totalRepeatCount: 5,
          animatedTexts: [
            TyperAnimatedText('Vous aimez', speed: Duration(milliseconds: 300)),
            TyperAnimatedText('VTT ou randonnée',
                speed: Duration(milliseconds: 200)),
            TyperAnimatedText('Sélectionnez votre favori',
                speed: Duration(milliseconds: 200)),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}
