class AppDataModel {
  String? isdCode;
  String? mobile;
  bool? isForMobileUpdate;
  bool isNoBack;

  AppDataModel(
      {this.isdCode,
      this.mobile,
      this.isForMobileUpdate,
      this.isNoBack = false});
}

class DashBoardDetail {
  String name;
  String imageName;
  Function() onTap;

  DashBoardDetail({
    required this.name,
    required this.imageName,
    required this.onTap,
  });
}

class DependantDetail {
  String name;
  Function() onTap;

  DependantDetail({
    required this.name,
    required this.onTap,
  });
}
