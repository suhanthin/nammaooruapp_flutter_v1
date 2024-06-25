import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Styles/Styles.dart';
import '../../services/chantha_services.dart';
import '/Styles/colors.dart';

class AddChantha extends StatefulWidget {
  final Map<String, dynamic> chanthaData;
  final String pageaction;
  const AddChantha({Key? key, required this.chanthaData, required this.pageaction}) : super(key: key);

  @override
  _AddChanthaState createState() => _AddChanthaState();
}

class _AddChanthaState extends State<AddChantha> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? statusDropdownValue = 'Select';
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  final ChanthaService chanthaService = ChanthaService();
  @override
  void initState() {
    super.initState();
    // Initialize your controllers or other state here if needed.
    if (widget.pageaction == 'edit') {
      _amountController.text = widget.chanthaData['amount'].toString();
      _dateController.text = widget.chanthaData['effectiveDate'].toString();
      statusDropdownValue = widget.chanthaData['status'].toString();
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _saveChanthaDetails() async {
    chanthaService.createChantha(
      context: context,
      amount: int.parse(_amountController.text),
      effectiveDate: _dateController.text,
      remark: '',
      status: statusDropdownValue.toString(),
    );
  }

  void _updateChanthaDetails() async {
    chanthaService.updateChantha(
      context: context,
      id: widget.chanthaData['_id'],
      amount: int.parse(_amountController.text),
      effectiveDate: _dateController.text,
      remark: '',
      status: statusDropdownValue.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String pageaction = widget.pageaction;
    return Scaffold(
      appBar: AppBar(
        title: Text(pageaction == 'add' ? 'Add Chantha' : 'Edit Chantha', style: TextStyle(color: Colors.white)),
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
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
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
                    _amountController.text = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Amount';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.0),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
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
                    return 'Please select a date';
                  }
                  return null;
                },
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
                    pageaction == 'add' ? 'Save Chantha Details' : 'Update Chantha Details',
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
