




import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/Place.dart';
import '../view/details_screen.dart';

Widget CustomIconButton(String text, Icon? icon,
    {void Function()? func, Color? color,double fontsize=12}) {
  return InkWell(
    onTap: func,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        if(icon != null)
        IconButton(
          onPressed: func,
          icon: icon,
        )
          else
        Image.asset("assets/icon/reservation.png",width: 50,),
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(color: color, fontSize: fontsize,fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}


Widget Customchoice(Place place,Size size ,String? type,BuildContext context){
  return InkWell(
    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Detail_Screen(type:type,place:place))),

    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          alignment: Alignment.center,
          width: size.width*0.8,
          height: size.height*0.1,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),

              // gradient:  LinearGradient(
              //   begin: Alignment(-1,-1),
              //   end: Alignment(1,1),
              //   colors: [
              //    Color(0xFFE6E6E6).withOpacity(0.5),
              //    Color(0xFFFFFFFF).withOpacity(0.5)
              //   ]
              // ),
              boxShadow: const [
                BoxShadow(
                    color: Color(0xFFCCCCCC),
                    offset: Offset(20,20),
                    spreadRadius: -25,
                    blurRadius: 60
                ),
                BoxShadow(
                  color: Color(0xFFFFFFFF),
                  offset: Offset(-20,-20),
                  blurRadius: 60,
                  spreadRadius: -20,

                ),
              ]
          ),
          child: Text( place.name ??"",style: GoogleFonts.racingSansOne(fontSize:
          place.name!.length>9 ?20
              :25),),
        ),
        //     Positioned(
        //         top: 0,
        //         left: -30,
        //         width: 70,
        //         child:type =="rondo"?
        //             Transform.translate(offset: const Offset(0,5)
        // ,child:               Transform.rotate(angle: 710, child: Image.asset("assets/image/0c17a9fa2b675467790a145da392c074.png",),      )
        //               ,
        // )
        //
        //         // Transform.rotate(angle: 710, child: Image.asset("assets/rondo2.png",),      )
        //
        //
        //               :Transform.rotate(angle: 660 ,child:Image.asset("assets/image/—Pngtree—cartoon characters ride bicycles_4141664.png",),)
        //
        //
        // ),
        Positioned(
            top:35,
            right:-12,
            child: Container(
              width: 50,
              height: 50,
              decoration:BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffc9a2a299),
                        offset: Offset(10,10),
                        blurRadius: 20
                    )
                  ],
                  color: const Color(0xff379dd4).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(60)
              ),
              child: const Icon(Icons.arrow_forward_ios),
            )
        )

      ],
    ),
  );

}