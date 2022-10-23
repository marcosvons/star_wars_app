mixin Crop {
  String cropEndpoint({required String endpoint}) {
    late String croppedEndpoint;
    int startIndex = endpoint.indexOf('/api');
    croppedEndpoint = endpoint.substring(startIndex + 5);
    return croppedEndpoint;
  }

  Map<String, dynamic> getPaginationInfo(Map<String, dynamic> json) {
    final Map<String, dynamic> paginationInfo = {};
    String? previousPage = json['previous'];
    String? nextPage = json['next'];
    if (previousPage != null) {
      int startIndex = previousPage.indexOf('people');
      paginationInfo['previous'] = previousPage.substring(startIndex);
      paginationInfo['page'] = int.parse(paginationInfo['previous']
          .substring(paginationInfo['previous'].indexOf('=') + 1)) +
          1;
    }
    if (nextPage != null) {
      int startIndex = nextPage.indexOf('people');
      paginationInfo['next'] = nextPage.substring(startIndex);
      paginationInfo['page'] = int.parse(paginationInfo['next']
          .substring(paginationInfo['next'].indexOf('=') + 1)) -
          1;
    }
    return paginationInfo;
  }
}
