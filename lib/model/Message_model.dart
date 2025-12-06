class Message_model{
  String? id;
  String? messenger_textMessage;
  String? messenger_textHTML;
  String? messenger_sender;
  String? messenger_status;
  String? messenger_dateOfCreation;

  Message_model({
    required this.id,
    required this.messenger_textMessage,
    required this.messenger_textHTML,
    required this.messenger_sender,
    required this.messenger_status,
    required this.messenger_dateOfCreation,
  });
  Message_model.fromJson(Map<String ,dynamic> json){
    id=json['id'];
    messenger_textMessage=json['messenger_textMessage'];
    messenger_textHTML=json['messenger_textHTML'];
    messenger_sender=json['messenger_sender'];
    messenger_status=json['messenger_status'];
    messenger_dateOfCreation=json['messenger_dateOfCreation'];
  }
}

