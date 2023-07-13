class Student {
  String? email;
  String? location;
  String? name;
  String? phone;
  String? role;
  String? studentId;

  Student(
      {this.email,
      this.location,
      this.name,
      this.phone,
      this.role,
      this.studentId});

  Student.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    location = json['location'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
    studentId = json['student_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['location'] = this.location;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['student_id'] = this.studentId;
    return data;
  }
}