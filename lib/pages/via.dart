import 'package:flutter/material.dart';

void main() {
  runApp(
     Via());
}

class Via extends StatelessWidget {


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
                      '  FORGOT PASSWORD',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 187, 51),
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
               ),   
                 SizedBox(
                  height:30.0,
                 ) , 
                 Align(
                alignment: Alignment.centerLeft,
                 child: Text(
                      '       Select which contact details should we ' ,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 187, 51),
                        fontSize: 10.0,
                      ),
                    ),
               ), 
               Align(
                alignment: Alignment.centerLeft,
               child: Text(
                      '       use to reset your password',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 187, 51),
                        fontSize: 10.0,
                      ),
                    ),
               ),   
               SizedBox(
                  height:30.0,
                 ) ,  
                Card(
                  color: Colors.white,
                margin: EdgeInsets.only(left:10.0,right:20.0),
                child: ListTile(
                  leading: Icon(
                    Icons.sms,
                    color: Color.fromARGB(255, 255, 187, 51),
                     size: 30.0,
                  ),
                  title: Text(
                    'Via sms:',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: TextField(
                    decoration: InputDecoration(
                   hintText:  '.... .... 4235',
                    ),
                  ),
                ),
              ),
               SizedBox(
                  height:10.0,
                 ) ,
              Card(
                color: Colors.white,
                margin: EdgeInsets.only(left:10.0,right:20.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 255, 187, 51),
                     size: 30.0,
                  ),
                  title: Text(
                    'Via email:',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: TextField(
                    decoration: InputDecoration(
                   hintText:  '.... @gmail.com',
                    ),
                  ),
                ),
              ),
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