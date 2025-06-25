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
  String? fqcNewId;
  String? line;
  String? currentUser;
  String? status;
  String? pallateType;
  String? issueStatus;
  String? productBarcode;
  String? productTestReport;
  String? issueType;
  String? productTestUrl;
  String? createdOn;
  String? updatedOn;
  String? createdByName;
  String? createdTime;
  String? issueStatusType;

  UserData({
    this.fqcNewId,
    this.line,
    this.currentUser,
    this.status,
    this.pallateType,
    this.issueStatus,
    this.productBarcode,
    this.productTestReport,
    this.issueType,
    this.productTestUrl,
    this.createdOn,
    this.updatedOn,
    this.createdByName,
    this.createdTime,
    this.issueStatusType,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    fqcNewId = json['fqcnewid'];
    line = json['line'];
    currentUser = json['currentuser'];
    status = json['status'];
    pallateType = json['pallateType'];
    issueStatus = json['issueStatus'];
    productBarcode = json['productBarcode'];
    productTestReport = json['productTestReport'];
    issueType = json['issuetype'];
    productTestUrl = json['productTestUrl'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    createdByName = json['createdByName'];
    createdTime = json['createdTime'];
    issueStatusType = json['issueStatusType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fqcnewid'] = this.fqcNewId;
    data['line'] = this.line;
    data['currentuser'] = this.currentUser;
    data['status'] = this.status;
    data['pallateType'] = this.pallateType;
    data['issueStatus'] = this.issueStatus;
    data['productBarcode'] = this.productBarcode;
    data['productTestReport'] = this.productTestReport;
    data['issuetype'] = this.issueType;
    data['productTestUrl'] = this.productTestUrl;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['updatedOn'] = this.createdByName;
    data['createdTime'] = this.createdTime;
    data['issueStatusType'] = this.issueStatusType;
    return data;
  }
}
