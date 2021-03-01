import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor:  Colors.cyan
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var txtStudentName = TextEditingController();
  var txtStudentId = TextEditingController();
  var txtStudyProgramId = TextEditingController();
  var txtStudentGPA = TextEditingController();

  String studentName, studentId, studyProgramId;
  double studentGPA;

  getStudentName(name){
    this.studentName = name;
  }

  getStudentID(id){
    this.studentId = id;
  }

  getStudentProgramId(programId){
    this.studyProgramId = programId;
  }

  getStudentGPA(gpa){
    this.studentGPA = double.parse(gpa);
  }

  createData() async{
    await Firebase.initializeApp();
    print("Create");
    DocumentReference documentReference = FirebaseFirestore.instance.
    collection("MyStudents").doc(studentId);

    if(studentName == null || studentGPA == null || studyProgramId == null || studentId == null){
      Fluttertoast.showToast(
        msg: "Pls Input Data !",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        fontSize: 16,
        backgroundColor: Colors.black,
      );
    }else{
      Map<String, dynamic> students = {
        "studentName": studentName,
        "studentID": studentId,
        "studentProgramID": studyProgramId,
        "studentGPA":studentGPA
      };

      documentReference.set(students).whenComplete(() => {
        Fluttertoast.showToast(
          msg: "$studentName has created successful.",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          fontSize: 16,
          backgroundColor: Colors.black,
        )
      });
    }
  }

  readData(dynamic obj) async {
    await Firebase.initializeApp();
    DocumentReference documentReference = FirebaseFirestore.instance.
    collection("MyStudents").doc(obj["studentID"]);

    await documentReference.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        txtStudentName.text = obj["studentName"];
        txtStudentGPA.text = obj["studentGPA"].toString();
        txtStudentId.text = obj["studentID"];
        txtStudyProgramId.text = obj["studentProgramID"];
        studentId = obj["studentID"];
      });
    });
  }

  updateData() async {
    await Firebase.initializeApp();
    print("update");
    DocumentReference documentReference = FirebaseFirestore.instance.
    collection("MyStudents").doc(studentId);

    if(studentId == null){
      Fluttertoast.showToast(
        msg: "Pls Select Student !",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        fontSize: 16,
        backgroundColor: Colors.black,
      );
    }else{
      Map<String, dynamic> students = {
        "studentName": studentName,
        "studentID": studentId,
        "studentProgramID": studyProgramId,
        "studentGPA":studentGPA
      };

      documentReference.set(students).whenComplete(() => {
        Fluttertoast.showToast(
          msg: "$studentName has created successful.",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          fontSize: 16,
          backgroundColor: Colors.black,
        )
      });
    }
  }

  deleteData() async {
    await Firebase.initializeApp();
    DocumentReference documentReference = FirebaseFirestore.instance.
    collection("MyStudents").doc(studentId);

    if(studentId != null){
      documentReference.delete().whenComplete(() => {
        Fluttertoast.showToast(
          msg: "$studentName has delete successful.",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          fontSize: 16,
          backgroundColor: Colors.black,
        ),
        setState(() {
          txtStudentName.text = "";
          txtStudentGPA.text = "";
          txtStudentId.text = "";
          txtStudyProgramId.text = "";
          studentId = null;
        })
      });
    }else{
      Fluttertoast.showToast(
        msg: "Pls Select Student !",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        fontSize: 16,
        backgroundColor: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter CRUD with Firebase"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String name){
                  getStudentName(name);
                },
                controller: txtStudentName,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Student ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String id){
                  getStudentID(id);
                },
                controller: txtStudentId,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Student Program ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String programId){
                  getStudentProgramId(programId);
                },
                controller: txtStudyProgramId,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "GPA",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String gpa){
                  getStudentGPA(gpa);
                },
                controller: txtStudentGPA,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget> [
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text("Create"),
                  textColor: Colors.white,
                  onPressed: () {
                    createData();
                  },
                ),

                RaisedButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text("Update"),
                  textColor: Colors.white,
                  onPressed: () {
                    updateData();
                  },
                ),

                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text("Delete"),
                  textColor: Colors.white,
                  onPressed: () {
                    deleteData();
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Text("No."),flex: 1),
                  Expanded(child: Text("Name"),flex: 2),
                  Expanded(child: Text("StudentID"),flex: 2),
                  Expanded(child: Text("ProgramID"),flex: 2),
                  Expanded(child: Text("GPA"),flex: 1)
                ],
              ),
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("MyStudents").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot){
                    if(querySnapshot.hasError){
                      return Text("Error");
                    }
                    if(querySnapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }else{

                      final list = querySnapshot.data.docs;

                      return ListView.builder(
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Expanded(child: Text((index + 1).toString()),flex: 1),
                                  Expanded(child: Text(list[index]["studentName"]),flex: 2),
                                  Expanded(child: Text(list[index]["studentID"]),flex: 2),
                                  Expanded(child: Text(list[index]["studentProgramID"]),flex: 2),
                                  Expanded(child: Text(list[index]["studentGPA"].toString()),flex: 1)
                                ],
                              ),
                              onTap: () => readData(list[index]),
                            ),
                          );
                        },
                        itemCount: list.length,
                      );
                    }
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}


