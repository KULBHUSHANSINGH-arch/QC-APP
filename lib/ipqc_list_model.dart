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

    data = json["data"] == null
        ? []
        : List<UserData>.from(json["data"].map((x) => UserData.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String? employeeID;
  String? name;
  String? profileImg;
  String? location;
  String? type;
  String? excelURL;
  String? referencePdf;
  String? jobCardDetailID;
  String? moduleNo;
  String? materialName;
  String? date;
  String? shift;

  UserData(
      {this.employeeID,
      this.name,
      this.profileImg,
      this.location,
      this.type,
      this.excelURL,
      this.referencePdf,
      this.jobCardDetailID,
      this.moduleNo,
      this.materialName,
      this.date,
      this.shift});

  UserData.fromJson(Map<String, dynamic> json) {
    employeeID = json['EmployeeID'];
    name = json['Name'];
    profileImg = json['ProfileImg'];
    location = json['Location'];
    type = json['Type'];
    excelURL = json['ExcelURL'];
    referencePdf = json['ReferencePdf'];
    jobCardDetailID = json['JobCardDetailID'];
    moduleNo = json['ModuleNo'];
    materialName = json['MaterialName'];
    date = json['Date'];
    shift = json['Shift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmployeeID'] = employeeID;
    data['Name'] = name;
    data['ProfileImg'] = profileImg;
    data['Location'] = location;
    data['Type'] = type;
    data['ExcelURL'] = excelURL;
    data['ReferencePdf'] = referencePdf;
    data['JobCardDetailID'] = jobCardDetailID;
    data['ModuleNo'] = moduleNo;
    data['MaterialName'] = materialName;
    data['Date'] = date;
    data['Shift'] = shift;
    return data;
  }
}
