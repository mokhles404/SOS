
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';
import 'package:sos/models/Place.dart';

import '../controller/controller.dart';
import '../controller/proximity_service.dart';
import '../utils/constant.dart';
import '../utils/widgets.dart';
import 'map.dart';


class Detail_Screen extends StatefulWidget {
  String? type;
  Place? place;
   Detail_Screen( {Key? key, this.type, required this.place}) : super(key: key);

  @override
  State<Detail_Screen> createState() => _Detail_ScreenState();
}

class _Detail_ScreenState extends State<Detail_Screen> {


  late TextEditingController nomController;
  late TextEditingController prenomController;
  late TextEditingController emailController;
  late TextEditingController numberController;





@override
void initState() {
  nomController= TextEditingController();
  prenomController= TextEditingController();
  emailController= TextEditingController();
  numberController= TextEditingController();
  correctBgImg();
    super.initState();
  }
  String bgImg="";
  bool repeatIt=true;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Container(
        // color:widget.type =="rondo"? Colors.blueGrey: const Color(0xff0086a9) ,
        color: const Color(0xff0086a9) ,
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
              margin:  EdgeInsets.only(bottom: size.height*0.12),
              decoration:  BoxDecoration(

                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(65)
                ),
                image:  DecorationImage(
                  // image: widget.type =="rondo"? const AssetImage("assets/forest2.png") : const AssetImage("assets/bikebg2.png"),
                  image:   AssetImage(bgImg),
                  // image:   AssetImage("assets/elgonna/1 (1).JPG"),
                      fit: BoxFit.cover,
                )
              ),
            ),
            Container(
              margin:  EdgeInsets.only(bottom: size.height*0.12),
              width: size.width,

              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(65)
                ),
                gradient: LinearGradient(
                        begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color(0xff1b1c27).withOpacity(0.7),
                      const Color(0xff1b1c27)
                    ],
                  stops: const [
                    0.5,
                    0.6,
                    1
                  ]
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.46,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            // width: size.width,
                            child: AutoSizeText(widget.place?.name ??"no name",style: GoogleFonts.rubik(color: Colors.white,fontSize: 36),maxLines: 1,maxFontSize:36,textAlign: TextAlign.left,)),
                       const SizedBox(width: 10,),
                        SizedBox(
                            // width: size.width,
                            child:
                          CustomIconButton("reserver",
                              null,
                              func: () async {

                                await buildShowDialog(context);

                              }, color: widget.type =="rondo"? const Color(0xff087aad) : const Color(
                                  0xffffffff)),
                        )
                      ],
                    ),
                    SizedBox(height: size.height*0.03,),
                    SizedBox(
                      height: size.height*.12,
                        child: SingleChildScrollView(child: Text(widget.place?.desc ??"",textAlign:TextAlign.justify,style: GoogleFonts.rubik(color: Colors.white.withOpacity(0.9),fontSize:14)))),
                    SizedBox(height: size.height*0.05,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Icon(Icons.directions_walk_outlined,color: Colors.white,size: 28,),
                        Padding(
                          padding:  const EdgeInsets.only(top: 12),
                          child: Image.asset("assets/image/difficulty icon.png",width: 40,color: Colors.white,),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Difficulté",style: GoogleFonts.rubik(color: Colors.white.withOpacity(0.9),fontSize: 16)),
                            const SizedBox(height: 10,),
                            Text(widget.place?.difficulte??"",style: GoogleFonts.rubik(color: Colors.white.withOpacity(0.9),fontSize: 16),)
                          ],

                        ),
                       Container(
                         color: Colors.white.withOpacity(0.7),
                         width: 1,
                         height: 60,
                       ),
                        // const Icon(Icons.social_distance_outlined,color: Colors.white,size: 28,),
                        Image.asset("assets/icon/distance.png",width: 35,color: Colors.white,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Distance",style: GoogleFonts.rubik(color: Colors.white.withOpacity(0.9),fontSize: 16)),
                            const SizedBox(height: 10,),
                            Text(widget.place?.longueur ??"",style: GoogleFonts.rubik(color: Colors.white.withOpacity(0.9),fontSize: 16),textAlign: TextAlign.start,)
                          ],

                        ),

                      ],
                    )
                  ],
                ),
              ),

            ),
            Positioned(
                bottom: 20,
                child: InkWell(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx)=>CustomMap(type:widget.type,place:widget.place))) ,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: size.width,
                        child: const Center(child: Text("Rejoindre le circuit ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w200,fontFamily: "Racerz"),))),
                  ),
                )),
            Positioned(
              top: size.height*0.07,
              left: size.width*0.08,
              child: InkWell(
                onTap: () {
              Navigator.pop(context);
              },
                child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.8),
                      ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.arrow_back_ios,size: 24,color: Colors.black,),
                ),
              ),
            ),
            Positioned(
              top: size.height*0.07,
              right: size.width*0.08,
              child: InkWell(
                onTap: () {
                  setState(() {
                    repeatIt=false;
                  });
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.infoReverse,
                      animType: AnimType.rightSlide,
                      // btnCancelOnPress: () {},
                    // btnCancel: null,
                  body: Column(
                    children: [
                     const Text("Contact",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18 ),),

                      const SizedBox(height: 27,),
                      contactText(Icons.home, "complexe des jeunes, Sfax, Tunisia, 3049", "Address"),
                      SizedBox(height: size.height*0.03,),
                      contactText(Icons.email, "sfaxoutdoorsports@gmail.com", "Email"),
                      SizedBox(height: size.height*0.03,),
                      contactText(Icons.call, "20353532", "téléphone"),
                      const SizedBox(height: 10,),


                    ],
                  ),
                  btnOkOnPress: () {},
                  ).show();
              },
                child: Container(
                  width: 50,
                  height: 50,
                  // padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.8),
                      ),
                  alignment: Alignment.center,
                  // child: const Icon(Icons.info_outlined,size: 24,color: Colors.blueAccent,),
                  child: Lottie.asset("assets/information.json",width: 40,fit: BoxFit.fill,repeat: repeatIt),
                ),
              ),
            ),
            // Positioned(
            //   top: size.height*0.07,
            //   right: size.width*0.08,
            //   child: SizedBox(
            //         width: 50,
            //         height: 50,
            //
            //         child: ClipRRect(
            //             borderRadius: BorderRadius.circular(15),
            //             child: Image.asset("assets/pdp.jpg",fit: BoxFit.cover,))
            //
            //       ),
            // ),

          ],
        ),
      ),

    );
  }

  Padding contactText(IconData icon ,String title,String subtitle,{void Function()? func }){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           Icon(icon,color: Colors.green,),
          SizedBox(width: 10,),
          RichText(text:  TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap=func,
              text: title,
              style: TextStyle(color: Colors.black,fontSize: 10),
              children: [
                TextSpan(text: '\n\t\t\t $subtitle ', style: TextStyle(fontSize: 8,color: Colors.grey)),

              ]

          ),

          )
        ],
      ),
    );
  }

  correctBgImg(){
    Random rnd = Random();
    String name=widget.place!.name!;
    if(name=="Dorcas" || name=="Halfa" ) {
      bgImg=elgonnaImg[rnd.nextInt(elgonnaImg.length)];
    }
    if(name=="Charfiya " || name=="Palmier" ) {
      bgImg=kerknahImg[rnd.nextInt(kerknahImg.length)];
    }
    if(name=="Chemleli " || name=="Younga & Sidi Absa" ) {
      bgImg=oliversImg[rnd.nextInt(oliversImg.length)];
    }
    if(name=="Flamant rose " || name=="Sel" ) {
      bgImg=salineImg[rnd.nextInt(salineImg.length)];
    }
    setState(() {

    });
  }
  buildShowDialog(BuildContext context) async {
    showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Stack(
                                        clipBehavior: Clip.none, children: <Widget>[

                                          Positioned(
                                            right: -40.0,
                                            top: -40.0,
                                            child: InkResponse(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const CircleAvatar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 16, 219, 185),
                                                child: Icon(Icons.close,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [

                                                 Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller: nomController,
                                                          decoration: const InputDecoration(
                                                            label: Text("Nom"),
                                                            border: UnderlineInputBorder()
                                                          ),
                                                  ),
                                                ),
                                                 Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller: prenomController,
                                                    decoration: const InputDecoration(
                                                            label: Text("Prenom"),
                                                            border: UnderlineInputBorder()
                                                          ),
                                                  ),
                                                ),
                                                 Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller: emailController,
                                                    decoration: const InputDecoration(
                                                            label: Text("E_mail"),
                                                            border: UnderlineInputBorder()
                                                          ),
                                                  ),
                                                ),
                                                 Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller: numberController,
                                                    decoration: const InputDecoration(
                                                            label: Text("Numéro"),
                                                            border: UnderlineInputBorder()
                                                          ),
                                                  ),
                                                ),
                                                  SizedBox(height: 50,),
                                                ElevatedButton( onPressed: () async {

                                                  if(nomController.text.trim().isNotEmpty && prenomController.text.trim().isNotEmpty && emailController.text.trim().isNotEmpty&& numberController.text.trim().isNotEmpty){

                                                            mycontroller api =mycontroller();
                                                           String rep= await api.sendEmail(nom: nomController.text,prenom: prenomController.text,email: emailController.text,number: numberController.text,type: widget.type);
                                                                      if(rep.substring(0,4) =="Nous"){
                                                                        Navigator.of(context).pop();
                                                                        nomController.clear();
                                                                        prenomController.clear();
                                                                        emailController.clear();
                                                                        numberController.clear();
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(

                                                                          child: Text(rep.trim()),
                                                                        )));
                                                                      }else{
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(

                                                                          child: Text(rep.trim()),
                                                                        )));
                                                                      }
                                                  }

                                                },
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
                                                    ),
                                                child: Text("Reserver",style: GoogleFonts.rubik(fontSize: 24),))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
  }
}
