import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pad_app/services/database_service.dart';

import 'circular_material_spinner.dart';

class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  bool isLoading = false;
  final GlobalKey<FormState> addStudent = GlobalKey<FormState>();
  File selectedImage;
  final picker = ImagePicker();
  String age,
      studentClass,
      name,
      studentNumber,
      uploadedPicUrl,
      parentsNumber,
      status;
  final DatabaseService setData = DatabaseService();

  String fieldValidator(String value) {
    if (value.length < 3) {
      return 'Field cant be empty';
    } else {
      return null;
    }
  }

  Widget getImage() {
    if (selectedImage != null) {
      return Image.file(selectedImage, height: 200, fit: BoxFit.contain);
    } else {
      return Image.asset(
        'assets/placeholder.jpg',
        width: 200,
        height: 100,
        fit: BoxFit.cover,
      );
    }
  }

  Future takePhoto2() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }

  Future takePhoto1() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }

  uploadPic() async {
    String fileName = selectedImage.path;
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = storageReference.putFile(selectedImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    uploadedPicUrl = await storageReference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Form(
        key: addStudent,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Student Name'),
              onChanged: (value) {
                name = value;
              },
              validator: fieldValidator,
              keyboardType: TextInputType.name,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Age'),
                    onChanged: (value) {
                      age = value;
                    },
                    validator: (String value) {
                      if (value.length < 2) {
                        return 'Age cant be more than 99';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Class'),
                    onChanged: (value) {
                      studentClass = value;
                    },
                    validator: (String value) {
                      if (value.length < 1) {
                        return 'Field cant be empty';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Student Number'),
              onChanged: (value) {
                studentNumber = value;
              },
              validator: (String value) {
                if (value.length < 4) {
                  return 'should be four figures';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Parent\'s Number'),
              onChanged: (value) {
                parentsNumber = value;
              },
              validator: (String value) {
                if (value.length < 10) {
                  return 'Enter a valid phone number';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.phone,
            ),
            DropdownButton(
              items: <String>['Paid', 'Not paid'].map((String value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  status = value;
                });
              },
              isExpanded: false,
              value: status,
              hint: Text('Status'),
            ),
            getImage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.amber,
                    child: Text(
                      'Take a photo',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      takePhoto2();
                    }),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.amber,
                    child: Text(
                      'gallery photo',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      takePhoto1();
                    }),
              ],
            ),
            CircularMaterialSpinner(
              loading: isLoading,
              color: Colors.pink,
              child: MaterialButton(
                  color: Colors.pink,
                  minWidth: 250,
                  elevation: 10,
                  height: size.width / 10,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 1, fontSize: 18),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () async {
                    if (status == null) {
                      Fluttertoast.showToast(
                          msg: "Status can't be empty",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (selectedImage == null) {
                      _showDialog();
                    } else {
                      if (addStudent.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        uploadPic().whenComplete(() async {
                          dynamic result = await setData.addStudent(
                              name,
                              age,
                              studentClass,
                              studentNumber,
                              parentsNumber,
                              status,
                              uploadedPicUrl);
                          if (result == null) {
                            print(result);
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Check your internet connectivity",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Added $name successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.pop(context);
                          }
                        });
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!!!"),
          content: new Text("Please take or upload a photo"),
          actions: <Widget>[
            FlatButton(
              color: Colors.green,
              child: new Text("Close"),
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
