class FAQ {
  String id;
  String clinicId;
  String question;
  String answer;

  FAQ({
    required this.id,
    required this.clinicId,
    required this.question,
    required this.answer,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      id: json['id'],
      clinicId: json['clinicId'],
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['clinicId'] = clinicId;
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}
