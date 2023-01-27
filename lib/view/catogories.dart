import 'package:flutter/material.dart';
import '../models/Place.dart';
import '../utils/point_list.dart';
import '../utils/widgets.dart';

class category extends StatefulWidget {
 final String? type;
   const category({Key? key,this.type}) : super(key: key);

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

  List<Widget> choice= [
    Customchoice(Places![0],size,widget.type,context),
    Customchoice(Places![1],size,widget.type,context),
    Customchoice(Places![2],size,widget.type,context),
    Customchoice(Places![3],size,widget.type,context),
    Customchoice(Places![4],size,widget.type,context),
    Customchoice(Places![5],size,widget.type,context),
    Customchoice(Places![6],size,widget.type,context),
    Customchoice(Places![7],size,widget.type,context),
  ];

  List<Widget> choicevtt= [
    Customchoice(Places![1],size,widget.type,context),
    Customchoice(Places![2],size,widget.type,context),
    Customchoice(Places![4],size,widget.type,context),
    Customchoice(Places![6],size,widget.type,context),
  ];
    return Scaffold(
      body: SafeArea(
      child:loading
                  ? const Center(child: CircularProgressIndicator(color: Colors.redAccent,),)
                  : Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Row(
              children: [

                // Expanded(
                //   child: Container(
                //
                //     color: widget.type =="rondo"?Colors.blueGrey: Color(0xff817d46),
                //   ),
                // ),
                 Expanded(
                   flex: 2,
                   child: Container(
                   decoration:  BoxDecoration(
                       image: DecorationImage(image: widget.type =="rondo" ? const AssetImage("assets/image/bg (2).jpg") :const AssetImage("assets/image/bg (3).jpg")
                           ,fit: BoxFit.cover
                       ),

                     //   gradient: LinearGradient(
                     //     begin: Alignment(-1,-1),
                     //     end: Alignment(1,1),
                     //     colors: [
                     //       // Color(0xFFb8c2aa),
                     //       Color(0xff817d46),
                     //       Color(0xff618cd5)
                     //     ]
                     // ),

                   ),
                ),
                 ),

              ],
            ),
          ),
          SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                    SizedBox(height: size.height*.1,),

                  // ClipPath(
                  //         clipper: ClipPathClass(),
                  //
                  //         child: Container(
                  //           margin: const EdgeInsets.only(bottom: 20),
                  //           padding: const EdgeInsets.only(right: 20),
                  //           decoration: const BoxDecoration(
                  //             // gradient: LinearGradient(
                  //             //     begin: Alignment(-1,-1),
                  //             //     end: Alignment(1,1),
                  //             //     colors: [
                  //             //       Color(0xFFE6E6E6),
                  //             //       Color(0xFFFFFFFF)
                  //             //     ]
                  //             // ),
                  //             image: DecorationImage(image: AssetImage("assets/image/5.jpg")
                  //             ,fit: BoxFit.cover
                  //             )
                  //
                  //           ),
                  //           width: size.width,
                  //           height: size.height*0.3,
                  //           alignment: Alignment.center,
                  //           // child: Text("Choisissez l'aventure",style: GoogleFonts.radioCanada(fontSize: 30,fontWeight: FontWeight.w900,
                  //           //     color: widget.type =="rondo"? Colors.blueGrey: Color(0xffbf2f2f)),),
                  //         ),
                  //       ),
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
                      if(widget.type =="rondo")
                    ...choice
                      else
                      ...choicevtt


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
