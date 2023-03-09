import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_storage_app_theme/views/theme/theme.dart';

import '../customWidgets/button.dart';
import '../customWidgets/inputFields.dart';
import '../customWidgets/myAppBar.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {

  DateTime _selectedDate = DateTime.now();
  String _endTime = "12:00 AM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  List<int> reminderList = [5,10,15,20,25,30,35,40,45,50,55,60];
  int _selectedItem = 5;


  List<String> repeatList = ["none","daily"];
  String _selectedRepeatItem = "none";

  int selectedColor = 0;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: buildAppBar2((){Get.back();},"",context),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Tasks",style: headingStyle,),
              15.ph,
              InputFields(title: "Title",hint: "Enter title here",controller: _titleController,),
              20.ph,
              InputFields(title: "Note",hint: "Enter note here",controller: _noteController,),
              20.ph,
              InputFields(title: "Date",hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed:(){
                    debugPrint("Date Picker");
                    _getDateFromUser(context);
                  },
                  icon: const Icon(Icons.calendar_today,color: Colors.grey,),
                ),
                controller: null,
              ),
              20.ph,
              Row(
                children: [
                  Expanded(
                      child: InputFields(
                        title: "Start Time",
                        hint: _startTime,
                        widget: Container(
                          child: IconButton(
                            onPressed:(){
                              _getTimeFromUser(isStartTime: true);
                            },
                            icon: const Icon(Icons.access_time,color: Colors.grey,),
                          ),
                        ),
                        controller: null,
                      )
                  ),
                  20.pw,
                  Expanded(
                      child: InputFields(
                        title: "End Time",
                        hint: _endTime,
                        widget: Container(
                          child: IconButton(
                            onPressed:(){
                              _getTimeFromUser(isStartTime: false);
                            },
                            icon: const Icon(Icons.access_time,color: Colors.grey,),
                          ),
                        ),
                        controller: null,
                      )
                  ),
                ],
              ),
              20.ph,
              InputFields(
                title: "Reminder",
                hint: "$_selectedItem minutes early",
                widget: DropdownButton(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0),
                  style: normalTextStyle,
                  items: reminderList.map<DropdownMenuItem<String>>((int value){
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = int.parse(newValue!);
                    });
                  },
                ),
                controller: null,
              ),
              20.ph,
              InputFields(
                title: "Repeat",
                hint: "$_selectedRepeatItem",
                widget: DropdownButton(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0),
                  style: normalTextStyle,
                  items: repeatList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeatItem = newValue!;
                    });
                  },
                ),
                controller: null,
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  colorPallet(),
                  MyButton(
                    onTap: (){_validationData();},
                    text: "Create Task",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validationData(){
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      Get.back();
    }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
    Get.snackbar(
        "Required Fields",
        "Please add title and note first!",
        snackPosition: SnackPosition.TOP,
        colorText: Get.isDarkMode ? darkGreyClr : white,
        backgroundColor: Get.isDarkMode ?  Colors.white : primaryClr,
        margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
        borderRadius: 10,
        icon: Icon(Icons.warning_rounded,color: Get.isDarkMode ? Colors.grey : Colors.white,)
    );
    }
  }


  Column colorPallet() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Color",style: normalTextStyle,),
                    5.ph,
                    Wrap(
                      children: List<Widget>.generate(
                          3,
                          (int index) => GestureDetector(
                            onTap: (){
                              setState(() {
                                selectedColor = index;
                                debugPrint(selectedColor.toString());
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: index == 0 ? primaryClr : index == 1 ? pinkClr : yellowClr,
                                child: selectedColor == index ? const Icon(Icons.done_outline_rounded,color: Colors.white,size: 16,) : Container(),
                              ),
                            ),
                          )
                      ),
                    ),
                  ],
                );
  }

  _getDateFromUser(BuildContext context) async {
    DateTime? _pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
    );
    if(_pickDate != null){
      setState(() {
        debugPrint("Date: ${_pickDate.toString()}");
        _selectedDate = _pickDate;
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);

    if(pickedTime == null){
      debugPrint("Canceled");
    }
    else if(isStartTime){
      setState(() {
        _startTime = _formatedTime;
      });
    }
    else if(!isStartTime){
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])
      ),
    );
  }
}
