mixin JsonCommand {
  Map<String, dynamic> generate();
}

abstract class GraphqlCommand {
  static const String queryKey = 'query';
  static const String variablesKey = 'variables';
  GraphqlCommand() : super();
  String getGraphqlMutation();
  Map<String, dynamic> createVariablesJson();

  Map<String, dynamic> generate() {
    return {
      queryKey: getGraphqlMutation(),
      variablesKey: createVariablesJson(),
    };
  }
}

mixin JsonQuery {
  Map<String, dynamic> generate();
}

abstract class GraphqlQuery {
  static const String queryKey = 'query';
  static const String variablesKey = 'variables';
  String getGraphqlQuery();
  Map<String, dynamic> createVariablesJson() {
    return {};
  }

  Map<String, dynamic> generate() {
    return {
      queryKey: getGraphqlQuery(),
      variablesKey: createVariablesJson(),
    };
  }
}
