import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_login_app/Controllers/reviews_controller.dart';

import 'package:firebase_login_app/Screens/profile.dart';

import 'package:flutter/material.dart';

 

import '../Models/tutor.dart';

 

class ProfilePage1Copy extends StatelessWidget {

  final Tutor tutorObject;

 

  const ProfilePage1Copy({required this.tutorObject, Key? key})

      : super(key: key);

 

  @override

  Widget build(BuildContext context) {

    List<ProfileInfoItem> items = [

      ProfileInfoItem(tutorObject.email, 'Email'),

      ProfileInfoItem(tutorObject.phone, 'Phone'),

      ProfileInfoItem(tutorObject.experience, 'Degree'),

      // ProfileInfoItem('4.5', "Reviews"), // Added "Reviews" item

    ];

    List<ProfileInfoItem> itemsTwo = [

      ProfileInfoItem(tutorObject.location, 'Location'),

      ProfileInfoItem(tutorObject.subject, 'Subject'),

      ProfileInfoItem("${tutorObject.hourly_rate}\$", "Hourly-Rate"),

    ];

    return Scaffold(

      body: Column(

        children: [

          Expanded(flex: 2, child: topPortion(tutorObject)),

          Expanded(

            flex: 3,

            child: Padding(

              padding: const EdgeInsets.all(8.0),

              child: Column(

                children: [

                  Text(

                    tutorObject.name,

                    style: Theme.of(context)

                        .textTheme

                        .headline6

                        ?.copyWith(fontWeight: FontWeight.bold),

                  ),

                  const SizedBox(height: 16),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      FloatingActionButton.extended(

                        onPressed: () {},

                        heroTag: 'follow',

                        elevation: 0,

                        backgroundColor: const Color.fromARGB(255, 186, 0, 186),

                        label: const Text("Request Session"),

                        icon: const Icon(Icons.schedule_send_outlined),

                      ),

                      const SizedBox(width: 16.0),

                      FloatingActionButton.extended(

                        onPressed: () {},

                        heroTag: 'mesage',

                        elevation: 0,

                        backgroundColor: Colors.yellow[700],

                        label: const Text("Message"),

                        icon: const Icon(Icons.message_rounded),

                      ),

                    ],

                  ),

                  const SizedBox(height: 16),

                  dataList(context, itemsTwo),

                  const SizedBox(height: 16),

                  DefaultTabController(

                    length: 2,

                    child: Expanded(

                      child: Column(

                        children: [

                          Container(

                            height: 35,

                            decoration: BoxDecoration(

                              color: Colors.grey[300],

                              borderRadius: BorderRadius.circular(10.0),

                            ),

                            child: TabBar(

                              indicator: BoxDecoration(

                                color: const Color.fromARGB(255, 186, 0, 186),

                                borderRadius: BorderRadius.circular(10.0),

                              ),

                              labelColor: Colors.white,

                              unselectedLabelColor: Colors.black,

                              tabs: const [

                                Tab(

                                  text: 'Contact',

                                ),

                                Tab(

                                  text: 'Reviews',

                                ),

                              ],

                            ),

                          ),

                          Expanded(

                            child: TabBarView(

                              children: [

                                info_tab(items),

                                reviewsTab(

                                  getReviews('LSqLdoxQNsZddl7tmNRnYPJSghx1'),

                                  tutorObject.id,

                                  context,

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

          ),

        ],

      ),

    );

  }

 

  Widget reviewsTab(

    Stream<QuerySnapshot> reviews,

    String tutorId,

    BuildContext context,

  ) {

    return StreamBuilder<QuerySnapshot>(

      stream: reviews,

      builder: (context, snapshot) {

        if (!snapshot.hasData) {

          return const CircularProgressIndicator();

        }

        final documents = snapshot.data!.docs;

        return Column(

          children: [

            Expanded(

              child: ListView.builder(

                itemCount: documents.length,

                itemBuilder: (context, index) {

                  final item = documents[index];

                  return GestureDetector(

                    onTap: () {

                      print('Grid Item $index tapped');

                    },

                    child: ListTile(

                      title: Padding(

                        padding: const EdgeInsets.all(3.0),

                        child: FutureBuilder<String>(

                          future: getStudentName(item),

                          builder: (context, snapshot) {

                            if (snapshot.connectionState ==

                                ConnectionState.waiting) {

                              return const Text('');

                            } else if (snapshot.hasData) {

                              return Text(

                                snapshot.data!,

                                style: const TextStyle(

                                  color: Colors.black,

                                  fontWeight: FontWeight.bold,

                                ),

                              );

                            } else if (snapshot.hasError) {

                              return Text('Error: ${snapshot.error}');

                            } else {

                              return const Text(

                                'student',

                              );

                            }

                          },

                        ),

                      ),

                      subtitle: Text(

                        item['comment'],

                        style: const TextStyle(

                          color: Colors.black,

                        ),

                      ),

                      tileColor: const Color.fromARGB(255, 254, 253, 254),

                      onTap: () {

                        print('List Item $index tapped');

                      },

                    ),

                  );

                },

              ),

            ),

            ElevatedButton(

              onPressed: () {

                showDialog(

                  context: context,

                  builder: (context) => AddReviewDialog(tutorId: tutorId),

                );

              },

              child: Text('Add a Review'),

            ),

          ],

        );

      },

    );

  }

 

  Widget topPortion(Tutor tutorObject) {

    return Stack(

      fit: StackFit.expand,

      children: [

        Container(

          margin: const EdgeInsets.only(bottom: 80),

          decoration: const BoxDecoration(

            gradient: LinearGradient(

              begin: Alignment.bottomCenter,

              end: Alignment.topCenter,

              colors: [

                Color.fromARGB(255, 186, 0, 186),

                Color.fromARGB(255, 245, 188, 33)

              ],

            ),

            borderRadius: BorderRadius.only(

              bottomLeft: Radius.circular(50),

              bottomRight: Radius.circular(50),

            ),

          ),

        ),

        // Positioned(

        //   top: 0,

        //   right: 0,

        //   child: Padding(

        //     padding: const EdgeInsets.all(8.0),

        //     child: IconButton(

        //       icon: const Icon(

        //         Icons.settings,

        //         color: Colors.white,

        //       ),

        //       onPressed: () {

        //         // Handle settings button tap

        //         print('Settings button tapped');

        //       },

        //     ),

        //   ),

        // ),

        Align(

          alignment: Alignment.bottomCenter,

          child: SizedBox(

            width: 120,

            height: 120,

            child: Stack(

              fit: StackFit.expand,

              children: [

                Container(

                  decoration: BoxDecoration(

                    color: Colors.black,

                    shape: BoxShape.circle,

                    image: DecorationImage(

                      fit: BoxFit.cover,

                      image: NetworkImage(tutorObject.profile_pic),

                    ),

                  ),

                ),

                // Positioned(

                //   bottom: 0,

                //   right: 0,

                //   child: Container(

                //     decoration: const BoxDecoration(

                //       color: Colors.yellow,

                //       shape: BoxShape.circle,

                //     ),

                //     child: IconButton(

                //       icon: const Icon(Icons.camera_alt),

                //       color: Colors.black,

                //       onPressed: () {

                //         // Handle camera button tap

                //         print('Camera button tapped');

                //       },

                //     ),

                //   ),

                // ),

              ],

            ),

          ),

        ),

      ],

    );

  }

 

  Widget info_tab(List<ProfileInfoItem> items) {

    return Expanded(

      child: ListView.builder(

        itemCount: items.length,

        itemBuilder: (context, index) {

          final item = items[index];

          return ListTile(

            title: Text(

              item.value,

              style: const TextStyle(

                color: Colors.black,

                fontSize: 14,

              ),

            ),

            subtitle: Text(

              item.title,

              style: const TextStyle(

                color: Colors.black,

                fontWeight: FontWeight.bold,

                fontSize: 16,

              ),

            ),

            tileColor: const Color.fromARGB(255, 254, 253, 254),

            onTap: () {

              print('List Item $index tapped');

            },

          );

        },

      ),

    );

  }

 

  Widget dataList(BuildContext context, List<ProfileInfoItem> itemsTwo) {

    return Container(

      height: 80,

      constraints: const BoxConstraints(maxWidth: 400),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: itemsTwo

            .map((item) => Expanded(

                  child: Row(

                    children: [

                      if (itemsTwo.indexOf(item) != 0) const VerticalDivider(),

                      Expanded(

                        child: item.title == 'Reviews'

                            ? _reviewsItem(context, item)

                            : _singleItem(context, item),

                      ),

                    ],

                  ),

                ))

            .toList(),

      ),

    );

  }

}

 

class AddReviewDialog extends StatefulWidget {

  final String tutorId;

 

  const AddReviewDialog({required this.tutorId});

 

  @override

  _AddReviewDialogState createState() => _AddReviewDialogState();

}

 

class _AddReviewDialogState extends State<AddReviewDialog> {

  double rating = 0.0;

  String feedback = '';

 

  @override

  Widget build(BuildContext context) {

    return AlertDialog(

      title: Text('Add a Review'),

      content: SingleChildScrollView(

        child: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text(

                  'Rating:',

                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

                ),

                Wrap(

                  spacing: -10,

                  children: List.generate(

                    5,

                    (index) => IconButton(

                      onPressed: () {

                        setState(() {

                          rating = index + 1.0;

                        });

                      },

                      icon: Icon(

                        Icons.star,

                        color: index < rating.floor()

                            ? Colors.yellow

                            : Colors.grey,

                      ),

                    ),

                  ),

                ),

              ],

            ),

            SizedBox(height: 16),

            TextField(

              onChanged: (value) {

                setState(() {

                  feedback = value;

                });

              },

              decoration: InputDecoration(

                labelText: 'Feedback',

                border: OutlineInputBorder(),

              ),

            ),

          ],

        ),

      ),

      actions: [

        TextButton(

          onPressed: () {

            Navigator.of(context).pop();

          },

          child: Text('Cancel'),

        ),

        TextButton(

          onPressed: () {

            print(widget.tutorId + " " + rating.toString() + " " + feedback+ " " + FirebaseAuth.instance.currentUser!.uid);

            addReview(widget.tutorId, rating, feedback, FirebaseAuth.instance.currentUser!.uid

                // getStudentId(item)

                );

            // Save the review data to Firestore using reviews_controller.dart

            // ReviewsController.addReview(

            //   widget.tutorId,

            //   rating,

            //   feedback,

            // );

 

            Navigator.of(context).pop();

          },

          child: Text('Submit'),

        ),

      ],

    );

  }

}

class ProfileInfoItem {

  final String value;

  final String title;

 

  ProfileInfoItem(this.title, this.value);

}

 

Widget _reviewsItem(BuildContext context, ProfileInfoItem item) {

  return GestureDetector(

    onTap: () {

      // Handle reviews item tap

      print('Reviews item tapped');

    },

    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        Text(

          item.value,

          style: Theme.of(context)

              .textTheme

              .subtitle1

              ?.copyWith(fontWeight: FontWeight.bold),

        ),

        const SizedBox(height: 4),

        Text(

          item.title,

          style:

              Theme.of(context).textTheme.caption?.copyWith(color: Colors.grey),

        ),

      ],

    ),

  );

}

 

Widget _singleItem(BuildContext context, ProfileInfoItem item) {

  return GestureDetector(

    onTap: () {

      // Handle item tap

      print('${item.title} item tapped');

    },

    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        Text(

          item.value,

          style: Theme.of(context)

              .textTheme

              .subtitle1

              ?.copyWith(fontWeight: FontWeight.bold),

        ),

        const SizedBox(height: 4),

        Text(

          item.title,

          style:

              Theme.of(context).textTheme.caption?.copyWith(color: Colors.grey),

        ),

      ],

    ),

  );

}

 

Future<String> getStudentName(DocumentSnapshot item) async {

  final data = item.data() as Map<String, dynamic>?;

 

  if (data != null && data.containsKey('studentId')) {

    final studentId = data['studentId'] as String?;

    if (studentId != null) {

      final studentSnapshot = await FirebaseFirestore.instance

          .collection('students')

          .doc(studentId)

          .get();

      final studentData = studentSnapshot.data() as Map<String, dynamic>?;

      if (studentData != null && studentData.containsKey('name')) {

        return studentData['name'] as String;

      }

    }

  }

 

  return 'Unknown Student';

}

 

Future<String?> getStudentId(DocumentSnapshot item) async {

  final data = item.data() as Map<String, dynamic>?;

 

  if (data != null && data.containsKey('studentId')) {

    return data['studentId'] as String?;

  }

 

  return null;

}