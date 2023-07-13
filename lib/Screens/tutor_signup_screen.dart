import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_login_app/Controllers/firebase_controller.dart';

import 'package:firebase_login_app/Controllers/signup_controller%20copy.dart';

import 'package:flutter/material.dart';

import 'package:firebase_login_app/utils/colors_utils.dart';

import 'package:firebase_login_app/Components/widgets.dart';

import 'package:firebase_login_app/Screens/home_screen.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/services.dart';

import 'package:geolocator/geolocator.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';

import '../Constants/firestore.dart';

import 'package:path/path.dart';

// import 'package:geocoding/geocoding.dart';

// import 'package:location/location.dart' as device_location;

// import 'package:permission_handler/permission_handler.dart';

class TutorSignUpScreen extends StatefulWidget {
  String email;

  String username;

  String password;

  String location;

  String phone;

  TutorSignUpScreen(
      {super.key,
      required this.email,
      required this.username,
      required this.password,
      required this.location,
      required this.phone});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<TutorSignUpScreen> {
  static const List<String> subjectsList = <String>[
    'Arabic',
    'English',
    'Physics',
    'Biology',
    'Chemistry',
    'History',
    'Math'
  ];

  String subjectValue = subjectsList.first;

  static const List<String> experienceList = <String>[
    '1 Year',
    '2 Years',
    '3 Years',
    'More than 4 Years',
  ];

  String experienceValue = experienceList.first;

  static const List<String> degreeList = <String>[
    'Diploma',
    'Bachelor',
    'Master',
  ];

  String degreeValue = degreeList.first;

  bool isLoading = false;

  // device_location.LocationData? locationData;

  File? profile_image;

  var image_name;

  var image_url;

  Position? currentLocation;

  final imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();

    getLocation();
  }

  Future getLocation() async {
    bool services;

    LocationPermission permission;

    services = await Geolocator.isLocationServiceEnabled();

    if (services == false) {
      print(services);

      // AwesomeDialog(

      //         context: context,

      //         title: "services",

      //         body: const Text("Services not enabled"))

      //     .show();

    }

    permission = await Geolocator.checkPermission();

    print(permission);

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.whileInUse) {
        print("object");

        currentLocation = await getLatAndLong();

        print(currentLocation!.latitude);

        print(currentLocation!.longitude);
      } else if (permission == LocationPermission.always) {
        print("object");

        currentLocation = await getLatAndLong();

        print(currentLocation!.latitude);

        print(currentLocation!.longitude);
      }
    }

    if (permission == LocationPermission.whileInUse) {
      print("object");

      currentLocation = await getLatAndLong();

      print(currentLocation!.latitude);

      print(currentLocation!.longitude);
    } else if (permission == LocationPermission.always) {
      print("object");

      currentLocation = await getLatAndLong();

      print(currentLocation!.latitude);

      print(currentLocation!.longitude);
    }
  }

  getLatAndLong() async {
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

  Future<void> uploadPhoto() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      profile_image = File(pickedImage!.path);

      image_name = basename(pickedImage.path);
    });

    var refstorage = FirebaseStorage.instance.ref('images/$image_name');

    await refstorage.putFile(profile_image!);

    image_url = await refstorage.getDownloadURL();

    print('url: $url');
  }

  Future<void> updateProfileImage(String userId, String imageUrl) async {
    final userRef =
        FireBaseController().firebaseFirestore.collection('users').doc(userId);

    await userRef.update({'profileImage': imageUrl});
  }

  SignUpController signUpController = SignUpController();

  final TextEditingController _experienceTextController =
      TextEditingController();

  final TextEditingController _qualificationTextController =
      TextEditingController();

  final TextEditingController _subjectsTextController = TextEditingController();

  final TextEditingController _hourlyrateTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                hexStringToColor("CB2B93"),
                hexStringToColor("9546C4"),
                hexStringToColor("5E61F4")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.15, 20, 0),
                  child: Form(
                    key: signUpController.formState,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1))
                                ],
                                shape: BoxShape.circle,
                                image: profile_image == null
                                    ? const DecorationImage(
                                        image: NetworkImage(
                                            'https://i.pinimg.com/originals/58/51/2e/58512eb4e598b5ea4e2414e3c115bef9.jpg'),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        // image: NetworkImage(

                                        //     'https://i.pinimg.com/originals/58/51/2e/58512eb4e598b5ea4e2414e3c115bef9.jpg'),

                                        image: FileImage(profile_image!),

                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  color: Colors.blue,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    uploadPhoto();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 30,
                            child: Text("Experience",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                        ),

                        // getDropDownButton(

                        // context, experienceList, experienceValue),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DropdownButton<String>(
                            value: experienceValue,
                            dropdownColor:
                                const Color.fromARGB(255, 143, 65, 233),
                            iconEnabledColor: Colors.white,
                            icon: const Icon(Icons.subject_outlined),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            underline: Container(
                              height: 2,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.

                              setState(() {
                                experienceValue = value!;

                                print(experienceValue);
                              });
                            },
                            items: experienceList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),

                        // reusableTextFormField(

                        //   "Experience",

                        //   Icons.book_sharp,

                        //   false,

                        //   _experienceTextController,

                        //   '',

                        // ),

                        const SizedBox(
                          height: 20,
                        ),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 30,
                            child: Text("Degree",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                        ),

                        // reusableTextFormField(

                        //   "Qualification",

                        //   Icons.school_outlined,

                        //   false,

                        //   _qualificationTextController,

                        //   '',

                        // ),

                        // decoration: BoxDecoration(

                        //   color: Colors.white70,

                        // ),

                        // getDropDownButton(context, degreeList, degreeValue),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DropdownButton<String>(
                            value: degreeValue,
                            dropdownColor: Color.fromARGB(255, 143, 65, 233),
                            iconEnabledColor: Colors.white,
                            icon: const Icon(Icons.subject_outlined),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            underline: Container(
                              height: 2,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.

                              setState(() {
                                degreeValue = value!;

                                print(degreeValue);
                              });
                            },
                            items: degreeList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: const SizedBox(
                            height: 30,
                            child: Text("Subject",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                        ),

                        // getDropDownButton(context, subjectsList, subjectValue),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DropdownButton<String>(
                            value: subjectValue,
                            dropdownColor: Color.fromARGB(255, 143, 65, 233),
                            iconEnabledColor: Colors.white,
                            icon: const Icon(Icons.subject_outlined),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            underline: Container(
                              height: 2,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.

                              setState(() {
                                subjectValue = value!;

                                print(subjectValue);
                              });
                            },
                            items: subjectsList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),

                        // reusableTextFormField(

                        //     "subjects",

                        //     Icons.article_outlined,

                        //     false,

                        //     _subjectsTextController,

                        //     'phone'),

                        const SizedBox(
                          height: 20,
                        ),

                        reusableTextField('hourly rate', Icons.money_outlined,
                            _hourlyrateTextController),

                        const SizedBox(
                          height: 5,
                        ),

                        // FloatingActionButton.extended (

                        //   label: const Text("Get Location"),

                        //   onPressed: () async{

                        //     currentLocation = await getLatAndLong();

                        //     print("object");

                        //     print(currentLocation!.latitude);

                        //     print(currentLocation!.longitude);

                        //   },

                        //   elevation: 0,

                        // ),

                        firebaseUIButton(context, "Sign up", () async {
                          if (experienceValue.isNotEmpty &&
                              degreeValue.isNotEmpty &&
                              subjectValue.isNotEmpty &&
                              _hourlyrateTextController.text.isNotEmpty) {
                            UserCredential? response =
                                await signUpController.signUpTutor(
                                    context,
                                    widget.email,
                                    widget.username,
                                    widget.password,
                                    widget.location,
                                    widget.phone,
                                    'tutor',

                                    // _experienceTextController.text,

                                    experienceValue,
                                    degreeValue,

                                    // _subjectsTextController.text,

                                    subjectValue,
                                    double.parse(
                                        _hourlyrateTextController.text),
                                    image_url,
                                    currentLocation!.latitude.toString(),
                                    currentLocation!.longitude.toString());

                            print(response.toString());

                            if (response != null) {
                              print(response.user?.email);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            } else {
                              print("Response: " + response.toString());
                            }
                          } else {
                            showAlertDialog(context);
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget getDropDownButton(
      BuildContext context, List<String> list, String firstValue) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: DropdownButton<String>(
        value: firstValue,
        dropdownColor: Color.fromARGB(255, 143, 65, 233),
        iconEnabledColor: Colors.white,
        icon: const Icon(Icons.subject_outlined),
        elevation: 16,
        style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        underline: Container(
          height: 2,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.

          setState(() {
            firstValue = value!;

            print(firstValue);
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button

  Widget okButton = ElevatedButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog

  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: const Text("Please fill all fields"),
    actions: [
      okButton,
    ],
  );

  // show the dialog

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
