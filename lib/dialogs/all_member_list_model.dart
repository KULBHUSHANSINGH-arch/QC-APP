class AllMemberListModel {
  bool? success;
  Data? data;

  AllMemberListModel({this.success, this.data});

  AllMemberListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  List<Person>? person;

  Data({this.person});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['person'] != null) {
      person = <Person>[];
      json['person'].forEach((v) {
        person!.add(Person.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (person != null) {
      data['person'] = person!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Person {
  String? businessname;
  String? businesscategory;
  String? personid;
  // Null title;
  String? firstname;
  String? middlename;
  String? lastname;
  Null suffix;
  String? profilepicture;
  String? dob;
  String? status;
  String? addrline1;
  String? addrline2;
  String? city;
  String? state;
  String? country;
  String? area;
  String? postalcode;
  String? countrycode;
  String? phonenum;

  Person(
      {this.businessname,
      this.businesscategory,
      this.personid,
      // this.title,
      this.firstname,
      this.middlename,
      this.lastname,
      this.suffix,
      this.profilepicture,
      this.dob,
      this.status,
      this.addrline1,
      this.addrline2,
      this.city,
      this.state,
      this.country,
      this.area,
      this.postalcode,
      this.countrycode,
      this.phonenum});

  Person.fromJson(Map<String, dynamic> json) {
    businessname = json['businessname'];
    businesscategory = json['businesscategory'];
    personid = json['personid'];
    // title = json['title'];
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    suffix = json['suffix'];
    profilepicture = json['profilepicture'];
    dob = json['dob'];
    status = json['status'];
    addrline1 = json['addrline1'];
    addrline2 = json['addrline2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    area = json['area'];
    postalcode = json['postalcode'];
    countrycode = json['countrycode'];
    phonenum = json['phonenum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['businessname'] = businessname;
    data['businesscategory'] = businesscategory;
    data['personid'] = personid;
    // data['title'] = this.title;
    data['firstname'] = firstname;
    data['middlename'] = middlename;
    data['lastname'] = lastname;
    data['suffix'] = suffix;
    data['profilepicture'] = profilepicture;
    data['dob'] = dob;
    data['status'] = status;
    data['addrline1'] = addrline1;
    data['addrline2'] = addrline2;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['area'] = area;
    data['postalcode'] = postalcode;
    data['countrycode'] = countrycode;
    data['phonenum'] = phonenum;
    return data;
  }
}
