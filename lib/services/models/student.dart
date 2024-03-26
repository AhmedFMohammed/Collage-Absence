class StudentModel {
  int? id;
  String? studentName;
  String? clas;
  String? stage;
  String? comment;
  String? attendencecount;
  bool? is_Absence;

  StudentModel(
      {this.id,
      this.studentName,
      this.clas,
      this.stage,
      this.comment,
      this.attendencecount});

  StudentModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json['id'];
    }

    studentName = json['student_name'];
    clas = json['clas'];
    stage = json['stage'];
    comment = json['comment'];
    attendencecount = json['attendencecount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (id != null) {
      data['id'] = this.id;
    }
    data['student_name'] = this.studentName;
    data['clas'] = this.clas;
    data['stage'] = this.stage;
    data['comment'] = this.comment;
    data['attendencecount'] = this.attendencecount;
    return data;
  }
}
