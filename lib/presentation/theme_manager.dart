import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/color_manager.dart';
import 'package:shopping_app/presentation/font_manager.dart';
import 'package:shopping_app/presentation/styles_manager.dart';
import 'package:shopping_app/presentation/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.lightPrimary,
      // cardview theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey1,
        elevation: AppSize.s4,
      ),
      // app bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.lightPrimary,
          titleTextStyle:
              getRegularStyle(fontSize: FontSize.s16, color: Colors.white)),
      // button theme
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.lightPrimary
      ),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s17),
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)
          ) 
        )
      ),
      // text theme
      textTheme: TextTheme(
        headline1: getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16),
        subtitle1: getMediumStyle(color: ColorManager.grey1, fontSize: FontSize.s14),
        caption: getRegularStyle(color: ColorManager.grey1),
        bodyText1: getRegularStyle(color: ColorManager.grey)
      ),
      // input decoration theme (text form field)
      );
}
