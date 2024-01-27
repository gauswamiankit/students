class StudentModel {
  String? createdAt;
  String? english;
  String? id;
  String? math;
  String? name;

  StudentModel({this.createdAt, this.english, this.id, this.math, this.name});

  StudentModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    english = json['english'];
    id = json['id'];
    math = json['math'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['english'] = this.english;
    data['id'] = this.id;
    data['math'] = this.math;
    data['name'] = this.name;
    return data;
  }
}
