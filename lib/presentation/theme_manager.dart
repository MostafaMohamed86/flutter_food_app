import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/color_manager.dart';
import 'package:shopping_app/presentation/values_manager.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    // cardview theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey1,
      elevation: AppSize.s4
    )
    // app bar theme

    //button theme

    //input decoration theme (text form field)
  );
}