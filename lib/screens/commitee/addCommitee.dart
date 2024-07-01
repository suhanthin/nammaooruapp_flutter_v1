import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Styles/styles.dart';
import '../../models/custom_member.dart';
import '../../providers/custom_member_provider.dart';
import '../../services/commitee_services.dart';
import '../../services/member_services.dart';
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
  late MemberService memberService;
  late Function getCustomMemberList;
  bool _isLoading = true;
  List<CustomMemberDetail> userDetails = [];

  @override
  void initState() {
    super.initState();
    memberService = MemberService();
    getCustomMemberList = () async {
      await memberService.getCustomMemberList(context);
      setState(() {
        _isLoading = false;
      });
    };
    Future.delayed(Duration.zero, () {
      getCustomMemberList();
    });

    if (widget.pageaction == 'edit') {
      _fineAmountController.text = widget.commiteeData['fineAmount'].toString();
      _dateController.text = widget.commiteeData['meetingDate'].toString();
      statusDropdownValue = widget.commiteeData['status'].toString();
      isAddAttendanceRadioButtonItem = widget.commiteeData['isAddAttendance'] ?? false;
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
      status: 'active',
      description: _descriptionController.text,
      userDetails:userDetails
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
      description: _descriptionController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final members = Provider.of<CustomMemberProvider>(context, listen: true).customMemberDetails;
    userDetails = members!.customMemberDetails;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageaction == 'add' ? 'Add Commitee' : 'Edit Commitee', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Text('Add Attendance?', style: styleDate),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: RadioListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                    title: Transform.translate(offset: const Offset(-20, 0), child: Text('Yes')),
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
                                    title: Transform.translate(offset: const Offset(-20, 0), child: Text('No')),
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
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Colors.grey.shade400)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
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
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _dateController,
                                    decoration: InputDecoration(
                                      labelText: 'Meeting Date',
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(color: Colors.grey.shade400)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
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
                                ),
                                SizedBox(width: 16.0), // Adjust the width as needed
                                Expanded(
                                  child: TextFormField(
                                    controller: _fineAmountController,
                                    decoration: InputDecoration(
                                      labelText: 'Fine Amount',
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(color: Colors.grey.shade400)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a fine amount';
                                      }
                                      if (int.tryParse(value) == null) {
                                        return 'Please enter a valid number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            
                            Visibility(
                              visible: widget.pageaction == 'edit',
                              child: Column(
                                children: [
                                  SizedBox(height: 16.0),
                                  DropdownButtonFormField<String>(
                                    value: statusDropdownValue,
                                    decoration: InputDecoration(
                                      labelText: 'Status',
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0), 
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0), 
                                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0), 
                                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                                      ),
                                    ),
                                    items: <String>['Select', 'Active', 'Inactive']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        statusDropdownValue = newValue!;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value == 'Select') {
                                        return 'Please select a status';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Colors.grey.shade400)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                              ),
                              validator: (value) {
                                // if (value == null || value.isEmpty) {
                                //   return 'Please enter a description';
                                // }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 5),
                              child: Row(
                                children: [
                                  Text('Member List', style: mStyle),
                                ],
                              ),
                            ),
                            Column(
                              children: List.generate(
                                userDetails!.length,
                                (index) => CheckboxListTile(
                                  controlAffinity: ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  title: Text(
                                    userDetails[index].firstname.toString(),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: (userDetails[index].status.toString() == 'active') ? Colors.black : Colors.redAccent,
                                    ),
                                  ),
                                  value: userDetails[index].attendance,
                                  onChanged: userDetails[index].status != 'active' ? null : (value) {
                                    setState(() {
                                      userDetails[index].attendance = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.pageaction == 'add') {
                            _saveChanthaDetails();
                          } else {
                            _updateChanthaDetails();
                          }
                        }
                      },
                      child: Text(widget.pageaction == 'add' ? 'Save' : 'Update'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}