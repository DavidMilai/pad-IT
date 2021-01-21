import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pad_app/services/database_service.dart';

import 'circular_material_spinner.dart';

class AddDonor extends StatefulWidget {
  @override
  _AddDonorState createState() => _AddDonorState();
}

class _AddDonorState extends State<AddDonor> {
  bool isLoading = false;
  final GlobalKey<FormState> addDonor = GlobalKey<FormState>();
  String donations, orgName, logoURL;
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
            TextFormField(
              decoration: InputDecoration(labelText: 'Image URL'),
              onChanged: (value) {
                logoURL = value;
              },
              validator: fieldValidator,
              keyboardType: TextInputType.emailAddress,
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
                    if (addDonor.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      dynamic result =
                          await setData.addDonor(donations, orgName, logoURL);
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
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
