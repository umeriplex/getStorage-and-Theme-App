import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_storage_app_theme/views/theme/services.dart';
import 'package:local_storage_app_theme/views/theme/theme.dart';

import '../customWidgets/button.dart';
import '../customWidgets/myAppBar.dart';
import '../notification/notificationServices.dart';
import 'addTaskView.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: buildAppBar(() {
          ThemeServices().switchTheme();
          notifyHelper.displayNotification(title: "Notification Theme Changed", body:Get.isDarkMode ? "Light Mode Activated" : "Dark Mode Activated");
          notifyHelper.scheduledNotification();
          setState(() {});
        },
        "Home View",
        context
      ),
      body: Column(
        children: [
          addTaskBar(),
          addDateBar(),
        ],
      ),
    );
  }

  Container addDateBar() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: DatePicker(
            DateTime.now(),
            height: 100,
            width: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: primaryClr,
            selectedTextColor: Colors.white,
            dateTextStyle: subHeadingStyle,
            dayTextStyle: smallTextStyle,
            monthTextStyle: smallTextStyle,
            onDateChange: (date){
              _selectedDate = date;
            },
          ),
        );
  }

  Container addTaskBar() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.yMMMMd().format(DateTime.now()),style: subHeadingStyle,),
                  Text("Today",style: headingStyle,),
                ]
              ),
              MyButton(
                onTap: (){
                  Get.to(const AddTaskView());
                },
                text: "+ Add Task",
              ),
            ],
          ),
        );
  }




}
