import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/bindings/general_bindings.dart';
import 'package:untitled/utils/constants/helpers/colors.dart';
import 'utils/theme/theme.dart';


class d_vault extends StatelessWidget{
  const d_vault({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: D_vaultTheme.lightTheme,
      darkTheme: D_vaultTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: const Scaffold(backgroundColor: DColors.primary,body: Center(child: CircularProgressIndicator(color: Colors.white))),
      debugShowCheckedModeBanner: false,
    );
  }
}
