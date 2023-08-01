part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopNavBarChange extends ShopState {}

class GetShopHomeDataLoading extends ShopState {}

class GetShopHomeDataSuccess extends ShopState {}

class GetShopHomeDataFailed extends ShopState {
  final String errorMessage;

  GetShopHomeDataFailed(this.errorMessage);
}

//////////////////////////////Categories///////////////////

class GetCategoriesDataSuccess extends ShopState {}

class GetCategoriesDataFailed extends ShopState {
  final String errorMessage;

  GetCategoriesDataFailed(this.errorMessage);
}

///////////////////////////////add or delete favourites////////////////

class ChangeFavoriteSuccess extends ShopState {}

class ChangeFavoriteFailed extends ShopState {
  final String errorMessage;

  ChangeFavoriteFailed(this.errorMessage);
}

////////////////////////////////get fav//////////////////
///
class GetFavoriteLoading extends ShopState {}

class GetFavoriteSuccess extends ShopState {}

class GetFavoriteFailed extends ShopState {
  final String errorMessage;

  GetFavoriteFailed(this.errorMessage);
}
/////////////////////get userdata//////////////////
///

class GetUserDataLoading extends ShopState {}

class GetUserDataSuccess extends ShopState {}

class GetUserDataFailed extends ShopState {
  final String errorMessage;

  GetUserDataFailed(this.errorMessage);
}

/////////////////update////////////

class UpdateUserLoading extends ShopState {}

class UpdateUserSuccess extends ShopState {
  final UserData loginDate;

  UpdateUserSuccess(this.loginDate);
}

class UpdateUserFailed extends ShopState {
  final String errMessage;

  UpdateUserFailed(this.errMessage);
}
