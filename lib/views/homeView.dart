import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_storage_app_theme/modals/task.dart';
import 'package:local_storage_app_theme/views/theme/services.dart';
import 'package:local_storage_app_theme/views/theme/theme.dart';

import '../controllers/tasksController.dart';
import '../customWidgets/button.dart';
import '../customWidgets/myAppBar.dart';
import '../customWidgets/taskTile.dart';
import '../notification/notificationServices.dart';
import 'addTaskView.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  DateTime _selectedDate = DateTime.now();
  final _tasksController = Get.put(TasksController());
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
          tasksTile(),
        ],
      ),
    );
  }

  Expanded tasksTile() {
    return Expanded(
            child: Obx((){
              return ListView.builder(
                  itemCount: _tasksController.tasksList.length,
                  itemBuilder: (context,index){
                    print(".::TASKS LIST LENGTH::. ${_tasksController.tasksList.length}");
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child:  Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    _showBottomSheet(context,_tasksController.tasksList[index]);
                                    },
                                  child : TaskTile(_tasksController.tasksList[index],)
                                ),
                              ],
                            ),
                          ),
                        ),
                    );
                  }
              );
            }),
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
                onTap: () async {
                  await Get.to(const AddTaskView());
                  _tasksController.getTasks();
                },
                text: "+ Add Task",
              ),
            ],
          ),
        );
  }

  _bottomSheetButton({required String lable, required Function()? onTap, required Color color, bool isClosed = false,required BuildContext context}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        height: 55,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isClosed == true ? Colors.transparent : color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              width: 2,
              color: isClosed == true ? Get.isDarkMode ? Colors.grey[600]! : Colors.grey[300]! : color
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lable,
              style: isClosed == true ? normalTextStyle : normalTextStyle.copyWith(color: Colors.white) ,
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Tasks tasks){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: tasks.isCompleted == 1 ? MediaQuery.of(context).size.height * 0.24 : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.white54 : Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const Spacer(),
            tasks.isCompleted == 1 ? Container() :
            _bottomSheetButton(lable: "Mark as Completed", color: primaryClr, context : context,onTap: (){
              _tasksController.updateStatus(tasks.id!);
              Get.back();
              },),

            _bottomSheetButton(lable: "Delete Task", color: Colors.red[500]! , context : context,onTap: (){
              _tasksController.deleteTask(tasks);
              Get.back();
            },),
            10.ph,

            _bottomSheetButton(isClosed :true, lable: "Close", color: Colors.white , context : context,onTap: (){
              Get.back();
            },),
            10.ph,
          ],
        ),
      )
    );
  }




}
