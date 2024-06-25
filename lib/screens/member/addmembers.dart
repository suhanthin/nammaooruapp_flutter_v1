import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/family.dart';
import '../../providers/searchmember_provider.dart';
import '../../utils/constants.dart';
import '/services/auth_services.dart';
import 'package:intl/intl.dart';
import '/common/theme_helper.dart';
import '/Styles/colors.dart';
import '/Styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/Styles/commonicons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

bool isDisabled = false;

String genderRadioButtonItem = 'male';
String memberTypeRadioButtonItem = "a-class";
String enrolledTypeRadioButtonItem = "a-class";
String maritalRadioButtonItem = "single";
String userTypeRadioButtonItem = "full";
bool isAdministratorRadioButtonItem = false;
bool isChitAdministratorRadioButtonItem = false;
String? positionDropdownValue = 'Select';
String? chitpositionDropdownValue ='Select';
String? identityProofDropdownValue ='Select';
String? jobTypeDropdownValue ='Select';
String? jobportalDropdownValue ='Select';
String? statusDropdownValue='Select';
String? jobProfessionalDropdownValue ='Select';
bool family_ismemberRadioButtonItem = false;
bool family_isnewFamily = false;
bool family_isaddBelowMember = false;
String family_genderRadioButtonItem = 'male';
String? family_realtionDropdownValue ='Select';
String family_maritalRadioButtonItem = "single";
String? family_identityProofDropdownValue='Select';
String? family_jobTypeDropdownValue='Select'; 
String? family_jobportalDropdownValue='Select';
String? family_jobProfessionalDropdownValue='Select';
String? family_statusDropdownValue='Select';
bool family_ismarriedsameplace = false;
String family_edit_id = "";
String familySubId = "";
String isChanthaRequiredRadioButtonItem = "false";
String isEnrolledAfterRecordRadioButtonItem = "false";


TextEditingController _firstNameController = TextEditingController();
TextEditingController _lastNameController = TextEditingController();
TextEditingController _fatherNameController = TextEditingController();
TextEditingController _motherNameController = TextEditingController();
TextEditingController _dateController = TextEditingController();
TextEditingController _phoneController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController identityProofNoController = TextEditingController();
TextEditingController jobdetailsController = TextEditingController();
TextEditingController qualificationController = TextEditingController();
TextEditingController _remarkController = TextEditingController();
TextEditingController family_memberIdController = TextEditingController();
TextEditingController family_member_IdController = TextEditingController();
TextEditingController family_marriedpersionIdController = TextEditingController();
TextEditingController family_searchmemberIdController = TextEditingController();
TextEditingController family_familyIdController = TextEditingController();
TextEditingController family_familyNameController = TextEditingController();
TextEditingController family_firstNameController = TextEditingController();
TextEditingController family_lastNameController = TextEditingController();
TextEditingController family_dateController = TextEditingController();
TextEditingController family_phoneController = TextEditingController();
TextEditingController family_husorwife_nameController = TextEditingController();
TextEditingController family_identityProofNoController = TextEditingController();
TextEditingController family_jobdetailsController = TextEditingController();
TextEditingController family_addressController = TextEditingController();
TextEditingController family_qualificationController = TextEditingController();
TextEditingController family_remarkController = TextEditingController();
TextEditingController _enrollDateController = TextEditingController();
TextEditingController _memberTypebclasschangedDateController = TextEditingController();
TextEditingController _memberTypebclassAddedDateController = TextEditingController();
TextEditingController _reJoiningDateController = TextEditingController();

final _formKey = GlobalKey<FormState>();
final _searchformKey = GlobalKey<FormState>();
DateFormat dateFormat = DateFormat("dd-MM-yyyy");

List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];
final AuthService authService = AuthService();

class DropdownItem {
  final String value;
  final String label;

  DropdownItem({required this.value, required this.label});
}

List<DropdownItem> familyRelations = [];

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}

List<FamilyMember> familyMembers = [];
class MyData {
  String _id = "";
  String firstname = '';
  String lastname = '';
  String fathername = '';
  String mothername = '';
  String dob = '';
  String phone = '';
  String email = '';
  String age = '';
  String address = '';
  String identityProofNo ='';
  String qualification = '';
  String jobdetails = '';
  String roleName = '';
  int balanceTribute = 0;
  String username = '';
  String memberId = '';

  String password = '';
  String usertypeSavedhalf = '';
  String userTypefullchangedDate = '';
  String maritalchangedDate = '';
  String maritalStatusSavedsingle = '';
  String memberTypebclasschangedDate = '';
  String memberTypeSavedbclass = '';
  String memberTypebclassAddedDate = '';
  String memberTypeSavedcclass = '';
  String status = '';
  String remark = '';
  String refreshToken ='';
  String avatar = '';
  String familyId = '';

  String enrollDate = '';
  String enrolledType ='';
  String reJoiningDate = '';
  bool isChanthaRequired = false;
  bool isEnrolledAfterRecord = false;
  bool statusDismisstoActive = false;
}
final MyData data =  MyData();

class Addmembers extends StatefulWidget { 
  final Map<String, dynamic> memberData;
  final String pageaction;
  const Addmembers({Key? key, required this.memberData, required this.pageaction}) : super(key: key);
  
  @override 
  _AddmembersState createState() => _AddmembersState(); 
} 

class _AddmembersState extends State<Addmembers> { 
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _dateController.text = "";
    jobTypeDropdownValue = null;
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  _stepState(int step) {
    if (_currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.editing;
    }
  }

  _steps() => [
    Step(
      title: Transform.translate(offset: const Offset(-8, 0), child: Text('Step 1',style: TextStyle(fontSize: 12))),
      isActive: _currentStep == 0,
      state: StepState.indexed,
      content: _StepOneForm(memberData: widget.memberData, pageaction: widget.pageaction),
    ),
    Step(
      title: Transform.translate(offset: const Offset(-8, 0), child: Text('Step 2',style: TextStyle(fontSize: 12))),
      content: _StepTwoForm(memberData: widget.memberData, pageaction: widget.pageaction),
      isActive: _currentStep == 1,
      state: StepState.indexed,
    ),
    Step(
      title: Transform.translate(offset: const Offset(-8, 0), child: Text('Step 3',style: TextStyle(fontSize: 12))),
      content: _StepThreeForm(memberData: widget.memberData, pageaction: widget.pageaction),
      isActive: _currentStep == 2,
      state: StepState.indexed,
    ),
    Step(
      title: Transform.translate(offset: const Offset(-8, 0), child: Text('Step 4',style: TextStyle(fontSize: 12))),
      content: _StepFourForm(memberData: widget.memberData, pageaction: widget.pageaction),
      isActive: _currentStep == 3,
      state: StepState.indexed,
    ),
    Step(
      title: Transform.translate(offset: const Offset(-8, 0), child: Text('Review',style: TextStyle(fontSize: 12))),
      content: _Overview(memberData: widget.memberData, pageaction: widget.pageaction),
      isActive: _currentStep == 4,
      state: StepState.indexed,
    )
  ];

  _shownewStepperDialog(width, pageaction) { 
    return SingleChildScrollView( 
      scrollDirection: Axis.horizontal, 
      child: SizedBox( 
        width: width, 
        child: Theme(
          data: ThemeData(
            canvasColor: primaryColor,
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.blue,
              background: Colors.red,
              secondary: Colors.green,
            ),
          ),
          child:Stepper(
            type: StepperType.horizontal,
            controlsBuilder: (BuildContext context, ControlsDetails controls) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  children: <Widget>[
                    if (_currentStep != 0)
                      TextButton(
                        onPressed: controls.onStepCancel,
                        child: const Text(
                          'BACK',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    if (_currentStep != 4)
                      ElevatedButton(
                        onPressed: controls.onStepContinue,
                        child: const Text('NEXT',
                            style: TextStyle(color: Colors.white)),
                      ),
                    if (_currentStep == 4)
                      ElevatedButton(
                        onPressed: () {
                          pageaction == 'add' ? _saveMemberStails() : _updateMemberStails();
                        },
                        child: Text(pageaction == 'add' ? 'Save Member Details' : 'Update Member Details', style: TextStyle(color: Colors.white)),
                      ),
                  ],
                ),
              );
            },
            //onStepTapped: (step) => setState(() => _currentStep = step),
            onStepContinue: () {     
              setState(() {
                if(formKeys[_currentStep].currentState!.validate()) {
                  if (_currentStep < _steps().length - 1) {
                    _currentStep = _currentStep + 1;
                  } else {
                    _currentStep = 0;
                  }
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (_currentStep > 0) {
                  _currentStep -= 1;
                } else {
                  _currentStep = 0;
                }
              });
            },
            currentStep: _currentStep,
            steps: _steps(),
          ),
        ), 
      ), 
    ); 
  }

  void _updateMemberStails () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('x-access-token');
    authService.userUpdate(
      context: context,
      id:data._id.toString(),
      username:data.username,
      firstname:data.firstname,
      lastname: data.lastname,
      password:data.password,
      memberId:data.memberId,
      roleName:data.roleName,
      isAdministrator:isAdministratorRadioButtonItem,
      position:positionDropdownValue == 'Select' ? '' :positionDropdownValue.toString(),
      isChitCommitteeMember:isChitAdministratorRadioButtonItem,
      chitCommitteePosition:chitpositionDropdownValue == 'Select' ? '' :chitpositionDropdownValue.toString(),
      phoneno:data.phone,
      fathername:data.fathername,
      mothername:data.mothername,
      gender:genderRadioButtonItem,
      avatar:data.avatar,
      address:data.address,
      dob:data.dob,
      balanceTribute:data.balanceTribute,
      userType:userTypeRadioButtonItem,
      usertypeSavedhalf:data.usertypeSavedhalf,
      userTypefullchangedDate:data.userTypefullchangedDate,
      maritalStatus:maritalRadioButtonItem,
      maritalchangedDate:data.maritalchangedDate,
      maritalStatusSavedsingle:data.maritalStatusSavedsingle,
      memberType:memberTypeRadioButtonItem,
      memberTypebclasschangedDate:data.memberTypebclasschangedDate,
      memberTypeSavedbclass:data.memberTypeSavedbclass,
      memberTypebclassAddedDate:data.memberTypebclassAddedDate,
      memberTypeSavedcclass:data.memberTypeSavedcclass,
      identityProof:identityProofDropdownValue == 'Select' ? '' :identityProofDropdownValue.toString(),
      identityProofNo:data.identityProofNo,
      nationality:'indian',
      qualification:data.qualification,
      jobType:jobTypeDropdownValue == 'Select' ? '' :jobTypeDropdownValue.toString(),
      jobportal:jobportalDropdownValue  == 'Select' ? '' :jobportalDropdownValue.toString(),
      jobdetails:data.jobdetails,
      familyId:data.familyId,
      status:statusDropdownValue == 'Select' ? '' :statusDropdownValue.toString(),
      remark:data.remark, 
      token:'',
      refreshToken:'',
      familyMembers:familyMembers,
      enrollDate:data.enrollDate, 
      enrolledType:enrolledTypeRadioButtonItem,
      reJoiningDate:data.reJoiningDate,
      isChanthaRequired:isChanthaRequiredRadioButtonItem.toLowerCase() == 'true' ? true : false,
      isEnrolledAfterRecord: isEnrolledAfterRecordRadioButtonItem.toLowerCase() == 'true' ? true : false,
      statusDismisstoActive: data.statusDismisstoActive,
      jobProfessional:jobProfessionalDropdownValue == 'Select' ? '' :jobProfessionalDropdownValue.toString(),
    );
  }

  void _saveMemberStails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('x-access-token');
    authService.signUpUser(
      context: context,
      id:"",
      username:"",
      firstname:data.firstname,
      lastname: data.lastname,
      password:"",
      memberId:"",
      roleName:"member",
      isAdministrator:isAdministratorRadioButtonItem,
      position:positionDropdownValue  == 'Select' ? '' :positionDropdownValue.toString(),
      isChitCommitteeMember:isChitAdministratorRadioButtonItem,
      chitCommitteePosition:chitpositionDropdownValue == 'Select' ? '' :chitpositionDropdownValue.toString(),
      phoneno:data.phone,
      fathername:data.fathername,
      mothername:data.mothername,
      gender:genderRadioButtonItem,
      avatar:"",
      address:data.address,
      dob:data.dob,
      balanceTribute:data.balanceTribute,
      userType:userTypeRadioButtonItem,
      usertypeSavedhalf:"",
      userTypefullchangedDate:"",
      maritalStatus:maritalRadioButtonItem,
      maritalchangedDate:"",
      maritalStatusSavedsingle:"",
      memberType:memberTypeRadioButtonItem,
      memberTypebclasschangedDate:"",
      memberTypeSavedbclass:"",
      memberTypebclassAddedDate:"",
      memberTypeSavedcclass:"",
      identityProof:identityProofDropdownValue == 'Select' ? '' :identityProofDropdownValue.toString(),
      identityProofNo:data.identityProofNo,
      nationality:'indian',
      qualification:data.qualification,
      jobType:jobTypeDropdownValue  == 'Select' ? '' :jobTypeDropdownValue.toString(),
      jobportal:jobportalDropdownValue == 'Select' ? '' :jobportalDropdownValue.toString(),
      jobdetails:data.jobdetails,
      familyId:"",
      status:statusDropdownValue == 'Select' ? '' :statusDropdownValue.toString(),
      remark:data.remark, 
      token:'',
      refreshToken:"",
      enrollDate:data.enrollDate, 
      enrolledType:enrolledTypeRadioButtonItem,
      reJoiningDate:data.reJoiningDate,
      isChanthaRequired:isChanthaRequiredRadioButtonItem.toLowerCase() == 'true' ? true : false,
      isEnrolledAfterRecord:isEnrolledAfterRecordRadioButtonItem.toLowerCase() == 'true' ? true : false,
      statusDismisstoActive:data.statusDismisstoActive,
      jobProfessional:jobProfessionalDropdownValue == 'Select' ? '' :jobProfessionalDropdownValue.toString(),
    );
  }

  @override 
  Widget build(BuildContext context) { 
    double width = MediaQuery.of(context).size.width;
    String pageaction =widget.pageaction;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageaction == 'add' ? 'Add Member' : 'Edit Member', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          color:Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container( 
        child: _shownewStepperDialog(width, pageaction)
      ), 
    ); 
  } 
} 

class _StepOneForm extends StatefulWidget {
  final Map<String, dynamic> memberData;
  final String pageaction;

  const _StepOneForm({Key? key, required this.memberData, required this.pageaction}) : super(key: key);

  @override
  _StepOneFormState createState() => _StepOneFormState();
}

class _StepOneFormState extends State<_StepOneForm> {
  @override
  void initState() {
    super.initState();
    if (widget.pageaction == 'edit') {
      _firstNameController.text = widget.memberData['firstname'] ?? '';
      _lastNameController.text = widget.memberData['lastname'] ?? '';
      _fatherNameController.text = widget.memberData['fathername'] ?? '';
      _motherNameController.text = widget.memberData['mothername'] ?? '';
      _dateController.text = widget.memberData['dob'] ?? '';
      _phoneController.text = widget.memberData['phoneno'] ?? '';
      _memberTypebclassAddedDateController.text = widget.memberData['memberTypebclassAddedDate'] ?? '';
      _memberTypebclasschangedDateController.text = widget.memberData['memberTypebclasschangedDate'] ?? '';
      genderRadioButtonItem = widget.memberData['gender'] ?? '';
      memberTypeRadioButtonItem= widget.memberData['memberType'] ?? '';
      statusDropdownValue= widget.memberData['status'] ?? 'Select';
      data.roleName = widget.memberData['roleName'] ?? '';
      data._id = widget.memberData['_id'] ?? '';
      data.balanceTribute = widget.memberData['balanceTribute'] ?? 0;
      data.username = widget.memberData['username'] ?? '';
      data.memberId = widget.memberData['memberId'] ?? '';
      data.password = widget.memberData['password'] ?? '';
      data.usertypeSavedhalf = widget.memberData['usertypeSavedhalf'] ?? '';
      data.userTypefullchangedDate = widget.memberData['userTypefullchangedDate'] ?? '';
      data.maritalchangedDate = widget.memberData['maritalchangedDate'] ?? '';
      data.maritalStatusSavedsingle = widget.memberData['maritalStatusSavedsingle'] ?? '';
      data.memberTypebclasschangedDate = widget.memberData['memberTypebclasschangedDate'] ?? '';
      data.memberTypeSavedbclass = widget.memberData['memberTypeSavedbclass'] ?? '';
      data.memberTypebclassAddedDate = widget.memberData['memberTypebclassAddedDate'] ?? '';
      data.memberTypeSavedcclass = widget.memberData['memberTypeSavedcclass'] ?? '';
      data.status = widget.memberData['status'] ?? '';
      data.remark = widget.memberData['remark'] ?? '';
      data.refreshToken = widget.memberData['refreshToken'] ?? '';
      data.avatar = widget.memberData['avatar'] ?? '';
      data.familyId = widget.memberData['familyId'] ?? '';
      data.enrolledType = widget.memberData['enrolledType'] ?? '';
      data.reJoiningDate = widget.memberData['reJoiningDate'] ?? '';
      data.isChanthaRequired = widget.memberData['isChanthaRequired'] ?? false;
      data.isEnrolledAfterRecord = widget.memberData['isEnrolledAfterRecord'] ?? false;
    } else {
      _firstNameController.text = '';
      _lastNameController.text = '';
      _fatherNameController.text = '';
      _motherNameController.text = '';
      _dateController.text = '';
      _phoneController.text = '';
      genderRadioButtonItem = 'male';
      memberTypeRadioButtonItem = "a-class";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeys[0],
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                //Icon(Icons.accessibility),
                Text('Member Type',style: sstyleDate,),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                  title: Transform.translate(offset: const Offset(-20, 0), child: Text('A-Class')),
                  value: "a-class", 
                  groupValue: memberTypeRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        memberTypeRadioButtonItem = value.toString();
                        genderRadioButtonItem = "male";
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                  title: Transform.translate(offset: const Offset(-20, 0), child: Text('B-Class')),
                  value: "b-class", 
                  groupValue: memberTypeRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        memberTypeRadioButtonItem = value.toString();
                        genderRadioButtonItem = "male";
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                  title: Transform.translate(offset: const Offset(-20, 0), child: Text('C-Class')),
                  value: "c-class", 
                  groupValue: memberTypeRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        memberTypeRadioButtonItem = value.toString();
                        genderRadioButtonItem = "female";
                    });
                  },
                ),
              ),
            ],
          ),
          Visibility(
            visible: memberTypeRadioButtonItem == 'b-class' ,
            child: Container(
                child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _memberTypebclassAddedDateController,
                        decoration: InputDecoration(
                            labelText: "Member Type B-Class Added Date",
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Icon(Icons.calendar_today, size: 18.0, color: Colors.grey),
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                        ),
                        onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                            selectableDayPredicate: (DateTime date) {
                                return date.isBefore(DateTime.now());
                            },
                            );
                            if (pickedDate != null) {
                            setState(() {
                                _memberTypebclassAddedDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                                data.memberTypebclassAddedDate = _memberTypebclassAddedDateController.text;
                            });
                            }
                        },
                      ),
                      SizedBox(height: 10.0),
                    ],
                ),
            ),
          ),
          Visibility(
            visible: memberTypeRadioButtonItem == 'a-class' && data.memberTypeSavedbclass == 'yes' ,
            child: Container(
                child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _memberTypebclasschangedDateController,
                        decoration: InputDecoration(
                          labelText: "Member Type B-Class Changed Date",
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: Icon(Icons.calendar_today, size: 18.0, color: Colors.grey),
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100),
                          selectableDayPredicate: (DateTime date) {
                              return date.isBefore(DateTime.now());
                          },
                          );
                          if (pickedDate != null) {
                          setState(() {
                              _memberTypebclasschangedDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                              data.memberTypebclasschangedDate = _memberTypebclasschangedDateController.text;
                          });
                          }
                        },
                      ),
                      SizedBox(height: 10.0),
                    ],
                ),
            ),
          ),
          
          TextFormField(
            controller: _firstNameController,
            keyboardType: TextInputType.text,
            autocorrect: false,
            decoration: ThemeHelper().textInputDecorationNoicon("First Name", "Enter your First name", Icon(Icons.person, color: Colors.grey)),
            onSaved: (String? value) { 
              if (value != null) { 
                data.firstname = value;
              }
            },
            maxLines: 1,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Please enter first name";
              } else {
                data.firstname = val;
              }
              return null;
            },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _lastNameController,
            keyboardType: TextInputType.text,
            autocorrect: false,
            decoration: ThemeHelper().textInputDecorationNoicon("Last Name", "Enter your last name", Icon(Icons.person, color: Colors.grey)),
            onSaved: (String? value) { 
              if (value != null) { 
                data.lastname = value;
              }
            },
            maxLines: 1,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Please enter last name";
              } else {
                data.lastname = val;
              }
              return null;
            },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _fatherNameController,
            keyboardType: TextInputType.text,
            autocorrect: false,
            decoration: ThemeHelper().textInputDecorationNoicon("Father Name", "Enter your father name", Icon(Icons.person, color: Colors.grey)),
            onSaved: (String? value) { 
              if (value != null) { 
                data.fathername = value;
              }
            },
            maxLines: 1,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Please enter father name";
              }else {
                data.fathername = val;
              }
              return null;
            },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _motherNameController,
            keyboardType: TextInputType.text,
            autocorrect: false,
            decoration: ThemeHelper().textInputDecorationNoicon("Mother Name", "Enter your mother name", Icon(Icons.person, color: Colors.grey)),
            onSaved: (String? value) { 
              if (value != null) { 
                data.mothername = value;
              }
            },
            validator: (val) {
              if (val != "") {
                data.mothername = val!;
              }
              return null;
            },
            maxLines: 1,
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: "Date of Birth",
              fillColor: Colors.white,
              filled: true,
              suffixIcon: Icon(Icons.calendar_today, size: 18.0, color: Colors.grey),
              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100),
                selectableDayPredicate: (DateTime date) {
                  return date.isBefore(DateTime.now());
                },
              );
              if (pickedDate != null) {
                setState(() {
                  _dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                  data.dob = _dateController.text;
                });
              }
            },
            // validator: (val) {
            //   if (val == null || val.isEmpty) {
            //     return "Please Select dob";
            //   }else {
            //     data.dob = val;
            //   }
            //   return null;
            // },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            autocorrect: false,
            decoration: ThemeHelper().textInputDecorationNoicon("Phone No", "Enter phone no", Icon(Icons.person, color: Colors.grey)),
            onSaved: (String? value) { 
              if (value != null) { 
                data.phone = value;
              }
            },
            maxLines: 1,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Please enter valid number";
              }else {
                data.phone = val;
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                //Icon(Icons.accessibility),
                Text('Gender',style: sstyleDate,),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                  title: Transform.translate(offset: const Offset(-20, 0), child: Text('Male')),
                  value: "male", 
                  groupValue: genderRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        genderRadioButtonItem = value.toString();
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                  title: Transform.translate(offset: const Offset(-20, 0), child: Text('Female')),
                  value: "female", 
                  groupValue: genderRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        genderRadioButtonItem = value.toString();
                    });
                  },
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepTwoForm extends StatefulWidget {
  final Map<String, dynamic> memberData;
  final String pageaction;

  const _StepTwoForm({Key? key, required this.memberData, required this.pageaction}) : super(key: key);
  @override
  _StepTwoFormState createState() => _StepTwoFormState();
}

class _StepTwoFormState extends State<_StepTwoForm> {
  @override
  void initState() {
    super.initState();
    if (widget.pageaction == 'edit') {
      maritalRadioButtonItem = widget.memberData['maritalStatus'];
      userTypeRadioButtonItem = widget.memberData['userType'];
      isAdministratorRadioButtonItem = widget.memberData['isAdministrator'];
      isChitAdministratorRadioButtonItem = widget.memberData['isChitCommitteeMember'];
      if(widget.memberData['isAdministrator'] == true){
        positionDropdownValue = widget.memberData['position'];
      } else {
        positionDropdownValue = 'member';
      }
      if(widget.memberData['isChitCommitteeMember']){
        chitpositionDropdownValue = widget.memberData['chitCommitteePosition'];
      }
      jobTypeDropdownValue =widget.memberData['jobType'] != '' ? widget.memberData['jobType'] : 'Select';
      jobportalDropdownValue =widget.memberData['jobportal']!= '' ? widget.memberData['jobportal'] : 'Select';
      identityProofDropdownValue =widget.memberData['identityProof'] != ''? widget.memberData['identityProof'] : 'Select';
      isChanthaRequiredRadioButtonItem =widget.memberData['isChanthaRequired'] != ''? widget.memberData['isChanthaRequired'] == true ? 'true' : 'false' : 'false';
      isEnrolledAfterRecordRadioButtonItem =widget.memberData['isEnrolledAfterRecord'] != ''? widget.memberData['isEnrolledAfterRecord'] == true ? 'true' : 'false' : 'false';
      _enrollDateController.text = widget.memberData['enrollDate'] ?? '';
      data.enrollDate = widget.memberData['enrollDate'] ?? '';
      data.enrolledType = widget.memberData['enrolledType'] ?? '';
      enrolledTypeRadioButtonItem = widget.memberData['enrolledType'] ?? 'a-class';
      data.statusDismisstoActive = widget.memberData['statusDismisstoActive'] ?? false;
      data.reJoiningDate = widget.memberData['reJoiningDate'] ?? '';
      _remarkController.text = widget.memberData['remark'] ?? '';
      data.remark = widget.memberData['remark'] ?? '';
    } else {
      isAdministratorRadioButtonItem = false;
      isChitAdministratorRadioButtonItem = false;
      positionDropdownValue = 'Select';
      chitpositionDropdownValue = 'Select';
      jobportalDropdownValue = 'Select';
      identityProofDropdownValue = 'Select';
      _enrollDateController.text = "";
      enrolledTypeRadioButtonItem = 'a-class';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeys[1],
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                //Icon(Icons.accessibility),
                Text('Marital Status',style: styleDate,),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                  title: Transform.translate(offset: const Offset(-20, 0), child: Text('Single')),
                  value: "single", 
                  groupValue: maritalRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        maritalRadioButtonItem = value.toString();
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                  title: Transform.translate(offset: const Offset(-20, 0), child: Text('Married')),
                  value: "married", 
                  groupValue: maritalRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        maritalRadioButtonItem = value.toString();
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                  title: Transform.translate(offset: const Offset(-20, 0), child: Text('Widowed')),
                  value: "widowed", 
                  groupValue: maritalRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        maritalRadioButtonItem = value.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                //Icon(Icons.accessibility),
                Text('User Type',style: styleDate,),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                  title: Transform.translate(offset: const Offset(-20, 0), child: Text('Full')),
                  value: "full", 
                  groupValue: userTypeRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        userTypeRadioButtonItem = value.toString();
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                  title: Transform.translate(offset: const Offset(-20, 0), child: Text('Half')),
                  value: "half", 
                  groupValue: userTypeRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        userTypeRadioButtonItem = value.toString();
                    });
                  },
                ),
              ),
              Spacer(),
            ],
          ),
          Visibility(
            visible: memberTypeRadioButtonItem == 'a-class' && userTypeRadioButtonItem == 'full' &&  genderRadioButtonItem == 'female',
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text('Chantha Required?',style: sstyleDate,),
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
                          value: 'true', 
                          groupValue: isChanthaRequiredRadioButtonItem, 
                          activeColor: primaryColor,
                          selectedTileColor:primaryColor,
                          onChanged:isDisabled ? null : (value) {
                            setState(() {
                                isChanthaRequiredRadioButtonItem = value.toString();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                          title: Transform.translate(offset: const Offset(-20, 0), child: Text('No')),
                          value: "false", 
                          groupValue: isChanthaRequiredRadioButtonItem, 
                          activeColor: primaryColor,
                          selectedTileColor:primaryColor,
                          onChanged:isDisabled ? null : (value) {
                            setState(() {
                                isChanthaRequiredRadioButtonItem = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                //Icon(Icons.accessibility),
                Text('Administrator',style: styleDate,),
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
                  groupValue: isAdministratorRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isChitAdministratorRadioButtonItem == true ? null : (value) {
                    setState(() {
                      isAdministratorRadioButtonItem = true;
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
                  groupValue: isAdministratorRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isChitAdministratorRadioButtonItem == true ? null : (value) {
                    setState(() {
                      isAdministratorRadioButtonItem = false;
                      positionDropdownValue = 'Select';
                    });
                  },
                ),
              ),
              Spacer(),
            ],
          ),
          // Position
          Visibility(
            visible: isAdministratorRadioButtonItem == true ? true : false,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        //Icon(Icons.accessibility),
                        Text('Position',style: styleDate,),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          iconSize: 20,
                          iconDisabledColor: Colors.blue,
                          iconEnabledColor: Colors.grey,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                          hint: const Text('Select position'),
                          dropdownColor: Colors.white,
                          value: positionDropdownValue,
                          validator: (value) => isAdministratorRadioButtonItem == true && value == 'Select' ? 'position required' : null,
                          onChanged: (String? newValue) {
                            setState(() {
                              positionDropdownValue = newValue!;
                            });
                          },
                          items: ['Select', 'superadmin','தலைவர்','துணைத்தலைவர்','செயலாளர்','பொருளாளர்','கணக்கர்','member']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            positionDropdownValue = 'Select';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                ]
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                //Icon(Icons.accessibility),
                Text('Chit Administrator',style: styleDate,),
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
                  groupValue: isChitAdministratorRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isAdministratorRadioButtonItem == true ? null : (value) {
                    setState(() {
                      isChitAdministratorRadioButtonItem = true;
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
                  groupValue: isChitAdministratorRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isAdministratorRadioButtonItem == true ? null : (value) {
                    setState(() {
                      isChitAdministratorRadioButtonItem = false;
                      chitpositionDropdownValue='Select';
                    });
                  },
                ),
              ),
              Spacer(),
            ],
          ),
          // Position
          Visibility(
            visible: isChitAdministratorRadioButtonItem  ? true : false,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        //Icon(Icons.accessibility),
                        Text('Chit Admin Position',style: styleDate,),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          iconSize: 20,
                          iconDisabledColor: Colors.blue,
                          iconEnabledColor: Colors.grey,
                          validator: (value) => isChitAdministratorRadioButtonItem == "true" && value == 'Select' ? 'Chit position required' : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                          value: chitpositionDropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              chitpositionDropdownValue = newValue!;
                            });
                          },
                          items: ['Select','chitadmin','chitcollectors']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            chitpositionDropdownValue = 'Select';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                ]
              )
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Text('Enrolled added After 1980?',style: sstyleDate,),
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
                  value: 'true', 
                  groupValue: isEnrolledAfterRecordRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        isEnrolledAfterRecordRadioButtonItem = value.toString();
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                  title: Transform.translate(offset: const Offset(-20, 0), child: Text('No')),
                  value: "false", 
                  groupValue: isEnrolledAfterRecordRadioButtonItem, 
                  activeColor: primaryColor,
                  selectedTileColor:primaryColor,
                  onChanged:isDisabled ? null : (value) {
                    setState(() {
                        isEnrolledAfterRecordRadioButtonItem = value.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          Visibility(
            visible: isEnrolledAfterRecordRadioButtonItem == 'true'  ? true : false,
            child: Container(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _enrollDateController,
                    decoration: InputDecoration(
                      labelText: "Enroll Date",
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Icon(Icons.calendar_today, size: 18.0, color: Colors.grey),
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100),
                        selectableDayPredicate: (DateTime date) {
                          return date.isBefore(DateTime.now());
                        },
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _enrollDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                          data.enrollDate = _enrollDateController.text;
                        });
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        //Icon(Icons.accessibility),
                        Text('Enrolled Type',style: sstyleDate,),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RadioListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                          title: Transform.translate(offset: const Offset(-20, 0), child: Text('A-Class')),
                          value: "a-class", 
                          groupValue: enrolledTypeRadioButtonItem, 
                          activeColor: primaryColor,
                          selectedTileColor:primaryColor,
                          onChanged:isDisabled ? null : (value) {
                            setState(() {
                                enrolledTypeRadioButtonItem = value.toString();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                          title: Transform.translate(offset: const Offset(-20, 0), child: Text('B-Class')),
                          value: "b-class", 
                          groupValue: enrolledTypeRadioButtonItem, 
                          activeColor: primaryColor,
                          selectedTileColor:primaryColor,
                          onChanged:isDisabled ? null : (value) {
                            setState(() {
                                enrolledTypeRadioButtonItem = value.toString();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                          title: Transform.translate(offset: const Offset(-20, 0), child: Text('C-Class')),
                          value: "c-class", 
                          groupValue: enrolledTypeRadioButtonItem, 
                          activeColor: primaryColor,
                          selectedTileColor:primaryColor,
                          onChanged:isDisabled ? null : (value) {
                            setState(() {
                                enrolledTypeRadioButtonItem = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ]
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                //Icon(Icons.accessibility),
                Text('Status',style: styleDate,),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonFormField<String>(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 20,
                  iconDisabledColor: Colors.blue,
                  iconEnabledColor: Colors.grey,
                  validator: (value) => statusDropdownValue == "Select" && value == null ? 'Status required' : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                  hint: const Text('Select Status'),
                  dropdownColor: Colors.white,
                  value: statusDropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      statusDropdownValue = newValue!;
                    });
                  },
                  items: ['Select','active','death','suspend','dismiss']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
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
            ],
          ),
          SizedBox(height: 10.0),
          Visibility(
            visible: statusDropdownValue != "Select" && statusDropdownValue != "active" ? true : false,
            child: TextFormField(
              controller:_remarkController,
              keyboardType: TextInputType.text,
              autocorrect: false,
              decoration: ThemeHelper().textInputDecorationNoicon("Remark", "Enter Remark", Icon(Icons.person, color: Colors.grey)),
              onSaved: (String? value) { 
                if (value != null) { 
                  data.remark = value;
                }
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Please enter Remark";
                }else {
                  data.remark = val;
                }
                return null;
              },
              maxLines: 1,
            ),
          ),
          SizedBox(height: 10.0),
          Visibility(
            visible: statusDropdownValue != "Select" && statusDropdownValue == "dismiss" ? true : false,
            child: TextFormField(
              controller: _reJoiningDateController,
              decoration: InputDecoration(
                  labelText: "Rejoin Date",
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: Icon(Icons.calendar_today, size: 18.0, color: Colors.grey),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
              ),
              onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100),
                  selectableDayPredicate: (DateTime date) {
                      return date.isBefore(DateTime.now());
                  },
                  );
                  if (pickedDate != null) {
                  setState(() {
                      _reJoiningDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                      data.reJoiningDate = _reJoiningDateController.text;
                  });
                  }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StepThreeForm extends StatefulWidget {
  final Map<String, dynamic> memberData;
  final String pageaction;

  const _StepThreeForm({Key? key, required this.memberData, required this.pageaction}) : super(key: key);

  @override
  _StepThreeFormState createState() => _StepThreeFormState();
}

class _StepThreeFormState extends State<_StepThreeForm> {
  @override
  void initState() {
    super.initState();
    print(widget.memberData['jobProfessional']);
    print('dsfsdfsfs');
    if (widget.pageaction == 'edit') {
      addressController.text = widget.memberData['address'] ?? '';
      data.address = widget.memberData['address'] ?? '';
      identityProofNoController.text = widget.memberData['identityProofNo'] ?? '';
      jobdetailsController.text = widget.memberData['jobdetails'] ?? '';
      identityProofDropdownValue = widget.memberData['identityProof'] == '' ? 'Select' : widget.memberData['identityProof'];
      jobTypeDropdownValue = widget.memberData['jobType']  == '' ? 'Select' : widget.memberData['jobType'];
      jobportalDropdownValue = widget.memberData['jobportal']   == '' ? 'Select' : widget.memberData['jobportal'];
      jobProfessionalDropdownValue = widget.memberData['jobProfessional'] == '' ? 'Select' : widget.memberData['jobProfessional'];
      data.identityProofNo = widget.memberData['identityProofNo'] ?? '';
      data.jobdetails = widget.memberData['jobdetails'] ?? '';
      data.qualification = widget.memberData['qualification'] ?? '';
      qualificationController.text= widget.memberData['qualification'] ?? '';
    } else {
      identityProofDropdownValue ='Select';
      jobTypeDropdownValue ='Select';
      jobportalDropdownValue ='Select';
      jobProfessionalDropdownValue='Select';
    }
    print(jobProfessionalDropdownValue);
    print('sfsdfdsfsdfdsfsdfsd');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeys[2],
      child: Column(
        children: <Widget>[
          TextFormField(
            controller:addressController,
            keyboardType: TextInputType.text,
            autocorrect: false,
            decoration: ThemeHelper().textInputDecorationNoicon("Address", "Enter Address", Icon(Icons.person, color: Colors.grey)),
            onSaved: (String? value) { 
              if (value != null) { 
                data.address = value;
              }
            },
            validator: (val) {
              data.address = val!;
              return null;
            },
            maxLines: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                //Icon(Icons.accessibility),
                Text('Identity Proof',style: styleDate,),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonFormField<String>(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 20,
                  iconDisabledColor: Colors.blue,
                  iconEnabledColor: Colors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                  hint: const Text('Select Identity Proof'),
                  dropdownColor: Colors.white,
                  value: identityProofDropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      identityProofDropdownValue = newValue!;
                    });
                  },
                  items: ['Select','Driving License','PAN Card','Aadhaar', 'Passport']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                ),
              ),
              IconButton(
                icon: Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    identityProofDropdownValue = 'Select';
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Visibility(
            visible: identityProofDropdownValue != 'Select' ? true : false,
            child: TextFormField(
              controller:identityProofNoController,
              keyboardType: TextInputType.text,
              autocorrect: false,
              decoration: ThemeHelper().textInputDecorationNoicon("Identity Proof No", "Enter Identity Proof No", Icon(Icons.person, color: Colors.grey)),
              onSaved: (String? value) { 
                if (value != null) { 
                  data.identityProofNo = value;
                }
              },
              validator: (val) {
                if (identityProofDropdownValue != 'Select' && (val == null || val.isEmpty)) {
                  return "Please enter Identity Proof No";
                } else {
                  data.identityProofNo = val!;
                }
                return null;
              },
              maxLines: 1,
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller:qualificationController,
            keyboardType: TextInputType.text,
            autocorrect: false,
            decoration: ThemeHelper().textInputDecorationNoicon("Qualification", "Enter Qualification", Icon(Icons.person, color: Colors.grey)),
            onSaved: (String? value) { 
              if (value != null) { 
                data.qualification = value;
              }
            },
            validator: (val) {
              data.qualification = val!;
              return null;
            },
            maxLines: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                //Icon(Icons.accessibility),
                Text('Job Type',style: styleDate,),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonFormField<String>(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 20,
                  iconDisabledColor: Colors.blue,
                  iconEnabledColor: Colors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                  hint: const Text('Select job Type'),
                  dropdownColor: Colors.white,
                  value: jobTypeDropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      jobTypeDropdownValue = newValue!;
                    });
                  },
                  items: ['Select','Govt','Private','Self', 'Un Employee']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                ),
              ),
              IconButton(
                icon: Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    jobTypeDropdownValue = 'Select';
                  });
                },
              ),
            ],
          ),
          Visibility(
            visible: jobTypeDropdownValue == "Govt" ? true : false,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        //Icon(Icons.accessibility),
                        Text('Job portal',style: styleDate,),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          iconSize: 20,
                          iconDisabledColor: Colors.blue,
                          iconEnabledColor: Colors.grey,
                          validator: (value) => jobTypeDropdownValue == "Govt" && value == null ? 'job portal required' : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                          hint: const Text('Select job portal'),
                          dropdownColor: Colors.white,
                          value: jobportalDropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              jobportalDropdownValue = newValue!;
                            });
                          },
                          items: ['Select','Central Govt','State Govt']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            jobportalDropdownValue = 'Select';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                ]
              )
            ),
          ),
          SizedBox(height: 10.0),
          Visibility(
            visible: jobTypeDropdownValue != "Select" ? true : false,
            child: TextFormField(
              controller:jobdetailsController,
              keyboardType: TextInputType.text,
              autocorrect: false,
              decoration: ThemeHelper().textInputDecorationNoicon("Job Details", "Enter job details", Icon(Icons.person, color: Colors.grey)),
              onSaved: (String? value) { 
                if (value != null) { 
                  data.jobdetails = value;
                }
              },
              validator: (val) {
                data.jobdetails = val!;
                return null;
              },
              maxLines: 1,
            ),
          ),
          SizedBox(height: 10.0),
          Visibility(
            visible: jobTypeDropdownValue == "Govt" || jobTypeDropdownValue == "Private",
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text('Job Professional', style: styleDate),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          iconSize: 20,
                          iconDisabledColor: Colors.blue,
                          iconEnabledColor: Colors.grey,
                          validator: (value) {
                            if (jobTypeDropdownValue == "Govt" && value == 'Select') {
                              return 'Job portal required';
                            }
                            return null;
                          },
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
                          hint: const Text('Select job Professional'),
                          dropdownColor: Colors.white,
                          value: jobProfessionalDropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              jobProfessionalDropdownValue = newValue!;
                            });
                          },
                          items: ['Select', 'Working', 'Retired']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            jobProfessionalDropdownValue = 'Select';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class _StepFourForm extends StatefulWidget {
  final Map<String, dynamic> memberData;
  final String pageaction;

  const _StepFourForm({Key? key, required this.memberData, required this.pageaction}) : super(key: key);

  @override
  _StepFourFormState createState() => _StepFourFormState();
}

class _StepFourFormState extends State<_StepFourForm> {
  @override
  void initState() {
    super.initState();
    if (widget.pageaction == 'edit') {
      familyMembers = (widget.memberData['familyMembers'] as List)
          .map((memberJson) => FamilyMember.fromJson(memberJson))
          .toList();
    }
  }

  void _addFamilyMember(BuildContext context, {FamilyMember? member}) {
    // Navigate to a new screen to add a family member
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditFamilyMemberScreen(
          onSave: (newMember) {
            setState(() {
              familyMembers.add(newMember);
            });
            Navigator.pop(context); // Close the add/edit screen
          },
        ),
      ),
    );
  }

  void _editFamilyMember(BuildContext context, FamilyMember member) {
    family_edit_id = member.id;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditFamilyMemberScreen(
          member: member,
          onSave: (editedMember) {
            setState(() {
              final index = familyMembers.indexWhere((m) {
                return m.id == family_edit_id;
              });
              if (index != -1) {
                familyMembers[index] = editedMember;
              }
            });
            Navigator.pop(context); // Close the add/edit screen
          },
        ),
      ),
    );
  }

  void _deleteFamilyMember(FamilyMember member) {
    setState(() {
      familyMembers = familyMembers.map((m) {
        if (m.id == member.id) {
          m.isDelete = true;
        }
        return m;
      }).toList();
    }); 
  }

  void _viewFamilyMember(BuildContext context, FamilyMember member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Family Member Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Family ID :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.familyId), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Family Name:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.familyName), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'name:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.lastName +' '+ member.firstName), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Status:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.status), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Relation:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.relation), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: member.isMember,
                        child: Row(
                          children: [
                            Text(
                              'Member ID:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Text(member.memberId), // Accessing data value here
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Gender:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.gender), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Date of Birth:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.dob), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Phone No:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.phoneNumber), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Marital Status:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.maritalStatus), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      
                      Row(
                        children: [
                          Text(
                            'Husband / Wife Name:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.husbandOrWifeName),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Identity Proof:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.identityProof),
                        ],
                      ),
                      Visibility(
                        visible: member.identityProof != null ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: Row(
                            children: [
                              Text(
                                'Identity Proof No:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(member.identityProofNo),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Qualification:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.qualification),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Address:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.address),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Nationality:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.nationality),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Job Type:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.jobType),
                        ],
                      ),
                      Visibility(
                        visible: member.jobType == "Govt" ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: Row(
                            children: [
                              Text(
                                'Job Portal:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(member.jobPortal),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Job Details:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.jobDetails),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final visibleFamilyMembers = familyMembers.where((m) => !m.isDelete).toList();
    return Form(
      key: formKeys[3],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Family Details', style: styleDate),
                Visibility(
                  visible: widget.pageaction == 'edit',
                  child: TextButton.icon(
                    onPressed: () {
                      _addFamilyMember(context);
                    },
                    icon: Icon(Icons.add), // Icon
                    label: Text('Add Family Members'),
                  ),
                ),
              ],
            ),
          ),

          Visibility(
            visible: visibleFamilyMembers.isNotEmpty,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Relation')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('')),
                ],
                rows: (visibleFamilyMembers as List<dynamic>).map<DataRow>((member) {
                  return DataRow(cells: [
                    DataCell(Text(member.lastName.toString() + ' ' + member.firstName.toString())),
                    DataCell(Text(capitalize(member.relation.toString().toLowerCase()))),
                    DataCell(Text(capitalize(member.status.toString().toLowerCase()))),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5), // Adjust padding as needed
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.remove_red_eye, size: 15),
                              onPressed: () {
                                _viewFamilyMember(context, member);
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5), // Adjust padding as needed
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.edit, size: 15),
                              onPressed: () {
                                _editFamilyMember(context, member);
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5), // Adjust padding as needed
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.delete, size: 15),
                              onPressed: () {
                                _deleteFamilyMember(member);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
            replacement: Text('Family Details not added'),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Map<String, dynamic> memberData;
  final String pageaction;

  const _Overview({Key? key, required this.memberData, required this.pageaction}) : super(key: key);

  void _viewFamilyMember(BuildContext context, FamilyMember member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Family Member Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Family ID :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.familyId), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Family Name:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.familyName), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'name:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.lastName +' '+ member.firstName), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Status:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.status), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Relation:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.relation), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: member.isMember,
                        child: Row(
                          children: [
                            Text(
                              'Member ID:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Text(member.memberId), // Accessing data value here
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Gender:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.gender), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Date of Birth:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.dob), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Phone No:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.phoneNumber), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Marital Status:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.maritalStatus), // Accessing data value here
                        ],
                      ),
                      SizedBox(height: 10),
                      
                      Row(
                        children: [
                          Text(
                            'Husband / Wife Name:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.husbandOrWifeName),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Identity Proof:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.identityProof),
                        ],
                      ),
                      Visibility(
                        visible: member.identityProof != null ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: Row(
                            children: [
                              Text(
                                'Identity Proof No:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(member.identityProofNo),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Qualification:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.qualification),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Address:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.address),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Nationality:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.nationality),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Job Type:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.jobType),
                        ],
                      ),
                      Visibility(
                        visible: member.jobType == "Govt" ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: Row(
                            children: [
                              Text(
                                'Job Portal:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(member.jobPortal),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Job Details:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(member.jobDetails),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final visibleFamilyMembers = familyMembers.where((m) => !m.isDelete).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Member Type:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(memberTypeRadioButtonItem.toString().toLowerCase())) // Accessing data value here
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'First name:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(data.firstname), // Accessing data value here
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Last name:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(data.lastname), // Accessing data value here
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Father name:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(data.fathername), // Accessing data value here
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Mother name:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(data.mothername), // Accessing data value here
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Phone no:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(data.phone), // Accessing data value here
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Gender:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(genderRadioButtonItem.toString().toLowerCase()))
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Date of Birth:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(data.dob),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Marital Status:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(maritalRadioButtonItem.toString().toLowerCase()))
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'User Type:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(userTypeRadioButtonItem.toString().toLowerCase()))
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Administrator:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(isAdministratorRadioButtonItem.toString().toLowerCase()))
                ],
              ),
              Visibility(
                visible: isAdministratorRadioButtonItem == true ? true : false,
                child: Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Row(
                    children: [
                      Text(
                        'position:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(capitalize(positionDropdownValue.toString().toLowerCase()))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Chit Administrator:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(isChitAdministratorRadioButtonItem.toString().toLowerCase()))
                ],
              ),
              Visibility(
                visible: isChitAdministratorRadioButtonItem == true ? true : false,
                child: Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Row(
                    children: [
                      Text(
                        'Chit position:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(capitalize(chitpositionDropdownValue.toString().toLowerCase()))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Address:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(data.address.toString().toLowerCase())),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Identity Proof:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(identityProofDropdownValue.toString().toLowerCase())),
                ],
              ),
              Visibility(
                visible: identityProofDropdownValue != null ? true : false,
                child: Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Row(
                    children: [
                      Text(
                        'Identity Proof No:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(capitalize(data.identityProofNo.toString().toLowerCase())),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Qualification:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(data.qualification.toString().toLowerCase())),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Job Type:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(jobTypeDropdownValue != 'Select' ? jobTypeDropdownValue.toString().toLowerCase() : '')),
                ],
              ),
              Visibility(
                visible: jobTypeDropdownValue != 'Select' && jobTypeDropdownValue == "Govt" ? true : false,
                child: Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Row(
                    children: [
                      Text(
                        'Job Portal:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(capitalize(jobportalDropdownValue != 'Select' ? jobportalDropdownValue.toString().toLowerCase() : '')),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Job Details:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(data.jobdetails.toString().toLowerCase())),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Job Professional:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(capitalize(jobProfessionalDropdownValue != 'Select' ? jobProfessionalDropdownValue.toString().toLowerCase() : '')),
                ],
              ),
              SizedBox(height: 10),
              Visibility(
                visible: familyMembers.isNotEmpty,
                child: Row(
                  children: [
                    Text(
                      'Family Details:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Visibility(
                visible: visibleFamilyMembers.isNotEmpty,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    columns: [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Relation')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('')),
                    ],
                    rows: (visibleFamilyMembers as List<dynamic>).map<DataRow>((member) {
                      return DataRow(cells: [
                        DataCell(Text(member.lastName.toString() + ' ' + member.firstName.toString())),
                        DataCell(Text(capitalize(member.relation.toString().toLowerCase()))),
                        DataCell(Text(capitalize(member.status.toString().toLowerCase()))),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5), // Adjust padding as needed
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.remove_red_eye, size: 15),
                                  onPressed: () {
                                    _viewFamilyMember(context, member);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]);
                    }).toList(),
                  )
                ),
                replacement: Text('Family Details not added'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AddEditFamilyMemberScreen extends StatefulWidget {
  final Function onSave;
  final FamilyMember? member;

  AddEditFamilyMemberScreen({required this.onSave, this.member});

  @override
  _AddEditFamilyMemberScreenState createState() =>
      _AddEditFamilyMemberScreenState();
}

class _AddEditFamilyMemberScreenState extends State<AddEditFamilyMemberScreen> {
  bool showDetails = false;
  
  String? familyRelationLevelValue;
  @override
  void initState() {
    super.initState();
    if (widget.member != null) {
      family_isnewFamily = widget.member!.isnewFamily;
      family_ismemberRadioButtonItem = widget.member!.isMember;
      family_familyIdController.text = widget.member!.familyId;
      family_familyNameController.text = widget.member!.familyName;
      family_member_IdController.text = widget.member!.member_Id;
      family_genderRadioButtonItem = widget.member!.gender;
      //family_realtionDropdownValue = widget.member!.relation ?? "";
      family_maritalRadioButtonItem = widget.member!.maritalStatus;
      family_identityProofDropdownValue = widget.member!.identityProof  == '' ? 'Select' : widget.member!.identityProof;
      family_jobTypeDropdownValue = widget.member!.jobType  == '' ? 'Select' : widget.member!.jobType;
      family_jobProfessionalDropdownValue= widget.member!.jobProfessional  == '' ? 'Select' : widget.member!.jobProfessional;
      
      // family_jobportalDropdownValue = widget.member!.jobPortal?? "Select";
      family_statusDropdownValue = widget.member!.status  == '' ? 'Select' : widget.member!.status;
      family_firstNameController.text = widget.member!.firstName;
      family_lastNameController.text = widget.member!.lastName;
      family_dateController.text = widget.member!.dob;
      family_phoneController.text = widget.member!.phoneNumber;
      family_husorwife_nameController.text = widget.member!.husbandOrWifeName;
      family_identityProofNoController.text = widget.member!.identityProofNo;
      family_jobdetailsController.text = widget.member!.jobDetails;
      family_addressController.text = widget.member!.address;
      family_qualificationController.text = widget.member!.qualification;
      family_ismarriedsameplace = widget.member!.isMarriedSamePlace;
      family_marriedpersionIdController.text = widget.member!.marriedPersonId;
      family_remarkController.text=widget.member!.remark;
      family_isaddBelowMember = widget.member!.family_isaddBelowMember;
      familySubId= widget.member!.familySubId;
    } else {
      family_isnewFamily = false;
      family_isaddBelowMember = false;
      family_ismemberRadioButtonItem = false;
      family_familyIdController.text = "";
      family_familyNameController.text = "";
      family_member_IdController.text = "";
      family_genderRadioButtonItem ='male';
      family_realtionDropdownValue = 'Select';
      family_maritalRadioButtonItem = "single";
      family_identityProofDropdownValue = "Select";
      family_jobTypeDropdownValue = "Select";
      family_jobProfessionalDropdownValue = 'Select';
      family_jobportalDropdownValue = "Select";
      family_statusDropdownValue = "Select";
      family_firstNameController.text = "";
      family_lastNameController.text = "";
      family_dateController.text = "";
      family_phoneController.text = "";
      family_husorwife_nameController.text = "";
      family_identityProofNoController.text = "";
      family_jobdetailsController.text = "";
      family_addressController.text = "";
      family_qualificationController.text = "";
      family_ismarriedsameplace = false;
      family_marriedpersionIdController.text = "";
      family_remarkController.text="";
      familyRelations = [];
      family_isaddBelowMember= false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<UserDetailProvider>(context, listen: false).clearUserDetails();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.member != null
            ? 'Edit Family Member'
            : 'Add Family Member',
            style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    //Icon(Icons.accessibility),
                    Text('Added New Family',style: styleDate,),
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
                      groupValue: family_isnewFamily,
                      activeColor: primaryColor,
                      selectedTileColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          family_isnewFamily = true;
                          family_familyIdController.text="";
                          family_familyNameController.text = '';
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
                      groupValue: family_isnewFamily,
                      activeColor: primaryColor,
                      selectedTileColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          family_isnewFamily = false;
                          family_familyIdController.text='';
                          family_familyNameController.text = '';
                        });
                      },
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Visibility(
                visible: family_isnewFamily == false ? true : false,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: family_familyNameController,
                        autocorrect: false,
                        decoration: ThemeHelper().textInputDecorationNoicon("Family Name", "Search Family Name", Icon(Icons.person, color: Colors.grey)),
                        onSaved: (String? value) { 
                          if (value != null) { 
                            family_familyNameController.text = value;
                          }
                        },
                        enabled:false,
                        maxLines: 1,
                        validator: (val) {
                        if (family_isnewFamily == false && (val == null || val.isEmpty)) {
                            return "Please enter Family Name";
                          }else {
                            family_familyNameController.text = val!;
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.grey),
                      onPressed: () {
                        family_searchmemberIdController.text = "";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchMemberScreen(searchType:'family'),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          family_familyIdController.text='';
                          family_familyNameController.text = '';
                          familyRelations = [];
                        });
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: family_isnewFamily == false ? true : false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text('Add below to the other member',style: styleDate,),
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
                            groupValue: family_isaddBelowMember,
                            activeColor: primaryColor,
                            selectedTileColor: primaryColor,
                            onChanged: (value) {
                              setState(() {
                                family_isaddBelowMember = true;
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
                            groupValue: family_isaddBelowMember,
                            activeColor: primaryColor,
                            selectedTileColor: primaryColor,
                            onChanged: (value) {
                              setState(() {
                                family_isaddBelowMember = false;
                              });
                            },
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: family_isnewFamily == false && family_isaddBelowMember == true,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text('Level', style: styleDate),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: DropdownButtonFormField<String>(
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
                            hint: const Text('Select Level'),
                            dropdownColor: Colors.white,
                            value: familyRelationLevelValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                familyRelationLevelValue = newValue;
                              });
                            },
                            items: familyRelations.map<DropdownMenuItem<String>>((DropdownItem item) {
                              return DropdownMenuItem<String>(
                                value: item.value,
                                child: Text(item.label),
                              );
                            }).toList(),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              familyRelationLevelValue = null;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    //Icon(Icons.accessibility),
                    Text('Already Member?',style: styleDate,),
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
                      groupValue: family_ismemberRadioButtonItem,
                      activeColor: primaryColor,
                      selectedTileColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          family_ismemberRadioButtonItem = true;
                          family_memberIdController.text = '';
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
                      groupValue: family_ismemberRadioButtonItem,
                      activeColor: primaryColor,
                      selectedTileColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          family_ismemberRadioButtonItem = false;
                          family_memberIdController.text = '';
                        });
                      },
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 10.0),
              Visibility(
                visible: family_ismemberRadioButtonItem,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: family_memberIdController,
                        autocorrect: false,
                        decoration: ThemeHelper().textInputDecorationNoicon("Member ID", "Search Member name", Icon(Icons.person, color: Colors.grey)),
                        onSaved: (String? value) { 
                          if (value != null) { 
                            family_memberIdController.text = value;
                          }
                        },
                        enabled:false,
                        maxLines: 1,
                        validator: (val) {
                        if (family_ismemberRadioButtonItem == true && (val == null || val.isEmpty)) {
                            return "Please enter valid number";
                          }else {
                            family_memberIdController.text = val!;
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.grey),
                      onPressed: () {
                        family_searchmemberIdController.text = "";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchMemberScreen(searchType:'member'),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          family_memberIdController.text = '';
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    //Icon(Icons.accessibility),
                    Text('Gender',style: sstyleDate,),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                      title: Transform.translate(offset: const Offset(-20, 0), child: Text('Male')),
                      value: "male", 
                      groupValue: family_genderRadioButtonItem, 
                      activeColor: primaryColor,
                      selectedTileColor:primaryColor,
                      onChanged:isDisabled ? null : (value) {
                        setState(() {
                            family_genderRadioButtonItem = value.toString();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                      title: Transform.translate(offset: const Offset(-20, 0), child: Text('Female')),
                      value: "female", 
                      groupValue: family_genderRadioButtonItem, 
                      activeColor: primaryColor,
                      selectedTileColor:primaryColor,
                      onChanged:isDisabled ? null : (value) {
                        setState(() {
                            family_genderRadioButtonItem = value.toString();
                        });
                      },
                    ),
                  ),
                  Spacer(),
                ],
              ),
              TextFormField(
                controller: family_firstNameController,
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: ThemeHelper().textInputDecorationNoicon("First Name", "Enter your First name", Icon(Icons.person, color: Colors.grey)),
                onSaved: (String? value) { 
                  if (value != null) { 
                    family_firstNameController.text = value;
                  }
                },
                maxLines: 1,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter first name";
                  } else {
                    family_firstNameController.text = val;
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: family_lastNameController,
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: ThemeHelper().textInputDecorationNoicon("Last Name", "Enter your last name", Icon(Icons.person, color: Colors.grey)),
                onSaved: (String? value) { 
                  if (value != null) { 
                    family_lastNameController.text = value;
                  }
                },
                maxLines: 1,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter last name";
                  } else {
                    family_lastNameController.text = val;
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: family_dateController,
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: Icon(Icons.calendar_today, size: 18.0, color: Colors.grey),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                    selectableDayPredicate: (DateTime date) {
                      return date.isBefore(DateTime.now());
                    },
                  );
                  if (pickedDate != null) {
                    setState(() {
                      family_dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                    });
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: family_phoneController,
                keyboardType: TextInputType.phone,
                autocorrect: false,
                decoration: ThemeHelper().textInputDecorationNoicon("Phone No", "Enter phone no", Icon(Icons.person, color: Colors.grey)),
                onSaved: (String? value) { 
                  if (value != null) { 
                    family_phoneController.text = value;
                  }
                },
                maxLines: 1,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter valid number";
                  }else {
                    family_phoneController.text = val;
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    //Icon(Icons.accessibility),
                    Text('Relation',style: styleDate,),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 20,
                      iconDisabledColor: Colors.blue,
                      iconEnabledColor: Colors.grey,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                      hint: const Text('Select Relation'),
                      dropdownColor: Colors.white,
                      value: family_realtionDropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          family_realtionDropdownValue = newValue!;
                        });
                      },
                      items: ['Select','தந்தை','தாய்','குடும்பத் தலைவர்','குடும்பத் தலைவி','கணவர்','மனைவி','மகன்', 'மகள்', 'மருமகன்', 'மருமகள்', 'பேரன்', 'பேத்தி', 'கொள்ளுப் பேரன்', 'கொள்ளுப் பேத்தி']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        family_realtionDropdownValue = null;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    //Icon(Icons.accessibility),
                    Text('Marital Status',style: styleDate,),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                      title: Transform.translate(offset: const Offset(-20, 0), child: Text('Single')),
                      value: "single", 
                      groupValue: family_maritalRadioButtonItem, 
                      activeColor: primaryColor,
                      selectedTileColor:primaryColor,
                      onChanged:isDisabled ? null : (value) {
                        setState(() {
                            family_maritalRadioButtonItem = value.toString();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                      title: Transform.translate(offset: const Offset(-20, 0), child: Text('Married')),
                      value: "married", 
                      groupValue: family_maritalRadioButtonItem, 
                      activeColor: primaryColor,
                      selectedTileColor:primaryColor,
                      onChanged:isDisabled ? null : (value) {
                        setState(() {
                            family_maritalRadioButtonItem = value.toString();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0), 
                      title: Transform.translate(offset: const Offset(-20, 0), child: Text('Widowed')),
                      value: "widowed", 
                      groupValue: family_maritalRadioButtonItem, 
                      activeColor: primaryColor,
                      selectedTileColor:primaryColor,
                      onChanged:isDisabled ? null : (value) {
                        setState(() {
                            family_maritalRadioButtonItem = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    //Icon(Icons.accessibility),
                    Text('Married same place?',style: styleDate,),
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
                      groupValue: family_ismarriedsameplace,
                      activeColor: primaryColor,
                      selectedTileColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          family_ismarriedsameplace = true;
                          family_marriedpersionIdController.text = '';
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
                      groupValue: family_ismarriedsameplace,
                      activeColor: primaryColor,
                      selectedTileColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          family_ismarriedsameplace = false;
                          family_marriedpersionIdController.text = '';
                        });
                      },
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 10.0),
              Visibility(
                visible:family_ismarriedsameplace == true ? true : false,
                child: TextFormField(
                  controller: family_marriedpersionIdController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: ThemeHelper().textInputDecorationNoicon("Married Persion Member Id", "Enter Married Persion Member Id", Icon(Icons.person, color: Colors.grey)),
                  onSaved: (String? value) { 
                    if (value != null) { 
                      family_marriedpersionIdController.text = value;
                    }
                  },
                  maxLines: 1,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter Married Persion Member Id";
                    } else {
                      family_marriedpersionIdController.text = val;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Visibility(
                visible:family_maritalRadioButtonItem != 'single' ? true : false,
                child: TextFormField(
                  controller: family_husorwife_nameController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: ThemeHelper().textInputDecorationNoicon("Husband / Wife Name", "Enter your Husband / Wife name", Icon(Icons.person, color: Colors.grey)),
                  onSaved: (String? value) { 
                    if (value != null) { 
                      family_husorwife_nameController.text = value;
                    }
                  },
                  maxLines: 1,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter Husband / Wife name";
                    } else {
                      family_husorwife_nameController.text = val;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller:family_addressController,
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: ThemeHelper().textInputDecorationNoicon("Address", "Enter Address", Icon(Icons.person, color: Colors.grey)),
                onSaved: (String? value) { 
                  if (value != null) { 
                    family_addressController.text = value;
                  }
                },
                validator: (val) {
                  family_addressController.text = val!;
                  return null;
                },
                maxLines: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    //Icon(Icons.accessibility),
                    Text('Identity Proof',style: styleDate,),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 20,
                      iconDisabledColor: Colors.blue,
                      iconEnabledColor: Colors.grey,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                      hint: const Text('Select Identity Proof'),
                      dropdownColor: Colors.white,
                      value: family_identityProofDropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          family_identityProofDropdownValue = newValue!;
                        });
                      },
                      items: ['Select','Driving License','PAN Card','Aadhaar', 'Passport']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        family_identityProofDropdownValue = 'Select';
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Visibility(
                visible: family_identityProofDropdownValue != 'Select' ? true : false,
                child: TextFormField(
                  controller:family_identityProofNoController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: ThemeHelper().textInputDecorationNoicon("Identity Proof No", "Enter Identity Proof No", Icon(Icons.person, color: Colors.grey)),
                  onSaved: (String? value) { 
                    if (value != null) { 
                      family_identityProofNoController.text = value;
                    }
                  },
                  validator: (val) {
                    if (family_identityProofDropdownValue != 'Select' && (val == null || val.isEmpty)) {
                      return "Please enter Identity Proof No";
                    } else {
                      family_identityProofNoController.text = val!;
                    }
                    return null;
                  },
                  maxLines: 1,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller:family_qualificationController,
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: ThemeHelper().textInputDecorationNoicon("Qualification", "Enter Qualification", Icon(Icons.person, color: Colors.grey)),
                onSaved: (String? value) { 
                  if (value != null) { 
                    family_qualificationController.text = value;
                  }
                },
                validator: (val) {
                  family_qualificationController.text = val!;
                  return null;
                },
                maxLines: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    //Icon(Icons.accessibility),
                    Text('Job Type',style: styleDate,),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 20,
                      iconDisabledColor: Colors.blue,
                      iconEnabledColor: Colors.grey,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                      hint: const Text('Select job Type'),
                      dropdownColor: Colors.white,
                      value: family_jobTypeDropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          family_jobTypeDropdownValue = newValue!;
                        });
                      },
                      items: ['Select','Govt','Private','Self', 'Un Employee']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        family_jobTypeDropdownValue = 'Select';
                      });
                    },
                  ),
                ],
              ),
              Visibility(
                visible: family_jobTypeDropdownValue == "Govt" && family_jobTypeDropdownValue != "Select" ? true : false,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            //Icon(Icons.accessibility),
                            Text('Job portal',style: styleDate,),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              icon: const Icon(Icons.keyboard_arrow_down_rounded),
                              iconSize: 20,
                              iconDisabledColor: Colors.blue,
                              iconEnabledColor: Colors.grey,
                              validator: (value) => family_jobTypeDropdownValue == "Govt" && value == null ? 'job portal required' : null,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                              hint: const Text('Select job portal'),
                              dropdownColor: Colors.white,
                              value: family_jobportalDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  family_jobportalDropdownValue = newValue!;
                                });
                              },
                              items: ['Select','Central Govt','State Govt']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                family_jobportalDropdownValue = null;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                    ]
                  )
                ),
              ),
              SizedBox(height: 10.0),
              Visibility(
                visible:family_jobTypeDropdownValue != null && family_jobTypeDropdownValue != 'Select' ? true : false,
                child: TextFormField(
                  controller:family_jobdetailsController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: ThemeHelper().textInputDecorationNoicon("Job Details", "Enter job details", Icon(Icons.person, color: Colors.grey)),
                  onSaved: (String? value) { 
                    if (value != null) { 
                      family_jobdetailsController.text = value;
                    }
                  },
                  validator: (val) {
                    family_jobdetailsController.text = val!;
                    return null;
                  },
                  maxLines: 1,
                ),
              ),
              Visibility(
                visible: family_jobTypeDropdownValue == "Govt" && family_jobTypeDropdownValue != "Select" ? true : false,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            //Icon(Icons.accessibility),
                            Text('Job portal',style: styleDate,),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              icon: const Icon(Icons.keyboard_arrow_down_rounded),
                              iconSize: 20,
                              iconDisabledColor: Colors.blue,
                              iconEnabledColor: Colors.grey,
                              validator: (value) => family_jobTypeDropdownValue == "Govt" && value == null ? 'job portal required' : null,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                              hint: const Text('Select job portal'),
                              dropdownColor: Colors.white,
                              value: family_jobProfessionalDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  family_jobProfessionalDropdownValue = newValue!;
                                });
                              },
                              items: ['Select','Working','Retired']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                family_jobProfessionalDropdownValue = 'Select';
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                    ]
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    //Icon(Icons.accessibility),
                    Text('Status',style: styleDate,),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 20,
                      iconDisabledColor: Colors.blue,
                      iconEnabledColor: Colors.grey,
                      validator: (value) => family_statusDropdownValue == "Select" && value == null ? 'Status required' : null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20), //this one
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
                      hint: const Text('Select Status'),
                      dropdownColor: Colors.white,
                      value: family_statusDropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          family_statusDropdownValue = newValue!;
                        });
                      },
                      items: ['Select','active','death','suspend']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        family_statusDropdownValue = 'Select';
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Visibility(
                visible: family_statusDropdownValue != "Select" && family_statusDropdownValue != "active" ? true : false,
                child: TextFormField(
                  controller:family_remarkController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: ThemeHelper().textInputDecorationNoicon("Remark", "Enter Remark", Icon(Icons.person, color: Colors.grey)),
                  onSaved: (String? value) { 
                    if (value != null) { 
                      family_remarkController.text = value;
                    }
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter Remark";
                    }else {
                      family_remarkController.text = val;
                    }
                    return null;
                  },
                  maxLines: 1,
                ),
              ),
              SizedBox(height: 50.0),
              // Center(
              //   child: Container(
              //     decoration: ThemeHelper().buttonBoxDecoration(context),
              //     child: ElevatedButton(
              //       style: ThemeHelper().buttonStyle(),
              //       child: Padding(
              //         padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
              //         child: Text('Save'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
              //       ),
              //       onPressed: () {
              //         // if(_formKey.currentState!.validate()) {
              //         //   loginUser();
              //         // }
              //       },
              //       //onPressed: loginUser,
              //     ),
              //   ),
              // ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FamilyMember member = FamilyMember(
            id: widget.member != null ? family_edit_id : '',
            isnewFamily: family_isnewFamily,
            isMarriedSamePlace: family_ismarriedsameplace,
            marriedPersonId: family_marriedpersionIdController.text,
            familyId: family_familyIdController.text,
            familyName: family_familyNameController.text,
            subId: '',
            levelNo: '',
            isMember: family_ismemberRadioButtonItem,
            member_Id: family_member_IdController.text,
            memberId: family_memberIdController.text,
            firstName: family_firstNameController.text,
            lastName: family_lastNameController.text,
            gender: family_genderRadioButtonItem,
            dob: family_dateController.text,
            phoneNumber: family_phoneController.text,
            relation: family_realtionDropdownValue == 'Select' ? '' :family_realtionDropdownValue.toString(),
            maritalStatus: family_maritalRadioButtonItem,
            husbandOrWifeName: family_husorwife_nameController.text,
            identityProof: family_identityProofDropdownValue == 'Select' ? '' :family_identityProofDropdownValue.toString(),
            identityProofNo: family_identityProofNoController.text,
            address: family_addressController.text,
            nationality: 'indian',
            qualification: family_qualificationController.text,
            jobType: family_jobTypeDropdownValue == 'Select' ? '' :family_jobTypeDropdownValue.toString(),
            jobPortal: family_jobportalDropdownValue == 'Select' ? '' :family_jobportalDropdownValue.toString(),
            jobDetails: family_jobdetailsController.text,
            status: family_statusDropdownValue == 'Select' ? '' :family_statusDropdownValue.toString(),
            remark: family_remarkController.text,
            isSameParent: false,
            sameParentFatherFamilyId: '',
            sameParentMotherFamilyId: '',
            family_isaddBelowMember:family_isaddBelowMember,
            familySubId: familyRelationLevelValue.toString(),
            jobProfessional: family_jobProfessionalDropdownValue == 'Select' ? '' :family_jobProfessionalDropdownValue.toString(),
            isDelete: false
          );
          widget.onSave(member);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

class SearchMemberScreen extends StatefulWidget {
  final String searchType;
  SearchMemberScreen({required this.searchType});
  @override
  _SearchMemberScreenState createState() => _SearchMemberScreenState();
}

class _SearchMemberScreenState extends State<SearchMemberScreen> {
  bool showDetails = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<SearchMemberProvider>(context, listen: false)
            .clearSearchMembersDetails());
  }

  Future<void> fetchData(String familyId) async {
    // setState(() {
      familyRelations = [];
    // });
    final Map<String, dynamic> requestData = {
      'familyId': familyId,
    };

    try {
      final response = await http.post(
        Uri.parse('${Constants.uri}/api/familyDetails/familyLevel/'),
        body: json.encode(requestData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        List<dynamic> levels = jsonMap['familyLevels'];
        //setState(() {
          familyRelations = levels.map((level) {
            return DropdownItem(
              value: level['value'],
              label: level['label'],
            );
          }).toList();
        //});
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String searchText = widget.searchType == 'member' ? 'Search Member' : 'Search family'; 
    String searchhintText = widget.searchType == 'member' ? 'Search Member name' : 'Search family name'; 
    final searchMemberDetails = Provider.of<SearchMemberProvider>(context, listen: true).searchMemberDetails;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Member Details',
            style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _searchformKey,
                child: TextFormField(
                  controller: family_searchmemberIdController,
                  autocorrect: false,
                  decoration: ThemeHelper().textInputDecorationNoicon(
                    searchText, 
                    searchhintText, 
                    Icon(Icons.person, color: Colors.grey)
                  ),
                  onChanged: (text) {
                    if(text.length >= 2){
                      authService.memberSearch(
                        context: context,
                        searchvalue: text,
                        searchType:widget.searchType
                      );
                    }
                  },
                ),
              ),

              Visibility(
                visible: searchMemberDetails?.searchMemberDetails != null && searchMemberDetails?.searchMemberDetails != "" ? true : false,
                child: SizedBox(
                  height: 600, // Adjust the height according to your UI requirements
                  child: ListView.builder(
                    itemCount: searchMemberDetails?.searchMemberDetails.length,
                      itemBuilder: (context,index) {
                      final itemData = searchMemberDetails?.searchMemberDetails[index];
                      final memberId = itemData?.memberId;
                      final firstname = itemData?.firstname;
                      final lastname = itemData?.lastname;
                      final gender = itemData?.gender;
                      final status = itemData?.status;  
                      final familyId = itemData?.familyId;
                      final familyname = itemData?.familyname;
                      Color statusColor = Colors.green;
                      String imgeIcon = "";
                      if(gender == 'male'){
                        imgeIcon = maleImage;
                      } else if(gender == 'female'){
                        imgeIcon = femaleImage;
                      }
                      if(status == 'active'){
                        statusColor= Colors.green;
                      } else if(status == 'suspended'){
                        statusColor= Colors.yellow;
                      } else if(status == 'dismiss'){
                        statusColor= Colors.red;
                      } else if(status == 'death'){
                        statusColor= Colors.black;
                      }
              
                    return GestureDetector(
                      onTap: () {
                        if(widget.searchType == 'member'){
                          family_identityProofNoController.text = itemData!.identityProofNo != '' ? itemData!.identityProofNo.toString() : 'Select';;
                          family_memberIdController.text = itemData!.memberId.toString();
                          family_member_IdController.text = itemData!.id.toString();
                          family_genderRadioButtonItem =itemData!.gender.toString();
                          //family_realtionDropdownValue =  itemData!.relation != '' ? itemData!.relation.toString() : 'Select';
                          family_maritalRadioButtonItem = itemData!.maritalStatus.toString();
                          family_identityProofDropdownValue =  itemData!.identityProof != '' ? itemData!.identityProof.toString() : 'Select'; ;
                          family_jobTypeDropdownValue = itemData!.jobType != '' ? itemData!.jobType.toString() : 'Select';
                          family_jobportalDropdownValue = itemData!.jobportal != '' ? itemData!.jobportal.toString() : 'Select';
                          family_statusDropdownValue = itemData!.status != '' ? itemData!.status.toString() : 'Select';
                          family_firstNameController.text = itemData!.firstname.toString();
                          family_lastNameController.text = itemData!.lastname.toString();
                          family_dateController.text = itemData!.dob.toString();
                          family_phoneController.text = itemData!.phoneno.toString();
                          family_husorwife_nameController.text = "";
                          
                          family_jobdetailsController.text = itemData!.jobdetails.toString();
                          family_addressController.text = itemData!.address.toString();
                          family_qualificationController.text = itemData!.qualification.toString();
                          family_remarkController.text = itemData!.remark.toString();
                          family_ismarriedsameplace = false;
                          family_marriedpersionIdController.text = "";
                          family_jobProfessionalDropdownValue= itemData!.jobProfessional != '' ? itemData!.jobProfessional.toString() : 'Select';
                        } else {
                          family_familyNameController.text = itemData!.familyname.toString();
                          family_familyIdController.text= itemData!.familyId.toString();
                          fetchData(itemData!.familyId);
                        }
                        Navigator.pop(context);
                      },
                      child: SingleChildScrollView(
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.only(left:0,top: 5,bottom: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: widget.searchType == 'member',
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: statusColor,
                                      child: Container(
                                          padding: EdgeInsets.all(2),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: AssetImage(imgeIcon),
                                            backgroundColor: statusColor,
                                            //
                                          )),
                                    ),
                                    title: Text(lastname.toString()+' '+firstname.toString(),style: TextStyle(fontSize: 16)),
                                    subtitle: Text('Member Id: '+memberId.toString(),style: TextStyle(fontSize: 15)),
                                    
                                  ),
                                ),
                                Visibility(
                                  visible: widget.searchType == 'family',
                                  child: ListTile(
                                    title: Text(familyname.toString(),style: TextStyle(fontSize: 16)),
                                    subtitle: Text('Family Id: '+familyId.toString(),style: TextStyle(fontSize: 15)),
                                    
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

