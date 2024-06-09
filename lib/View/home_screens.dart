import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restomaknyus/Utils/assets.dart';
import 'package:restomaknyus/Utils/colors.dart';
import '../Utils/buttons.dart';
import '../Utils/column_button.dart';
import '../Widgets/card_product.dart';
import '../Utils/spaces.dart';
import '../ViewModel/product_providers.dart';
import '../Widgets/home_title.dart';
import '../Utils/strings.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    searchController.addListener(() {
      String keyword = searchController.text;
      // _productProviders!.search(keyword);
      context.read<ProductProviders>().search(keyword);
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProviders>().getProduct(context: context);
    });
    return Hero(
      tag: Strings.conf,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(
                  16.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HomeTitle(
                        controller: searchController,
                      ),
                      const SpaceHeight(
                        24,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Consumer<ProductProviders>(
                          builder: (context, value, child) {
                            if (value.product.isEmpty) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (value.product.isNotEmpty) {
                              return ListView.builder(
                                itemCount: value.product.length,
                                itemBuilder: (context, index) {
                                  var product = value.product[index];
                                  return CardProduct(
                                    dataProduct: product,
                                    onCartButton: () {},
                                  );
                                },
                              );
                            } else {
                              return const Text(
                                'Gagal',
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(
                      24.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.orders,
                          style: const TextStyle(
                            color: CustomColor.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SpaceHeight(
                          8.0,
                        ),
                        Row(
                          children: [
                            Button.filled(
                              width: 120.0,
                              height: 40,
                              onPressed: () {},
                              label: Strings.dineIn,
                            ),
                            const SpaceWidth(8.0),
                            Button.outlined(
                              width: 100.0,
                              height: 40,
                              onPressed: () {},
                              label: Strings.takeAway,
                            ),
                          ],
                        ),
                        const SpaceHeight(
                          16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.item,
                              style: const TextStyle(
                                color: CustomColor.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SpaceWidth(
                              130,
                            ),
                            SizedBox(
                              width: 50.0,
                              child: Text(
                                Strings.qty,
                                style: const TextStyle(
                                  color: CustomColor.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                Strings.price,
                                style: const TextStyle(
                                  color: CustomColor.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SpaceHeight(
                          8,
                        ),
                        const Divider(),
                        const SpaceHeight(
                          8,
                        ),
                        Text(
                          Strings.noItem,
                        ),
                        const SpaceHeight(
                          8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColumnButton(
                              label: Strings.diskon,
                              iconPath: AppAsset.iconDiscount,
                              onPressed: () {},
                            ),
                            ColumnButton(
                              label: Strings.pajak,
                              iconPath: AppAsset.iconPajak,
                              onPressed: () {},
                            ),
                            ColumnButton(
                              label: Strings.layanan,
                              iconPath: AppAsset.iconLayanan,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SpaceHeight(
                          8.0,
                        ),
                        const Divider(),
                        const SpaceHeight(
                          8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.pajak,
                              style: const TextStyle(
                                color: CustomColor.grey,
                              ),
                            ),
                            Text(
                              Strings.nominalPajak,
                              style: const TextStyle(
                                color: CustomColor.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SpaceHeight(8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.diskon,
                              style: const TextStyle(
                                color: CustomColor.grey,
                              ),
                            ),
                            Text(
                              Strings.nominalDiskon,
                              style: const TextStyle(
                                color: CustomColor.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SpaceHeight(
                          8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.subTotal,
                              style: const TextStyle(
                                color: CustomColor.grey,
                              ),
                            ),
                            // BlocBuilder<CheckoutBloc, CheckoutState>(
                            //   builder: (context, state) {
                            //     final price = state.maybeWhen(
                            //       orElse: () => 0,
                            //       success: (products, qty, price) => price,
                            //     );
                            //     return Text(
                            //       price.currencyFormatRp,
                            //       style: const TextStyle(
                            //         color: AppColors.primary,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                        const SpaceHeight(
                          100.0,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ColoredBox(
                      color: CustomColor.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16.0),
                        child: Button.filled(
                          onPressed: () {
                            // context.push(const ConfirmPaymentPage());
                          },
                          label: Strings.lanjutPembayaran,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
