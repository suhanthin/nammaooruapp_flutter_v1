// import 'package:flutter/material.dart';
// class SearchMemberScreen extends StatefulWidget {
//   final String searchType;
//   SearchMemberScreen({required this.searchType});
//   @override
//   _SearchMemberScreenState createState() => _SearchMemberScreenState();
// }

// class _SearchMemberScreenState extends State<SearchMemberScreen> {
//   bool showDetails = false;
//   @override
//   void initState() {
//     super.initState();
//     print(widget.searchType);
    
//   }
//   @override
//   Widget build(BuildContext context) {
//     String searchText = widget.searchType == 'member' ? 'Search Member' : 'Search family'; 
//     String searchhintText = widget.searchType == 'member' ? 'Search Member name' : 'Search family name'; 
//     final userDetails = Provider.of<UserDetailProvider>(context, listen: true).userDetails;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Member Details',
//             style: TextStyle(color: Colors.white)),
//         backgroundColor: primaryColor,
//         leading: IconButton(
//           color: Colors.white,
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Form(
//                 key: _searchformKey,
//                 child: TextFormField(
//                   controller: family_searchmemberIdController,
//                   autocorrect: false,
//                   decoration: ThemeHelper().textInputDecorationNoicon(
//                     searchText, 
//                     searchhintText, 
//                     Icon(Icons.person, color: Colors.grey)
//                   ),
//                   onChanged: (text) {
//                     if(text.length >= 2){
//                       authService.memberSearch(
//                         context: context,
//                         searchvalue: text,
//                         searchType:widget.searchType
//                       );
//                     }
//                   },
//                 ),
//               ),


//               Visibility(
//                 visible: userDetails?.userDetails != null && userDetails?.userDetails != "" ? true : false,
//                 child: SizedBox(
//                   height: 600, // Adjust the height according to your UI requirements
//                   child: ListView.builder(
//                     itemCount: userDetails?.userDetails.length,
//                       itemBuilder: (context,index) {
//                       final itemData = userDetails?.userDetails[index];
//                       final memberId = itemData?.memberId;
//                       final firstname = itemData?.firstname;
//                       final lastname = itemData?.lastname;
//                       final gender = itemData?.gender;
//                       final status = itemData?.status;  
//                       final familyId = itemData?.familyId;
//                       final familyname = itemData?.familyname;
//                       Color statusColor = Colors.green;
//                       String imgeIcon = "";
//                       if(gender == 'male'){
//                         imgeIcon = maleImage;
//                       } else if(gender == 'female'){
//                         imgeIcon = femaleImage;
//                       }
//                       if(status == 'active'){
//                         statusColor= Colors.green;
//                       } else if(status == 'suspended'){
//                         statusColor= Colors.yellow;
//                       } else if(status == 'dismiss'){
//                         statusColor= Colors.red;
//                       } else if(status == 'death'){
//                         statusColor= Colors.black;
//                       }
              
//                     return GestureDetector(
//                       onTap: () {
//                         if(widget.searchType == 'member'){
//                         family_memberIdController.text = itemData!.id.toString();
//                           family_member_IdController.text = itemData!.memberId.toString();
//                           family_genderRadioButtonItem =itemData!.gender.toString();
//                           family_realtionDropdownValue = itemData!.relation.toString();
//                           family_maritalRadioButtonItem = itemData!.maritalStatus.toString();
//                           family_identityProofDropdownValue = itemData!.identityProof.toString();
//                           family_jobTypeDropdownValue = itemData!.jobType.toString();
//                           family_jobportalDropdownValue = itemData!.jobportal.toString();
//                           family_statusDropdownValue = itemData!.status.toString();
//                           family_firstNameController.text = itemData!.firstname.toString();
//                           family_lastNameController.text = itemData!.lastname.toString();
//                           family_dateController.text = itemData!.dob.toString();
//                           family_phoneController.text = itemData!.phoneno.toString();
//                           family_husorwife_nameController.text = "";
//                           family_identityProofNoController.text = itemData!.identityProofNo.toString();
//                           family_jobdetailsController.text = itemData!.jobdetails.toString();
//                           family_addressController.text = itemData!.address.toString();
//                           family_qualificationController.text = itemData!.qualification.toString();
//                           family_ismarriedsameplace = false;
//                           family_marriedpersionIdController.text = "";
//                         } else {
//                           family_familyNameController.text = itemData!.familyname.toString();
//                           family_familyIdController.text= itemData!.familyId.toString();
//                         }
//                         Navigator.pop(context);
//                       },
//                       child: SingleChildScrollView(
//                         child: Card(
//                           child: Padding(
//                             padding: EdgeInsets.only(left:0,top: 5,bottom: 5),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Visibility(
//                                   visible: widget.searchType == 'member',
//                                   child: ListTile(
//                                     leading: CircleAvatar(
//                                       radius: 20,
//                                       backgroundColor: statusColor,
//                                       child: Container(
//                                           padding: EdgeInsets.all(2),
//                                           child: CircleAvatar(
//                                             radius: 30,
//                                             backgroundImage: AssetImage(imgeIcon),
//                                             backgroundColor: statusColor,
//                                             //
//                                           )),
//                                     ),
//                                     title: Text(firstname.toString()+' '+lastname.toString(),style: TextStyle(fontSize: 16)),
//                                     subtitle: Text('Member Id: '+memberId.toString(),style: TextStyle(fontSize: 15)),
                                    
//                                   ),
//                                 ),
//                                 Visibility(
//                                   visible: widget.searchType == 'family',
//                                   child: ListTile(
//                                     title: Text(familyname.toString(),style: TextStyle(fontSize: 16)),
//                                     subtitle: Text('Family Id: '+familyId.toString(),style: TextStyle(fontSize: 15)),
                                    
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }