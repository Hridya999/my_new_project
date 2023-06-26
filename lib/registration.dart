import 'package:flutter/material.dart';

class Reg extends StatelessWidget {
  const Reg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Register(),
    );
  }
}
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/R.jpg"),
                  ),
                  SizedBox(height: 50),
                  Text("Sign up Now",style: TextStyle(
                      fontSize: 34,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold
                  ),),
                  Text("Please fill the details and create account"),
                  SizedBox(height: 50,),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Fullname",hintText:"Fullname",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        )
                    ),
                  ),
                  SizedBox(height: 50,),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Email",hintText:"Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        )
                    ),
                  ),
                  SizedBox(height: 50,),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Password",hintText:"Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                        suffixIcon:IconButton(
                          icon: Icon(Icons.visibility_off), onPressed: () {},

                        )
                    ),
                  ),
                  Align(
                    alignment:Alignment.centerLeft ,
                  ),
                  Text("Password must be atleast 6 character"),
                  SizedBox(height: 50,),
                  SizedBox(height: 35,width: 300,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                        ),onPressed: () {},child: Text("Log In")
                    ),
                  ),
                  Text("Already have an account? Log In")
                ],
              ),
            ),
          ),
        )
    );
  }
}