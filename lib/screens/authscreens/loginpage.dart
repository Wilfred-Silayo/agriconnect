import 'package:flutter/material.dart';
import 'package:agriconnect/providers/userdata.dart';
import 'package:agriconnect/screens/authscreens/accounttypepage.dart';
import 'package:agriconnect/screens/authscreens/autfunctions.dart';
import 'package:agriconnect/screens/farmerhome.dart';
import 'package:agriconnect/screens/makeoderscreen.dart';
import 'package:agriconnect/utilities/constantscolors.dart';
import 'package:agriconnect/widgets/formfildone.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // String _email = '';
    // String _password = '';

    final _email = TextEditingController();
    final _password = TextEditingController();
    bool isLoading = false;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 4),
                  borderRadius: BorderRadius.circular(100)),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('assets/applogo.png'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: FormFieldOne(
              hintText: 'Barua pepe',
              textContoler: _email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 45,
              color: Colors.white,
              child: TextFormField(
                 obscureText: true,
                  controller: _password,
                decoration: InputDecoration(
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 2)),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 2)),
                   hintText: 'Neno la Siri',
                ),
              ),
            ),
          ),
          Center(
              child: InkWell(
            onTap: () async {
              setState(() {
                isLoading = true;
                _loadingIndicator(isLoading);
              });
              try {
                await AuthFunction()
                  //  .login(context, 'test@g.co', 'qq1234');
            .login(context, _email.text, _password.text);
              } catch (e) {
                
              }
              setState(() {
                isLoading = false;
              });
            },
            child: Container(
              width: 130,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.cyan,
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'Ingia',
                  style: TextStyle(
                      fontSize: ConstantsColors().textSizeOne,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          )),
          Container(
            height: 40,
            width: 78,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Hapana bado Sijajisajili  !"),
                TextButton(
                    onPressed: (() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SelectAccountType()));
                    }),
                    child: const Text(
                      'Jisajili',
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Loading Indicator

  _loadingIndicator(bool isactie) {
    if (isactie == true) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tafadhali Subiri'),
            content: Container(
              height: MediaQuery.of(context).size.height / 7,
              child: Center(
                  child: CircularProgressIndicator(
                color: ConstantsColors().mainColor(),
              )),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tafadhali Subiri'),
            content: Container(
              child: Text("Verify"),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
