import 'package:flutter/material.dart';
import 'package:inject_x/inject_x.dart';
import 'package:sqlite_wrapper_sample/services/registration_info_service.dart';

class RegistrationPage extends StatefulWidget {
  bool loginVersion;
  final VoidCallback onLogin;
  RegistrationPage(
      {super.key, required this.loginVersion, required this.onLogin});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: widget.loginVersion
              ? const Text('Login')
              : const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final regex = RegExp(r'^\S+@\S+\.\S+$');
                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => email = value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  final regex = RegExp(r'^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$');
                  if (!regex.hasMatch(value)) {
                    return 'Password must be at least 8 characters long and include a number';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => password = value),
              ),
              if (!widget.loginVersion)
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (password != value) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Process registration
                    await inject<RegistrationInfoService>().registerOrLogin(
                        email: email,
                        password: password,
                        login: widget.loginVersion);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Registration/Login successful')),
                      );
                    }
                    widget.onLogin();
                  }
                },
                child: widget.loginVersion
                    ? const Text('Login')
                    : const Text('Register'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.loginVersion = !widget.loginVersion;
                    });
                  },
                  child: widget.loginVersion
                      ? const Text('Switch to Register')
                      : const Text('Switch to Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
