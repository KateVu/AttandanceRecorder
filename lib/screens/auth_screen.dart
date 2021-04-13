import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record_attendance/data/http_exception.dart';
import 'package:record_attendance/providers/auth.dart';
import '../data/img.dart';
import '../data/my_colors.dart';
import '../widgets/my_text.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  AuthScreen();

  @override
  _AuthScreenState createState() => _AuthScreenState();
}


class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: Container(color: MyColors.primary)),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(color: MyColors.primary, height: 220),
            Column(
              children: <Widget>[
                Container(height: 40),
                Container(
                  child: Image.asset(
                    Img.get('swinburnelogo.png'),
                    // color: Colors.white,
                  ),
                  width: 100, height: 100,
                ),
                Card(
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(6)),
                    margin: EdgeInsets.all(25),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child :  Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 25),
                            Text("SIGN IN", style: MyText.title(context).copyWith(
                                color: Colors.green[500], fontWeight: FontWeight.bold
                            )),
                            // TextField(
                            //   keyboardType: TextInputType.text,
                            //   style: TextStyle(color: Colors.white),
                            //   decoration: InputDecoration(labelText: "Email",
                            //     labelStyle: TextStyle(color: Colors.blueGrey[400]),
                            //     enabledBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.blueGrey[400], width: 1),
                            //     ),
                            //     focusedBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.blueGrey[400], width: 2),
                            //     ),
                            //   ),
                            // ),

                            TextFormField(
                              // decoration: InputDecoration(labelText: 'E-Mail'),
                              decoration: InputDecoration(labelText: "Email",
                                labelStyle: TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueGrey[400], width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueGrey[400], width: 2),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Invalid email!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['email'] = value;
                              },
                            ),

                            SizedBox(height: 25),
                            // TextField(
                            //   keyboardType: TextInputType.text,
                            //   style: TextStyle(color: Colors.white),
                            //   decoration: InputDecoration(labelText: "Password",
                            //     labelStyle: TextStyle(color: Colors.blueGrey[400]),
                            //     enabledBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.blueGrey[400], width: 1),
                            //     ),
                            //     focusedBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.blueGrey[400], width: 2),
                            //     ),
                            //   ),
                            // ),

                            TextFormField(
                              // decoration: InputDecoration(labelText: 'Password'),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(labelText: "Password",
                                labelStyle: TextStyle(color: Colors.blueGrey[400]),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueGrey[400], width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueGrey[400], width: 2),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password can not be empty!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                            ),

                            Container(height: 25),
                            if (_isLoading)
                              CircularProgressIndicator()
                            else
                              Container(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: MyColors.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                ),
                                child: Text("SUBMIT", style: TextStyle(color: Colors.white),),
                                onPressed: _submit,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                )
              ],
            )
          ],
        ),
      ),

    );
  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

}

