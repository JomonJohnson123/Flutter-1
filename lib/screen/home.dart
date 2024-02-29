import 'package:flutter/material.dart';
import 'package:flutter_application_2222/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key})
      : super(key: key); // Fixed the syntax for super key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 14, 67),
        title: const Text(
          'Home',
          style: TextStyle(color: Color(24 - 31)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                signout(context);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Color.fromARGB(255, 231, 247, 245),
              ))
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: 21,
          itemBuilder: (ctx, index) {
            // Moved SeparatorBuilder and itemCount to the correct place
            Widget avatar;
            if (index % 2 == 0) {
              avatar = const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('.idea/assets/images/profile2.jpg'),
              );
            } else {
              avatar = Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('.idea/assets/images/60111.jpg'),
                  ),
                ),
              );
            }
            return ListTile(
              title: Text('Person $index'),
              subtitle: Text('Massage $index'),
              leading: avatar,
              trailing: Text('1$index:00PM'),
            );
          },
          separatorBuilder: (ctx, index) =>
              const Divider(), // Corrected SeparatorBuilder
        ),
      ),
    );
  }

  Future<void> signout(BuildContext ctx) async {
    // Corrected return type to Future<void>
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();

    // ignore: use_build_context_synchronously
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the alert dialog

                // Clear shared preferences
                await SharedPreferences.getInstance()
                    .then((prefs) => prefs.clear());

                // Navigate to login screen
                // ignore: use_build_context_synchronously
                Navigator.of(ctx).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx1) => ScreenLogin()),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
