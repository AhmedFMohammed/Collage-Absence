class AttendanceModel {
  int? id;
  String? datetime;
  String? teacherName;
  String? studentName;
  String? comment;
  int? studentId;
  int? lessonId;
  String? clas;

  AttendanceModel(
      {this.id,
      this.datetime,
      this.teacherName,
      this.studentName,
      this.comment,
      this.studentId,
      this.lessonId,
      this.clas});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["datetime"] is String) {
      datetime = json["datetime"];
    }
    if (json["teacher_name"] is String) {
      teacherName = json["teacher_name"];
    }
    if (json["student_name"] is String) {
      studentName = json["student_name"];
    }
    if (json["comment"] is String) {
      comment = json["comment"];
    }
    if (json["studentID"] is int) {
      studentId = json["studentID"];
    }
    if (json["lessonID"] is int) {
      lessonId = json["lessonID"];
    }
    if (json["clas"] is String) {
      clas = json["clas"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["datetime"] = datetime;
    _data["teacher_name"] = teacherName;
    _data["student_name"] = studentName;
    _data["comment"] = comment;
    _data["studentID"] = studentId;
    _data["lessonID"] = lessonId;
    _data["clas"] = clas;
    return _data;
  }
}
