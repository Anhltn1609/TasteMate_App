import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/cart/model/cart_detail_dto.dart';
import 'package:tastemate_app/core/widgets/green_button_widget.dart';
import 'package:tastemate_app/feature/order/bloc/order_bloc.dart';
import 'package:tastemate_app/feature/order/bloc/order_event.dart';
import 'package:tastemate_app/feature/order/bloc/order_state.dart';
import 'package:tastemate_app/feature/order/model/order_dto.dart';
import 'package:tastemate_app/feature/profile/model/address_dto.dart';

class OrderPage extends StatefulWidget {
  final List<CartDetailsDTO> selectedCartDetails;

  const OrderPage({required this.selectedCartDetails, super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late Future<List<AddressDTO>?> _addressFuture;

  @override
  void initState() {
    super.initState();
    _addressFuture = ApiService().getAddress();
  }

  @override
  Widget build(BuildContext context) {
    List<String> selectCartIds = [];
    for (CartDetailsDTO i in widget.selectedCartDetails)
      selectCartIds.add(i.id);
    print(selectCartIds);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin đơn hàng"),
        elevation: 0,
      ),
      body: FutureBuilder(
          future: _addressFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Lỗi khi tải địa chỉ: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Không có địa chỉ nào.'));
            }

            // Sử dụng địa chỉ đầu tiên
            final addressDTO = snapshot.data!.first;
            return BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrderLoaded) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Thông tin đơn hàng",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: AppStyles.primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.cartDetails.length,
                            itemBuilder: (context, index) {
                              final cartDetail = state.cartDetails[index];
                              return ListTile(
                                leading:
                                    Image.network(cartDetail.ingredient.image),
                                title: Text(cartDetail.ingredient.name),
                                subtitle: Text("x${cartDetail.quantity}"),
                                trailing: Text("${cartDetail.subtotal}đ"),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Text("Tổng tiền: ${state.totalPrice}đ"),
                          const SizedBox(height: 16),
                          Text(
                            "Tên người nhận: ${addressDTO.recipientName}",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Số điện thoại: ${addressDTO.phoneNumber}",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Địa chỉ: ${addressDTO.detailAddress}",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.userInfor);
                            },
                            child: Text('Chỉnh sửa địa chỉ'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GreenButtonWidget(
                            onPressed: () async {
                              final AddressDTO =
                                  await ApiService().getAddress();
                              context.read<OrderBloc>().add(
                                    CreateOrderEvent(
                                      order: OrderDTO(
                                        recipientName:
                                            AddressDTO![0].recipientName,
                                        phoneNumber: AddressDTO[0].phoneNumber,
                                        detailAddress:
                                            AddressDTO[0].detailAddress,
                                        note: "aaaa",
                                        cartDetails: selectCartIds,
                                      ),
                                    ),
                                  );
                            },
                            title: "Xác nhận đơn hàng",
                            isDisabled: state.cartDetails.isEmpty,
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is OrderError) {
                  Future.microtask(
                      () => Navigator.pop(context, '${state.error}'));
                  return Container();
                } else if (state is OrderSuccess) {
                  Future.microtask(() => Navigator.pop(context, "Thành công"));
                  return Container();
                } else {
                  Future.microtask(() => Navigator.pop(
                      context, 'Bạn đã đặt hàng công thành công'));
                  return Container();
                }
              },
            );
          }),
    );
  }
}
