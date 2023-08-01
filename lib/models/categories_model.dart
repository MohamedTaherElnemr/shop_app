class CategoriesModel {
  late bool status;
  CategoriesDataModel? categoriesData;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoriesData = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  late int currentPage;
  late DataModel data;
  List<DataModel> dataList = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    // data = DataModel.fromJson(json['data']);
    json['data'].forEach((element) {
      dataList.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
