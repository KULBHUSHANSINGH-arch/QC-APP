import 'dart:convert';
import 'dart:io';
// import 'package:QCM/QualityList.dart';
// import 'package:QCM/QualityPage.dart';
// import 'package:QCM/components/app_loader.dart';
// import 'barcode_scanner_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/src/response.dart' as Response;
// import 'package:QCM/components/app_button_widget.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:logisticapp/barcode_scanner_widget.dart';
import 'package:qcmapp/QualityList.dart';
import 'package:qcmapp/QualityPage.dart';
import 'package:qcmapp/barcode_scanner_widget.dart';
import 'package:qcmapp/components/app_button_widget.dart';
import 'package:qcmapp/components/app_loader.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'components/appbar.dart';
import 'constant/app_assets.dart';
import 'constant/app_color.dart';
import 'constant/app_fonts.dart';
import 'constant/app_strings.dart';
import 'constant/app_styles.dart';

class AddQuality extends StatefulWidget {
  final String? id;
  AddQuality({this.id});
  _AddQualityState createState() => _AddQualityState();
}

class _AddQualityState extends State<AddQuality> {
  File? _image, personPreview, _elimage;
  List<int>? personlogoBytes, pdfFileBytes, _imageBytes, _elimageBytes;
  List data = [];
  List statedata1 = [];
  List citydata1 = [];
  bool sameAsPresentAddress = false;
  final picker = ImagePicker();
  List<String> barcodes = [];
  final _dio = Dio();
  // Response? _response;
  Response.Response? _response;
  String? particletypeController; // Change to nullable
  String? subparticletypeController;
  String? issuetypeController;
  String? subissuetypeController;
  String? _errorMessage,
      bloodGroupController,
      token,
      barcodeScanRes,
      laminatorTypeController,
      // issuetypeController,
      // particletypeController,
      // subparticletypeController,
      elTypeController,
      shiftController,
      lineController,
      chamberController,
      laminatorController,
      reportingManagerController,
      modelNumberController,
      modulepicture,
      WorkLocationName,
      workLocation,
      elpicture,
      personLogoname,
      personid,
      designation,
      department,
      setpersonid,
      firstname,
      _selectedFileName,
      lastname,
      pic,
      ImagePath,
      logo,
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
  String setStatus = "Active";
  List<String> itemsToRemove = [
    'PIL04770TG115252557',
    'GS04770TG1462513622',
  ];
  Map<String, dynamic> apiResponse = {};
  bool isLoading = false;
  List<Map<String, dynamic>> particleList = [];
  List<Map<String, dynamic>> subparticleList = [];
  final List<Map<String, String>> staticSubParticleList = [
    {'particleChildName': 'Conductiver', 'particleChildId': '1'},
    {'particleChildName': 'Non-Conductive', 'particleChildId': '2'},
  ];
  List<Map<String, dynamic>> issueList = [];
  List<Map<String, dynamic>> subIssueList = [];

  List lineList = [];
  // particleList = [],
  // subparticleList = [],
  List elList = [],
      stringList = [],
      modelNumberList = [],
      reportingManagerList = [],
      shiftList = [
        {"key": "Day", "value": "Day"},
        {"key": "Night", "value": "Night"},
      ];
  List<Map<String, String>> chamberList = [
    {"key": "Upper Chamber", "value": "Upper Chamber"},
    {"key": "Lower Chamber", "value": "Lower Chamber"},
  ];
  List<Map<String, String>> laminatorList = [
    {"key": "GME", "value": "GME"},
    {"key": "Jinchen", "value": "Jinchen"},
  ];

  List<Map<String, dynamic>> sublaminator1 = [];

  SharedPreferences? prefs;
  TextEditingController shiftinchargeprelimeController =
      new TextEditingController();
  TextEditingController shiftinchargepostlimeController =
      new TextEditingController();

  TextEditingController productBarcodeController = new TextEditingController();
  TextEditingController wattageController = new TextEditingController();
  TextEditingController othermodelnumberController =
      new TextEditingController();
  TextEditingController responsiblepersonController =
      new TextEditingController();
  TextEditingController reasonofissueController = new TextEditingController();
  TextEditingController stageController = new TextEditingController();
  TextEditingController issuecomefromController = new TextEditingController();
  TextEditingController actiontakenController = new TextEditingController();
  TextEditingController otherissuetypeController = new TextEditingController();

  GlobalKey<FormState> qualityformKey = GlobalKey<FormState>();

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File pdffile = File(result.files.single.path!);
      setState(() {
        pdfFileBytes = pdffile.readAsBytesSync();
        _selectedFileName = result.files.single.name;
      });
    } else {
      // User canceled the file picker
    }
  }

  @override
  void initState() {
    store();
    getLocationData();
    getStringData();

    getIssueData(null);
    getaPartclesData(null);
    getELListData();
    getModelNumberData();
    print("ProfilePicccc");
    print(modulepicture);
    super.initState();
  }

  void store() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // productBarcodeController.text = 'GS04770TG1462512616';
      designation = prefs.getString('designation');
      department = prefs.getString('department');
      pic = prefs.getString('pic');
      personid = prefs.getString('personid');
      site = prefs.getString('site');
      token = prefs.getString('token');
      workLocation = prefs.getString('workLocation');
      WorkLocationName = prefs.getString('WorkLocationName');
    });
    if (widget.id != "" && widget.id != null) {
      _get();
    }
    getLineData();
    getCheckedBarcodeData();
    getBarcodesDataBaliyali('');
  }

  Future<void> getLineData() async {
    print("workLocation");
    print(workLocation);
    try {
      final prefs = await SharedPreferences.getInstance();
      site = prefs.getString('site');

      if (site == null) {
        print("Site URL is null");
        return;
      }

      final url = Uri.parse('https://hrm.umanerp.com/api/factory/getUnitLine');
      print("Fetching from URL: $url");

      final response = await http.post(
        url,
        body: jsonEncode({"factoryId": "2", "type": "line"}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final lineBody = jsonDecode(response.body);
        print("lineBody...?");
        print(lineBody['data']);
        setState(() {
          lineList = lineBody['data'];
        });

        return;
      }

      setState(() {});
    } catch (e, stackTrace) {
      print("Error fetching issue/sub-issue data: $e");
      print("Stack trace: $stackTrace");
    }
  }

  Future<void> getCheckedBarcodeData() async {
    print("workLocation");
    print(workLocation);
    try {
      final prefs = await SharedPreferences.getInstance();
      site = prefs.getString('site');

      if (site == null) {
        print("Site URL is null");
        return;
      }

      final url = Uri.parse('${site!}TestEquipmet/getItemsToRemove');
      print("Fetching from URL: $url");

      final response = await http.post(
        url,
        body: jsonEncode({
          "WorkLocation": workLocation ?? "",
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        print("Error: Status Code ${response.statusCode}");
        print("Response: ${response.body}");
        final checkedBarcodeBody = jsonDecode(response.body);
        print("checkedBarcodeBody...?");
        getBarcodesDataBaliyali(checkedBarcodeBody);
        print(checkedBarcodeBody);
        return;
      }

      setState(() {});
    } catch (e, stackTrace) {
      print("Error fetching issue/sub-issue data: $e");
      print("Stack trace: $stackTrace");
    }
  }

  Future<void> getBarcodesDataBaliyali(checkedBarcodeBody) async {
    print("checkedBarcodeBody.......?");
    print(checkedBarcodeBody['itemsToRemove']);
    try {
      final prefs = await SharedPreferences.getInstance();
      final site = prefs.getString('site');

      const url = 'https://umanmrp.in/api/rejModuleQCApi2.php';

      // final response = await http.get(
      //   Uri.parse(url),
      //   headers: {
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'store_id': WorkLocationName == "Baliyali Unit 1"
              ? '4'
              : WorkLocationName == "Haridwar Unit 1"
                  ? '2'
                  : WorkLocationName == "Haridwar Unit 2"
                      ? '1'
                      : '3',
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (mounted) {
        print("Raw Response Body:");
        print(response.body);

        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic> && decoded['barcodes'] is List) {
          setState(() {
            barcodes = List<String>.from(decoded['barcodes']);
            print("Length....");
            print(barcodes.length);
            barcodes.removeWhere(
                (item) => checkedBarcodeBody['itemsToRemove'].contains(item));
            print(barcodes);
          });

          print("Decoded barcodes list:");
          print(barcodes);
        } else {
          print("Unexpected JSON structure or 'barcodes' is not a List.");
        }
      }
    } catch (e, stackTrace) {
      print("Error in getBarcodesDataBaliyali: $e");
      print("StackTrace: $stackTrace");
    }
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      // cameraDevice: CameraDevice.rear,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _compressImage(_image!);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getElImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      // cameraDevice: CameraDevice.rear,
    );

    setState(() {
      if (pickedFile != null) {
        _elimage = File(pickedFile.path);
        _compressElImage(_elimage!);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _compressElImage(File imageFile) async {
    var _elimageBytesOriginal = imageFile.readAsBytesSync();
    _elimageBytes = await FlutterImageCompress.compressWithList(
      _elimageBytesOriginal!,
      quality: 60,
    );
    print("kya hai bytes??");
    print(_imageBytes);
  }

  Future _compressImage(File imageFile) async {
    var _imageBytesOriginal = imageFile.readAsBytesSync();
    _imageBytes = await FlutterImageCompress.compressWithList(
      _imageBytesOriginal!,
      quality: 60,
    );
    print("kya hai bytes??");
    print(_imageBytes);
  }

  Future<void> _get() async {
    print("Id.....AddEditProfile");
    print(personid);
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (widget.id != '' && widget.id != null) {
        _isLoading = true;
      }
      site = prefs.getString('site');
    });
    final QualityData = ((site!) + 'Quality/QualityList');
    final qualityData = await http.post(
      Uri.parse(QualityData),
      body: jsonEncode(
          <String, String>{"QualityId": widget.id ?? '', "token": token!}),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var resBody = json.decode(qualityData.body);

    if (mounted) {
      setState(() {
        data = resBody['data'];
        print("Data ......??");
        print(data);
        if (data != null && data.length > 0) {
          _isLoading = false;
          final dataMap = data.asMap();

          print(dataMap[0]['subParticleType']);
          print("Datamap////?");
          modulepicture = dataMap[0]['ModulePicture'] ?? "";
          elpicture = dataMap[0]['ElModuleImage'] ?? "";
          shiftController = dataMap[0]['Shift'] ?? "";
          lineController = dataMap[0]['line'] ?? "";
          shiftinchargeprelimeController.text =
              dataMap[0]['ShiftInChargePreLime'] ?? '';
          shiftinchargepostlimeController.text =
              dataMap[0]['ShiftInChargePostLim'] ?? '';
          productBarcodeController.text = dataMap[0]['ProductBarCode'] ?? '';
          wattageController.text = dataMap[0]['Wattage'] ?? '';
          elTypeController = dataMap[0]['elType'] ?? '';
          particletypeController = dataMap[0]['particleType'] ?? '';
          subparticletypeController = dataMap[0]['subParticleType'] ?? '';
          issuetypeController = dataMap[0]['IssueType'] ?? '';
          subissuetypeController = dataMap[0]['subIssueType'] ?? '';
          chamberController = dataMap[0]['Chamber'] ?? '';
          laminatorController = dataMap[0]['Laminator'] ?? '';
          laminatorTypeController = dataMap[0]['Stringer'] ?? '';
          otherissuetypeController.text = dataMap[0]['OtherIssueType'] ?? '';
          modelNumberController = dataMap[0]['ModelNumber'] ?? '';
          othermodelnumberController.text =
              dataMap[0]['OtherModelNumber'] ?? '';
          stageController.text = dataMap[0]['Stage'] ?? '';
          responsiblepersonController.text =
              dataMap[0]['ResposiblePerson'] ?? '';
          reasonofissueController.text = dataMap[0]['ReasonOfIssue'] ?? '';
          issuecomefromController.text = dataMap[0]['IssueComeFrom'] ?? '';
          actiontakenController.text = dataMap[0]['ActionTaken'] ?? '';
        }
      });
      await getIssueData(issuetypeController); // Populate subIssueList
      await getaPartclesData(
          particletypeController); // Populate subparticleList

      setState(() {});
    }
  }

  Future<bool> redirectto() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget.id != "" && widget.id != null
          ? QualityList()
          : QualityPage();
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
                        ? QualityList()
                        : QualityPage();
                  }));
                },
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10, top: 15),
                child: _isLoading ? AppLoader() : _user(),
              ),
              floatingActionButton: _getFAB(),
            )));
  }

  Widget _getFAB() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: FloatingActionButton(
        onPressed: () {
          createData(
            "Inprogress",
            lineController ?? "",
            shiftController ?? "",
            shiftinchargeprelimeController.text,
            shiftinchargepostlimeController.text,
            productBarcodeController.text,
            wattageController.text,
            modelNumberController ?? "",
            othermodelnumberController.text,
            elTypeController ?? "",
            particletypeController ?? "",
            subparticletypeController ?? "",
            issuetypeController ?? "",
            subissuetypeController ?? "",
            chamberController ?? "",
            laminatorController ?? "",
            laminatorTypeController ?? '',
            otherissuetypeController.text,
            stageController.text,
            responsiblepersonController.text,
            reasonofissueController.text,
            issuecomefromController.text,
            actiontakenController.text,
          );
          // setState(() {
          //   setStatus = 'Inprogress';
          // });
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

  TextFormField textShiftInchargePrelime() {
    return TextFormField(
      controller: shiftinchargeprelimeController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter Shift Incharge Prelime",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'Please enter shift incharge prelime';
      //   }
      //   return null;
      // },
    );
  }
  // Stringer

  TextFormField textShiftInchargePostlime() {
    return TextFormField(
      controller: shiftinchargepostlimeController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter Shift Incharge Postlime",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'Please enter shift incharge postlime';
      //   }
      //   return null;
      // },
    );
  }

  // TextFormField textProductBarcode() {
  //   return TextFormField(
  //     controller: productBarcodeController,
  //     decoration: AppStyles.textFieldInputDecoration.copyWith(
  //       hintText: "Please Scan Product Barcode.",
  //       counterText: '',
  //       contentPadding: EdgeInsets.all(10),
  //       suffixIcon: IconButton(
  //         onPressed: () async {
  //           barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //             '#FF6666',
  //             'Cancel',
  //             true,
  //             ScanMode.DEFAULT,
  //           );

  //           setState(() {
  //             productBarcodeController.text =
  //                 (barcodeScanRes != "-1" ? barcodeScanRes : '')!;
  //           });

  //           if (barcodeScanRes != null && barcodeScanRes != "-1") {
  //             fetchQcApiData(barcodeScanRes!);
  //           }
  //         },
  //         icon: const Icon(Icons.qr_code),
  //       ),
  //     ),
  //     readOnly: false,
  //     style: AppStyles.textInputTextStyle,
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please Scan Product Barcode.';
  //       }

  //       // Exempt specific values from validation
  //       final exemptValues = {
  //         'N/A',
  //         'n/a',
  //         'na',
  //         'NA',
  //         'n a',
  //         'N A',
  //         'N a',
  //         'n A',
  //         'Na',
  //         'nA',
  //         'n/A',
  //         'N/a'
  //       };

  //       if (!exemptValues.contains(value)) {
  //         // Check for spaces and validate length
  //         if (value.contains(' ')) {
  //           return 'Barcode cannot contain spaces.';
  //         }
  //         if (value.length < 10) {
  //           return 'Barcode must be at least 10 digits or be N/A.';
  //         }
  //       }

  //       return null;
  //     },
  //     onChanged: (value) {
  //       if (value.isNotEmpty && value.length >= 10 && !value.contains(' ')) {
  //         fetchQcApiData(value);
  //       }
  //     },
  //   );
  // }

  Widget textProductBarcode() {
    return TextFormField(
      controller: productBarcodeController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: "Please Scan Product Barcode ",
        contentPadding: const EdgeInsets.all(10),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (widget.id != "" && widget.id != null)
                ? Container()
                : IconButton(
                    onPressed: () async {
                      // Show scanner page and get result
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BarcodeScannerWidget(
                            onBarcodeDetected: (barcode) {
                              setState(() {
                                productBarcodeController.text = barcode;
                              });
                              print("Scan.......?");
                              print(productBarcodeController.text);

                              fetchQcApiData(barcode);
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.qr_code),
                  ),
          ],
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please scan the product barcode';
        }
        return null;
      },
    );
  }

  TextFormField textWattage() {
    return TextFormField(
      controller: wattageController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter Wattage",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter wattage';
        }
        return null;
      },
    );
  }

  // Stringer

  TextFormField textOtherModelNumber() {
    return TextFormField(
      controller: othermodelnumberController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter Model Number",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter model number';
        }
        return null;
      },
    );
  }

  TextFormField textOtherIssueType() {
    return TextFormField(
      controller: otherissuetypeController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter Issue Type",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter issue type';
        }
        return null;
      },
    );
  }

  TextFormField textStage() {
    return TextFormField(
      controller: stageController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter Stage",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter stage';
        }
        return null;
      },
    );
  }

  TextFormField textResponsiblePerson() {
    return TextFormField(
      controller: responsiblepersonController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter Responsible Person",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter responsible person';
        }
        return null;
      },
    );
  }

  TextFormField textReasonOfIssue() {
    return TextFormField(
      controller: reasonofissueController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter Reason Of Issue",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter reason of issue';
        }
        return null;
      },
    );
  }

  TextFormField textIssueComeFrom() {
    return TextFormField(
      controller: issuecomefromController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter Issue Come From",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter issue come from';
        }
        return null;
      },
    );
  }

  TextFormField textActionTaken() {
    return TextFormField(
      controller: actiontakenController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter Action Taken For This Issue",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      validator: (value) {
        if (value!.isEmpty) {
          print("hiiiiiiiiii");
          return 'Please enter action taken for this issue';
        }
        return null;
      },
    );
  }

  Future<void> fetchQcApiData(String barcode) async {
    print("Starting API call...");
    setState(() {
      isLoading = true;
    });

    const String apiUrl = "https://www.umanmrp.in/api/qcApi.php";

    // Pass everything in the headers
    // final Map<String, String> headers = {
    //   'apiKey': "mrpap1Dqcp1",
    //   'barcode': "GS03540M27624003414",
    //   'store_id': "1",
    // };

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'apikey': 'mrp-ap1D-qc@p1',
        'type': "",
        'barcode': barcode,
        'storeid': WorkLocationName == "Baliyali Unit 1"
            ? '4'
            : WorkLocationName == "Haridwar Unit 1"
                ? '2'
                : WorkLocationName == "Haridwar Unit 2"
                    ? '1'
                    : '3', // Add your default value here
      });

      print({
        'apikey': 'mrp-ap1D-qc@p1',
        'barcode': barcode,
        'storeId': WorkLocationName == "Baliyali Unit 1"
            ? '4'
            : WorkLocationName == "Haridwar Unit 1"
                ? '2'
                : WorkLocationName == "Haridwar Unit 2"
                    ? '1'
                    : '3', // Add your default value here
      });

      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        setState(() {
          apiResponse = jsonDecode(response.body);
        });
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (error) {
      print("Error occurred: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  getStringData() async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');

    final url = (site! + 'Quality/typeStringer');
    print("Fetching data from: $url");

    http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((response) {
      if (mounted) {
        var issueBody = jsonDecode(response.body);
        setState(() {
          stringList = issueBody;
        });
      }
    });
  }

  // getIssueData(issuetypeController) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   site = prefs.getString('site');

  //   final url = (site! + 'Quality/GetIssues');

  //   http.post(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   ).then((response) {
  //     if (mounted) {
  //       var issueBody = jsonDecode(response.body);
  //       setState(() {
  //         issueList = issueBody['Issues'];
  //         issueList.add({
  //           "IssueId": "9f00c67d-0b99-11ef-8005-52549f6cc694",
  //           "Issue": "Other"
  //         });
  //       });
  //     }
  //   });
  // }
  Future<void> getIssueData([String? issueId]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      site = prefs.getString('site');

      if (site == null) {
        print("Site URL is null");
        return;
      }

      final url = Uri.parse(site! + 'Quality/GetIssues');
      print("Fetching from URL: $url");

      final response = await http.post(
        url,
        body: jsonEncode({
          "IssueId": issueId ?? "",
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (!mounted) return;

      if (response.statusCode != 200) {
        print("Error: Status Code ${response.statusCode}");
        print("Response: ${response.body}");
        return;
      }

      final issueBody = jsonDecode(response.body);

      setState(() {
        if (issueId == null || issueId.isEmpty) {
          issueList = (issueBody['Issues'] as List?)
                  ?.map((item) => Map<String, dynamic>.from(item))
                  .toList() ??
              [];

          // Add "Other" option
          issueList.add({
            "IssueId": "9f00c67d-0b99-11ef-8005-52549f6cc694",
            "Issue": "Other",
          });
        } else {
          subIssueList = (issueBody['Issues'] as List?)
                  ?.map((item) => Map<String, dynamic>.from(item))
                  .toList() ??
              [];
        }
      });
    } catch (e, stackTrace) {
      print("Error fetching issue/sub-issue data: $e");
      print("Stack trace: $stackTrace");
    }
  }

  Future<void> getaPartclesData(String? particleId) async {
    try {
      print("lalalalalaam");
      print(particleId);
      final prefs = await SharedPreferences.getInstance();
      site = prefs.getString('site');

      if (site == null) {
        print("Site URL is null");
        return;
      }

      // Ensure proper URL formatting
      final url = Uri.parse(site! + 'Quality/getParticles');
      print("Fetching from URL: $url"); // Debug print

      final response = await http.post(
        url,
        body: jsonEncode({"particleId": particleId ?? ""}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (!mounted) return;

      if (response.statusCode == 404) {
        print("404 Error: API endpoint not found");
        return;
      }

      if (response.statusCode != 200) {
        print("Error: Status Code ${response.statusCode}");
        print("Response: ${response.body}");
        return;
      }

      var issueBody = jsonDecode(response.body);
      print(issueBody);
      print("lalalalal");

      setState(() {
        if (particleId != null && particleId.isNotEmpty) {
          subparticleList = (issueBody['data'] as List?)
                  ?.map((item) => Map<String, dynamic>.from(item))
                  .toList() ??
              [];
        } else {
          particleList = (issueBody['data'] as List?)
                  ?.map((item) => Map<String, dynamic>.from(item))
                  .toList() ??
              [];
        }
        print(particleList);
      });
    } catch (e, stackTrace) {
      print("Error fetching particle data: $e");
      print("Stack trace: $stackTrace");
    }
  }

  getELListData() async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');

    // Check if `site` is not null before proceeding
    if (site != null) {
      final url = site! + 'Quality/getTypeEL';

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          try {
            // Attempt to decode the JSON response
            final issueBody = jsonDecode(response.body);
            print("Response Data: $issueBody");

            if (mounted) {
              setState(() {
                elList = issueBody;
                print("EL List: $elList");
              });
            }
          } catch (e) {
            // Handle JSON parsing error
            print("JSON Parsing Error: $e");
            print("Response Body: ${response.body}");
          }
        } else {
          print("Failed to load data: ${response.statusCode}");
          print("Response Body: ${response.body}");
        }
      } catch (e) {
        print("Error occurred: $e");
      }
    } else {
      print("Site URL is not set in SharedPreferences.");
    }
  }

  getModelNumberData() async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');

    final url = (site! + 'Quality/GetModels');

    http.get(
      Uri.parse(url),
      // body: jsonEncode(<String, String>{"departmentid": departmentId}),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((response) {
      if (mounted) {
        var modelNumberBody = jsonDecode(response.body);
        setState(() {
          modelNumberList = modelNumberBody['Models'];
          modelNumberList.add({
            "ModelId": "8634275c-0b99-11ef-8005-52549f6cc694",
            "ModelName": "Other"
          });
        });
      }
    });
  }

  getLocationData() async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');

    final url = (site! + 'QCM/GetWorkLocationList');

    http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((response) {
      if (mounted) {
        var designationBody = jsonDecode(response.body);
        setState(() {
          // locationList = designationBody['data'];
        });
      }
    });
  }

  DropdownButtonFormField textLine() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Select Line",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      borderRadius: BorderRadius.circular(20),
      items: lineList
          .map((label) => DropdownMenuItem(
                child: Text(label['factoryLines']!,
                    style: AppStyles.textInputTextStyle),
                value: label['factoryLines'].toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          lineController = val!;
        });
      },
      value: lineController != '' ? lineController : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a line';
        }
        return null; // Return null if the validation is successful
      },
    );
  }

  DropdownButtonFormField textShift() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Select Shift",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      borderRadius: BorderRadius.circular(20),
      items: shiftList
          .map((label) => DropdownMenuItem(
                child: Text(label['key']!, style: AppStyles.textInputTextStyle),
                value: label['value'].toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          shiftController = val!;
        });
      },
      value: shiftController != '' ? shiftController : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a shift';
        }
        return null; // Return null if the validation is successful
      },
    );
  }

  //  EL Status New Element Added
  DropdownButtonFormField textELStatus() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Select El Status Type",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      borderRadius: BorderRadius.circular(20),
      items: elList
          .map((label) => DropdownMenuItem(
                child: Text(label['name'], style: AppStyles.textInputTextStyle),
                value: label['id'].toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          elTypeController = val!;
          print("hiiiiiiiiii");
          print(elTypeController);
        });
      },
      value: elTypeController != '' ? elTypeController : null,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please select a  El Status Type';
      //   }
      //   return null; // Return null if the validation is successful
      // },
    );
  }

  //  Sub Forign Particle New Element Added
  // DropdownButtonFormField textSubForeignParticle() {
  //   return DropdownButtonFormField<String>(
  //     decoration: AppStyles.textFieldInputDecoration.copyWith(
  //         hintText: "Please Select Sub Foriegn particle Type",
  //         counterText: '',
  //         contentPadding: EdgeInsets.all(10)),
  //     borderRadius: BorderRadius.circular(20),
  //     items: subparticleList
  //         .map((label) => DropdownMenuItem(
  //               child: Text(label['particleChildName']?.toString() ?? '',
  //                   style: AppStyles.textInputTextStyle),
  //               value: label['particleChildId']?.toString(),
  //             ))
  //         .toList(),
  //     onChanged: (val) {
  //       setState(() {
  //         subparticletypeController = val;
  //         print("hiiiiiiiiii");
  //         print(particletypeController);
  //       });
  //     },
  //     value: subparticletypeController != ''
  //         ? subparticletypeController
  //         : null, // Remove the check since it's already nullable
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please select a Sub Foriegn particle Type';
  //       }
  //       return null;
  //     },
  //   );
  // }
  DropdownButtonFormField<String> textSubForeignParticle() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
        hintText: "Please Select Sub Foreign Particle Type",
        counterText: '',
        contentPadding: EdgeInsets.all(10),
      ),
      borderRadius: BorderRadius.circular(20),
      items: staticSubParticleList
          .map((item) => DropdownMenuItem(
                child: Text(
                  item['particleChildName'] ?? '',
                  style: AppStyles.textInputTextStyle,
                ),
                value: item['particleChildId'],
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          subparticletypeController = val;
          print("Selected Sub Foreign Particle: $val");
        });
      },
      value: subparticletypeController != '' ? subparticletypeController : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a Sub Foreign Particle Type';
        }
        return null;
      },
    );
  }
  //Forign Particle New Element Added

  DropdownButtonFormField textForeignParticle() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Select Defect Location Type",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      borderRadius: BorderRadius.circular(20),
      items: particleList
          .map((label) => DropdownMenuItem(
                child: Text(label['particleName']?.toString() ?? '',
                    style: AppStyles.textInputTextStyle),
                value: label['particleId']?.toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          particletypeController = val;
          print("hiiiiiiiiii");
          if (val != null) {
            // getaPartclesData(val); // Pass val directly
          }
          print(particletypeController);
        });
      },
      value: particletypeController != '' ? particletypeController : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a Defect Location type';
        }
        return null;
      },
    );
  }

  // DropdownButtonFormField textIssueType() {
  //   return DropdownButtonFormField<String>(
  //     decoration: AppStyles.textFieldInputDecoration.copyWith(
  //         hintText: "Please Select Issue Type",
  //         counterText: '',
  //         contentPadding: EdgeInsets.all(10)),
  //     borderRadius: BorderRadius.circular(20),
  //     items: issueList
  //         .map((label) => DropdownMenuItem(
  //               child:
  //                   Text(label['Issue'], style: AppStyles.textInputTextStyle),
  //               value: label['IssueId'].toString(),
  //             ))
  //         .toList(),
  //     onChanged: (val) {
  //       setState(() {
  //         issuetypeController = val!;
  //         getIssueData(issuetypeController);
  //         print("hiiiiiiiiii");
  //       });
  //     },
  //     value: issuetypeController != '' ? issuetypeController : null,
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please select a issue type';
  //       }
  //       return null; // Return null if the validation is successful
  //     },
  //   );
  // }

  // DropdownButtonFormField textSubIssueType() {
  //   return DropdownButtonFormField<String>(
  //     decoration: AppStyles.textFieldInputDecoration.copyWith(
  //         hintText: "Please Select Issue Type",
  //         counterText: '',
  //         contentPadding: EdgeInsets.all(10)),
  //     borderRadius: BorderRadius.circular(20),
  //     items: issueList
  //         .map((label) => DropdownMenuItem(
  //               child: Text(label['ChildIssue'],
  //                   style: AppStyles.textInputTextStyle),
  //               value: label['ChildIssueId'].toString(),
  //             ))
  //         .toList(),
  //     onChanged: (val) {
  //       setState(() {
  //         subissuetypeController = val!;
  //         print("hiiiiiiiiii");
  //       });
  //     },
  //     value: subissuetypeController != '' ? subissuetypeController : null,
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please select a issue type';
  //       }
  //       return null; // Return null if the validation is successful
  //     },
  //   );
  // }
  DropdownButtonFormField textIssueType() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
        hintText: "Please Select Issue Type",
        counterText: '',
        contentPadding: const EdgeInsets.all(10),
      ),
      borderRadius: BorderRadius.circular(20),
      items: issueList
          .map((label) => DropdownMenuItem(
                child: Text(label['Issue']?.toString() ?? '',
                    style: AppStyles.textInputTextStyle),
                value: label['IssueId']?.toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          issuetypeController = val;
          subissuetypeController = null; // Reset sub-issue when issue changes
          getIssueData(val);
        });
      },
      value: issuetypeController != '' ? issuetypeController : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an issue type';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField textSubIssueType() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
        hintText: "Please Select Sub-Issue Type",
        counterText: '',
        contentPadding: const EdgeInsets.all(10),
      ),
      borderRadius: BorderRadius.circular(20),
      items: subIssueList
          .map((label) => DropdownMenuItem(
                child: Text(label['ChildIssue']?.toString() ?? '',
                    style: AppStyles.textInputTextStyle),
                value: label['ChildIssueId']?.toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          subissuetypeController = val;
        });
      },
      value: subissuetypeController != '' ? subissuetypeController : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a sub-issue type';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField textModelNumber() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Select Model Number",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      borderRadius: BorderRadius.circular(20),
      items: modelNumberList
          .map((label) => DropdownMenuItem(
                child: Text(label['ModelName'],
                    style: AppStyles.textInputTextStyle),
                value: label['ModelId'].toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          modelNumberController = val!;
          print("hiiiiiiiiii");
        });
      },
      value: modelNumberController != '' ? modelNumberController : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a model number';
        }
        return null; // Return null if the validation is successful
      },
    );
  }

  // laminator

  DropdownButtonFormField textStingType() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Select Stringer Type",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      borderRadius: BorderRadius.circular(20),
      items: stringList
          .map((label) => DropdownMenuItem(
                child: Text(label['name'].toString(),
                    style: AppStyles.textInputTextStyle),
                value: label['id'].toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          laminatorTypeController = val!;
          print("hiiiiiiiiii");
        });
      },
      value: laminatorTypeController != '' ? laminatorTypeController : null,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please select a Stringer type';
      //   }
      //   return null; // Return null if the validation is successful
      // },
    );
  }

  DropdownButtonFormField laminatorType() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Select Laminator",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      borderRadius: BorderRadius.circular(20),
      items: laminatorList
          .map((label) => DropdownMenuItem(
                child: Text(label['key']!, style: AppStyles.textInputTextStyle),
                value: label['value'].toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          laminatorController = val!;
        });
      },
      value: laminatorController != '' ? laminatorController : null,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please select a shift';
      //   }
      //   return null; // Return null if the validation is successful
      // },
    );
  }

  DropdownButtonFormField subLaminatorType() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Select Shift",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      borderRadius: BorderRadius.circular(20),
      items: chamberList
          .map((label) => DropdownMenuItem(
                child: Text(label['key']!, style: AppStyles.textInputTextStyle),
                value: label['value'].toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          chamberController = val!;
        });
      },
      value: chamberController != '' ? chamberController : null,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please select a shift';
      //   }
      //   return null; // Return null if the validation is successful
      // },
    );
  }

  Future createData(
    String status,
    String line,
    String shift,
    String shiftinchargeprelime,
    String shiftinchargepostlime,
    String productBarcode,
    String wattage,
    String modelnumber,
    String othermodelnumber,
    String elType,
    String particleType,
    String subparticleType,
    String issuetype,
    String subissueType,
    String chambertype,
    String laminatortype,
    String stringertype,
    String otherissuetype,
    String stage,
    String responsibleperson,
    String reasonofissue,
    String issuecomefrom,
    String actiontaken,
  ) async {
    setState(() {
      _isLoading = true;
    });
    print("whyyyyyyyyyyyyyyyyyyyy");

    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');
    print("Howwwwwwwwwwwwwwwwwwwww");
    print(site);
    final url = (site! + 'Quality/AddQuality'); // Prod

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(<String, String>{
        "qualityid":
            widget.id != "" && widget.id != null ? widget.id.toString() : "",
        "line": line,
        "currentuser": personid ?? '',
        "status": status,
        "shift": shift,
        "shiftinchargename": "",
        "shiftinchargeprelime": shiftinchargeprelime,
        "shiftinchargepostlime": shiftinchargepostlime,
        "productBarcode": productBarcode,
        "wattage": wattage,
        "modelnumber": modelnumber,
        "productTestReport": apiResponse.toString(),
        "othermodelnumber": othermodelnumber,
        "elType": elType,
        "particleType": particleType,
        "subParticleType": subparticleType,
        "issuetype": issuetype,
        "subIssueType": subissueType,
        "chamber": chambertype,
        "laminator": laminatortype,
        "stringer": stringertype,
        "otherissuetype": otherissuetype,
        "stage": stage,
        "responsibleperson": responsibleperson,
        "reasonofissue": reasonofissue,
        "issuecomefrom": issuecomefrom,
        "actiontaken": actiontaken,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("Resssssssss.....???");
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      print(data['UUID']);

      setState(() {
        setpersonid = data['UUID'];
      });
      if (_imageBytes != null && _imageBytes != '') {
        upload(
            (_imageBytes ?? []), (_elimageBytes ?? []), (productBarcode ?? ''));
      } else {
        Toast.show("Issue reporting successfully.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.primaryColor);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => QualityList()),
            (Route<dynamic> route) => false);
      }
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
    } else if (response.statusCode == 403) {
      setState(() {
        _isLoading = false;
      });
      Toast.show("Barcode must be at least 10 digits or be N/A.",
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

  // upload(List<int> bytes, String name) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   site = prefs.getString('site');

  //   var currentdate = DateTime.now().microsecondsSinceEpoch;
  //   var formData = FormData.fromMap({
  //     'QualityId': setpersonid != '' && setpersonid != null ? setpersonid : '',
  //     "ModuleImage": MultipartFile.fromBytes(
  //       bytes,
  //       filename: (name + (currentdate.toString()) + '.jpg'),
  //       contentType: MediaType("image", 'jpg'),
  //     ),
  //   });

  //   _response = await _dio.post((site! + 'Quality/UploadModuleImage'), // Prod

  //       options: Options(
  //         contentType: 'multipart/form-data',
  //         followRedirects: false,
  //         validateStatus: (status) => true,
  //       ),
  //       data: formData);

  //   try {
  //     if (_response!.data != null) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       print("Upload....?");
  //       print(_response!.data);

  //       Toast.show("Issue reporting successfully.",
  //           duration: Toast.lengthLong,
  //           gravity: Toast.center,
  //           backgroundColor: AppColors.primaryColor);
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (BuildContext context) => QualityList()),
  //           (Route<dynamic> route) => false);
  //     }
  //   } catch (err) {
  //     print("Error");
  //   }
  // }
  Future upload(
    List<int> imageBytes,
    List<int> elImageBytes,
    String name,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');

    var currentdate = DateTime.now().microsecondsSinceEpoch;

    // Create FormData with both images
    Map<String, dynamic> formDataMap = {
      'QualityId': setpersonid != '' && setpersonid != null ? setpersonid : '',
    };

// Add ModuleImage conditionally
    if (imageBytes != null && imageBytes.isNotEmpty) {
      formDataMap["ModuleImage"] = MultipartFile.fromBytes(
        imageBytes,
        filename: '${name}${currentdate.toString()}.jpg',
        contentType: MediaType("image", 'jpg'),
      );
    }

// Add ElModuleImage conditionally
    if (elImageBytes != null && elImageBytes.isNotEmpty) {
      formDataMap["ElModuleImage"] = MultipartFile.fromBytes(
        elImageBytes,
        filename: '${name}${currentdate.toString()}.jpg',
        contentType: MediaType("image", 'jpg'),
      );
    }

// Create FormData from the map
    var formData = FormData.fromMap(formDataMap);

    try {
      print("Payload:");
      formData.fields.forEach((field) {
        print("${field.key}: ${field.value}");
      });
      formData.files.forEach((file) {
        print(
            "${file.key}: ${file.value.filename} (${file.value.contentType})");
      });

      _response = await _dio.post((site! + 'Quality/UploadModuleImage'), // Prod
          options: Options(
            contentType: 'multipart/form-data',
            followRedirects: false,
            validateStatus: (status) => true,
          ),
          data: formData);

      print("Response:");
      print("Status Code: ${_response?.statusCode}");
      print("Response Data: ${_response?.data}");

      if (_response?.data != null) {
        setState(() {
          _isLoading = false;
        });
        print("Upload....?");
        print(_response!.data);

        Toast.show("Issue reporting successfully.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.primaryColor);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => QualityList()),
            (Route<dynamic> route) => false);
      }
    } catch (err) {
      print("Error");
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
            // const Center(
            //     child: Padding(
            //         padding: EdgeInsets.only(top: 10),
            //         child: Text("Incoming Quality Control Plan",
            //             style: TextStyle(
            //                 fontSize: 27,
            //                 color: AppColors.black,
            //                 fontFamily: appFontFamily,
            //                 fontWeight: FontWeight.w700)))),
            const Center(
                child: Text("Quality",
                    style: TextStyle(
                        fontSize: 25,
                        color: AppColors.black,
                        fontFamily: appFontFamily,
                        fontWeight: FontWeight.w700))),
            const SizedBox(
              height: 25,
            ),
            if (WorkLocationName == "Baliyali Unit 1")
              Text(
                "Select Line*",
                style: AppStyles.textfieldCaptionTextStyle,
              ),
            if (WorkLocationName == "Baliyali Unit 1")
              const SizedBox(height: 5),
            if (WorkLocationName == "Baliyali Unit 1") textLine(),

            const SizedBox(
              height: 15,
            ),
            Text(
              "Capture Module Pic*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 10),
            _image == null
                ? Container(
                    width: 300,
                    height: 300,
                    child: GestureDetector(
                      onTap: () {
                        print("image.....?");
                        print(_image);
                        getImage();
                      },
                      child: widget.id != "" &&
                              widget.id != null &&
                              modulepicture != ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: ((modulepicture ?? '')),
                                fit: BoxFit.cover,
                                width: 300,
                                height: 300,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                AppAssets.camera,
                                fit: BoxFit.cover,
                                width: 300,
                                height: 300,
                              ),
                            ),
                    ),
                  )
                : Container(
                    width: 300,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
            if (WorkLocationName == "Baliyali Unit 1" &&
                _image == null &&
                (widget.id == "" || modulepicture == ""))
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "Please capture the Module picture.",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const SizedBox(height: 10),
            if (WorkLocationName == "Baliyali Unit 1") ...[
              Text(
                "Capture EL Image*",
                style: AppStyles.textfieldCaptionTextStyle,
              ),
              const SizedBox(height: 10),
              _elimage == null
                  ? Container(
                      width: 300,
                      height: 300,
                      child: GestureDetector(
                        onTap: () {
                          print("image.....?");
                          print(_elimage);
                          getElImage();
                        },
                        child: widget.id != "" &&
                                widget.id != null &&
                                elpicture != ""
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: ((elpicture ?? '')),
                                  fit: BoxFit.cover,
                                  width: 300,
                                  height: 300,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  AppAssets.camera,
                                  fit: BoxFit.cover,
                                  width: 300,
                                  height: 300,
                                ),
                              ),
                      ),
                    )
                  : Container(
                      width: 300,
                      height: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _elimage!,
                          fit: BoxFit.cover,
                          width: 300,
                          height: 300,
                        ),
                      ),
                    ),
              // Error Message for _elimage
              // if (_elimage == null && (widget.id == "" || elpicture == ""))
              //   Padding(
              //     padding: const EdgeInsets.only(top: 5),
              //     child: Text(
              //       "Please capture the EL picture.",
              //       style: TextStyle(color: Colors.red, fontSize: 12),
              //     ),
              //   ),
              const SizedBox(height: 10),
            ],
            Text(
              "Shift*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            textShift(),

            const SizedBox(
              height: 15,
            ),

            Text(
              "Shift Incharge Name Prelime",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            textShiftInchargePrelime(),
            const SizedBox(
              height: 15,
            ),

            Text(
              "Shift Incharge Name Postlime",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            textShiftInchargePostlime(),
            const SizedBox(
              height: 15,
            ),

            // if (WorkLocationName == "Baliyali Unit 1" &&
            //     (widget.id == "" || widget.id == null))
            //   Text(
            //     "Visual360/Visual90 Rejected Barcode",
            //     style: AppStyles.textfieldCaptionTextStyle,
            //   ),
            // const SizedBox(height: 5),
            // if (WorkLocationName == "Baliyali Unit 1" &&
            //     (widget.id == "" || widget.id == null))
            //   SearchChoices.single(
            //     items: barcodes.map((barcode) {
            //       return DropdownMenuItem(
            //         value: barcode,
            //         child: Text(barcode),
            //       );
            //     }).toList(),
            //     value: productBarcodeController.text,
            //     hint: Text("Please Select Barcode"),
            //     searchHint: "Search Barcode...",
            //     onChanged: (val) {
            //       setState(() {
            //         productBarcodeController.text = val;
            //       });
            //       fetchQcApiData(val);
            //       print("Selected barcode: $val");
            //     },
            //     isExpanded: true,
            //     displayClearIcon: true,
            //     validator: (value) {
            //       if (value == null || value.toString().isEmpty) {
            //         return 'Please Select Barcode';
            //       }
            //       return null;
            //     },
            //   ),
            // const SizedBox(height: 5),
            // Text(
            //   "Product Barcode*",
            //   style: AppStyles.textfieldCaptionTextStyle,
            // ),

            // textProductBarcode(),
            // const SizedBox(height: 15),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section for Visual360/Visual90 Rejected Barcode
                if (widget.id == "" || widget.id == null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      border: Border.all(color: Colors.blue.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          WorkLocationName == "Baliyali Unit 1"
                              ? "Visual360/Visual90 Rejected Barcode"
                              : "Visual Rejected Barcode",
                          style: AppStyles.textfieldCaptionTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SearchChoices.single(
                          items: barcodes.map((barcode) {
                            return DropdownMenuItem(
                              value: barcode,
                              child: Text(barcode),
                            );
                          }).toList(),
                          value: productBarcodeController.text,
                          hint: const Text("Please Select Barcode"),
                          searchHint: "Search Barcode...",
                          onChanged: (val) {
                            setState(() {
                              productBarcodeController.text = val;
                            });
                            fetchQcApiData(val);
                            print("Selected barcode: $val");
                          },
                          isExpanded: true,
                          displayClearIcon: true,
                          // validator: (value) {
                          //   if (value == null || value.toString().isEmpty) {
                          //     return 'Please Select Barcode';
                          //   }
                          //   return null;
                          // },
                        ),
                      ],
                    ),
                  ),

                // OR separator
                if (widget.id == "" || widget.id == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        const Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                  ),

                // Section for Product Barcode
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    border: Border.all(color: Colors.green.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Barcode*",
                        style: AppStyles.textfieldCaptionTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      textProductBarcode(),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
              ],
            ),

            if (apiResponse.isNotEmpty)
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (apiResponse.containsKey("lamination")) ...[
                      Text(
                        "Lamination",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                          "Date: ${apiResponse["lamination"]["date"] ?? "N/A"}"),
                      Text(
                          "Time: ${apiResponse["lamination"]["time"] ?? "N/A"}"),
                      Text(
                          "Supervisor: ${apiResponse["lamination"]["username"] ?? "N/A"}"),
                      Divider(color: Colors.grey),
                    ],
                    if (apiResponse.containsKey("visual90")) ...[
                      Text(
                        "Visual90 Rejection",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                          "Reason: ${apiResponse["visual90"]["reason"] ?? "N/A"}"),
                      Text(
                          "Location: ${apiResponse["visual90"]["location"] ?? "N/A"}"),
                      Text("Date: ${apiResponse["visual90"]["date"] ?? "N/A"}"),
                      Text("Time: ${apiResponse["visual90"]["time"] ?? "N/A"}"),
                      Text(
                          "Supervisor: ${apiResponse["visual90"]["username"] ?? "N/A"}"),
                      Divider(color: Colors.grey),
                    ],
                    if (WorkLocationName == "Baliyali Unit 1" &&
                        apiResponse.containsKey("visual360")) ...[
                      Text(
                        "Visual360 Rejection",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                          "Reason: ${apiResponse["visual360"]["reason"] ?? "N/A"}"),
                      Text(
                          "Location: ${apiResponse["visual360"]["location"] ?? "N/A"}"),
                      Text(
                          "Date: ${apiResponse["visual360"]["date"] ?? "N/A"}"),
                      Text(
                          "Time: ${apiResponse["visual360"]["time"] ?? "N/A"}"),
                      Text(
                          "Supervisor: ${apiResponse["visual360"]["username"] ?? "N/A"}"),
                      Divider(color: Colors.grey),
                    ],
                  ],
                ),
              ),

            const SizedBox(height: 15),

            Text(
              "Wattage*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            textWattage(),
            const SizedBox(height: 15),

            Text(
              "Model Number*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            textModelNumber(),
            const SizedBox(
              height: 15,
            ),
            if (modelNumberController == "8634275c-0b99-11ef-8005-52549f6cc694")
              Text(
                "Other Model Number*",
                style: AppStyles.textfieldCaptionTextStyle,
              ),

            if (modelNumberController == "8634275c-0b99-11ef-8005-52549f6cc694")
              const SizedBox(height: 5),
            if (modelNumberController == "8634275c-0b99-11ef-8005-52549f6cc694")
              textOtherModelNumber(),
            if (modelNumberController == "8634275c-0b99-11ef-8005-52549f6cc694")
              const SizedBox(height: 15),
            Text(
              "Stringers",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 15),
            textStingType(),
            // getStringData(),
            const SizedBox(height: 15),
            Text(
              "EL Status",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            textELStatus(),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Defect Location*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            textForeignParticle(),
            const SizedBox(
              height: 15,
            ),

            Text(
              "Issue Type*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            textIssueType(),
            const SizedBox(
              height: 15,
            ),
            if (issuetypeController == "9f00c67d-0b99-11ef-8005-52549f6cc694")
              Text(
                "Other Issue Type*",
                style: AppStyles.textfieldCaptionTextStyle,
              ),
            if (issuetypeController == "9f00c67d-0b99-11ef-8005-52549f6cc694")
              const SizedBox(
                height: 5,
              ),
            if (issuetypeController == "9f00c67d-0b99-11ef-8005-52549f6cc694")
              textOtherIssueType(),
            if (issuetypeController == "9f00c67d-0b99-11ef-8005-52549f6cc694")
              const SizedBox(
                height: 15,
              ),
            if (issuetypeController == "f1e24387-9e85-11ef-80b2-1a2cd4d9c0d1")
              Text(
                "Sub Foreign Particle*",
                style: AppStyles.textfieldCaptionTextStyle,
              ),
            if (issuetypeController == "f1e24387-9e85-11ef-80b2-1a2cd4d9c0d1")
              const SizedBox(
                height: 5,
              ),
            if (issuetypeController == "f1e24387-9e85-11ef-80b2-1a2cd4d9c0d1")
              textSubForeignParticle(),
            if (issuetypeController == "f1e24387-9e85-11ef-80b2-1a2cd4d9c0d1")
              const SizedBox(
                height: 15,
              ),
            if (subIssueList.isNotEmpty) ...[
              Text(
                "Sub Issue Type*",
                style: AppStyles.textfieldCaptionTextStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              textSubIssueType(),
              const SizedBox(
                height: 15,
              ),
            ],

            Text(
              "Stage*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            textStage(),
            const SizedBox(height: 15),
            Text(
              "Laminator",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            laminatorType(),
            const SizedBox(height: 15),
            Text(
              "Chamber",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            subLaminatorType(),
            const SizedBox(height: 15),

            Text(
              "Responsible Person*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            textResponsiblePerson(),
            const SizedBox(height: 15),

            Text(
              "Reason Of Issue*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            textReasonOfIssue(),
            const SizedBox(height: 15),

            Text(
              "Issue Come From*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            textIssueComeFrom(),
            const SizedBox(height: 15),

            Text(
              "Action Taken For This Issue*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            textActionTaken(),
            const SizedBox(height: 15),
            // Text(
            //   "Capture Module Pic*",
            //   style: AppStyles.textfieldCaptionTextStyle,
            // ),
            // const SizedBox(height: 10),
            // _image == null
            //     ? Container(
            //         width: 300, // Set the desired width
            //         height: 300, // Set the desired height
            //         child: GestureDetector(
            //           onTap: () {
            //             getImage();
            //           },
            //           child: ClipRRect(
            //             borderRadius: BorderRadius.circular(
            //                 10), // Adjust the radius to your preference
            //             child: Image.asset(
            //               AppAssets.camera,
            //               fit: BoxFit.cover,
            //               width:
            //                   300, // Set width and height to match Container's size
            //               height: 300,
            //             ),
            //           ),
            //         ),
            //       )
            //     : Container(
            //         width: 300, // Set the desired width
            //         height: 300, // Set the desired height
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(10),
            //           child: Image.file(
            //             _image!, // Assuming _image is a File object
            //             fit: BoxFit.cover,
            //             width:
            //                 300, // Set width and height to match Container's size
            //             height: 300,
            //           ),
            //         ),
            //       ),

            const SizedBox(height: 30),

            AppButton(
              organization: (organizationtype ?? ''),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  fontSize: 16),
              onTap: () async {
                if (qualityformKey.currentState!.validate()) {
                  bool isBaliyali = WorkLocationName == "Baliyali Unit 1";

                  bool allFieldsValid = shiftController != null &&
                      shiftController != "" &&
                      (!isBaliyali ||
                          (lineController != null && lineController != "")) &&
                      productBarcodeController.text != "" &&
                      wattageController.text != "" &&
                      modelNumberController != null &&
                      modelNumberController != "" &&
                      particletypeController != null &&
                      particletypeController != "" &&
                      issuetypeController != null &&
                      issuetypeController != "" &&
                      stageController.text != "" &&
                      responsiblepersonController.text != "" &&
                      reasonofissueController.text != "" &&
                      actiontakenController.text != "" &&
                      (!isBaliyali ||
                          (_image != null ||
                              (widget.id != "" && modulepicture != "")));

                  if (allFieldsValid) {
                    createData(
                      "Completed",
                      lineController ?? "",
                      shiftController ?? "",
                      shiftinchargeprelimeController.text,
                      shiftinchargepostlimeController.text,
                      productBarcodeController.text,
                      wattageController.text,
                      modelNumberController ?? "",
                      othermodelnumberController.text,
                      elTypeController ?? "",
                      particletypeController ?? "",
                      subparticletypeController ?? "",
                      issuetypeController ?? "",
                      subissuetypeController ?? "",
                      chamberController ?? "",
                      laminatorController ?? "",
                      laminatorTypeController ?? "",
                      otherissuetypeController.text,
                      stageController.text,
                      responsiblepersonController.text,
                      reasonofissueController.text,
                      issuecomefromController.text,
                      actiontakenController.text,
                    );
                  } else {
                    Toast.show(
                      "Please Enter All Required Fields.",
                      duration: Toast.lengthLong,
                      gravity: Toast.center,
                      backgroundColor: Colors.redAccent,
                    );
                  }

                  qualityformKey.currentState!.save();
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
                                    ? QualityList()
                                    : QualityPage()),
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
