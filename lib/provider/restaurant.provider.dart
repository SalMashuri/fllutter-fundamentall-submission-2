import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sumission_2/models/response.model.dart';
import 'package:sumission_2/models/response_detail.model.dart';
import 'package:sumission_2/services/api_service.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String? id;
  final String? query;
  final String type;

  RestaurantProvider(
      {required this.apiService, this.id, this.query, required this.type}) {
    if (type == "getAll") {
      _fetchAllRestaurant();
    }
    if (type == "getDetail") {
      _fetchDetailRestaurant(id);
    }
    if (type == "search") {
      _searchRestaurant(query);
    }
  }

  late Response _restaurantResponse;
  ResponseDetail? _restaurantResponsedetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Response get result => _restaurantResponse;

  ResponseDetail? get resultDetail => _restaurantResponsedetail;

  ResultState get state => _state;

  // Function untuk mengambil semua data retaurant
  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result = await apiService.getAllrestaurant();
      if (result.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResponse = result;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  // Function untuk mengambil data detail restaurant
  Future<dynamic> _fetchDetailRestaurant(id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final resultDetail = await apiService.getDetailRestaurant(id);
      // print(resultDetail.restaurant.);
      if (resultDetail.restaurant == {}) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "Invalid Id";
      }
      _state = ResultState.HasData;
      notifyListeners();
      return _restaurantResponsedetail = resultDetail;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "Error --> $e";
    }
  }

  // function untuk search
  Future<dynamic> _searchRestaurant(query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result = await apiService.searchRestaurant(query);
      if (result.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResponse = result;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
