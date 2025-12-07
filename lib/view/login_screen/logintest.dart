import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login with Fingerprint',
      home: LoginPage(),
    );
  }
}

// کلاس کمکی بیومتریک
class BiometricHelper {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> canUseBiometric() async {
    return await auth.canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'برای ورود اثر انگشت خود را تأیید کنید',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      return didAuthenticate;
    } catch (e) {
      print('خطا در بیومتریک: $e');
      return false;
    }
  }
}

// صفحه Login
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final BiometricHelper bioHelper = BiometricHelper();
  bool canUseBio = false;

  @override
  void initState() {
    super.initState();
    checkBiometricAvailable();
  }

  void checkBiometricAvailable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool useBio = prefs.getBool("useBiometric") ?? false;

    if (useBio) {
      bool available = await bioHelper.canUseBiometric();
      setState(() {
        canUseBio = available;
      });
    }
  }

  void login() async {
    String username = _userController.text.trim();
    String password = _passController.text.trim();

    // برای مثال، پسورد ثابت: 1234
    if (username.isNotEmpty && password == "1234") {
      // ذخیره اجازه استفاده از بیومتریک
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("useBiometric", true);

      goToHome();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('نام کاربری یا رمز اشتباه است')));
    }
  }

  void loginWithBiometric() async {
    bool ok = await bioHelper.authenticate();
    print("ok");
    print(ok);
    if (ok) {
      goToHome();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('اثر انگشت معتبر نیست')));
    }
  }

  void goToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    canUseBio = true;
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text("Login")),
            SizedBox(height: 20),
            if (canUseBio)
              ElevatedButton.icon(
                onPressed: loginWithBiometric,
                icon: Icon(Icons.fingerprint),
                label: Text("ورود با اثر انگشت"),
              ),
          ],
        ),
      ),
    );
  }
}

// صفحه اصلی بعد از ورود
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(child: Text("Welcome!")),
    );
  }
}