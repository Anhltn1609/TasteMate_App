import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tastemate_app/feature/authenication/model/authentication_dto.dart';
import 'package:tastemate_app/feature/authenication/model/user_create_dto.dart';
import 'package:tastemate_app/feature/authenication/model/user_dto.dart';
import 'package:tastemate_app/feature/authenication/model/verify_otp_dto.dart';
import 'package:tastemate_app/feature/cart/model/cart_dto.dart';
import 'package:tastemate_app/feature/discovery/model/category_dto.dart';
import 'package:tastemate_app/feature/discovery/model/ingredient_dto.dart';
import 'package:tastemate_app/feature/discovery/model/supplier_dto.dart';
import 'package:tastemate_app/feature/dish/model/dish_dto.dart';
import 'package:tastemate_app/feature/dish/dish_detail/model/dish_recipe_dto.dart';
import 'package:tastemate_app/feature/nutrition_history/model/nutrition_history_dto.dart';
import 'package:tastemate_app/feature/order/model/order_dto.dart';
import 'package:tastemate_app/feature/order/model/order_history_dto.dart';
import 'package:tastemate_app/feature/profile/model/address_dto.dart';
import 'package:tastemate_app/feature/profile/model/user_update_dto.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ApiService {
  static const baseUrl = 'https://tastemate-be.onrender.com';
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  ));
  static String accessToken = "";
  static UserDTO user = UserDTO.defaultConstructor();
  static void setAccessToken(String token) {
    accessToken = token;
  }

  static void setUserInfor(UserDTO userInfor) {
    user = userInfor;
  }

  ApiService() {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException error) {
    if (error.response != null) {
      debugPrint('Error: ${error.response?.data}');
    } else {
      debugPrint('Error: ${error.message}');
    }
  }

  Future<bool> register(UserCreateDTO model) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode(model);
      var response = await _dio.request(
        '$baseUrl/api/v1/auth/register',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        debugPrint(json.encode(response.data));
        return true;
      } else {
        debugPrint(response.statusMessage);
        return false;
      }
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<UserDTO?> login(AuthenticationDTO model) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = jsonEncode(model.toJson());
      var response = await _dio.request(
        '$baseUrl/api/v1/auth/login',
        // 'https://tastemate-be.onrender.com/api/v1/auth/login',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        debugPrint(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;

        if (responseData['data'] != null) {
          final String? token = responseData['data']['accessToken'];
          if (token != null) {
            // Update Access Token for ApiService
            ApiService.setAccessToken(token);
            debugPrint("Access Token được lưu: $token");
          }
        }
        if (responseData['data'] != null &&
            responseData['data']['user'] != null) {
          final UserDTO userInfor =
              UserDTO.fromJson(responseData['data']['user']);
          ApiService.setUserInfor(userInfor);
          return userInfor;
        } else {
          debugPrint("login error : User data not found in response.");
          return null;
        }
      } else if (response.statusCode == 400) {
        debugPrint("login error : ${response.statusMessage}");
        return null;
      } else {
        debugPrint("login error : ${response.statusMessage}");
        return null;
      }
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      Map<String, String> emailJson = {'email': email};
      var data = jsonEncode(emailJson);
      var response = await _dio.request(
        '$baseUrl/api/v1/auth/forgot-password',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        debugPrint(json.encode(response.data));
        return true;
      } else {
        debugPrint("login error : ${response.statusMessage}");
        return false;
      }
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<bool> verifyOtp(VerifyOtpDTO model) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode(model);
      var response = await _dio.request(
        '$baseUrl/api/v1/auth/verify-otp',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        debugPrint(json.encode(response.data));
        return true;
      } else {
        debugPrint("login error : ${response.statusMessage}");
        return false;
      }
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Đang tự ý thay đổi so với api 2 đối số thay vì 3
  ///  chắc chắn lỗi nếu api chưa sửa
  Future<bool> resetPassword(AuthenticationDTO model) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode(model);
      var response = await _dio.request(
        '$baseUrl/api/v1/auth/reset-password',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        debugPrint(json.encode(response.data));
        return true;
      } else {
        debugPrint("login error : ${response.statusMessage}");
        return false;
      }
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<UserDTO?> changeProfile(UserUpdateDTO model) async {
    try {
      XFile? result;
      if (model.file != null) {
        final tempDir = await getTemporaryDirectory();
        final targetPath =
            join(tempDir.path, "compressed_${basename(model.file!.path)}");

        result = await FlutterImageCompress.compressAndGetFile(
          model.file!.absolute.path,
          targetPath,
          quality: 10,
          format: CompressFormat.jpeg,
        );
      }

      var headers = {'Authorization': 'Bearer $accessToken'};
      var data;
      if (result != null) {
        data = FormData.fromMap({
          'avatar': result,
          'fullname': model.fullname,
          'phoneNumber': model.phoneNumber
        });
      } else {
        data = FormData.fromMap(
            {'fullname': model.fullname, 'phoneNumber': model.phoneNumber});
      }

      var response = await _dio.request(
        '$baseUrl/api/v1/auth/change-profile',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        debugPrint(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null &&
            responseData['data']['user'] != null) {
          final UserDTO userInfor =
              UserDTO.fromJson(responseData['data']['user']);
          ApiService.setUserInfor(userInfor);
          return userInfor;
        }
      } else if (response.statusCode == 401) {
        print(response.statusMessage);
        print("Change infor error: Kích thước file quá lớn");
        return null;
      } else {
        print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.toString());
      rethrow;
    }
    return null;
  }

  Future<List<CategoryDTO>?> getCategories(int page) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var response = await _dio.request(
        '$baseUrl/api/v1/categories?limit=20&page=$page&sortBy=name:desc',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null &&
            responseData['data']['categories'] != null) {
          final List<CategoryDTO> categories =
              CategoryDTO.listFromJson(responseData['data']['categories']);
          return categories;
        }
      } else {
        print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.toString());
      rethrow;
    }
    return null;
  }

  Future<List<SupplierDTO>?> getSuppliers(int page) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var response = await _dio.request(
        '$baseUrl/api/v1/suppliers?limit=30&page=$page&sortBy=name:desc',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null &&
            responseData['data']['suppliers'] != null) {
          final List<SupplierDTO> suppliers =
              SupplierDTO.listFromJson(responseData['data']['suppliers']);
          return suppliers;
        }
      } else {
        print(response.statusMessage);
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.toString());
      rethrow;
    }
    return null;
  }

  Future<List<IngredientDTO>?> getIngredients(int page) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var response = await _dio.request(
        '$baseUrl/api/v1/ingredients?limit=30&page=1&sortBy=name:desc',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null &&
            responseData['data']['ingredients'] != null) {
          final List<IngredientDTO> ingredients =
              IngredientDTO.listFromJson(responseData['data']['ingredients']);
          return ingredients;
        }
      } else {
        print(response.statusMessage);
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.toString());
      rethrow;
    }
    return null;
  }

  Future<List<DishDTO>?> getDishes(int page) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var response = await _dio.request(
        // '$baseUrl/api/v1/ingredients?limit=10&page=1&sortBy=name:desc',
        '$baseUrl/api/v1/dishes?limit=30&page=$page&sortBy=name:desc',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null &&
            responseData['data']['dishes'] != null) {
          final List<DishDTO> dishes =
              DishDTO.listFromJson(responseData['data']['dishes']);
          return dishes;
        }
      } else {
        print(response.statusMessage);
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.toString());
      rethrow;
    }
    return null;
  }

  Future<DishWithIngredientsDTO?> getDishesWithIngredients(
      String dishId) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var response = await _dio.request(
        '$baseUrl/api/v1/dishes-recipes/dishes/$dishId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        // Ensure the response contains valid data
        if (responseData['data'] != null) {
          final DishWithIngredientsDTO dishesWithIngredient =
              DishWithIngredientsDTO.fromJson(responseData['data']);
          print("*** $dishesWithIngredient");
          return dishesWithIngredient;
        }
      } else {
        print(response.statusMessage);
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.toString());
      rethrow;
    }
    return null;
  }

  Future<List<IngredientDTO>?> getIngredientByCategoryId(
      String categoryId) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var dio = Dio();
      var response = await dio.request(
        '$baseUrl/api/v1/ingredients/categories/$categoryId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null) {
          final List<IngredientDTO> ingredientDTOs =
              IngredientDTO.listFromJson(responseData['data']['ingredients']);
          return ingredientDTOs;
        }
      } else {
        print(response.statusMessage);
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.toString());
      rethrow;
    }
    return null;
  }

  Future<IngredientDTO?> getIngredientById(String ingredientId) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var dio = Dio();
      var response = await dio.request(
        '$baseUrl/api/v1/ingredients/$ingredientId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null) {
          final IngredientDTO ingredientDTO =
              IngredientDTO.fromJson(responseData['data']['ingredient']);
          return ingredientDTO;
        }
      } else {
        print(response.statusMessage);
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.toString());
      rethrow;
    }
    return null;
  }

  Future<List<AddressDTO>?> getAddress() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      var dio = Dio();
      var response = await dio.request(
        '$baseUrl/api/v1/addresses',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null) {
          final List<AddressDTO> addressDTO =
              AddressDTO.listFromJson(responseData['data']['addresses']);
          return addressDTO;
        }
      } else {}
    } on DioException catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<AddressDTO>?> updateAddress(AddressDTO address) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      var data = json.encode(address);
      var response = await _dio.request(
        '$baseUrl/api/v1/addresses/${address.id}',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null) {
          final List<AddressDTO> addressDTO =
              AddressDTO.listFromJson(responseData['data']['addresses']);
          return addressDTO;
        }
      } else {}
    } on DioException catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<IngredientDTO>?> getIngredientBySupplierId(
      String supplierId) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var response = await _dio.request(
        '$baseUrl/api/v1/ingredients/suppliers/$supplierId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null) {
          final List<IngredientDTO> ingredientDTOs =
              IngredientDTO.listFromJson(responseData['data']['ingredients']);
          return ingredientDTOs;
        }
      } else {
        print(response.statusMessage);
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.toString());
      rethrow;
    }
    return null;
  }

  Future<CartDTO?> getCart() async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var response = await _dio.request(
        '$baseUrl/api/v1/carts/me',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null) {
          final CartDTO cartDTO =
              CartDTO.fromJson(responseData['data']['cart']);
          return cartDTO;
        }
      } else {
        return null;
      }
    } on DioException catch (e) {
      rethrow;
    }
    return null;
  }

  Future<bool> addIngredientToCart(String ingredientId) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var data = json.encode({"ingredientId": "$ingredientId", "quantity": 1});
      var response = await _dio.request(
        '$baseUrl/api/v1/carts/add-ingredient',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return true;
      }
      return false;
    } on DioException catch (e) {
      // return false;
      rethrow;
    }
  }

  Future<bool> addIngredientsToCart(String ingredientId, int quantity) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var data =
          json.encode({"ingredientId": "$ingredientId", "quantity": quantity});
      var response = await _dio.request(
        '$baseUrl/api/v1/carts/add-ingredient',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return true;
      }
      return false;
    } on DioException catch (e) {
      // return false;
      rethrow;
    }
  }

  Future<bool> removeIngredientFromCart(String ingredientId) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var data = json.encode({"ingredientId": "$ingredientId", "quantity": 1});
      var response = await _dio.request(
        '$baseUrl/api/v1/carts/remove-ingredient',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return true;
      }
      return false;
    } on DioException catch (e) {
      // return false;
      rethrow;
    }
  }

  Future<bool> removeIngredientsFromCart(
      String ingredientId, int quantity) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var data =
          json.encode({"ingredientId": "$ingredientId", "quantity": quantity});
      var response = await _dio.request(
        '$baseUrl/api/v1/carts/remove-ingredient',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return true;
      }
      return false;
    } on DioException catch (e) {
      // return false;
      rethrow;
    }
  }

  Future<bool> createOrder(OrderDTO order) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      var data = json.encode(order);
      print("Data: $data");
      var dio = Dio();
      var response = await dio.request(
        '$baseUrl/api/v1/orders',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        print(json.encode(response.data));
        return true;
      } else {
        print(response.statusMessage);
        return false;
      }
    } on DioException catch (e) {
      // return false;
      rethrow;
    }
  }

  Future<List<OrderHistoryDTO>?> getAllOrders() async {
    try {
      var data = '''''';
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      var response = await _dio.request(
        '$baseUrl/api/v1/orders/me?limit=20&page=1',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null) {
          final List<OrderHistoryDTO> orderHistoryDTO =
              OrderHistoryDTO.listFromJson(responseData['data']['orders']);
          return orderHistoryDTO;
        } else {
          print(response.statusMessage);
          return null;
        }
      }
    } on DioException catch (e) {
      // return false;
      rethrow;
    }
  }

  Future<List<NutritionHistoryDTO>?> getNutritionHistory() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      var response = await _dio.request(
        '$baseUrl/api/v1/nutrition-history/user/${user.id}?limit=10&page=1&sortBy=recordedAt:desc',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null) {
          final List<NutritionHistoryDTO> nutritionHistoryDTO =
              NutritionHistoryDTO.listFromJson(
                  responseData['data']['nutritionHistory']);
          return nutritionHistoryDTO;
        } else {
          print(response.statusMessage);
          return null;
        }
      }
    } on DioException catch (e) {
      // return false;
      print(e);
      rethrow;
    }
  }
}
