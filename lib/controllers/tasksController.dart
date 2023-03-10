import 'package:get/get.dart';
import 'package:local_storage_app_theme/Db/DbHelper.dart';
import 'package:local_storage_app_theme/modals/task.dart';

class TasksController extends GetxController {

  //todo This method calls during the initialization of the controller
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  Future<int> addTask({Tasks? tasks}) async {
    return await DbHelper.insert(tasks);
  }

  var tasksList = <Tasks>[].obs;
  void getTasks() async {
    List<Map<String,dynamic>> _tasks = await DbHelper.queryAll();
    tasksList.assignAll(_tasks.map((data)=> Tasks.fromJson(data)).toList());

  }

  void deleteTask(Tasks tasks) {
    DbHelper.deleteTask(tasks);
    getTasks();
  }

  void updateStatus(int id) async{
    await DbHelper.updateStatus(id);
    getTasks();
  }



}