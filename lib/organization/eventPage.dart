import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sa3dni_app/models/event.dart';
import 'package:sa3dni_app/services/databaseServiceEvent.dart';
import 'package:sa3dni_app/shared/constData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  String title = '';
  String location = '';
  String description = '';
  var date = DateTime.now();
  var time = TimeOfDay.now();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key:  formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                     TextFormField(
                      decoration: const InputDecoration(
                        hintText: "  Add Title",
                      ),
                       onChanged: (value) => {
                         setState((){
                           title = value;
                         })
                       },
                                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(children: [
                      GestureDetector(
                        child: Icon(
                          Icons.date_range,
                          size: 30.0,
                          color: ConstData().basicColor,
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey[300],
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(
                            DateFormat.yMd().format(date).toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ))
                    ]),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(children: [
                      GestureDetector(
                        child: Icon(
                          Icons.access_time_outlined,
                          size: 30.0,
                          color: ConstData().basicColor,
                        ),
                        onTap: () {
                          _selectTime(context);
                        },
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey[300],
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(
                            MaterialLocalizations.of(context)
                                .formatTimeOfDay(time),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ))
                    ]),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 30.0,
                        color: ConstData().basicColor,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                       Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "  Add Location",
                            ),
                            onChanged: (value) => {
                              setState((){
                                location = value;
                              })
                            },
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Icon(
                        Icons.description,
                        size: 30.0,
                        color: ConstData().basicColor,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                       Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "  Add description",
                            ),
                            onChanged: (value) => {
                              setState((){
                                description = value;
                              })
                            },
                          ),
                        ),
                      ),
                    ]),
                   const SizedBox(height: 30,),
                    RaisedButton(
                      onPressed: () async{
                    var result =  await  DatabaseServiceEvent().addEvent(
                             OrganizationEvent(organizationID: FirebaseAuth.instance.currentUser!.uid,
                                title: title,
                                date: date,
                                time: time,
                                location: location,
                                description: description));
                      if(result != null){
                        Fluttertoast.showToast(
                            msg: "Event Added Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        formKey.currentState?.reset();
                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "Something happened wrong",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      },
                      child: const Text('Add Event',
                          style: TextStyle(color: Colors.white)),
                      color: ConstData().basicColor,)
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != date)
      setState(() {
        date = pickedDate;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != date)
      setState(() {
        time = pickedTime;
      });
  }
}
