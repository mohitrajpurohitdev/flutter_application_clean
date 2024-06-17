import 'package:flutter/material.dart';

class StoreDetails extends StatefulWidget {
  const StoreDetails({super.key});

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  TextEditingController storeName = TextEditingController();
  String? storeType;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  final _formkey = GlobalKey<FormState>();

  Future selectTime() async {
    var pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null && pickedTime != _startTime) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  submitForm(){
    if(_formkey.currentState?.validate()??false){
      if(_startTime == null || _endTime == null){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("time should not be null")));
   
      }
      print("form is validated");
      if(_startTime!.hour < _endTime!.hour  ){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("time should be greatter")));
      }
    }
  }

  Future endselectTime() async {
    var pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null && pickedTime != _endTime) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const Text("Enter Store details"),
              TextFormField(
                controller: storeName,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Enter Value";
                  }
                },
              ),
              DropdownButtonFormField(
                value:storeType ,
                  items: const [
                   DropdownMenuItem(
                      child: Text("type one"),
                      value: "type one",
                    ),
                    DropdownMenuItem(
                      child: Text("type two"),
                      value: "type two",
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      storeType = value ?? "type one";
                    });
                  },
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "select a value";
                    }
                  },
                  
                  ),
              InkWell(
                  onTap: selectTime,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Text("Start time ${_startTime}"),
                  )),
              InkWell(
                  onTap: endselectTime,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Text("End time${_endTime}"),
                  )),
                  ElevatedButton(onPressed: (){
                    submitForm();
                  }, child: Text("save"))
            ],
          ),
        ),
      ),
    );
  }
}
