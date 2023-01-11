import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sos/view/details_screen.dart';

import '../models/Place.dart';
import '../utils/cliper.dart';
import '../utils/point_list.dart';

class category extends StatefulWidget {
  String? type;
   category({Key? key,this.type}) : super(key: key);

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {

  List<Place>? Places=<Place>[];
  bool loading =true;
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    Widget Customchoice(Place place){
      return Stack(
          clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            // padding: EdgeInsets.only(left: 50),
            alignment: Alignment.center,
            width: size.width*0.8,
            height: size.height*0.1,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment(-1,-1),
                end: Alignment(1,1),
                colors: [
                 Color(0xFFE6E6E6),
                 Color(0xFFFFFFFF)
                ]
              ),
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
            child: Text(widget.type =="rondo"?"Rondo": place.name ??"",style: GoogleFonts.racingSansOne(fontSize:
            place.name!.length>9 ?20
                :25),),
          ),
          Positioned(
              top: 0,
              left: -30,
              width: 95,
              child:widget.type =="rondo"?
                  Transform.translate(offset: const Offset(13,25)
      ,child:               Transform.rotate(angle: 710, child: Image.asset("assets/rondo2.png",),      )
                    ,
      )

              // Transform.rotate(angle: 710, child: Image.asset("assets/rondo2.png",),      )


                    :Transform.rotate(angle: 660 ,child:Image.asset("assets/vtt.png",),)


      ),
          Positioned(
            top:43,
            right:-12,
           child: InkWell(
             // onTap: (){
             //   print(Places?.first.coordinates?.first.lat);
             // },
             onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Detail_Screen(type:widget.type,place:place))),
             child: Container(
               width: 50,
                height: 50,
                decoration:BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffC9A2A299),
                      offset: Offset(10,10),
                      blurRadius: 20
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60)
                ),
               child: const Icon(Icons.arrow_forward_ios),
              ),
           )
          )

        ],
      );

    }
    return Scaffold(
      body: SafeArea(
      child:loading ? const Center(child: CircularProgressIndicator(color: Colors.redAccent,),)
      :
      Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Row(
              children: [

                Expanded(
                  child: Container(

                    color: widget.type =="rondo"?Colors.blueGrey: Color(0xffEB394D),
                  ),
                ),
                 Expanded(
                   flex: 2,
                   child: Container(
                   decoration: const BoxDecoration(
                     gradient: LinearGradient(
                         begin: Alignment(-1,-1),
                         end: Alignment(1,1),
                         colors: [
                           Color(0xFFE6E6E6),
                           Color(0xFFFFFFFF)
                         ]
                     ),

                   ),
                ),
                 ),

              ],
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ClipPath(
                          clipper: ClipPathClass(),

                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.only(right: 20),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment(-1,-1),
                                  end: Alignment(1,1),
                                  colors: [
                                    Color(0xFFE6E6E6),
                                    Color(0xFFFFFFFF)
                                  ]
                              ),

                            ),
                            width: size.width,
                            height: size.height*0.2,
                            alignment: Alignment.center,
                            child: Text("Choisissez l'aventure",style: GoogleFonts.radioCanada(fontSize: 30,fontWeight: FontWeight.w900,
                                color: widget.type =="rondo"? Colors.blueGrey: Color(0xffbf2f2f)),),
                          ),
                        ),
                  // SizedBox(
                  //   height: 200,
                  //   width: MediaQuery.of(context).size.width-80,
                  //   child: ListView.builder(
                  //     itemCount: Places?.length
                  //     , itemBuilder: (BuildContext context, int index) {
                  //
                  //       // return Text("aaaaaaaaaaaaaaaaaaaaaaaa");
                  //       return SizedBox(
                  //         width: 10,
                  //           child: Customchoice(Places![index]));
                  //   },
                  //
                  //
                  //   ),
                  // ),

                  Customchoice(Places![0]),
                  Customchoice(Places![1]),
                  Customchoice(Places![2]),
                  Customchoice(Places![3]),
                  Customchoice(Places![4]),
                  Customchoice(Places![5]),
                  Customchoice(Places![6]),
                  Customchoice(Places![7]),



                ],
              ),
            ),
          )
        ],
      ) )
    );
  }

  Future<void> getData() async {
    Places = await PointList().getdata();
    setState(() {
      loading=false;
    });

  }






}
