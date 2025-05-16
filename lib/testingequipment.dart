import 'dart:convert';
import 'dart:io';
import 'package:newqcm/CommonDrawer.dart';
import 'package:newqcm/Ipqc.dart';
import 'package:newqcm/Iqcp.dart';
import 'package:newqcm/Welcomepage.dart';
import 'package:newqcm/components/app_button_widget.dart';
import 'package:newqcm/components/app_loader.dart';
import 'package:newqcm/ipqcTestList.dart';
import 'package:newqcm/testingEquipList.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:dio/src/response.dart' as Response;
import '../components/appbar.dart';
import '../constant/app_assets.dart';
import '../constant/app_color.dart';
import '../constant/app_fonts.dart';
import '../constant/app_helper.dart';

import '../constant/app_styles.dart';

class TestingEquipment extends StatefulWidget {
  final String? id;
  TestingEquipment({this.id});

  @override
  _TestingEquipmentState createState() => _TestingEquipmentState();
}

class _TestingEquipmentState extends State<TestingEquipment> {
  final _bomCardFormKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  // TextEditingController shiftController = TextEditingController();
  TextEditingController eNameController = TextEditingController();
  TextEditingController bNameController = TextEditingController();

  TextEditingController modelNoController = TextEditingController();
  TextEditingController specificationController = TextEditingController();
  TextEditingController calibarationReportController = TextEditingController();
  TextEditingController calibarationDateController = TextEditingController();

  TextEditingController expiryDateController = TextEditingController();
  TextEditingController labController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController personController = TextEditingController();
  TextEditingController testProductNameController = TextEditingController();

  TextEditingController referencePdfController = new TextEditingController();
  TextEditingController invoiceReportController = new TextEditingController();
  List<TextEditingController> testControllers = [];
  bool menu = false, user = false, face = false, home = false;
  bool _isLoading = false;
  String selectedShift = "Day Shift";
  List<Map<String, dynamic>> equipmentData = [];
  String? selectedEquipment;

  String? selectedLocation;
  String setPage = '',
      pic = '',
      site = '',
      othersEquipment = '',
      designation = '',
      status = '',
      BomId = '',
      token = '',
      personid = '',
      bomCardDate = '',
      calibrationDate = '',
      approvalStatus = "Approved",
      department = '';
  String invoiceDate = '';
  late String dateOfQualityCheck;

  List<int>? referencePdfFileBytes;
  List<int>? invoicePdfFileBytes;
  late String sendStatus;
  bool? isCycleTimeTrue;
  bool? isBacksheetCuttingTrue;
  Response.Response? _response;
  final _dio = dio.Dio();
  List shiftList = [
    {"key": 'Day Shift', "value": 'Day Shift'},
    {"key": 'Night Shift', "value": 'Night Shift'},
  ];

  @override
  void initState() {
    super.initState();
    store();

    quantityController.addListener(() {
      int quantity = int.tryParse(quantityController.text) ?? 0;
      _updateFields(quantity);
    });
  }

  void _updateFields(int quantity) {
    // Adjust the list of controllers to match the new quantity
    setState(() {
      // Add new controllers if quantity is higher
      if (quantity > testControllers.length) {
        for (int i = testControllers.length; i < quantity; i++) {
          testControllers.add(TextEditingController());
        }
      } else if (quantity < testControllers.length) {
        // Remove extra controllers if quantity is lower
        testControllers = testControllers.sublist(0, quantity);
      }
    });
  }

  void store() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pic = prefs.getString('pic')!;
      personid = prefs.getString('personid')!;
      site = prefs.getString('site')!;
      designation = prefs.getString('designation')!;
      department = prefs.getString('department')!;
      token = prefs.getString('token')!;
    });
    if (widget.id != '' && widget.id != null) {
      _get();
    }
    getEquipment();
  }

  Future<void> getEquipment() async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site')!;

    if (site != null) {
      final url = site + 'TestEquipmet/getUniqueEquipmentDetails';

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            equipmentData = List<Map<String, dynamic>>.from(data['data']);
            // Add "Others" as an option if not already present
            if (!equipmentData
                .any((item) => item["equipment_Name"] == "Others")) {
              equipmentData.add({
                "equipment_Name": "Others",
                "brand_Name": "",
                "model_No": ""
              });
            }
            // Reset to avoid mismatches
          });
        } else {
          print("Failed to fetch data: ${response.statusCode}");
        }
      } catch (error) {
        print("Error fetching data: $error");
      }
    } else {
      print("Site URL is not set in SharedPreferences.");
    }
  }

  Future _get() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (widget.id != '' && widget.id != null) {
        _isLoading = true;
      }
      site = prefs.getString('site')!;
    });
    print("haahahaahahahahah");
    print(widget.id);

    final AllSolarData = ((site!) + 'TestEquipmet/getTestEquipment');
    final allSolarData = await http.post(
      Uri.parse(AllSolarData),
      body: jsonEncode(<String, String>{
        "testEquipmentId": widget.id ?? '',
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      _isLoading = false;
    });

    var resBody = json.decode(allSolarData.body);

    if (mounted) {
      print("jjdfsodpoerwewoope");
      print(resBody['data'][0]);
      setState(() {
        if (resBody['data'] != null && resBody['data'].isNotEmpty) {
          var equipmentData = resBody['data'][0];
          status = equipmentData['Status'] ?? '';
          selectedLocation = equipmentData['workLocation'] ?? '';

          selectedEquipment = equipmentData['equipment_Name'] ?? '';
          bNameController.text = equipmentData['brand_Name'] ?? '';
          modelNoController.text = equipmentData['model_No'] ?? '';
          specificationController.text = equipmentData['specification'] ?? '';

          calibarationReportController.text = equipmentData['Type'] ?? '';
          calibrationDate = equipmentData['calibration_date'] ?? '';

          calibarationDateController.text = equipmentData['calibration_date'] !=
                      null &&
                  equipmentData['calibration_date'] != ''
              ? DateFormat("EEE MMM dd, yyyy").format(
                  DateTime.parse(equipmentData['calibration_date'].toString()))
              : '';
          bomCardDate = equipmentData['calibration_Expiry'] ?? '';

          expiryDateController.text =
              equipmentData['calibration_Expiry'] != '' &&
                      equipmentData['calibration_Expiry'] != null
                  ? DateFormat("EEE MMM dd, yyyy").format(DateTime.parse(
                      equipmentData['calibration_Expiry'].toString()))
                  : '';

          labController.text = equipmentData['lab'] ?? '';
          quantityController.text = equipmentData['quantity'].toString();
          locationController.text = equipmentData['location'] ?? '';

          personController.text = equipmentData['person'] ?? '';
          testProductNameController.text =
              equipmentData['test_Product_Name'] ?? '';

          // Handling nested TestValues
          // var testValues = equipmentData['TestValues'];
          calibarationReportController.text = equipmentData['PdfUrl'] ?? '';
          invoiceReportController.text = equipmentData['invoiceUrl'] ?? '';
          testControllers.clear();
          if (equipmentData['TestValues'] != null) {
            var testValues =
                equipmentData['TestValues'] as Map<String, dynamic>;
            testValues.forEach((key, value) {
              var controller = TextEditingController(text: value.toString());
              testControllers.add(controller);
            });
          }
        }
      });
    }
  }

  Future<void> _pickReferencePDF() async {
    print("lalallalalaln");
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      print("lalallalalaln");
      print(result);
      File pdffile = File(result.files.single.path!);
      setState(() {
        referencePdfFileBytes = pdffile.readAsBytesSync();
        calibarationReportController.text = result.files.single.name;
        print(calibarationReportController.text);
      });
    } else {
      // User canceled the file picker
    }
  }

  Future<void> _invoiceReport() async {
    print("lalallalalaln");
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      print("lalallalalaln");
      print(result);
      File pdffile = File(result.files.single.path!);
      setState(() {
        invoicePdfFileBytes = pdffile.readAsBytesSync();
        invoiceReportController.text = result.files.single.name;
      });
    } else {
      // User canceled the file picker
    }
  }

  Future findData() async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site')!;

    int quantity = int.tryParse(quantityController.text) ?? 0;

    // Initialize a map to hold the dynamic test values
    Map<String, dynamic> testValues = {};
    for (int i = 0; i < quantity; i++) {
      testValues['Test${i + 1}'] = testControllers[i].text;
    }
    var Bom = {
      "Type": "Testing Equipment",
      "testEquipmentId": BomId != '' && BomId != null
          ? BomId
          : widget.id != '' && widget.id != null
              ? widget.id
              : '',
      "CurrentUser": personid,
      "Status": sendStatus,
      "workLocation": selectedLocation,
      "equipment_Name":
          selectedEquipment != "Others" ? selectedEquipment : othersEquipment,
      "brand_Name": bNameController.text,
      "model_No": modelNoController.text,
      "specification": specificationController.text,
      "calibration_date": calibrationDate,
      "calibration_Expiry": bomCardDate,
      "lab": labController.text,
      "quantity": quantityController.text,
      "location": locationController.text,
      "person": personController.text,
      "test_Product_Name": testProductNameController.text,
      "TestValues": testValues, // Add dynamic test values here
    };
    print('Sending data to backend: $Bom');
    setState(() {
      _isLoading = true;
    });
    FocusScope.of(context).unfocus();

    final url = (site! + "TestEquipmet/addTestEquipment");
    var response = await http.post(
      Uri.parse(url),
      body: json.encode(Bom),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var objData = json.decode(response.body);
      setState(() {
        BomId = objData['UUID'];
        _isLoading = false;
      });
      print(objData);
      print("lalalalala");
      if (objData['success'] == false) {
        Toast.show(objData['message'],
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.redColor);
      } else {
        print(referencePdfFileBytes);
        if (sendStatus == 'Pending' && referencePdfFileBytes != null) {
          print("refffff");
          print(referencePdfFileBytes);
          uploadPDF((referencePdfFileBytes ?? []));
        } else if (sendStatus == 'Pending' && invoicePdfFileBytes != null) {
          print("refffff");
          print(referencePdfFileBytes);
          uploadinvoicePDF((invoicePdfFileBytes ?? []));
        } else {
          Toast.show("Data has been saved.",
              duration: Toast.lengthLong,
              gravity: Toast.center,
              backgroundColor: AppColors.blueColor);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return testingEquipList();
              },
            ),
          );
        }
      }
    } else {
      Toast.show("Error In Server",
          duration: Toast.lengthLong, gravity: Toast.center);
    }
  }

  uploadPDF(List<int> referenceBytes) async {
    print("nanannanananna");
    print(referenceBytes);
    print(calibarationReportController.text);
    setState(() {
      _isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site')!;

    var currentdate = DateTime.now().microsecondsSinceEpoch;
    var formData = FormData.fromMap({
      "testEquipmentId": BomId,
      "TestEquipmentPdf": MultipartFile.fromBytes(
        referenceBytes,
        filename: (calibarationReportController.text +
            (currentdate.toString()) +
            '.pdf'),
        contentType: MediaType("application", 'pdf'),
      ),
    });

    _response =
        await _dio.post((site! + 'TestEquipmet/uploadTestEquipment'), // Prod

            options: Options(
              contentType: 'multipart/form-data',
              followRedirects: false,
              validateStatus: (status) => true,
            ),
            data: formData);

    try {
      print(_response?.statusCode);
      if (_response?.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });

        Toast.show("Testing Equipmemt Test Completed.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.blueColor);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return testingEquipList();
            },
          ),
        );
      } else {
        Toast.show("Error In Server",
            duration: Toast.lengthLong, gravity: Toast.center);
      }
    } catch (err) {
      print("Error");
    }
  }

  uploadinvoicePDF(List<int> invoiceBytes) async {
    print("nanannananannacagha");
    print(invoiceBytes);
    print(invoiceReportController.text);
    setState(() {
      _isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site')!;

    var currentdate = DateTime.now().microsecondsSinceEpoch;
    var formData = FormData.fromMap({
      "testEquipmentId": BomId,
      "InvoicePdf": MultipartFile.fromBytes(
        invoiceBytes,
        filename: (calibarationReportController.text +
            (currentdate.toString()) +
            '.pdf'),
        contentType: MediaType("application", 'pdf'),
      ),
    });

    _response =
        await _dio.post((site! + 'TestEquipmet/uploadInvoiceEquipment'), // Prod

            options: Options(
              contentType: 'multipart/form-data',
              followRedirects: false,
              validateStatus: (status) => true,
            ),
            data: formData);

    try {
      print(_response?.statusCode);
      if (_response?.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });

        Toast.show("Testing Equipmemt Test Completed.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.blueColor);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return testingEquipList();
            },
          ),
        );
      } else {
        Toast.show("Error In Server",
            duration: Toast.lengthLong, gravity: Toast.center);
      }
    } catch (err) {
      print("Error");
    }
  }

  Widget _getFAB() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: FloatingActionButton(
        onPressed: () {
          setState(() {
            sendStatus = 'Pending';
          });
          findData();
        },
        child: ClipOval(
          child: Image.asset(
            AppAssets.save,
            height: 70,
            width: 60,
          ),
        ),
      ),
    );
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
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.white,
          appBar: GautamAppBar(
            organization: "organizationtype",
            isBackRequired: true,
            memberId: personid,
            imgPath: "ImagePath",
            memberPic: pic,
            logo: "logo",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    if (widget.id != null && widget.id != "") {
                      return testingEquipList();
                    } else {
                      print(department);
                      print("Departmeennnt");

                      if (department == 'IPQC') {
                        return IpqcPage();
                      } else if (department == 'IQCP') {
                        return IqcpPage();
                      } else {
                        return WelcomePage();
                      }
                    }
                  },
                ),
              );
            },
          ),
          body: _isLoading
              ? AppLoader()
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
                        child: Form(
                          key: _bomCardFormKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppAssets.imgLogo,
                                            height: 100,
                                            width: 230,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Center(
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text("Testing Equipment",
                                          style: TextStyle(
                                              fontSize: 27,
                                              color: AppColors.black,
                                              fontFamily: appFontFamily,
                                              fontWeight: FontWeight.w700)))),

                              const SizedBox(
                                height: 35,
                              ),
                              Text(
                                "Work Location",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              DropdownButtonFormField<String>(
                                value: selectedLocation != ''
                                    ? selectedLocation
                                    : null, // Initial value
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Select Location Name.",
                                ),
                                style: AppStyles.textInputTextStyle,
                                items: [
                                  "Haridwar",
                                  "Bhiwani",
                                ].map((location) {
                                  return DropdownMenuItem(
                                    value: location,
                                    child: Text(location),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // Update the selected value
                                  setState(() {
                                    selectedLocation = value!;
                                  });
                                },
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Please Select Location name."
                                        : null,
                              ),

                              const SizedBox(
                                height: 35,
                              ),

                              // Text(
                              //   "Equipment Name",
                              //   style: AppStyles.textfieldCaptionTextStyle,
                              // ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // TextFormField(
                              //   controller: eNameController,
                              //   keyboardType: TextInputType.text,
                              //   textInputAction: TextInputAction.next,
                              //   decoration:
                              //       AppStyles.textFieldInputDecoration.copyWith(
                              //     hintText: "Please Enter Equipment name.",
                              //   ),
                              //   style: AppStyles.textInputTextStyle,
                              //   // readOnly:
                              //   //     status == 'Pending' && designation != "QC"
                              //   //         ? true
                              //   //         : false,
                              //   validator: MultiValidator(
                              //     [
                              //       RequiredValidator(
                              //         errorText: "Please Enter Equipment name.",
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              // // ************  PO Number ***********************

                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // Text(
                              //   "Brand Name",
                              //   style: AppStyles.textfieldCaptionTextStyle,
                              // ),

                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // TextFormField(
                              //   controller: bNameController,
                              //   keyboardType: TextInputType.text,
                              //   textInputAction: TextInputAction.next,
                              //   decoration:
                              //       AppStyles.textFieldInputDecoration.copyWith(
                              //     hintText: "Please Brand Name",
                              //     counterText: '',
                              //   ),
                              //   style: AppStyles.textInputTextStyle,
                              //   // readOnly:
                              //   //     status == 'Pending' && designation != "QC"
                              //   //         ? true
                              //   //         : false,
                              //   validator: MultiValidator(
                              //     [
                              //       RequiredValidator(
                              //         errorText: "Please Brand Name",
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              // //  ********   BOM Verification Check sheet ********************

                              // const SizedBox(
                              //   height: 15,
                              // ),

                              // Text(
                              //   "Model Number",
                              //   style: AppStyles.textfieldCaptionTextStyle,
                              // ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // TextFormField(
                              //   controller: modelNoController,
                              //   keyboardType: TextInputType.text,
                              //   textInputAction: TextInputAction.next,
                              //   decoration:
                              //       AppStyles.textFieldInputDecoration.copyWith(
                              //     hintText: "Please Enter Model Number",
                              //     counterText: '',
                              //   ),
                              //   style: AppStyles.textInputTextStyle,
                              //   // readOnly:
                              //   //     status == 'Pending' && designation != "QC"
                              //   //         ? true
                              //   //         : false,
                              //   validator: MultiValidator(
                              //     [
                              //       RequiredValidator(
                              //         errorText: "Please Enter Model Number",
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Text(
                                "Equipment Name",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              // Main dropdown
                              DropdownButtonFormField<String>(
                                value: selectedEquipment,
                                isExpanded: true,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Equipment Name",
                                ),
                                items: equipmentData
                                    .where((item) =>
                                        item["equipment_Name"] != null)
                                    .map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item["equipment_Name"],
                                    child: Text(item["equipment_Name"] ?? ''),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedEquipment = newValue;
                                    if (newValue != null &&
                                        newValue != "Others") {
                                      var equipment = equipmentData.firstWhere(
                                        (item) =>
                                            item["equipment_Name"] == newValue,
                                        orElse: () =>
                                            {"brand_Name": "", "model_No": ""},
                                      );
                                      bNameController.text =
                                          equipment["brand_Name"] ?? '';
                                      modelNoController.text =
                                          equipment["model_No"] ?? '';
                                    } else {
                                      bNameController.clear();
                                      modelNoController.clear();
                                    }
                                    print(
                                        "Selected Equipment Updated: $selectedEquipment");
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select an equipment name.";
                                  }
                                  return null;
                                },
                              ),

                              // Others specification field
                              if (selectedEquipment == "Others") ...[
                                const SizedBox(height: 15),
                                Text(
                                  "Please specify the Equipment Name",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      othersEquipment = value;
                                    });
                                  },
                                  decoration: AppStyles.textFieldInputDecoration
                                      .copyWith(
                                    hintText: "Please Enter Equipment Name",
                                    counterText: '',
                                  ),
                                  validator: (value) {
                                    if (selectedEquipment == "Others" &&
                                        (value == null || value.isEmpty)) {
                                      return "Please specify the equipment name";
                                    }
                                    return null;
                                  },
                                ),
                              ],

                              const SizedBox(height: 15),
                              Text(
                                "Brand Name",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: bNameController,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Brand Name",
                                  counterText: '',
                                ),
                              ),

                              const SizedBox(height: 15),
                              Text(
                                "Model Number",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: modelNoController,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Model Number",
                                  counterText: '',
                                ),
                              ),
                              // ********** Specification / Model No. *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Specification",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: specificationController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Specification ",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText: "Please Enter Specification",
                                    ),
                                  ],
                                ),
                              ),

                              // ************* Lot/Batch Number *********************

                              const SizedBox(
                                height: 15,
                              ),

                              Text(
                                "Calibaration Report",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: calibarationReportController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: AppStyles.textFieldInputDecoration
                                    .copyWith(
                                        hintText:
                                            "Please Select Calibaration Report",
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            // if (widget.id != null &&
                                            //     widget.id != '' &&
                                            //     calibarationReportController
                                            //             .text !=
                                            //         '') {
                                            //   UrlLauncher.launch(
                                            //       calibarationReportController
                                            //           .text);
                                            // }
                                            if (status != 'Approved') {
                                              _pickReferencePDF();
                                            }
                                          },
                                          // icon: widget.id != null &&
                                          //         widget.id != '' &&
                                          //         calibarationReportController
                                          //                 .text !=
                                          //             ''
                                          //     ? const Icon(Icons.download)
                                          icon: const Icon(Icons.upload_file),
                                        ),
                                        counterText: ''),
                                style: AppStyles.textInputTextStyle,
                                maxLines: 1,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Please Select Calibaration Report";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              Text(
                                "Calibaration Date",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: calibarationDateController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: AppStyles.textFieldInputDecoration
                                    .copyWith(
                                        hintText:
                                            "Please Enter Calibaration Date",
                                        counterText: '',
                                        suffixIcon: Image.asset(
                                          AppAssets.icCalenderBlue,
                                          color: AppColors.primaryColor,
                                        )),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                onTap: () async {
                                  // if (status != 'Pending') {
                                  DateTime date = DateTime(2021);
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  date = (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2050)))!;
                                  calibarationDateController.text =
                                      DateFormat("EEE MMM dd, yyyy").format(
                                          DateTime.parse(date.toString()));
                                  setState(() {
                                    calibrationDate = DateFormat("yyyy-MM-dd")
                                        .format(
                                            DateTime.parse(date.toString()));
                                  });
                                  // }
                                },
                                // validator: MultiValidator([
                                //   RequiredValidator(
                                //       errorText:
                                //           "Please Enter Calibaration Date")
                                // ])
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              Text(
                                "Expiry Date",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                controller: expiryDateController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                        hintText: "Please Enter Expiry Date",
                                        counterText: '',
                                        suffixIcon: Image.asset(
                                          AppAssets.icCalenderBlue,
                                          color: AppColors.primaryColor,
                                        )),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                onTap: () async {
                                  DateTime date = DateTime(2021);
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  date = (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2050)))!;
                                  expiryDateController.text =
                                      DateFormat("EEE MMM dd, yyyy").format(
                                          DateTime.parse(date.toString()));
                                  setState(() {
                                    bomCardDate = DateFormat("yyyy-MM-dd")
                                        .format(
                                            DateTime.parse(date.toString()));
                                  });
                                },
                                // validator: MultiValidator([
                                //   RequiredValidator(
                                //       errorText: "Please Enter Expiry Date")
                                // ])
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Lab",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: labController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Lab",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText: "Please Enter Lab",
                                    ),
                                  ],
                                ),
                              ),

                              // *************************** Flux- Lot/Batch Number *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Quantity",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: quantityController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Quantity",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Please Enter Quantity"),
                                ]),
                              ),
                              const SizedBox(height: 15),

                              // Generate dynamic fields based on quantity
                              for (int i = 0;
                                  i < testControllers.length;
                                  i++) ...[
                                Text("Test ${i + 1}"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: testControllers[i],
                                  decoration: AppStyles.textFieldInputDecoration
                                      .copyWith(
                                    hintText: "Enter value for Test ${i + 1}",
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],

                              const SizedBox(
                                height: 15,
                              ),
                              // Location
                              Text(
                                "Location",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: locationController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Location",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                maxLines: 3,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText: "Please Enter Location",
                                    ),
                                  ],
                                ),
                              ),

                              // ############   Ribbon ########################################

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Person",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: personController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Person",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText: "Please Enter Person",
                                    ),
                                  ],
                                ),
                              ),

                              // *************************** Remark *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Test Product Name",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: testProductNameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Test Product Name",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText:
                                          "Please Enter Test Product Name",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // Invoice PDF
                              Text(
                                "Invoice Report",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: invoiceReportController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: AppStyles.textFieldInputDecoration
                                    .copyWith(
                                        hintText:
                                            "Please Select Invoice Report",
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            // if (widget.id != null &&
                                            //     widget.id != '' &&
                                            //     calibarationReportController
                                            //             .text !=
                                            //         '') {
                                            //   UrlLauncher.launch(
                                            //       calibarationReportController
                                            //           .text);
                                            // }
                                            if (status != 'Approved') {
                                              _invoiceReport();
                                            }
                                          },
                                          // icon: widget.id != null &&
                                          //         widget.id != '' &&
                                          //         calibarationReportController
                                          //                 .text !=
                                          //             ''
                                          //     ? const Icon(Icons.download)
                                          icon: const Icon(Icons.upload_file),
                                        ),
                                        counterText: ''),
                                style: AppStyles.textInputTextStyle,
                                maxLines: 1,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Please Select Invoice Report";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              // ********* ribbon-Specification / Model No. *********************

// *************************** Some style for the All Data *********************

                              const SizedBox(
                                height: 15,
                              ),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  //     : (widget.id == "" || widget.id == null) ||
                                  //             (status == 'Inprogress' &&
                                  //                 widget.id != null)
                                  //         ? AppButton(
                                  //             textStyle: const TextStyle(
                                  //               fontWeight: FontWeight.w700,
                                  //               color: AppColors.white,
                                  //               fontSize: 16,
                                  //             ),
                                  //             onTap: () {
                                  //               AppHelper.hideKeyboard(context);
                                  //               setState(() {
                                  //                 sendStatus = "Inprogress";
                                  //               });
                                  //               findData();
                                  //             },
                                  //             label: "Save",
                                  //             organization: '',
                                  //           )
                                  //         : Container(),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  : (widget.id == "" || widget.id == null) ||
                                          (status == 'Pending' &&
                                              widget.id != null)
                                      ? AppButton(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.white,
                                            fontSize: 16,
                                          ),
                                          onTap: () {
                                            AppHelper.hideKeyboard(context);
                                            _bomCardFormKey.currentState!.save;
                                            if (_bomCardFormKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                sendStatus = "Pending";
                                              });
                                              findData();
                                            }
                                          },
                                          label: "Submit",
                                          organization: '',
                                        )
                                      : Container(),
                              const SizedBox(
                                height: 10,
                              ),
                              if (widget.id != "" &&
                                  widget.id != null &&
                                  status == 'Pending' &&
                                  designation == "Super Admin")
                                Container(
                                  color: Color.fromARGB(255, 191, 226, 187),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Divider(),
                                      SizedBox(height: 15),
                                      AppButton(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.white,
                                            fontSize: 16),
                                        onTap: () {
                                          AppHelper.hideKeyboard(context);
                                          _bomCardFormKey.currentState!.save;
                                          if (_bomCardFormKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              sendStatus = "Approved";
                                            });
                                            findData();
                                          }
                                        },
                                        label: "Approved",
                                        organization: '',
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ),
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Powered By Gautam Solar Pvt. Ltd.",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: appFontFamily,
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          floatingActionButton: (status == "Approved") ? null : _getFAB(),
          // bottomNavigationBar: Container(
          //   height: 60,
          //   decoration: const BoxDecoration(
          //     color: Color.fromARGB(255, 245, 203, 19),
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(20),
          //       topRight: Radius.circular(20),
          //     ),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       InkWell(
          //           onTap: () {
          //             Navigator.of(context).pushReplacement(MaterialPageRoute(
          //                 builder: (BuildContext context) =>
          //                     department == 'IPQC' &&
          //                             designation != 'Super Admin'
          //                         ? IpqcPage()
          //                         : WelcomePage()));
          //           },
          //           child: Image.asset(
          //               home
          //                   ? AppAssets.icHomeSelected
          //                   : AppAssets.icHomeUnSelected,
          //               height: 25)),
          //       const SizedBox(
          //         width: 8,
          //       ),
          //       InkWell(
          //           onTap: () {
          //             // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //             //     builder: (BuildContext context) => AddEditProfile()));
          //           },
          //           child: Image.asset(
          //               user
          //                   ? AppAssets.imgSelectedPerson
          //                   : AppAssets.imgPerson,
          //               height: 25)),
          //       const SizedBox(
          //         width: 8,
          //       ),
          //       InkWell(
          //           child: Image.asset(
          //               face
          //                   ? AppAssets.icSearchSelected
          //                   : AppAssets.icSearchUnSelected,
          //               height: 25)),
          //       const SizedBox(
          //         width: 8,
          //       ),
          //       InkWell(
          //           onTap: () {
          //             Navigator.of(context).pushReplacement(MaterialPageRoute(
          //                 builder: (BuildContext context) => PublicDrawer()));
          //           },
          //           child: Image.asset(
          //               menu ? AppAssets.imgSelectedMenu : AppAssets.imgMenu,
          //               height: 25)),
          //     ],
          //   ),
          // ),
        );
      }),
    );
  }
}
