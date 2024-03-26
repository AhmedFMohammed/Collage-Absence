class StageModel {
  String? classes, student_count, semester;
  bool? is_Activated;
  int? classes_count, id;
  StageModel({
    this.id,
    this.classes,
    this.classes_count,
    this.is_Activated,
    this.semester,
    this.student_count,
  });

  StageModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json['id'];
    }

    classes = json['classes'];
    is_Activated = json['is_activated'];
    semester = json['semester'];
    student_count = json['student_count'];
    classes_count = json['classes_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id;
    }
    data['classes'] = this.classes;
    data['is_activated'] = this.is_Activated;
    data['semester'] = this.semester;
    data['student_count'] = this.student_count;
    data['classes_count'] = this.classes_count;
    return data;
  }
}
