class Bookmark_Model {
  String no = '';
  String date_ = '';
  String address_ = '';
  String predict = '';

  Bookmark_Model(
      {no,
        date_,
        address_,
        predict});

  Bookmark_Model.fromJson(Map<String, dynamic> json) {
    this.no = json['no'];
    this.date_ = json['date_'];
    this.address_ = json['address_'];
    this.predict = json['predict'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['date_'] = this.date_;
    data['address_'] = this.address_;
    data['predict'] = this.predict;
    return data;
  }
}
