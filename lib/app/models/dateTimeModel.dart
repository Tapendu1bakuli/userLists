class DateTimeModel  {
  String? title;
  String? subTitle;
  bool? isColoured;
  Function()? ontap;

  DateTimeModel(
      {this.title, this.subTitle,  this.ontap, this.isColoured});

  DateTimeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['icon'];
    isColoured = json['isColoured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['secondTitle'] =
    this.subTitle;
    return data;
  }
}
