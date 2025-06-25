import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? status;
  String? message;
  List<UserData>? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null && json['data'] is List) {
      data = List<UserData>.from(json['data'].map((x) => UserData.fromJson(x)));
    } else {
      data = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String? reportId;
  Map<String, dynamic>? problemDescription; // Changed this to Map
  String? type;
  String? shift;
  String? createdOn;
  String? updatedOn;
  String? pdfUrl;
  String? createdBy;
  String? department;
  String? departmentName;

  UserData(
      {this.reportId,
      this.problemDescription,
      this.type,
      this.shift,
      this.createdOn,
      this.updatedOn,
      this.pdfUrl,
      this.createdBy,
      this.department,
      this.departmentName});

  UserData.fromJson(Map<String, dynamic> json) {
    reportId = json['report_id'];
    problemDescription = json['problem_description']; // Keep this as Map
    type = json['type'];
    shift = json['shift'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    pdfUrl = json['pdf_url'];
    createdBy = json['createdBy'];
    department = json['Department'];
    departmentName = json['department_name'];
  }

  get name => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['report_id'] = this.reportId;
    data['problem_description'] = this.problemDescription; // Keep this as Map
    data['type'] = this.type;
    data['shift'] = this.shift;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['pdf_url'] = this.pdfUrl;
    data['createdBy'] = this.createdBy;
    data['Department'] = this.department;
    data['department_name'] = this.departmentName;
    return data;
  }
}
