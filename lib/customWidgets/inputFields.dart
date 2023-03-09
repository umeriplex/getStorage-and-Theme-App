import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_storage_app_theme/views/theme/theme.dart';


class InputFields extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  InputFields({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: normalTextStyle,),
          10.ph,
          Container(
            height: 52,
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children:[
                Expanded(
                    child: TextFormField(
                      readOnly: widget == null ? false : true,
                      autofocus: false,
                      cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[500],
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: verySmallTextStyle,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: context.theme.backgroundColor,width: 0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: context.theme.backgroundColor,width: 0),
                        ),
                      ),
                    )
                ),
                10.pw,
                widget == null ? Container() : Container(child: widget,)
              ]
            )
          ),

        ],
      ),
    );
  }
}
