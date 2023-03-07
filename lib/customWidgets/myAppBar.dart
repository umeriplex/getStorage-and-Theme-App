import 'package:flutter/material.dart';

import '../views/theme/services.dart';

  myAppBar(String title){
  return AppBar(
    title: Text(title),
    leading: GestureDetector(
      onTap: (){ThemeServices().switchTheme();},
      child: const Icon(
        Icons.nightlight_rounded,size: 20,),
    ),
    actions: [
      GestureDetector(
        onTap: (){},
        child: const Icon(Icons.person,size: 20,),
      ),
      const SizedBox(width: 10,),
    ],
  );
}