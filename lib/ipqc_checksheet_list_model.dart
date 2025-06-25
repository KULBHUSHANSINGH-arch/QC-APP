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
  String? inspectionId;
  List<String>? images;
  String? checkPoint;
  String? remarks;
  String? parameter;
  String? feedback;
  String? createdBy;
  String? updatedBy;
  String? createdOn;
  String? updatedOn;
  String? status;

  UserData(
      {this.inspectionId,
      this.images,
      this.checkPoint,
      this.remarks,
      this.parameter,
      this.feedback,
      this.createdBy,
      this.updatedBy,
      this.createdOn,
      this.updatedOn,
      this.status});

  UserData.fromJson(Map<String, dynamic> json) {
    inspectionId = json['inspection_id'];
    images = json['images'].cast<String>();
    checkPoint = json['checkPoint'];
    remarks = json['remarks'];
    parameter = json['parameter'];
    feedback = json['feedback'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inspection_id'] = this.inspectionId;
    data['images'] = this.images;
    data['checkPoint'] = this.checkPoint;
    data['remarks'] = this.remarks;
    data['parameter'] = this.parameter;
    data['feedback'] = this.feedback;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['status'] = this.status;
    return data;
  }
}
