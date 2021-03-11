import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}


class _MyHomeState extends State<MyHome> {

  bool isRememberMe = false;

  TextEditingController userid=new TextEditingController();
  TextEditingController password=new TextEditingController();

  String msg='';

  Future<List> _login() async {
    final response = await http.post(Uri.parse("http://10.0.2.2/login/login.php"),
        headers: {"Accept":"applicarion/json"},body: {
      "userid": userid.text,
      "password": password.text,
    });

    var datauser = json.decode(response.body);
    if (response.statusCode == 200) {
      print(datauser);
    } else {
      print(response.statusCode);
    }

    if(datauser.length==0){
      setState(() {
        msg="Login Fail";
      });
    }else {

      setState(() {
        msg = "Login Success";
      });
    }
    return datauser;
  }


  Widget buildUserID(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 6,
                    offset: Offset(0,2)
                )
              ]
          ),
          height: 60,
          child: TextField(
            controller:userid,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:10),
              suffixIcon: Icon(
                Icons.person,
                color: Colors.grey[600],
              ),
              hintText: ' User ID ',
              hintStyle: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPassword(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 6,
                    offset: Offset(0,2)
                )
              ]
          ),
          height: 60,
          child: TextField(
            controller: password,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:10),
              suffixIcon: Icon(
                Icons.lock,
                color: Colors.grey[600],
              ),
              hintText: ' Password ',
              hintStyle: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildForgotPassBtn(){
    return Row(
      children:<Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: FlatButton(
            onPressed: () => print("Forgot Password pressed"),
            padding: EdgeInsets.only(right: 0),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          child: Text('                              '),
        ),
        Container(
          alignment: Alignment.centerRight,
         child: Row(
         children: <Widget>[
          Theme(
          data: ThemeData(unselectedWidgetColor: Colors.grey),
          child: Checkbox(
          value: isRememberMe,
          checkColor: Colors.grey[600],
            activeColor: Colors.grey[600],
            onChanged: (value) {
            setState(() {
              isRememberMe = value;
            });
            },
          ),
          ),
           Text(
             'Remember Me',
             style: TextStyle(
               color: Colors.grey[600],
               fontWeight: FontWeight.bold,

             ),
           ),
          ],
          ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor:Colors.green[600],
      ),
      body: new Container(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 120,
          ),
          child: new Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image(image: AssetImage("assets/login.png"),
                // height:140.0,
                width:400.0,
                fit: BoxFit.cover,
              ),
              buildUserID(),
              buildPassword(),
              buildForgotPassBtn(),
              ButtonTheme(
                minWidth:400.0,
              child: RaisedButton(
                padding: const EdgeInsets.all(20),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text('Login'),
                color: Colors.green[500],
                onPressed: (){
                  _login();
                },
              ),
              ),
              Text(msg,style: TextStyle(fontSize: 20.0, color: Colors.red),),
            ],
          ),
        ),
      ),
    );
  }
}
