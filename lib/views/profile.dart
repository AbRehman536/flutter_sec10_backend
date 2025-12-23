import 'package:flutter/material.dart';
import 'package:flutter_sec10_backend/provider/user.dart';
import 'package:flutter_sec10_backend/views/update_profile.dart';
import 'package:provider/provider.dart';

class GetProfile extends StatelessWidget {
  const GetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(children: [
        Text("Name : ${userProvider.getUser().name.toString()}", style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w800),),
        Text("Email : ${userProvider.getUser().email.toString()}", style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w800),),
        Text("Address : ${userProvider.getUser().address.toString()}", style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w800),),
        Text("Phone : ${userProvider.getUser().phone.toString()}", style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w800),),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfile()));
        }, child: Text("Update Profile"))
      ],),
    );
  }
}
