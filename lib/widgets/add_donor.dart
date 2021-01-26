import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pad_app/services/database_service.dart';

import 'circular_material_spinner.dart';

class AddDonor extends StatefulWidget {
  @override
  _AddDonorState createState() => _AddDonorState();
}

class _AddDonorState extends State<AddDonor> {
  bool isLoading = false;
  final GlobalKey<FormState> addDonor = GlobalKey<FormState>();
  String donations, orgName, uploadedPicUrl;
  File selectedImage;
  final picker = ImagePicker();
  final DatabaseService setData = DatabaseService();

  uploadPic() async {
    String fileName = selectedImage.path;
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = storageReference.putFile(selectedImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    uploadedPicUrl = await storageReference.getDownloadURL();
  }

  Widget getImage() {
    if (selectedImage != null) {
      return Image.file(selectedImage, height: 200, fit: BoxFit.contain);
    } else {
      return Image.asset(
        'assets/placeholder.jpg',
        width: 250,
        height: 150,
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

  String fieldValidator(String value) {
    if (value.length < 2) {
      return 'Field cant be empty';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Form(
        key: addDonor,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Organization Name'),
              onChanged: (value) {
                orgName = value;
              },
              validator: fieldValidator,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Donations'),
              onChanged: (value) {
                donations = value;
              },
              validator: fieldValidator,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
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
                    if (selectedImage != null) {
                      if (addDonor.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        uploadPic().whenComplete(() async {
                          dynamic result = await setData.addDonor(
                              donations, orgName, uploadedPicUrl);
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
                                msg: "Added $orgName successfully",
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
                    } else {
                      _showDialog();
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
