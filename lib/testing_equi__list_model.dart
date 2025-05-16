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

    data = json['data'] == null
        ? []
        : List<UserData>.from(json['data'].map((x) => UserData.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String? testEquipmentId;
  String? type;
  String? testingDetailId;
  String? currentUser;
  String? status;
  String? equipmentName;
  String? brandName;
  String? modelNo;
  String? specification;
  String? calibrationExpiry;
  String? lab;
  int? quantity;
  String? location;
  String? person;
  String? testProductName;
  String? date;

  String? pdfUrl;

  UserData(
      {this.testEquipmentId,
      this.type,
      this.testingDetailId,
      this.currentUser,
      this.status,
      this.equipmentName,
      this.brandName,
      this.modelNo,
      this.specification,
      this.calibrationExpiry,
      this.lab,
      this.quantity,
      this.location,
      this.person,
      this.testProductName,
      this.date,
      this.pdfUrl});

  UserData.fromJson(Map<String, dynamic> json) {
    testEquipmentId = json['testEquipmentId'];
    type = json['Type'];
    testingDetailId = json['TestingDetailId'];
    currentUser = json['CurrentUser'];
    status = json['Status'];
    equipmentName = json['equipment_Name'];
    brandName = json['brand_Name'];
    modelNo = json['model_No'];
    specification = json['specification'];
    calibrationExpiry = json['calibration_Expiry'];
    lab = json['lab'];
    quantity = json['quantity'];
    location = json['location'];
    person = json['person'];
    testProductName = json['test_Product_Name'];
    date = json['createdOn'];
    pdfUrl = json['PdfUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testEquipmentId'] = this.testEquipmentId;
    data['Type'] = this.type;
    data['TestingDetailId'] = this.testingDetailId;
    data['CurrentUser'] = this.currentUser;
    data['Status'] = this.status;
    data['equipment_Name'] = this.equipmentName;
    data['brand_Name'] = this.brandName;
    data['model_No'] = this.modelNo;
    data['specification'] = this.specification;
    data['calibration_Expiry'] = this.calibrationExpiry;
    data['lab'] = this.lab;
    data['quantity'] = this.quantity;
    data['location'] = this.location;
    data['person'] = this.person;
    data['test_Product_Name'] = this.testProductName;
    data['createdOn'] = this.date;

    data['PdfUrl'] = this.pdfUrl;
    return data;
  }
}
