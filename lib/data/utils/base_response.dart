class BaseResponse<T> {
  final int page;
  final int totalPage;
  final int limit;
  final List<T> listResult;

  BaseResponse({
    required this.page,
    required this.totalPage,
    required this.limit,
    required this.listResult,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    var list = json['listResult'] as List;
    List<T> items = list.map((item) => fromJsonT(item)).toList();

    return BaseResponse(
      page: json['page'],
      totalPage: json['totalPage'],
      limit: json['limit'],
      listResult: items,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'page': page,
      'totalPage': totalPage,
      'limit': limit,
      'listResult': listResult.map((item) => toJsonT(item)).toList(),
    };
  }
}
