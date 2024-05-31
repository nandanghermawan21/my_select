class OptionModel {
  String? id;
  String? title;
  String? description;

  OptionModel({
    this.id,
    this.title,
    this.description,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  // dummy
  static List<OptionModel> get dummyData => [
        OptionModel(
          id: '1',
          title: 'Title 1',
          description: 'Description 1',
        ),
        OptionModel(
          id: '2',
          title: 'Title 2',
          description: 'Description 2',
        ),
        OptionModel(
          id: '3',
          title: 'Title 3',
          description: 'Description 3',
        ),
        OptionModel(
          id: '4',
          title: 'Title 4',
          description: 'Description 4',
        ),
        OptionModel(
          id: '5',
          title: 'Title 5',
          description: 'Description 5',
        ),
        OptionModel(
          id: '6',
          title: 'Title 6',
          description: 'Description 6',
        ),
      ];
}
