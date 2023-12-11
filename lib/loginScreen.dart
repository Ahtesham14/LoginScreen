import 'package:flutter/material.dart';
import 'package:login_screen/homeScreen.dart';
import 'package:login_screen/provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => authProvider.setEmail(value),
              decoration: InputDecoration(
                labelText: "Email/Username",
                errorText: authProvider.email.isEmpty ? "Field required" : null,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) => authProvider.setPassword(value),
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                errorText: authProvider.password.length < 6
                    ? "Password must be at least 6 characters"
                    : null,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _validateInputs(context),
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  void _validateInputs(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.email.isEmpty) {
      _showErrorDialog(context, "Email/Username is required");
    } else if (!_isEmailValid(authProvider.email)) {
      _showErrorDialog(context, "Please enter a valid email");
    } else if (authProvider.password.length < 6) {
      _showErrorDialog(context, "Password is too short");
    } else {
      _showSuccessDialog(context);
    }
  }

  bool _isEmailValid(String email) {
    // Simple email validation, you may want to use a package like email_validator
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Successful"),
          content: Text("Welcome to the Home screen!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to the Home screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
