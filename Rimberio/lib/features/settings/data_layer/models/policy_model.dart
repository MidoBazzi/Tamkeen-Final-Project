class PolicyModel {
  final int id;
  final String title;
  final String content;

  PolicyModel({required this.id, required this.title, required this.content});

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  static List<PolicyModel> fromJsonList(Map<String, dynamic> json) {
    List<PolicyModel> policies = [];
    json['data'].forEach((e) => policies.add(PolicyModel.fromJson(e)));
    return policies;
  }
}
