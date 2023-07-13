import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextField reusableTextField(
    String text, IconData icon, TextEditingController controller) {
  return TextField(
    controller: controller,
    // obscureText: isPasswordType,
    // enableSuggestions: !isPasswordType,
    // autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    // keyboardType: isPasswordType
    //     ? TextInputType.visiblePassword
    //     : TextInputType.emailAddress,
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
  );
}

TextFormField reusableTextFormField(String text, IconData icon,
    bool isPasswordType, TextEditingController controller, String textType) {
  return TextFormField(
    validator: (value) {
      if (textType == 'username') {
        if (value!.length < 4) {
          print('username can not be less than 4 letters');
          return 'username can not be less than 4 letters';
        }
      } else if (textType == 'email') {
        if (value!.isEmpty) {
          return 'Please enter your email';
        }
        final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value!)) {
          return 'Please enter a valid email';
        }
      }
    },
    // onSaved: (newValue) {
    //   val = newValue!;
    // },
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

Stack topPortion(String title) {
  return Stack(
    children: [
      Container(
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            // bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(100),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 186, 0, 186),
              Color.fromARGB(255, 245, 188, 33)
            ],
          ),
        ),
      ),
      Positioned(
        top: 45,
        left: 10,
        child: Text(
          title,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    ],
  );
}
