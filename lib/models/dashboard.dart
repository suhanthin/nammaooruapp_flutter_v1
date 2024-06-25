class DashboardModel {
  int aClassMaleMembers;
  int aClassFemaleMembers;
  int bClassMaleMembers;
  int bClassFemaleMembers;
  int cClassMaleMembers;
  int cClassFemaleMembers;

  DashboardModel({
    required this.aClassMaleMembers,
    required this.aClassFemaleMembers,
    required this.bClassMaleMembers,
    required this.bClassFemaleMembers,
    required this.cClassMaleMembers,
    required this.cClassFemaleMembers,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      aClassMaleMembers: int.parse(json['aClass_Male_members']),
      aClassFemaleMembers: int.parse(json['aClass_female_members']),
      bClassMaleMembers: int.parse(json['bClass_Male_members']),
      bClassFemaleMembers: int.parse(json['bClass_female_members']),
      cClassMaleMembers: int.parse(json['cClass_Male_members']),
      cClassFemaleMembers: int.parse(json['cClass_female_members']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aClass_Male_members': aClassMaleMembers.toString(),
      'aClass_female_members': aClassFemaleMembers.toString(),
      'bClass_Male_members': bClassMaleMembers.toString(),
      'bClass_female_members': bClassFemaleMembers.toString(),
      'cClass_Male_members': cClassMaleMembers.toString(),
      'cClass_female_members': cClassFemaleMembers.toString(),
    };
  }
}
