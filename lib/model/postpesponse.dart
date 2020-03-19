class PostResponse {
  bool error;
  String docId;
  String status;
  String message;
  PostResponse({this.error, this.docId, this.status, this.message});
  factory PostResponse.fromJson(Map<String, dynamic> json) {
    var postResponse = PostResponse(
      error: json['error'],
      docId: '${json['docId']}',
      status: json['status'],
      message: json['message'],
    );
    return postResponse;
  }
}