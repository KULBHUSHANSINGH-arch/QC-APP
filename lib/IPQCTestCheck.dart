// import 'dart:io';
// import 'dart:typed_data';
// import 'package:QCM/constant/app_styles.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:toast/toast.dart';

// class IPQCTestCheck extends StatefulWidget {
//   @override
//   _IPQCTestCheckState createState() => _IPQCTestCheckState();
// }

// class _IPQCTestCheckState extends State<IPQCTestCheck> {
//   final _formKey = GlobalKey<FormState>();

//   final ImagePicker _picker = ImagePicker();
//   List<File> _images = [];
//   List<Uint8List> _imageBytes = [];

//   final TextEditingController _field1Controller = TextEditingController();
//   final TextEditingController _field2Controller = TextEditingController();
//   final TextEditingController _field3Controller = TextEditingController();

//   // Pick image and convert it to bytes
//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//     if (image != null) {
//       File imageFile = File(image.path);
//       Uint8List bytes = await imageFile.readAsBytes();

//       setState(() {
//         _images.add(imageFile);
//         _imageBytes.add(bytes);
//       });
//     }
//   }

//   // Remove image and corresponding bytes
//   void _removeImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//       _imageBytes.removeAt(index);
//     });
//   }

//   // Send images and form data to API
//   Future<void> _sendToApi() async {
//     if (_formKey.currentState!.validate()) {
//       if (_images.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please add at least one picture.')),
//         );
//         return;
//       }

//       FormData formData = FormData();

//       for (int i = 0; i < _images.length; i++) {
//         formData.files.add(
//           MapEntry(
//             'images[]',
//             MultipartFile.fromBytes(_imageBytes[i], filename: 'image$i.jpg'),
//           ),
//         );
//       }

//       formData.fields.addAll([
//         MapEntry('field1', _field1Controller.text),
//         MapEntry('field2', _field2Controller.text),
//         MapEntry('field3', _field3Controller.text),
//       ]);

//       try {
//         final dio = Dio();
//         final response = await dio.post(
//           'https://your-api-endpoint.com/upload',
//           data: formData,
//         );

//         if (response.statusCode == 200) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Images uploaded successfully!')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to upload images.')),
//           );
//         }
//       } catch (e) {
//         print('Error: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error uploading images.')),
//         );
//       }
//     }
//   }

//   // Helper method to create styled TextFormFields
//   Widget _buildStyledTextField({
//     required TextEditingController controller,
//     required String hintText,
//     required String validationMessage,
//   }) {
//     return TextFormField(
//       controller: controller,
//       minLines: 1,
//       maxLines: null,
//       keyboardType: TextInputType.multiline,
//       textInputAction: TextInputAction.next,
//       decoration: AppStyles.textFieldInputDecoration.copyWith(
//         hintText: hintText,
//         counterText: '',
//         contentPadding: EdgeInsets.all(10),
//       ),
//       style: AppStyles.textInputTextStyle,
//       readOnly: false,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return validationMessage;
//         }
//         return null;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     ToastContext().init(context);
//     return Scaffold(
//       appBar: AppBar(title: Text('Module Picture Form')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Styled Text Fields
//               _buildStyledTextField(
//                 controller: _field1Controller,
//                 hintText: "Please enter Field 1",
//                 validationMessage: "Field 1 is required",
//               ),
//               SizedBox(height: 10),
//               _buildStyledTextField(
//                 controller: _field2Controller,
//                 hintText: "Please enter Field 2",
//                 validationMessage: "Field 2 is required",
//               ),
//               SizedBox(height: 10),
//               _buildStyledTextField(
//                 controller: _field3Controller,
//                 hintText: "Please enter Field 3",
//                 validationMessage: "Field 3 is required",
//               ),
//               SizedBox(height: 20),

//               // Image Picker
//               Text(
//                 'Module Pictures',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: [
//                   ..._images.asMap().entries.map((entry) {
//                     int index = entry.key;
//                     File image = entry.value;
//                     return Stack(
//                       alignment: Alignment.topRight,
//                       children: [
//                         Image.file(
//                           image,
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.cancel, color: Colors.red),
//                           onPressed: () => _removeImage(index),
//                         ),
//                       ],
//                     );
//                   }).toList(),
//                   GestureDetector(
//                     onTap: _pickImage,
//                     child: Container(
//                       width: 100,
//                       height: 100,
//                       color: Colors.grey[300],
//                       child: Icon(Icons.camera_alt,
//                           size: 40, color: Colors.black54),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),

//               // Submit Button
//               ElevatedButton(
//                 onPressed: _sendToApi,
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
// import 'package:QCM/FqcNewTestList.dart';
// import 'package:QCM/Fqcnew.dart';
// import 'package:QCM/IPQCCheckSheetList.dart';
// import 'package:QCM/Ipqc.dart';
// import 'package:QCM/QualityList.dart';
// import 'package:QCM/QualityPage.dart';
// import 'package:QCM/components/app_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/src/response.dart' as Response;
import 'package:qcmapp/IPQCCheckSheetList.dart';
import 'package:qcmapp/components/app_button_widget.dart';
import 'package:qcmapp/components/app_loader.dart';
// import 'package:QCM/components/app_button_widget.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'components/appbar.dart';
import 'constant/app_assets.dart';
import 'constant/app_color.dart';
import 'constant/app_fonts.dart';
import 'constant/app_strings.dart';
import 'constant/app_styles.dart';

class IPQCTestCheck extends StatefulWidget {
  final String? id;
  IPQCTestCheck({this.id});
  _IPQCTestCheckState createState() => _IPQCTestCheckState();
}

class _IPQCTestCheckState extends State<IPQCTestCheck> {
  List data = [];
  List checkPointData = [];
  List citydata1 = [];
  bool sameAsPresentAddress = false;
  final picker = ImagePicker();

  final _dio = Dio();
  // Response? _response;
  Response.Response? _response;
  List<String>? issuetypeController = [];

  // String? issuetypeController;
  String? subissuetypeController;
  String? _errorMessage,
      bloodGroupController,
      personid,
      designation,
      department,
      setpersonid,
      firstname,
      lastname,
      pic,
      ImagePath,
      logo,
      checkPointController,
      site,
      businessname,
      organizationtype,
      dobdate,
      dojdate,
      doidate,
      announcementId,
      endDate,
      announcementStatus;
  bool _isLoading = false;
  String setStatus = "Active", status = "Ok";

  bool isLoading = false;

  List<Map<String, dynamic>> issueList = [];

  SharedPreferences? prefs;

  TextEditingController feedbackController = new TextEditingController();
  TextEditingController parameterController = new TextEditingController();
  TextEditingController remarksController = new TextEditingController();

  GlobalKey<FormState> qualityformKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];
  List<Uint8List> _imageBytes = [];
  @override
  void initState() {
    store();

    getIssueData();

    super.initState();
  }

  void store() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      designation = prefs.getString('designation');
      department = prefs.getString('department');
      pic = prefs.getString('pic');
      personid = prefs.getString('personid');
      site = prefs.getString('site');
    });
    // if (widget.id != "" && widget.id != null) {
    //   _get();
    // }
  }

  // Pick image and convert it to bytes
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      File imageFile = File(image.path);
      Uint8List bytes = await imageFile.readAsBytes();

      setState(() {
        _images.add(imageFile);
        _imageBytes.add(bytes);
      });
    }
  }

  // Remove image and corresponding bytes
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      _imageBytes.removeAt(index);
    });
  }

  // Future<void> _get() async {
  //   print("Id.....AddEditProfile");
  //   print(personid);
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     if (widget.id != '' && widget.id != null) {
  //       _isLoading = true;
  //     }
  //     site = prefs.getString('site');
  //   });
  //   final QualityData = ((site!) + 'Quality/QualityList');
  //   final qualityData = await http.post(
  //     Uri.parse(QualityData),
  //     body: jsonEncode(
  //         <String, String>{"QualityId": widget.id ?? '', "token": token!}),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );

  //   var resBody = json.decode(qualityData.body);

  //   if (mounted) {
  //     setState(() {
  //       data = resBody['data'];
  //       print("Data ......??");
  //       print(data);
  //       if (data != null && data.length > 0) {
  //         _isLoading = false;
  //         final dataMap = data.asMap();

  //         print(dataMap[0]['subParticleType']);
  //         print("Datamap////?");
  //         modulepicture = dataMap[0]['ModulePicture'] ?? "";
  //         elpicture = dataMap[0]['ElModuleImage'] ?? "";
  //         // shiftController = dataMap[0]['Shift'] ?? "";
  //         shiftinchargeprelimeController.text =
  //             dataMap[0]['ShiftInChargePreLime'] ?? '';
  //         shiftinchargepostlimeController.text =
  //             dataMap[0]['ShiftInChargePostLim'] ?? '';
  //         productBarcodeController.text = dataMap[0]['ProductBarCode'] ?? '';
  //         wattageController.text = dataMap[0]['Wattage'] ?? '';
  //         // elTypeController = dataMap[0]['elType'] ?? '';
  //         // particletypeController = dataMap[0]['particleType'] ?? '';
  //         // subparticletypeController = dataMap[0]['subParticleType'] ?? '';
  //         issuetypeController = dataMap[0]['IssueType'] ?? '';
  //         subissuetypeController = dataMap[0]['subIssueType'] ?? '';

  //         laminatorTypeController = dataMap[0]['Stringer'] ?? '';
  //         otherissuetypeController.text = dataMap[0]['OtherIssueType'] ?? '';

  //         othermodelnumberController.text =
  //             dataMap[0]['OtherModelNumber'] ?? '';
  //         stageController.text = dataMap[0]['Stage'] ?? '';
  //         responsiblepersonController.text =
  //             dataMap[0]['ResposiblePerson'] ?? '';
  //         reasonofissueController.text = dataMap[0]['ReasonOfIssue'] ?? '';
  //         issuecomefromController.text = dataMap[0]['IssueComeFrom'] ?? '';
  //         actiontakenController.text = dataMap[0]['ActionTaken'] ?? '';
  //       }
  //     });
  //     // await getIssueData(issuetypeController); // Populate subIssueList
  //     // await getaPartclesData(
  //     //     particletypeController); // Populate subparticleList

  //     setState(() {});
  //   }
  // }

  Future<bool> redirectto() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget.id != "" && widget.id != null
          ? IPQCCheckSheetList()
          : IPQCCheckSheetList();
    }));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        // ignore: deprecated_member_use
        child: WillPopScope(
            // ignore: missing_return
            onWillPop: redirectto,
            child: Scaffold(
              appBar: GautamAppBar(
                organization: "organizationtype",
                isBackRequired: true,
                memberId: personid,
                imgPath: "ImagePath",
                memberPic: pic,
                logo: "logo",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return widget.id != "" && widget.id != null
                        ? IPQCCheckSheetList()
                        : IPQCCheckSheetList();
                  }));
                },
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10, top: 15),
                child: _isLoading ? AppLoader() : _user(),
              ),
              // floatingActionButton: _getFAB(),
            )));
  }

  TextFormField remarks() {
    return TextFormField(
      controller: remarksController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter remarks",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter remarks';
        }
        return null;
      },
    );
  }

  Future<void> getIssueData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      site = prefs.getString('site');

      if (site == null) {
        print("Site URL is null");
        return;
      }

      final url = Uri.parse(site! + 'TestEquipmet/getIPQCCheckpoints');
      print("Fetching from URL: $url");

      final response = await http.post(
        url,
        body: jsonEncode({
          // "IssueId": issueId ?? "",
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final issueBody = jsonDecode(response.body);
        print("datataaaaaaa..?");
        print(issueBody);
        print(issueBody['data']);
        setState(() {
          checkPointData = issueBody['data'];
        });
        return;
      }
    } catch (e, stackTrace) {
      print("Error fetching issue/sub-issue data: $e");
      print("Stack trace: $stackTrace");
    }
  }

  // Send images and form data to API
  Future<void> sendToApi() async {
    if (qualityformKey.currentState!.validate()) {
      if (_images.isEmpty) {
        Toast.show(
          "Please add at least one picture.",
          duration: Toast.lengthLong,
          gravity: Toast.center,
          backgroundColor: const Color.fromARGB(255, 176, 55, 55),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final prefs = await SharedPreferences.getInstance();
        site = prefs.getString('site');

        final dio = Dio();

        // Prepare the data as JSON object
        Map<String, dynamic> requestBody = {
          'personId': personid ?? "",
          'checkPoint': checkPointController ?? "",
          'status': status,
          'remarks': remarksController.text,
          'parameter': parameterController.text,
          'feedback': feedbackController.text,
        };

        // Add images as base64 strings
        // List<String> base64Images =
        //     _imageBytes.map((bytes) => base64Encode(bytes)).toList();
        // requestBody['images'] = base64Images;

        // print("Request Body: $requestBody");

        List<String> base64Images = _imageBytes.map((bytes) {
          String mimeType =
              "image/png"; // Change to "image/jpeg" or appropriate type
          return "data:$mimeType;base64,${base64Encode(bytes)}";
        }).toList();

        requestBody['images'] = base64Images;

        print("Request Body: $requestBody");

        final response = await dio.post(
          '$site/TestEquipmet/addInspectionData',
          data: jsonEncode(requestBody),
          options: Options(
            headers: {
              "Content-Type": "application/json",
            },
          ),
        );

        print("Response: $response");

        if (response.statusCode == 200) {
          setState(() {
            _isLoading = false;
          });
          Toast.show(
            "Check Sheet Successfully Created.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: const Color.fromARGB(255, 10, 158, 244),
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => IPQCCheckSheetList()));
        } else {
          Toast.show(
            "Failed to create.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: const Color.fromARGB(255, 176, 55, 55),
          );
        }
      } catch (e) {
        print('Error: $e');
        Toast.show(
          "Error...",
          duration: Toast.lengthLong,
          gravity: Toast.center,
          backgroundColor: const Color.fromARGB(255, 176, 55, 55),
        );
      }
    }
  }

  Future createData(
      String status,
      String shift,
      String productBarcode,
      String issueStatus,
      // List issuetype,
      String otherissuetype,
      String issueStatusType,
      String remarksController) async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');

    final url = (site! + 'TestEquipmet/AddNewFQC'); // Prod

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(<String, String>{
        "fqcnewid":
            widget.id != "" && widget.id != null ? widget.id.toString() : "",
        "currentuser": personid ?? '',
        "status": status,
        "pallateType": shift,
        "issueStatus": issueStatus,
        "productBarcode": productBarcode,
        "issueStatusType": issueStatusType,
        "Remark": remarksController
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("Resssssssss.....???");
    print({
      "fqcnewid":
          widget.id != "" && widget.id != null ? widget.id.toString() : "",
      "currentuser": personid ?? '',
      "status": status,
      "pallateType": shift,
      "issueStatus": issueStatus,
      "productBarcode": productBarcode,
      "issuetype": jsonEncode(issuetypeController),
      "Remark": remarksController
    });
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      print(data['UUID']);

      setState(() {
        setpersonid = data['UUID'];
      });
    } else if (response.statusCode == 400) {
      setState(() {
        _isLoading = false;
      });
      Toast.show("This Issue is Already Reported.",
          duration: Toast.lengthLong,
          gravity: Toast.center,
          backgroundColor: Colors.redAccent);
    } else if (response.statusCode == 409) {
      setState(() {
        _isLoading = false;
      });
      Toast.show("This Barcode Number is Already Exist.",
          duration: Toast.lengthLong,
          gravity: Toast.center,
          backgroundColor: Colors.redAccent);
    } else {
      setState(() {
        _isLoading = false;
      });
      Toast.show("Error on Server",
          duration: Toast.lengthLong,
          gravity: Toast.center,
          backgroundColor: Colors.redAccent);
    }
  }

  Widget _user() {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: qualityformKey,
        child: ListView(
          children: [
            // Padding(padding: EdgeInsets.only(top: 10)),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
              ),
            ),
            //  Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.imgLogo,
                    height: 100,
                    width: 230,
                  ),
                ],
              ),
            ),

            const Center(
                child: Text("InLine Check Sheet",
                    style: TextStyle(
                        fontSize: 25,
                        color: AppColors.black,
                        fontFamily: appFontFamily,
                        fontWeight: FontWeight.w700))),
            const SizedBox(
              height: 25,
            ),

            Text(
              "Check Point*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: AppStyles.textFieldInputDecoration.copyWith(
                  hintText: "Please Select Check Point",
                  counterText: '',
                  contentPadding: EdgeInsets.all(10)),
              borderRadius: BorderRadius.circular(20),
              items: checkPointData
                  .map((label) => DropdownMenuItem(
                        child: Text(label['Checkpoint']!,
                            style: AppStyles.textInputTextStyle),
                        value: label['Checkpoint_ID'].toString(),
                      ))
                  .toList(),
              onChanged: (val) {
                var checkpoint = checkPointData.firstWhere(
                  (item) => item['Checkpoint_ID'] == val,
                  orElse: () => {'Frequency': 'Not Found'},
                );
                final frequency = checkpoint['Frequency'] ?? 'Not Found';

                print("Params");
                print(frequency);

                setState(() {
                  parameterController.text = frequency;
                  checkPointController = val!;
                });
              },
              value: checkPointController != '' ? checkPointController : null,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please select check point';
              //   }
              //   return null; // Return null if the validation is successful
              // },
            ),

            const SizedBox(
              height: 15,
            ),

            Text(
              "Frequency*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: parameterController,
              minLines: 1,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              decoration: AppStyles.textFieldInputDecoration.copyWith(
                  hintText: "Please Enter Frequency",
                  counterText: '',
                  contentPadding: EdgeInsets.all(10)),
              style: AppStyles.textInputTextStyle,
              readOnly: true,
            ),

            const SizedBox(
              height: 15,
            ),

            // --- Radio Buttons Section ---
            Text(
              "Status*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: Text("Ok", style: AppStyles.textInputTextStyle),
                    value: "Ok",
                    groupValue: status,
                    onChanged: (value) {
                      setState(() {
                        status = value!;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                  RadioListTile<String>(
                    title: Text("Not Ok", style: AppStyles.textInputTextStyle),
                    value: "Not Ok",
                    groupValue: status,
                    onChanged: (value) {
                      setState(() {
                        status = value!;
                      });
                    },
                    activeColor: Colors.red,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Text(
              "Feedback*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: feedbackController,
              minLines: 1,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              decoration: AppStyles.textFieldInputDecoration.copyWith(
                  hintText: "Please Enter Feedback",
                  counterText: '',
                  contentPadding: EdgeInsets.all(10)),
              style: AppStyles.textInputTextStyle,
              readOnly: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter feedback';
                }
                return null;
              },
            ),

            const SizedBox(
              height: 15,
            ),

            Text(
              "Remarks*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: remarksController,
              minLines: 1,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              decoration: AppStyles.textFieldInputDecoration.copyWith(
                  hintText: "Please Enter Remarks",
                  counterText: '',
                  contentPadding: EdgeInsets.all(10)),
              style: AppStyles.textInputTextStyle,
              readOnly: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter remarks';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            // Image Picker
            Text(
              'Module Pictures*',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ..._images.asMap().entries.map((entry) {
                  int index = entry.key;
                  File image = entry.value;
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.file(
                        image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel, color: Colors.red),
                        onPressed: () => _removeImage(index),
                      ),
                    ],
                  );
                }).toList(),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child:
                        Icon(Icons.camera_alt, size: 40, color: Colors.black54),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            AppButton(
              organization: (organizationtype ?? ''),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  fontSize: 16),
              onTap: () async {
                if (qualityformKey.currentState!.validate()) {
                  sendToApi();
                }
              },
              label: AppStrings.SAVE,
            ),
            SizedBox(height: 10),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                widget.id != "" && widget.id != null
                                    ? IPQCCheckSheetList()
                                    : IPQCCheckSheetList()),
                        (Route<dynamic> route) => false);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontFamily: appFontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.redColor),
                  ),
                ),
              ),
            ),
            const Divider(),
          ],
        ));
  }
}
