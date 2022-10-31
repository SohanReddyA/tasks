
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasks/SignUp.dart';
import 'package:tasks/Tasks.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'Login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return LoginMobile();
        },
      ),
    );
  }
}

class LoginMobile extends StatefulWidget {
  const LoginMobile({Key? key}) : super(key: key);

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  bool _isChecked = false;
  String email="", password="";
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 140, bottom: 60),
      child: SingleChildScrollView(
        child: SizedBox(
          // width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Login',
                style: GoogleFonts.inter(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 35),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value){
                  email=value;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'abc@example.com',
                  labelStyle: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value){
                  password=value;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: '********',
                  labelStyle: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              TextButton(
                onPressed: () async {
                  final newUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(newUser != null) {
                    Navigator.pushNamed(context, Tasks.id);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 15),TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.id);;
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                ),
                child: Text(
                  'Signup',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/google.png'),
                    const SizedBox(width: 8),
                    Text(
                      'Continue with Google',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onChanged(bool? value) {
    setState(() {
      _isChecked = value!;
    });
  }
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Color.fromRGBO(75, 75, 75, 1),
//         bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: Colors.blue[300],
//           items: [
//             BottomNavigationBarItem(
//               icon: Image.asset('Images/icons8-combo-chart-30.png'),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Image.asset('Images/icons8-lock-30.png'),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Image.asset('Images/icons8-clock-50.png'),
//               label: '',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// //
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         Expanded(
//           child: TextButton(
//             onPressed: () {
//               setState(() {
//                 change();
//               });
//             },
//             child: Image.asset('images/dice$lDN.png'),
//           ),
//         ),
//         Expanded(
//           child: TextButton(
//             onPressed: (){
//               setState(() {
//                 change();
//               });
//             },
//             child: Image.asset('images/dice$rDN.png'),
//           ),
//         ),
//       ],
//     );
//   }
// }


//Rem
// const SizedBox(height: 25),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Flexible(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SizedBox(
//                           height: 24,
//                           width: 24,
//                           child:
//                           Checkbox(value: _isChecked, onChanged: onChanged),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           'Remember me',
//                           style: GoogleFonts.inter(
//                             fontSize: 14,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 25),
//                   Flexible(
//                     child: Text(
//                       'Forgot password?',
//                       style: GoogleFonts.inter(
//                         fontSize: 14,
//                         color: const Color.fromARGB(255, 0, 84, 152),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),