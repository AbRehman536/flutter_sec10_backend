import 'package:flutter/material.dart';
import 'package:flutter_sec10_backend/views/get_all_task.dart';
import 'package:flutter_sec10_backend/views/registeration.dart';
import 'package:flutter_sec10_backend/views/reset_password.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../provider/user.dart';
import '../services/auth.dart';
import '../services/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(children: [
        TextField(controller: emailController,),
        TextField(controller: passwordController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await AuthServices().loginUser(
                    email: emailController.text.toString(),
                    password: passwordController.text.toString())
                    .then((val)async{
                  UserModel userModel = await UserServices()
                      .getUserByID(userProvider.getUser().docId.toString());
                  userProvider.setUser(userModel);
                  isLoading = false;
                  setState(() {});
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("${userModel.name.toString()} has been logged in"),
                    );
                  }, );
                });
              }catch(e){
                isLoading =false;
                setState(() {});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
        }, child: Text("Login")),
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Registeration()));
        }, child: Text("Register")),
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
        }, child: Text("Reset Password")),
      ],),
    );
  }
}
