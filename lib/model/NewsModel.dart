class NewsModel {
  String message, sender, title, time;
  NewsModel({this.message, this.sender, this.title, this.time });
  NewsModel.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        sender = json['sender'],
        title = json['title'],
        time = json['time'];

  @override
  Map<String, dynamic> toMap() {
    return {
      "message": message == null ? "" : message,
      "sender": sender == null ? "" : sender,
      "title": title == null ? "" : title,
      "time" : time == null ? "" : time
    };
  }
}