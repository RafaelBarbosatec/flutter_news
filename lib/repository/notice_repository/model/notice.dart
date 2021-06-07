class Notice {
  var img;
  var title;
  var date;
  var description;
  var category;
  var link;
  var origin;

  Notice.fromMap(Map<String, dynamic> map)
      : img = map['url_img'],
        title = map['tittle'],
        date = map['date'],
        description = map['description'],
        category = map['category'],
        link = map['link'],
        origin = map['origin'];
}
