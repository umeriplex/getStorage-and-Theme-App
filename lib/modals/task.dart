class Tasks{
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? sTime;
  String? eTime;
  int? color;
  String? remind;
  String? repeat;

  Tasks(this.id, this.title, this.note, this.isCompleted, this.date, this.sTime,
      this.eTime, this.color, this.repeat,this.remind);

  Tasks.fromJson(Map<String,dynamic> json){
    id = json["id"];
    title = json["title"];
    note = json["note"];
    isCompleted = json["isCompleted"];
    date = json["date"];
    sTime = json["startTime"];
    eTime = json["endTime"];
    color = json["color"];
    remind = json["remind"];
    repeat = json["repeat"];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data["id"] = id;
    data["title"] = title;
    data["note"] = note;
    data["isCompleted"] = isCompleted;
    data["date"] = date;
    data["startTime"] = sTime;
    data["endTime"] = eTime;
    data["color"] = color;
    data["remind"] = remind;
    data["repeat"] = repeat;
    return data;
  }
}