class StateModel {
  int stateId;
  String stateName;
  StateModel({required this.stateId, required this.stateName});
  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(stateId: json['id'], stateName: json['name']);
  }
 static List<StateModel> fromJsonList(Map<String, dynamic> json) {
    List<StateModel> state = [];
    json['data'].forEach((e) => state.add(StateModel.fromJson(e)));
    return state;
  }
}
