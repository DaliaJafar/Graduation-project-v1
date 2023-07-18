import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Screens/usertype_screen.dart';
import 'package:flutter/material.dart';

import '../Controllers/firebase_controller.dart';
import '../Controllers/users_controller.dart';
import '../utils/colors_utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'tutors_list_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Scaffold(
          // appBar: AppBar(
          //   // actions: [
          //   //   IconButton(onPressed: signOutUser(context), icon: const Icon(Icons.logout))
          //   // ],
          //   title: Text('User Details'),
          //   automaticallyImplyLeading: false,
          // ),
          backgroundColor: Color(0xfff5f7fa),
          body: Column(children: [
            Stack(
              children: [
                Container(
                  height: size.height * .4,
                  width: size.width,
                ),
                GradientContainer(size),
                Positioned(
                    top: size.height * .15,
                    left: 30,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                            ),
                            child: FutureBuilder<DocumentSnapshot>(
                              future: getUserData(
                                  FirebaseAuth.instance.currentUser!.uid),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                        'Error occurred: ${snapshot.error}'),
                                  );
                                }

                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return Center(
                                    child: Text('User data not found.'),
                                  );
                                }

                                // User data exists
                                Map<String, dynamic> userData = snapshot.data!
                                    .data() as Map<String, dynamic>;

                                String name = userData['name'];
                               

                                return AnimatedTextKit(
                                  animatedTexts: [
                                    FadeAnimatedText('Hi ' + name),
                                    // FadeAnimatedText('do it RIGHT!!'),
                                    // FadeAnimatedText('do it RIGHT NOW!!!'),
                                  ],
                                  onTap: () {
                                    print("Tap Event");
                                  },
                                  isRepeatingAnimation: true,
                                );
                              },
                            ),
                          ),
                          Text(
                            "My Home",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 10, bottom: 5),
                          //   child: Text(
                          //     "Rooms",
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.w600,
                          //         fontSize: 17),
                          //   ),
                          // ),
                          // Row(children: [
                          //   CustomCard(size, context),
                          //   CustomCard(size, context),
                          //   CustomCard(size, context),
                          // ]),
                        ]))
              ],
            ),
            DevicesGridDashboard(size: size),
          ]));
    });
  }

  Container GradientContainer(Size size) {
    return Container(
      height: size.height * .3,
      width: size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        // image: DecorationImage(
        //     image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            gradient: LinearGradient(colors: [
              secondaryColor.withOpacity(0.9),
              primaryColor.withOpacity(0.9)
            ])),
      ),
    );
  }

  signOutUser(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const UserTypeScreen()),
        (route) => false);
  }
}

class DevicesGridDashboard extends StatelessWidget {
  const DevicesGridDashboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              "What do you want to study today ?",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardField(
                  size,
                  Colors.blue,
                  Icon(
                    Icons.science,
                    color: Colors.white,
                  ),
                  'Biology',
                  context),
              CardField(size, Colors.amber,
                  Icon(Icons.abc, color: Colors.white), 'English', context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardField(
                  size,
                  Colors.orange,
                  Icon(Icons.calculate_outlined, color: Colors.white),
                  'Math',
                  context),
              CardField(
                  size,
                  Colors.teal,
                  Icon(Icons.history_edu_outlined, color: Colors.white),
                  'History',
                  context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardField(
                  size,
                  Colors.purple,
                  Icon(Icons.psychology_sharp, color: Colors.white),
                  'Physics',
                  context),
              CardField(size, Colors.green,
                  Icon(Icons.book, color: Colors.white), 'Arabic', context),
            ],
          )
        ],
      ),
    );
  }
}

CardField(
    Size size, Color color, Icon icon, String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: GestureDetector(
      onTap: () {
        print(title);
        FireBaseController()
            .firebaseFirestore
            .collection('users')
            .where('role', isEqualTo: 'tutor')
            .where('subject', isEqualTo: title)
            .get()
            .then((value) {
          List<Map<String, dynamic>> tempList = [];

          value.docs.forEach((element) {
            tempList.add(element.data());
            print(element.data()['tutor_id']);
            // print('------------------------------');
          });

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TutorsList(
                  subject: title,
                  items: tempList,
                ),
              ));
        });
      },
      child: Card(
          child: SizedBox(
              height: size.height * .1,
              width: size.width * .39,
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color,
                    child: icon,
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  // subtitle: Text(
                  //   subtitle,
                  //   style: const TextStyle(
                  //       color: Colors.grey,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 13),
                  // ),
                ),
              ))),
    ),
  );
}
