import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../shared/components/constants.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  SearchModel? searchModel;
  void search({required String text}) {
    emit(SearchLoading());
    DioHelper.postData(
        url: 'products/search',
        auth: token,
        data: {'text': text}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccess());
    }).catchError((error) {
      emit(SearchFailed(error.toString()));
    });
  }
}
