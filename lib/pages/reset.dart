import 'package:flutter/material.dart';

void main() {
  runApp( Reset());
}
class PasswordVisibilityToggle extends StatefulWidget {
  @override
  _PasswordVisibilityToggleState createState() => _PasswordVisibilityToggleState();
}

class _PasswordVisibilityToggleState extends State<PasswordVisibilityToggle> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.black,
      ),
      onPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
    );
  }
}
class Reset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: Scaffold(
           resizeToAvoidBottomInset : false,
           backgroundColor: Colors.white,
           body: SafeArea(
             child: Container(
            padding: EdgeInsets.only(top: 20.0, left: 20.0),
            alignment: Alignment.topLeft,
          child: Column(           
            children: [
               Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child:  Icon(
                      Icons.chevron_left,
                      color: Color.fromARGB(255, 255, 187, 51),
                      size: 30.0,
                    ),
                ),
              ),
               SizedBox(
                  height:10.0,
                 ) , 
               Align(
                alignment: Alignment.centerLeft,
                 child: Text(
                      '  RESET YOUR PASSWORD\n  HERE',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 187, 51),
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
               ),   
                 SizedBox(
                  height:60.0,
                 ) ,  
                   Card(
                  color: Colors.white,
                margin: EdgeInsets.only(left:10.0,right:20.0),
                child: ListTile(
                  title: TextField(
                    decoration: InputDecoration(
                    hintText:'New Password',
                  ),
                  ),
                  trailing:PasswordVisibilityToggle(), 
                ),
              ),
               SizedBox(
                  height:10.0,
                 ) ,
                  Card(
                  color: Colors.white,
                margin: EdgeInsets.only(left:10.0,right:20.0),
                child: ListTile(
                  title: TextField(
                    decoration: InputDecoration(
                    hintText:'Confirm Password',
                  ),
                  ),
                  trailing:PasswordVisibilityToggle(), 
                ),
              ),
               SizedBox(
                  height:10.0,
                 ) ,
                 Padding(
  padding: EdgeInsets.only(top: 100.0, left: 20.0,right:25.0), 
      child: Align(
  alignment: Alignment.center,
  child: Padding(
    padding: EdgeInsets.zero,
    child: Card(
       color: Color.fromARGB(255, 255, 187, 51),
      child: ListTile(
        title: Text(
          'Confirm',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, 
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            
          ),
        ),
      ),
    ),
  ),
), 
      ),
            ],
          ),
             ),
             ),
             ),
             );
  }
}