import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kafe_app/Service/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Widget _title() {
    return const Text("Firebase Auth");
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    const mainColor = Color(0xff766C42);
    const secondColor = Color(0xffD8D8C1);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(
            color: mainColor,
            fontFamily: "Lato",
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: mainColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton() {
    const mainColor = Color(0xff766C42);
    const secondColor = Color(0xffD8D8C1);
    return SizedBox(
      width: MediaQuery.of(context).size.width, // <-- Your width
      height: 40, // <-- Your height
      child: ElevatedButton(
        onPressed: () {
          isLogin
              ? Auth(FirebaseAuth.instance).login(
                  email: _controllerEmail.text,
                  password: _controllerPassword.text)
              : Auth(FirebaseAuth.instance).register(
                  email: _controllerEmail.text,
                  password: _controllerPassword.text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
          foregroundColor: secondColor,
        ),
        child: Text(isLogin ? 'LOGIN' : 'REGISTER'),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    const mainColor = Color(0xff766C42);
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(
        isLogin ? 'Register instead' : 'Login instead',
        style: TextStyle(
          color: mainColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(48, 0, 48, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 135, 0, 135),
              child: Image.asset('assets/images/Logo_kafe.png'),
            ),
            _entryField('EMAIL', _controllerEmail),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: _entryField('PASSWORD', _controllerPassword),
            ),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}
