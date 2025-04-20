class Message {
  static const String collectionName="message";
  String id;
  String roomId;
  String content;
  String senderId;
  String senderName;
  int dateTime;
  Message(
      {this.id = '',
      required this.roomId,
      required this.content,
      required this.dateTime,
      required this.senderId,
      required this.senderName});
  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          roomId: json['roomId'] as String,
          content: json['content'] as String,
          senderId: json['senderId'] as String,
          senderName: json['senderName'] as String,
          dateTime: json['dateTime'] as int,
        );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'content': content,
      'senderId': senderId,
      'senderName': senderName,
      'dateTime': dateTime
    };
  }
}
