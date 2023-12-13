import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();

  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textFormField2 = TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: ' Full name *',
        hintText: "What people call you?",
        prefixIcon: Icon(Icons.person),
        suffix: Icon(
          Icons.delete_outline,
          color: Colors.red,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.black, width: 2.0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.purple.shade900, width: 2.0)),
      ),
      validator: _validateName,
    );
    var textFormField = textFormField2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Form"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            textFormField,
            SizedBox(height: 10.0),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: ' Phone Number *',
                hintText: 'Where can we reach you?',
                prefixIcon: Icon(Icons.call),
                helperText: ' Number format: (XXX)XXX-XXX',
                suffix: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide:
                        BorderSide(color: Colors.purple.shade900, width: 2.0)),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: ' Email Address',
                hintText: 'Enter your email address!',
                icon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(
                labelText: ' Life Story',
                hintText: 'Tell us about yourself...',
                helperText: ' Keep it short, it is just demo',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
            ),
            SizedBox(height: 10.0),
            TextFormField(
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: ' Password *',
                hintText: 'Enter the password',
                suffixIcon: IconButton(
                  icon:
                      Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                icon: Icon(Icons.security),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: ' Confirm Password *',
                hintText: 'Confirm the password',
                icon: Icon(Icons.border_color),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: _submitForm,
              child: Text('Select Form'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Form is valid');
      print('Name : ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email : ${_emailController.text}');
      print('Life Story : ${_storyController.text}');
    }
  }

  String? _validateName(String value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+ $');
    if (value.isEmpty) {
      return 'Name is required.';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters';
    } else {
      return null;
    }
  }
}
