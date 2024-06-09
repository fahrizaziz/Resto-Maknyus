import 'package:flutter/material.dart';
import 'package:restomaknyus/Utils/format.dart';
import '../Utils/colors.dart';
import '../Model/product_model.dart';
import '../Utils/spaces.dart';

class CardProduct extends StatelessWidget {
  final DataProduct dataProduct;
  final VoidCallback onCartButton;
  const CardProduct({
    super.key,
    required this.dataProduct,
    required this.onCartButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(
          16.0,
        ),
        margin: const EdgeInsets.all(
          12.0,
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: CustomColor.card,
            ),
            borderRadius: BorderRadius.circular(
              19,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                dataProduct.name ?? '-',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SpaceHeight(
              8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: FittedBox(
                    child: Text(
                      dataProduct.price!.toIntegerFromText.currencyFormatRp,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // child: Stack(
        //   children: [
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         // Container(
        //         //   alignment: Alignment.center,
        //         //   padding: const EdgeInsets.all(12.0),
        //         //   margin: const EdgeInsets.only(top: 20.0),
        //         //   decoration: BoxDecoration(
        //         //     shape: BoxShape.circle,
        //         //     color: CustomColor.disabled.withOpacity(0.4),
        //         //   ),
        //         //   child: ClipRRect(
        //         //     borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        //         //     child: Image.network(
        //         //       dataProduct.image!.contains('http')
        //         //           ? dataProduct.image!
        //         //           : '${Variables.baseUrl}/${dataProduct.image}',
        //         //       width: 50,
        //         //       height: 50,
        //         //       fit: BoxFit.cover,
        //         //     ),
        //         //   ),
        //         // ),
        //         const Spacer(),
        //         FittedBox(
        //           child: Text(
        //             dataProduct.name ?? '-',
        //             style: const TextStyle(
        //               fontSize: 12,
        //               fontWeight: FontWeight.w700,
        //             ),
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //         ),
        //         const SpaceHeight(
        //           8.0,
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             // Flexible(
        //             //   child: FittedBox(
        //             //     child: Text(
        //             //       cu.category?.name ?? '-',
        //             //       style: const TextStyle(
        //             //         color: AppColors.grey,
        //             //         fontSize: 12,
        //             //       ),
        //             //     ),
        //             //   ),
        //             // ),
        //             Flexible(
        //               child: FittedBox(
        //                 child: Text(
        //                   dataProduct.price!.toIntegerFromText.currencyFormatRp,
        //                   style: const TextStyle(
        //                     fontWeight: FontWeight.w700,
        //                     fontSize: 12,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
