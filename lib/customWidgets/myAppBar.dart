import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/theme/services.dart';

//   myAppBar(String title){
//   return AppBar(
//     title: Text(title),
//     leading: GestureDetector(
//       onTap: (){ThemeServices().switchTheme();},
//       child: const Icon(
//         Icons.nightlight_rounded,size: 20,),
//     ),
//     actions: [
//       GestureDetector(
//         onTap: (){},
//         child: const Icon(Icons.person,size: 20,),
//       ),
//       const SizedBox(width: 10,),
//     ],
//   );
// }
  AppBar buildAppBar(Function()? onTap,String? title,BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: context.theme.backgroundColor,
    title: Text(title!),
    leading: GestureDetector(
      onTap: onTap,
      child:  Get.isDarkMode
          ?
      const Icon(
        Icons.nightlight_rounded,size: 20,)
          :
      const Icon(
        Icons.sunny,size: 20,color: Colors.black,),
    ),
    actions: [
      GestureDetector(
        onTap: (){},
        child: const CircleAvatar(
          radius: 17,
          backgroundImage: AssetImage("images/st.png"),
        ),
      ),
      const SizedBox(width: 10,),
    ],
  );
}