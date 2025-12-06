class Car_model{
  String? id;
  String? formAnswers_status;
  String? formAnswers_userName;
  String? department_title;
  String? formAnswers_extraComment;
  String? formAnswers_date;
  String? userId;
  String? formAnswers_formId;
  Car_model({
    required this.id,
    required this.formAnswers_status,
    required this.formAnswers_userName,
    required this.department_title,
    required this.formAnswers_extraComment,
    required this.formAnswers_date,
    required this.userId,
    required this.formAnswers_formId,
  });
  Car_model.fromJson(Map<String ,dynamic> json){
    id=json['id'];
    formAnswers_status=json['formAnswers_status'];
    formAnswers_userName=json['formAnswers_userName'];
    department_title=json['department_title'];
    formAnswers_date=json['formAnswers_date'];
    formAnswers_extraComment=json['formAnswers_extraComment'];
    userId=json['userId'];
    formAnswers_formId=json['formAnswers_formId'];
  }
}

