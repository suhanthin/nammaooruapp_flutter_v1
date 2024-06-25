import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Styles/Styles.dart';
import '../../services/commitee_services.dart';
import '/Styles/colors.dart';

class AddCommitee extends StatefulWidget {
  final Map<String, dynamic> commiteeData;
  final String pageaction;
  const AddCommitee({Key? key, required this.commiteeData, required this.pageaction}) : super(key: key);

  @override
  _AddCommiteeState createState() => _AddCommiteeState();
}

class _AddCommiteeState extends State<AddCommitee> {
  final TextEditingController _fineAmountController = TextEditingController();
  final TextEditingController _meetingTitleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isAddAttendanceRadioButtonItem = true;
  String? statusDropdownValue = 'Select';
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  final CommiteeService commiteeService = CommiteeService();
  @override
  void initState() {
    super.initState();
    // Initialize your controllers or other state here if needed.
    if (widget.pageaction == 'edit') {
      _fineAmountController.text = widget.commiteeData['fineAmount'].toString();
      _dateController.text = widget.commiteeData['meetingDate'].toString();
      statusDropdownValue = widget.commiteeData['status'].toString();
      isAddAttendanceRadioButtonItem = widget.commiteeData['isAddAttendance']?? false;
      _meetingTitleController.text = widget.commiteeData['title'].toString();
      _descriptionController.text = widget.commiteeData['description'].toString();
    }
  }

  @override
  void dispose() {
    _fineAmountController.dispose();
    _dateController.dispose();
    _meetingTitleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveChanthaDetails() async {
    commiteeService.createCommitee(
      context: context,
      title: _meetingTitleController.text,
      fineAmount: int.parse(_fineAmountController.text),
      meetingDate: _dateController.text,
      remark: '',
      isAddAttendance: isAddAttendanceRadioButtonItem,
      status: statusDropdownValue.toString(),
      description: _descriptionController.toString(),
    );
  }

  void _updateChanthaDetails() async {
    commiteeService.updateCommitee(
      context: context,
      id: widget.commiteeData['_id'],
      fineAmount: int.parse(_fineAmountController.text),
      meetingDate: _dateController.text,
      remark: '',
      status: statusDropdownValue.toString(),
      title: _meetingTitleController.text,
      isAddAttendance: isAddAttendanceRadioButtonItem,
      description: _descriptionController.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    String pageaction = widget.pageaction;
    return Scaffold(
      appBar: AppBar(
        title: Text(pageaction == 'add' ? 'Add Commitee' : 'Edit Commitee', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    //Icon(Icons.accessibility),
                    Text('Add Attendance?',style: styleDate,),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      title: Transform.translate(
                          offset: const Offset(-20, 0), child: Text('Yes')),
                      value: true,
                      groupValue: isAddAttendanceRadioButtonItem,
                      activeColor: primaryColor,
                      selectedTileColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          isAddAttendanceRadioButtonItem = true;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      title: Transform.translate(
                          offset: const Offset(-20, 0), child: Text('No')),
                      value: false,
                      groupValue: isAddAttendanceRadioButtonItem,
                      activeColor: primaryColor,
                      selectedTileColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          isAddAttendanceRadioButtonItem = false;
                        });
                      },
                    ),
                  ),
                  Spacer(),
                ],
              ),
              TextFormField(
                controller: _meetingTitleController,
                decoration: InputDecoration(
                  labelText: 'Meeting Title',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                ),
                onSaved: (String? value) {
                  if (value != null) {
                    _meetingTitleController.text = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a meeting title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Meeting Date',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && mounted) {
                        setState(() {
                          _dateController.text = dateFormat.format(pickedDate);
                        });
                      }
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a meeting date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _fineAmountController,
                decoration: InputDecoration(
                  labelText: 'Fine Amount',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                ),
                onSaved: (String? value) {
                  if (value != null) {
                    _fineAmountController.text = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Fine Amount';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                ),
                onSaved: (String? value) {
                  if (value != null) {
                    _descriptionController.text = value;
                  }
                },
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter a Fine Amount';
                //   }
                //   return null;
                // },
              ),

              Visibility(
                visible: pageaction == 'edit' ? true : false,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 6.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Text('Status', style: sstyleDate),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: statusDropdownValue,
                              icon: const Icon(Icons.keyboard_arrow_down_rounded),
                              iconSize: 20,
                              iconDisabledColor: Colors.blue,
                              iconEnabledColor: Colors.grey,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                ),
                              ),
                              hint: const Text('Select chit position'),
                              dropdownColor: Colors.white,
                              items: ['Select', 'active', 'delete', 'close']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  statusDropdownValue = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null || value == 'Select') {
                                  return 'Please select a status';
                                }
                                return null;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                statusDropdownValue = 'Select';
                              });
                            },
                          ),
                        ]
                      ),
                    ]
                  )
                )
              ),
              SizedBox(height: 16.0),

              Visibility(
                visible: pageaction == 'edit' && (statusDropdownValue == 'closed' || statusDropdownValue == 'delete') ? true : false,
                child: TextFormField(
                  controller: _remarkController,
                  decoration: InputDecoration(
                    labelText: 'Remark',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  ),
                  onSaved: (String? value) {
                    if (value != null) {
                      _remarkController.text = value;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Remark';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16.0),  
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      pageaction == 'add' ? _saveChanthaDetails() : _updateChanthaDetails();
                    }
                  },
                  child: Text(
                    pageaction == 'add' ? 'Save Commitee Details' : 'Update Commitee Details',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor, // Replace with your desired color
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
