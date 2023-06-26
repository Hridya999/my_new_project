import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:jalanidhi/login.dart';
import 'package:jalanidhi/user/Connection_payment.dart';
import 'package:path/path.dart';

import 'api.dart';

class reg2 extends StatefulWidget {
  const reg2({Key? key}) : super(key: key);

  @override
  State<reg2> createState() => _reg2State();
}

enum Gender { male, female, other }

class _reg2State extends State<reg2> {
  Gender? _gen = Gender.male;
  var children;
  Gender? gender;
  String? categ;

  late final _filename;
  String dropdownvalue = 'Select Panchayath';
  File? imageFile;
  // List of items in our dropdown menu
  var items = [
    'Select Panchayath',
    'Grama panchayath',
    'Jilla panchayath',
    'Block panchayath',
  ];
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),
                  SizedBox(height: 10),
                  const Padding(padding: EdgeInsets.all(0.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();

                      Navigator.pop(context);
                      //   _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  File? imagefile;
    print(request.fields);
    final imageStream = http.ByteStream(imageFile!.openRead());
    final imageLength = await imageFile!.length();

    final multipartFile = await http.MultipartFile(
      'category_proof',imageStream,imageLength,
      filename: _filename ,
      // contentType: MediaType('image', 'jpeg'), // Replace with your desired image type
    );
    print(_filename);
    request.files.add(multipartFile);

    final response = await request.send();
    print(response);

    if (response.statusCode == 201) {
      print('Form submitted successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Payment()));
    } else {
      print('Error submitting form. Status code: ${response.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTRATION"),
      ),
      body: ListView(children: [
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(

              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                ),
                SizedBox(height: 30),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Field can't be empty";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Consumer Name",
                    hintText: "name",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Field can't be empty";
                    }
                  },
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: "House name",
                    hintText: "house name",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onTap: () async{
                            DateTime? pickedDate= await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1890),
                                lastDate: DateTime(2100)
                            );
                            if(pickedDate!=null){
                              datecontroller.text=
                                  DateFormat('yyy-MM-dd').format(pickedDate);
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range),
                            hintText: "DOB",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Field can't be empty";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "House no",
                    hintText: "house no",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Field can't be empty";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Aadhaar no",
                    hintText: "aadhaar no",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Field can't be empty";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "email",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Align(
                      alignment: Alignment.centerLeft, child: Text("Gender *")),
                ),
                ListTile(
                  title: const Text('Male'),
                  leading: Radio<Gender>(
                    value: Gender.male,
                    groupValue: _gen,
                    onChanged: (Gender? value) {
                      setState(() {
                        _gen = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Female'),
                  leading: Radio<Gender>(
                    value: Gender.female,
                    groupValue: _gen,
                    onChanged: (Gender? value) {
                      setState(() {
                        _gen = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Other'),
                  leading: Radio<Gender>(
                    value: Gender.other,
                    groupValue: _gen,
                    onChanged: (Gender? value) {
                      setState(() {
                        _gen = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Field can't be empty";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Pincode",
                    hintText: "pin",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Field can't be empty";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Phone no",
                      hintText: "phone",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.maxFinite,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black38),
                  ),
                  child: DropdownButton(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(items),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Field can't be empty";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Panchayath name",
                      hintText: "name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Field can't be empty";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Ward no",
                      hintText: "ward no",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text("APL"),
                          value: "Apl",
                          groupValue: categ,
                          onChanged: (value) {
                            setState(() {
                              categ = value.toString();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text("BPL"),
                          value: "Bpl",
                          groupValue: categ,
                          onChanged: (value) {
                            setState(() {
                              categ = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(children: [
                  Container(),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Container(
                        child: imageFile == null
                            ? Container(
                          child: Column(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  //    _getFromGallery();
                                  _showChoiceDialog(context);
                                },
                                child: Text("Upload Image"),
                              ),
                              Container(
                                height: 40.0,
                              ),
                            ],
                          ),
                        )
                            : Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.file(
                                imageFile!,
                                width: 100,
                                height: 100,
                                //  fit: BoxFit.cover,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                //    _getFromGallery();
                                _showChoiceDialog(context);
                              },
                              child: Text("Upload Image"),
                            ),
                          ],
                        ),

                      ),
                    ],
                  ),
                ]),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Field can't be empty";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "username",
                      hintText: "username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Field can't be empty";
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "password",
                      hintText: "password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                SizedBox(height: 30),
                SizedBox(width: 150,
                    height: 50,
                    child: ElevatedButton(onPressed: () {
                    },
                      child:
                      Text("APPLY"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80)),
                        // padding: EdgeInsets.all(30),
                      ),
                    )

                ),
                SizedBox(height: 5,),


              ],
              ),
            )
        ),
      ]
      ),
    );

  }
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(()  {

        imageFile = File(pickedFile.path);
        _filename = basename(imageFile!.path);
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);
        print("imageFile:${imageFile}");
        print(_filename);
        print(_nameWithoutExtension);
        print(_extenion);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        //  _filename = basename(imageFile!.path).toString();
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);
      });
    }
  }
}
