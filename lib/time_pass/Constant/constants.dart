import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mystyle(
    double fs, [Color ?Clr, FontWeight ?fw ]){
  return GoogleFonts.oleoScript(
    fontSize: fs,
    color: Clr,
    fontWeight: fw,
  );
}