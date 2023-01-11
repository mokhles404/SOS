




import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CustomIconButton(String text, Icon icon,
    {void Function()? func, Color? color,double fontsize=12}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        onPressed: func,
        icon: icon,
      ),
      Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.rubik(color: color, fontSize: fontsize,fontWeight: FontWeight.bold),
      )
    ],
  );
}