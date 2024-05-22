import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'app/routes/app_pages.dart';
import 'languages/LocalizationService.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    onReady: () async {
    },
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    translations: LocalizationService(),
    supportedLocales: LocalizationService.locales,
    // translationsKeys: Get.find<TranslationService>().translations,
    locale: LocalizationService.locale,
    fallbackLocale: LocalizationService.fallbackLocale,
    defaultTransition: Transition.cupertino,
    debugShowCheckedModeBanner: false,
    initialRoute:Theme1AppPages.INITIAL,
    getPages: Theme1AppPages.routes,
    // themeMode: Get.find<SettingsService>().getThemeMode(),
    // theme: Get.find<SettingsService>().getLightTheme(),
    // darkTheme: Get.find<SettingsService>().getDarkTheme(),
  ));
}


