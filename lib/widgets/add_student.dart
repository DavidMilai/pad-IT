import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pad_app/services/database_service.dart';

import 'circular_material_spinner.dart';

class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  bool isLoading = false;
  final GlobalKey<FormState> addStudent = GlobalKey<FormState>();
  String age, studentClass, name, studentNumber, parentsNumber, photo, status;
  final DatabaseService setData = DatabaseService();

  String fieldValidator(String value) {
    if (value.length < 3) {
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
            SizedBox(height: 5),
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
            SizedBox(height: 5),
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
            SizedBox(height: 5),
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
            SizedBox(height: 5),
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
                    } else {
                      if (addStudent.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        dynamic result = await setData.addStudent(
                            name,
                            age,
                            studentClass,
                            studentNumber,
                            parentsNumber,
                            status,
                            photo);
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
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
