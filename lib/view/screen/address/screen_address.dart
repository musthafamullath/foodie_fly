import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/address/address_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/add_address/screen_add_address.dart';
import 'package:foodie_fly/view/screen/address/widgets/add_new_address_button.dart';
import 'package:foodie_fly/view/screen/address/widgets/confirmation_button.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';

class ScreenAddresses extends StatefulWidget {
  const ScreenAddresses({super.key, this.couponCode});
  final String? couponCode;

  @override
  State<ScreenAddresses> createState() => _ScreenAddressesState();
}

class _ScreenAddressesState extends State<ScreenAddresses> {
  // final int addressId = 0;

  // @override
  // void initState() {
  //   widget.couponCode == null
  //       ? context.read<AddressBloc>().add(GetAllAddressEvent())
  //       : null;

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<AddressBloc>().add(GetAllAddressEvent());
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBarWidget(title: 'Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  return BlocBuilder<AddressBloc, AddressState>(
                    builder: (context, state) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              context
                                  .read<AddressBloc>()
                                  .add(SelectAddressEvent(index: index));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(12),
                              width: width,
                              decoration: BoxDecoration(
                                color: state.index == index
                                    ? Colors.grey[300]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on_outlined,
                                              size: 24, color: Colors.red),
                                          SectionHead(
                                              heading:
                                                  state.addresses[index].name),
                                        ],
                                      ),
                                      ButtonWidget(
                                        width: width * .4,
                                        text: 'Change',
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ScreenAddAddress(
                                                operation: Operation.edit,
                                                address: state.addresses[index],
                                              ),
                                            ),
                                          );
                                        },
                                        height: 2,
                                      )
                                    ],
                                  ),
                                  kHight10,
                                  Text(
                                    '${state.addresses[index].houseName}, ${state.addresses[index].street}, ${state.addresses[index].pinCode}, ${state.addresses[index].district}, ${state.addresses[index].state}, ${state.addresses[index].phone}',
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: state.addresses.length,
                      );
                    },
                  );
                },
              ),
              kHight10,
              AddNewAddressButton(width: width, height: height),
              kHight30,
              ConfirmationButton(
                width: width,
                couponCode: widget.couponCode,
                height: height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
