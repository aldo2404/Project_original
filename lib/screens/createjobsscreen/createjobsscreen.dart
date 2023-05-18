import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/input_field.dart';
import 'package:fx_project/layout/snackbar.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/services/createjodservices.dart';
import 'package:image_picker/image_picker.dart';

class CreateJobsScreen extends StatefulWidget {
  const CreateJobsScreen({super.key});

  @override
  State<CreateJobsScreen> createState() => _CreateJobsScreenState();
}

class _CreateJobsScreenState extends State<CreateJobsScreen> {
  List<dynamic>? propertyData = [];
  List<dynamic>? locationData = [];
  List<dynamic>? serviceData = [];
  // List<dynamic>? locatData = [];
  List<dynamic>? priorityData = [];
  List<dynamic>? categoryData = [];
  List<dynamic>? managerData = [];
  List<dynamic>? engineersData = [];

  List<File> imageFiles = [];
  List<dynamic> imageId = [];
  String? serviceTypeId;
  String? propertyId;
  String? locationId;
  String? categoryId;
  String? priorityId;
  String? engineersId;
  String? managerId;
  //String? unitId;
  bool iconChange = true;
  bool textChange = true;
  late bool iconVisiable;
  bool isSwitch = true;
  bool textIcon = true;
  bool isChecked = false;
  bool _isChecked = false;

  String? unitName;
  String? unitTenantName;
  String? address;
  String? managerName;
  List<String>? engineersName = [];
  int manNameCount = 0;
  int engNameCount = 0;

  final TextEditingController serviceController = TextEditingController();
  final TextEditingController propertyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController briefDescripController = TextEditingController();
  final TextEditingController detailDescripController = TextEditingController();
  final TextEditingController searchEditingController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController accesController = TextEditingController();

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    serviceGetData();
    propetyGetData();
    priorityGetData();
    priorityController.text = "Medium";
    dateController.text = nowDate();
  }
// service drop down list URL data........

  Future<void> serviceGetData() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    dynamic serData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl1/v1/jobs/service-type/')))
        .createJobService()));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    serviceData = serData;
    print(serviceData!);
  }

// property drop down list URL data........

  Future<void> propetyGetData() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    dynamic proData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl1/v1/properties/dropdown/')))
        .createJobService()));

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    propertyData = proData;
    print(propertyData!);
  }

// Location drop down list URL data........

  Future<void> locationGetData(id) async {
    dynamic baseurl2 = await EnvironmentPageState.getBaseurl() as dynamic;
    dynamic locData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl2/v1/properties/$id/units/')))
        .createJobService()));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    locationData = locData;
    print(locationData!);
  }
// maintenance category drop down list  data........

  Future<void> categoryGetData(catid) async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    dynamic cateData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl1/v1/properties/$catid/categories/')))
        .createJobService()));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    categoryData = cateData;
    print(categoryData!);
  }

  //  Priority drop down list  data........

  Future<void> priorityGetData() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    dynamic priData = (await (CreateJobServices(
            service: Dio(
                BaseOptions(baseUrl: 'https://$baseurl1/v1/jobs/priorities/')))
        .createJobService()));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    priorityData = priData;
    print(priorityData!);
  }

  Future<void> managerGetData(id) async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    dynamic manData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl1/v1/properties/$id/managers/')))
        .createJobService()));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    managerData = manData;
    print(managerData!);
  }

  Future<void> assignEnggGetData(id) async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    dynamic enggData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl1/v1/properties/$id/engineers/')))
        .createJobService()));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    engineersData = enggData;
    print(engineersData!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 48, 92),
          leading: IconButton(
              onPressed: () {
                if (currentStep >= 1) {
                  setState(() => currentStep -= 1);
                } else if (currentStep == 0) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.arrow_back_sharp)),
          centerTitle: true,
          title: currentStep == 2
              ? const Text("Review & Submit")
              : const Text("Create Jobs Request"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "cancel",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 230, 81, 0)),
            iconTheme: Theme.of(context).iconTheme.copyWith(size: 32.0),
          ),
          child: Stepper(
            margin: EdgeInsets.zero,
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              //final isLastStep = currentStep == getSteps().length - 1;
              if (currentStep == 0) {
                if (serviceController.text.isEmpty) {
                  ShowSnackBar()
                      .snackBarMessage(context, "Kindly choose Service Type");
                } else if (propertyController.text.isEmpty) {
                  ShowSnackBar()
                      .snackBarMessage(context, "Kindly choose property");
                } else if (locationController.text.isEmpty) {
                  ShowSnackBar()
                      .snackBarMessage(context, "Kindly choose Location");
                } else if (briefDescripController.text.isEmpty) {
                  ShowSnackBar()
                      .snackBarMessage(context, "Kindly type description");
                } else {
                  setState(() {
                    currentStep = currentStep + 1;
                  });
                }
              } else if (currentStep == 1) {
                if (categoryController.text.isEmpty) {
                  ShowSnackBar()
                      .snackBarMessage(context, "Kindly choose category");
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              }

              if (currentStep == 2) {
                print("last Step");
              }
            },
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              final isLastStep = currentStep == getSteps().length - 1;

              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  //color: Colors.grey.shade100,
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClickButton(
                          onpressed: details.onStepContinue,
                          child: Text(isLastStep ? 'SUBMIT' : 'NEXT'),
                        ),
                      ),
                      // if (currentStep == 2)
                      //   Expanded(
                      //     child: ClickButton(
                      //       onpressed: details.onStepCancel,
                      //       child: const Text('BACK'),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        // Step 1 form data enter details......
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text(''),
            content: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKeyStep1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mandatoryText("Service"),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        hinttext: 'Select',
                        inputfieldcolor: Colors.white,
                        maxLines: 1,
                        password: false,
                        readOnly: true,
                        showCursor: false,
                        controller: serviceController,
                        textAlign: TextAlign.left,
                        onTap: () {
                          serviceBottomSheetModel();
                        },
                        suffixs: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 30,
                        ),
                      ),
                    ),
                    mandatoryText("Property"),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                          hinttext: 'Select',
                          inputfieldcolor: Colors.white,
                          maxLines: 1,
                          password: false,
                          readOnly: true,
                          showCursor: false,
                          controller: propertyController,
                          textAlign: TextAlign.left,
                          suffixs: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 30,
                          ),
                          onTap: () {
                            propertyBottomSheetModel();
                          }),
                    ),
                    mandatoryText("Location"),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        hinttext: 'Select',
                        inputfieldcolor: Colors.white,
                        maxLines: 1,
                        password: false,
                        readOnly: true,
                        showCursor: false,
                        controller: locationController,
                        textAlign: TextAlign.left,
                        suffixs: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 30,
                        ),
                        onTap: () {
                          locationBottomSheetModel();
                        },
                      ),
                    ),
                    mandatoryText("Brief Description"),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        textAlign: TextAlign.left,
                        hinttext: "Description",
                        inputfieldcolor: Colors.white,
                        maxLines: 4,
                        controller: briefDescripController,
                        password: false,
                        readOnly: false,
                      ),
                    ),
                    const Text("Detailed Description",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none)),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                      child: ReuseTextFields(
                        textAlign: TextAlign.left,
                        hinttext: "Description",
                        inputfieldcolor: Colors.white,
                        maxLines: 4,
                        controller: detailDescripController,
                        password: false,
                        readOnly: false,
                      ),
                    ),
                  ],
                ),
              ),
            )),

        // Step 2  form page.....
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text(''),
          content: Form(
            key: formKeyStep2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mandatoryText("Maintenance Category"),

                //const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: ReuseTextFields(
                    hinttext: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    password: false,
                    readOnly: true,
                    showCursor: false,
                    textAlign: TextAlign.left,
                    controller: categoryController,
                    onTap: () {
                      categoryBottomSheetModel();
                    },
                    suffixs: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 8.0),
                //   child: ListTile(
                //     title: const Text('Courtesy Job',
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold, fontSize: 20)),
                //     trailing: Checkbox(
                //         checkColor: Colors.white,
                //         activeColor: Colors.orange[900],
                //         side: const BorderSide(
                //             width: 2, color: Color.fromARGB(255, 230, 81, 0)),
                //         value: _isChecked,
                //         onChanged: null),
                //   ),
                // ),

                const Text("Priority",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),

                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: ReuseTextFields(
                    hinttext: 'Select',
                    inputfieldcolor: Colors.white,
                    controller: priorityController,
                    maxLines: 1,
                    password: false,
                    readOnly: true,
                    showCursor: false,
                    textAlign: TextAlign.left,
                    onTap: () {
                      priorityBottomSheetModel();
                    },
                    suffixs: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    ),
                  ),
                ),

                const Text("Target Completion Date",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: ReuseTextFields(
                    hinttext: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    password: false,
                    readOnly: true,
                    showCursor: false,
                    controller: dateController,
                    textAlign: TextAlign.left,
                    onTap: () async {
                      DateTime? selected = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100));
                      setState(() {
                        dateController.text = DateFormat("MM-dd-yyyy")
                            .format(selected!)
                            .toString();
                      });
                    },
                    suffixs: const Icon(
                      Icons.calendar_month_outlined,
                      size: 30,
                    ),
                  ),
                ),
                const Text("Add Photos",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 140,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color.fromARGB(255, 1, 30, 54)),
                          child: Row(
                            children: const [
                              SizedBox(width: 8),
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 22,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Take Photo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          imageFromCamera();
                        },
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color.fromARGB(255, 1, 30, 54)),
                          child: Row(
                            children: const [
                              SizedBox(width: 8),
                              Icon(
                                Icons.file_upload_outlined,
                                size: 22,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Upload Photo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                //strutStyle: StrutStyle(leading: 1),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          imageFromGallery();
                        },
                      )
                    ],
                  ),
                ),
                imageFiles.isNotEmpty
                    ? GridView.count(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10,
                        shrinkWrap: true,
                        children: List.generate(imageFiles.length, (index) {
                          return SingleChildScrollView(
                            child: Stack(
                              children: <Widget>[
                                Image.file(
                                  imageFiles[index],
                                  fit: BoxFit.cover,
                                  scale: 2,
                                ),
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.cancel,
                                        size: 15,
                                        color:
                                            Color.fromARGB(255, 196, 194, 194),
                                      ),
                                      onTap: () {
                                        // var imgId = imageId[index].toString();
                                        // print(imgId);
                                        // deletedFile(imgId);
                                        setState(() {
                                          imageFiles.removeAt(index);
                                        });
                                      },
                                    ))
                              ],
                            ),
                          );
                        }),
                      )
                    : Container()
              ],
            ),
          ),
        ),

        //Step 3 Review and Submit .. given all data in there....
        Step(
            isActive: currentStep >= 2,
            title: const Text(' '),
            content: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(31, 199, 198, 198)),
                    child: Column(
                      children: [
                        titleText("Priority"),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, bottom: 10.0, left: 5, right: 5),
                          child: ReuseTextFields(
                            hinttext: 'Select',
                            inputfieldcolor: Colors.white,
                            controller: priorityController,
                            maxLines: 1,
                            password: false,
                            readOnly: true,
                            showCursor: false,
                            textAlign: TextAlign.left,
                            onTap: () {
                              priorityBottomSheetModel();
                            },
                            suffixs: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                titleText("Brief Description"),
                briefDescripField(
                    briefDescripController.text, briefDescripController),
                titleText("Detailed Description"),
                detailDescripField(
                    detailDescripController.text, detailDescripController),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 15),
                    child: reviewData("Property:", propertyController.text,
                        iconVisiable = false, () {})),
                reviewData("Address:", address, iconVisiable = false, () {}),
                reviewData("Location:", unitName, iconVisiable = true, () {
                  locationBottomSheetModel();
                }),
                reviewData("Target\nCompletion Date:", dateController.text,
                    iconVisiable = true, () async {
                  DateTime? selected = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100));
                  setState(() {
                    dateController.text =
                        DateFormat("MM/dd/yyyy").format(selected!).toString();
                  });
                }),
                reviewData("Service Type:", serviceController.text,
                    iconVisiable = true, () {
                  serviceBottomSheetModel();
                }),
                reviewData(
                    "Category:", categoryController.text, iconVisiable = true,
                    () {
                  categoryBottomSheetModel();
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 15),
                  child: reviewData(
                      "Tenant:", unitTenantName, iconVisiable = false, () {}),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Billable Party:"),
                    Text(
                      "Tenant",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Assign Manager:"),
                    //const SizedBox(width: 30),
                    managerName != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                managerName!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                  onPressed: () {
                                    managerBottomSheetModel();
                                  },
                                  icon: const Icon(
                                    Icons.mode_edit_outline,
                                    size: 22,
                                  ))
                            ],
                          )
                        : Container(
                            padding: const EdgeInsets.all(8),
                            width: 170,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 235, 234, 233))),
                                onPressed: () {
                                  managerBottomSheetModel();
                                },
                                child: const Text(
                                  "Assign",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                          )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Assign Engineer:"),
                    engineersName!.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ListView.builder(
                                  controller: ScrollController(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: engineersName!.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: 150,
                                      child: IntrinsicWidth(
                                        child: Container(
                                          height: 20,
                                          //width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  color: Colors.black26)),
                                          child: Text(
                                            engineersName![index],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                              IconButton(
                                  onPressed: () {
                                    engineerBottomSheetModel();
                                  },
                                  icon: const Icon(
                                    Icons.mode_edit_outline,
                                    size: 22,
                                  ))
                            ],
                          )
                        : Container(
                            padding: const EdgeInsets.all(8),
                            width: 170,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 235, 234, 233))),
                                onPressed: () {
                                  engineerBottomSheetModel();
                                },
                                child: const Text(
                                  "Assign",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                          )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Submitted by:"),
                    Text(
                      "Navin Antony",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Date Created:"),
                      Text(
                        DateFormat('MM-dd-yyyy HH:mm a')
                            .format(DateTime.now())
                            .toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20)
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Courtesy Job"),
                    Row(
                      children: [
                        const Text("Yes"),
                        Switch(
                          value: isSwitch,
                          onChanged: (value) {},
                          activeColor: Colors.green,
                          activeTrackColor: Colors.lightGreenAccent,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(31, 190, 190, 190),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(6)),
                        child: ExpansionTile(
                          childrenPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 3),
                          expandedCrossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          title: const Text(
                            'Access Instruction',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.white,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textIcon
                                    ? Text(accesController.text)
                                    : ReuseTextFields(
                                        width: 260,
                                        controller: accesController,
                                        inputfieldcolor: const Color.fromARGB(
                                            31, 197, 197, 197),
                                        maxLines: 5,
                                        minLines: 1,
                                        password: false,
                                        readOnly: false,
                                        showCursor: true,
                                        // color: const Color.fromARGB(255, 226, 72, 1),
                                        textAlign: TextAlign.start),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        textIcon = !textIcon;
                                      });
                                    },
                                    icon: textIcon
                                        ? const Icon(
                                            Icons.mode_edit_outline,
                                            size: 16,
                                          )
                                        : const Icon(
                                            Icons.check_sharp,
                                            color:
                                                Color.fromARGB(255, 230, 81, 0),
                                          ))
                              ],
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: Text(
                          "Pre-Completion Photos",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      imageFiles.isNotEmpty
                          ? GridView.count(
                              crossAxisCount: 5,
                              crossAxisSpacing: 10,
                              shrinkWrap: true,
                              children:
                                  List.generate(imageFiles.length, (index) {
                                return Stack(
                                  children: <Widget>[
                                    Image.file(
                                      imageFiles[index],
                                      fit: BoxFit.cover,
                                      scale: 1,
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: InkWell(
                                          child: const Icon(
                                            Icons.cancel,
                                            size: 15,
                                            color: Color.fromARGB(
                                                255, 196, 194, 194),
                                          ),
                                          onTap: () {
                                            //var imgId = imageId[index].toString;
                                            //deletedFile(imgId);
                                            setState(() {
                                              imageFiles.removeAt(index);
                                            });
                                          },
                                        ))
                                  ],
                                );
                              }),
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            )),
      ];

  mandatoryText(String text) {
    return RichText(
      text: TextSpan(
          text: text,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          children: const [
            TextSpan(text: '*', style: TextStyle(color: Colors.red))
          ]),
      textAlign: TextAlign.start,
    );
  }

  titleText(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Text(text)],
    );
  }

  reviewData(
      String tiText, infoText, bool iconVisiable, void Function()? onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tiText),
        Text(
          infoText ?? '_',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        iconVisiable
            ? IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.mode_edit_outline,
                  size: 22,
                ))
            : const SizedBox(
                width: 5,
              )
      ],
    );
  }

  briefDescripField(String descripText, TextEditingController descripTextcont) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        iconChange
            ? Text(
                descripText,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            : ReuseTextFields(
                width: 280,
                inputfieldcolor: Colors.white,
                minLines: 1,
                maxLines: 4,
                textAlign: TextAlign.left,
                password: false,
                readOnly: false,
                controller: descripTextcont,
              ),
        iconChange
            ? IconButton(
                onPressed: () {
                  setState(() {
                    iconChange = false;
                  });
                },
                icon: const Icon(
                  Icons.mode_edit_outline,
                  size: 22,
                ))
            : IconButton(
                onPressed: () {
                  setState(() {
                    iconChange = true;
                  });
                },
                icon: const Icon(
                  Icons.check,
                  size: 22,
                  color: Color.fromARGB(255, 247, 84, 9),
                ))
      ],
    );
  }

  detailDescripField(
      String descripText, TextEditingController descripTextcont) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textChange
            ? Text(
                descripText,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            : ReuseTextFields(
                width: 280,
                inputfieldcolor: Colors.white,
                minLines: 1,
                maxLines: 4,
                textAlign: TextAlign.left,
                password: false,
                readOnly: false,
                controller: descripTextcont,
              ),
        textChange
            ? IconButton(
                onPressed: () {
                  setState(() {
                    textChange = false;
                  });
                },
                icon: const Icon(
                  Icons.mode_edit_outline,
                  size: 22,
                ))
            : IconButton(
                onPressed: () {
                  setState(() {
                    textChange = true;
                  });
                },
                icon: const Icon(
                  Icons.check,
                  size: 22,
                  color: Color.fromARGB(255, 247, 84, 9),
                ))
      ],
    );
  }

  imageFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (image != null) {
      setState(() {
        imageFiles.add(File(image.path));
      });
      uploadImages();
    } else {
      return '';
    }
  }

  imageFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (image != null) {
      setState(() {
        imageFiles.add(File(image.path));
      });
      uploadImages();
    } else {
      return '';
    }
  }

  Future<void> uploadImages() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    FormData pictureFile = FormData();

    for (var i = 0; i < imageFiles.length; i++) {
      pictureFile.files.add(
          MapEntry('file', await MultipartFile.fromFile(imageFiles[i].path)));

      pictureFile.fields.add(const MapEntry('mime_type', 'image/PNG'));
      pictureFile.fields.add(const MapEntry('type', 'Pre Completion'));
      pictureFile.fields.add(const MapEntry('description', 'photo'));
      pictureFile.fields.add(const MapEntry('source', 'Job'));
    }
    dynamic id = await (CreateJobServices(
            service: Dio(BaseOptions(baseUrl: 'https://$baseurl1/v1/photos/')))
        .uploadDataCreateJobService(pictureFile));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    print(id['id']);
    dynamic cpyId = id['id'];
    print(cpyId);
    imageId.add(cpyId);
    // print(imageId);
  }

  Future<void> deletedFile(imgId) async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    await (CreateJobServices(
            service: Dio(
                BaseOptions(baseUrl: 'https://$baseurl1/v1/photos/$imgId/')))
        .deleteDataService());
    print(imgId);
  }

  nowDate() {
    return DateFormat("MM-dd-yyyy").format(DateTime.now());
  }

  Future<dynamic> uploadCreateJobData() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    var data = {
      "service_type": serviceTypeId,
      "type": "Regular",
      "request_type": "In Unit",
      "property": propertyId,
      "category": categoryId,
      "target_date": dateController.text,
      "description": briefDescripController.text,
      "asscess_jinstruction": accesController.text,
      "unit_entry_permission": false,
      "property_entry_permission": false,
      "skip_site_visit": false,
      "request_feedback_on_close": false,
      "request_auto_response": false,
      "skip_bid": false,
      "courtesy_job": false,
      "request_completion_photos": false,
      "_vendors": [],
      "followers": [],
      "engineers_required": false,
      "engineers": [engineersId],
      "photos": imageId,
      "pm_assingnee": managerId,
      "issue_type": detailDescripController.text,
      "priority": priorityId,
      "unit": locationId,
    };

    await (CreateJobServices(
            service: Dio(BaseOptions(baseUrl: 'https://$baseurl1/v1/jobs/')))
        .uploadDataCreateJobService(data));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  serviceBottomSheetModel() {
    return bottomsheetmodel("Service", serviceData!.length, (context, index) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.02,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide()),
            color: Color.fromARGB(255, 248, 246, 246),
          ),
          child: ListTile(
            title: Text(
              serviceData![index]['name'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            onTap: () {
              setState(() {
                serviceController.text = serviceData![index]['name'].toString();
                serviceTypeId = serviceData![index]['id'].toString();
              });

              Navigator.of(context).pop();
            },
          ));
    });
  }

  propertyBottomSheetModel() {
    return bottomsheetmodel("Property", propertyData!.length, (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
            //padding: const EdgeInsets.only(bottom: 5),
            width: MediaQuery.of(context).size.width * 0.02,
            decoration: const BoxDecoration(
              color: Color.fromARGB(31, 214, 213, 213),
            ),
            child: ListTile(
              title: Text(
                propertyData![index]['name'].toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                propertyData![index]['address'].toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 1,
              ),
              onTap: () {
                print(propertyData![index]['id']);
                setState(() {
                  propertyController.text =
                      propertyData![index]['name'].toString();
                  dynamic id = propertyData![index]['id'];
                  locationGetData(id);
                  categoryGetData(id);
                  managerGetData(id);
                  assignEnggGetData(id);
                  propertyId = id;
                });

                Navigator.of(context).pop();
              },
            )),
      );
    });
  }

  locationBottomSheetModel() {
    return bottomsheetmodel("Location", locationData!.length, (context, index) {
      //locatData = locationData![index]['units'];
      List<Map<String, dynamic>> unitData =
          locationData![index]['units'].cast<Map<String, dynamic>>();

      return Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: ListTile(
            title: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 248, 246, 246),
              ),
              child: Text(
                locationData![index]['address'].toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            subtitle: Column(
              children: unitData.map<Widget>((unit) {
                String? uniNam = unit['name'];
                String? uniTenNam =
                    unit['tenant'] != null ? unit['tenant']['name'] : '-';
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          uniNam!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                          maxLines: 1,
                        ),
                        Text(uniTenNam!,
                            style: const TextStyle(
                              fontSize: 12,
                            ))
                      ],
                    ),
                  ),
                  onTap: () {
                    address = locationData![index]['address'].toString();
                    unitName = uniNam;
                    unitTenantName = uniTenNam;

                    setState(() {
                      locationController.text =
                          '$address,$unitName,$unitTenantName';
                      locationId = unit['id'];
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ));
    });
  }

  categoryBottomSheetModel() {
    return bottomsheetmodel("Category", categoryData!.length, (context, index) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.02,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 248, 246, 246),
          ),
          child: ListTile(
            title: Text(
              categoryData![index]['name'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            onTap: () {
              setState(() {
                categoryController.text =
                    categoryData![index]['name'].toString();
                categoryId = categoryData![index]['id'];
              });

              Navigator.of(context).pop();
            },
          ));
    });
  }

  priorityBottomSheetModel() {
    return bottomsheetmodel("Priority", priorityData!.length,
        (contextd, index) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.02,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide()),
            //color: Color.fromARGB(255, 248, 246, 246),
          ),
          child: ListTile(
            title: Text(
              priorityData![index]['name'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            onTap: () {
              setState(() {
                priorityController.text =
                    priorityData![index]['name'].toString();
              });

              Navigator.of(context).pop();
            },
          ));
    });
  }

  managerBottomSheetModel() async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.13,
              maxChildSize: 0.9,
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return FutureBuilder(
                    //future: ,
                    builder: (context, snapshot) {
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListTile(
                            leading: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon:
                                    const Icon(Icons.arrow_back_ios_new_sharp)),
                            title: const Text(
                              "Assign Manager",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: searchEditingController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            contentPadding: EdgeInsets.only(
                                left: 10, top: 8.0, bottom: 8.0, right: 15.0),
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              managerName != null
                                  ? Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("Assigned($manNameCount)"),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 10),
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 186, 247, 217)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(managerName!),
                                              ),
                                              IconButton(
                                                  constraints:
                                                      const BoxConstraints(),
                                                  onPressed: () {
                                                    setState(() {
                                                      managerName = null;
                                                      manNameCount -= 1;
                                                    });
                                                  },
                                                  icon: const Icon(Icons.close))
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Unassigned",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                controller: scrollController,
                                shrinkWrap: true,
                                itemCount: managerData!.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      // decoration: const BoxDecoration(
                                      //   border: Border(bottom: BorderSide()),
                                      //   //color: Color.fromARGB(255, 248, 246, 246),
                                      // ),
                                      child: ListTile(
                                        title: Text(
                                          managerData![index]['full_name']
                                              .toString(),
                                          style: const TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            managerName = managerData![index]
                                                    ['full_name']
                                                .toString();
                                            manNameCount += 1;
                                            managerId = managerData![index]
                                                    ['id']
                                                .toString();
                                          });

                                          Navigator.of(context).pop();
                                        },
                                      ));
                                  ;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
              });
        });
  }

  engineerBottomSheetModel() async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.13,
              maxChildSize: 0.9,
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return FutureBuilder(
                    //future: ,
                    builder: (context, snapshot) {
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListTile(
                            leading: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon:
                                    const Icon(Icons.arrow_back_ios_new_sharp)),
                            title: const Text(
                              "Assign Engineer",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: searchEditingController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            contentPadding: EdgeInsets.only(
                                left: 10, top: 8.0, bottom: 8.0, right: 15.0),
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Assigned($engNameCount)"),
                              ],
                            ),
                            engineersName!.isNotEmpty
                                ? ListView.builder(
                                    itemCount: engineersName!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 10),
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 186, 247, 217)),
                                          child: ListTile(
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child:
                                                  Text(engineersName![index]),
                                            ),
                                            trailing: IconButton(
                                                constraints:
                                                    const BoxConstraints(),
                                                onPressed: () {
                                                  setState(() {
                                                    engineersName = null;
                                                    engNameCount -= 1;
                                                  });
                                                },
                                                icon: const Icon(Icons.close)),
                                          ));
                                    })
                                : const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "Unassigned",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.black,
                                  side: const BorderSide(
                                      width: 2, color: Colors.black),
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _isChecked = !_isChecked;
                                    });
                                  },
                                ),
                                const Text("No Engineer Required")
                              ],
                            ),
                            // ListBody(
                            //   children: widget.engineersData!.map((item)=>CheckboxListTile(value: engineersName!.contains(item), onChanged: (_isChecked)=>),),
                            // ),
                            ListView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              itemCount: engineersData!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Row(children: [
                                    Checkbox(
                                      checkColor: Colors.black,
                                      side: const BorderSide(
                                          width: 2, color: Colors.black),
                                      value: isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = !isChecked;
                                          engineersName!.add(
                                              engineersData![index]
                                                  ['full_name']);
                                        });
                                      },
                                    ),
                                    Text(
                                      engineersData![index]['full_name']
                                          .toString(),
                                      style: const TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ]),
                                  onTap: () {
                                    setState(() {
                                      isChecked = !isChecked;
                                      engNameCount += 1;
                                      engineersId = engineersData![index]['id'];
                                    });
                                  },
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ClickButton(
                                child: Text("Assign"),
                                onpressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                });
              });
        });
  }

  bottomsheetmodel(String titleText, int itemCount,
      Widget Function(BuildContext, int) itemBuilder) async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.13,
              maxChildSize: 0.9,
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return FutureBuilder(
                    //future: ,
                    builder: (context, snapshot) {
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListTile(
                            leading: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon:
                                    const Icon(Icons.arrow_back_ios_new_sharp)),
                            title: Text(
                              titleText,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: searchEditingController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            contentPadding: EdgeInsets.only(
                                left: 10, top: 8.0, bottom: 8.0, right: 15.0),
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: itemCount,
                          itemBuilder: itemBuilder,
                        ),
                      ),
                    ],
                  );
                });
              });
        });
  }

  void onClearTap() {
    searchEditingController.clear();
  }
}
