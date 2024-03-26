class LessonModel {
  int? id;
  String? lessonName;
  String? teacherName;
  String? semester;
  String? days;
  String? time;
  String? color;
  String? comment;
  String? stage;

  LessonModel(
      {this.id,
      this.lessonName,
      this.teacherName,
      this.semester,
      this.days,
      this.time,
      this.color,
      this.comment,
      this.stage});

  LessonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonName = json['lesson_Name'];
    stage = json['stage'];
    teacherName = json['teacher_name'];
    semester = json['semester'];
    days = json['days'];
    time = json['time'];
    color = json['color'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lesson_Name'] = this.lessonName;
    data['stage'] = this.stage;
    data['teacher_name'] = this.teacherName;
    data['semester'] = this.semester;
    data['days'] = this.days;
    data['time'] = this.time;
    data['color'] = this.color;
    data['comment'] = this.comment;
    return data;
  }
}
