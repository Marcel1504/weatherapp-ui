abstract class AppListResponseDto<DATA> {
  AppListResponseDto({this.hasNext, this.total, this.list = const []});

  int? total;
  bool? hasNext;
  List<DATA> list;
}
