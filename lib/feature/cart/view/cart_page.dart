import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/core/widgets/dialog_widget.dart';
import 'package:tastemate_app/feature/cart/bloc/cart_bloc.dart';
import 'package:tastemate_app/feature/cart/bloc/cart_event.dart';
import 'package:tastemate_app/feature/cart/bloc/cart_state.dart';
import 'package:tastemate_app/feature/cart/model/cart_detail_dto.dart';
import 'package:tastemate_app/feature/cart/view/component/list_item_oder.dart';
import 'package:tastemate_app/feature/cart/view/component/order_history_list.page.dart';
import 'package:tastemate_app/feature/cart/view/component/order_summary_widget.dart';
import 'package:tastemate_app/core/widgets/green_button_widget.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tastemate_app/feature/order/bloc/order_bloc.dart';
import 'package:tastemate_app/feature/order/bloc/order_event.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartBloc>().add(LoadCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).cart,
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: AppStyles.primaryColor),
        ),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.profile);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child: Image.network(
                  ApiService.user.avatar ?? AppConfigs.fakeUrl,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person,
                        color: Colors.grey[700], size: 30);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Cart Items List
                  ListItemOrder(cartDetails: state.cart.cartDetails),
                  // Order Summary
                  OrderSummary(totalPrice: state.cart.totalPrice),
                  // Place Order Button
                  GreenButtonWidget(
                    onPressed: () {
                      _makeOrder(context, state.cart.cartDetails);
                    },
                    title: "Tạo đơn hàng mới",
                    isDisabled: state.cart.cartDetails.isEmpty,
                  ),
                  OrderHistoryListWidget(orders: state.orderHistoryDTOs),
                ],
              ),
            );
          } else if (state is CartError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text("No cart data available"));
          }
        },
      ),
    );
  }

  void _makeOrder(
      BuildContext context, List<CartDetailsDTO> cartDetails) async {
    var selectedCartDetails = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return CartDetailSelectionSheet(cartDetails: cartDetails);
      },
    );
    if (selectedCartDetails != null) {
      context.read<OrderBloc>().add(LoadOrderEvent(selectedCartDetails));
      var rs = await Navigator.pushNamed(
        context,
        Routes.orderPage,
        arguments: selectedCartDetails,
      );
      if (rs != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogWidget(
              message: "$rs!",
            );
          },
        );
        rs = null;
      }
      context.read<CartBloc>().add(LoadCartEvent());
      selectedCartDetails = null;
    }
  }
}

class CartDetailSelectionSheet extends StatefulWidget {
  final List<CartDetailsDTO> cartDetails;

  const CartDetailSelectionSheet({required this.cartDetails, Key? key})
      : super(key: key);

  @override
  _CartDetailSelectionSheetState createState() =>
      _CartDetailSelectionSheetState();
}

class _CartDetailSelectionSheetState extends State<CartDetailSelectionSheet> {
  List<CartDetailsDTO> selectedCartDetails = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            translation(context).select_products_to_order,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppStyles.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartDetails.length,
              itemBuilder: (context, index) {
                final cartDetail = widget.cartDetails[index];
                return CheckboxListTile(
                  title: Text(cartDetail.ingredient.name),
                  subtitle: Text("x${cartDetail.quantity}"),
                  value: selectedCartDetails.contains(cartDetail),
                  onChanged: (bool? selected) {
                    setState(() {
                      if (selected == true) {
                        selectedCartDetails.add(cartDetail);
                      } else {
                        selectedCartDetails.remove(cartDetail);
                      }
                    });
                  },
                );
              },
            ),
          ),
          GreenButtonWidget(
            onPressed: () {
              Navigator.pop(context, selectedCartDetails);
            },
            title: AppLocalizations.of(context).place_order,
            isDisabled: selectedCartDetails.isEmpty,
          ),
        ],
      ),
    );
  }
}
