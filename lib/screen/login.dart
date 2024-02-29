import 'package:flutter/material.dart';
import 'package:flutter_application_2222/main.dart';
import 'package:flutter_application_2222/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final usernameControler = TextEditingController();
  final passwordControler = TextEditingController();
  bool isDataMatched = true;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Color(24 - 31)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 27, 80),
      ),
      body: Stack(
        children: [
          // Background image..
          Positioned.fill(
            child: Image.asset(
              '.idea/assets/images/v915-wit-011-f.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 1000,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          controller: usernameControler,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Username'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Username';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: passwordControler,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Password';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: !isDataMatched,
                              child: const Text(
                                'Username Password doesnot match',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  checkLogin(context);
                                } else {
                                  // print('Data is Empty');
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color.fromARGB(255, 1, 18, 74)),
                                foregroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromARGB(255, 254, 254, 254)),
                              ),
                              icon: const Icon(Icons.check),
                              label: const Text('Login'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final username = usernameControler.text;
    final password = passwordControler.text;

    //USe User name and password.
    const validUsername = 'jomon';
    const validPassword = '12345';
    if (username == validUsername && password == validPassword) {
      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setBool(saveName, true);

      // ignore: use_build_context_synchronously
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => const Homepage()));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Username or Password is incorrect'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
