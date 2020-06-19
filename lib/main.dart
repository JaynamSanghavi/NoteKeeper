import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/note_list.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  static Future<Widget> checkBio() async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if(canCheckBiometrics){
      return Auth();
    }else{
      return NoteList();
    }
  }
  
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      child: new FutureBuilder(
        future: checkBio(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!=null) {
              return MaterialApp(
                title: "Note Keeper",
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.purple
                ),
                home: snapshot.data,
              );
            } else {  
              return new CircularProgressIndicator();
            }
          }else {  
              return new CircularProgressIndicator();
          }
        }
      )
    );    
  }
}


class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  static final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _authorizedOrNot = "Not Authorized";

  _AuthState(){
    authorizeNow();
  }

  Future<void> authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to complete your transaction",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
        Navigator.push(context,MaterialPageRoute(builder: (context) => NoteList()));
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}

