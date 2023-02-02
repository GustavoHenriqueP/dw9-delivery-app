import 'package:dw9_delivery_app/app/core/extensions/formatter_extension.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/product_model.dart';

class DeliveryProductTile extends StatelessWidget {
  final ProductModel productModel;
  final OrderProductDto? orderProduct;

  const DeliveryProductTile({Key? key, required this.productModel, required this.orderProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<HomeController>();
        final orderProductResult = await Navigator.of(context).pushNamed('/productDetail',arguments: {
          'product': productModel,
          'order': orderProduct,
        });

        if (orderProductResult != null) {
          controller.addOrUpdateBag(orderProductResult as OrderProductDto);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      productModel.name,
                      style:
                          context.textStyles.textExtraBold.copyWith(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      productModel.description,
                      style: context.textStyles.textRegular.copyWith(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      productModel.price.currencyPTBR,
                      style: context.textStyles.textMedium.copyWith(
                        fontSize: 12,
                        color: context.colors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: productModel.image,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
