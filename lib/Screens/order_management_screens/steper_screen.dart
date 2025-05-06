import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stepper_list_view/stepper_list_view.dart';





class SteperWidget extends StatefulWidget {

  // List<String>? orderDates = [];
  SteperWidget({super.key,});


  @override
  State<SteperWidget> createState() => _SteperWidgetState();
}

class _SteperWidgetState extends State<SteperWidget> {

  // final _stepperData = List.generate(4, (index) => StepperItemData(
  //   id: '$index',
  //   content: ({
  //     'name': 'Confirm Order',
  //     'occupation': 'Flutter Development',
  //     'mobileNumber': '7318459902',
  //     'email': 'subhashchandras7318@gmail.com',
  //     'born_date': '28/01/2025',
  //     "contact_list": {
  //       "LinkedIn": "https://www.linkedin.com/in/subhashcs/",
  //       "Portfolio": "https://subhashdev121.github.io/subhash/#/",
  //     }
  //   }),
  //   avatar: 'https://avatars.githubusercontent.com/u/70679949?v=4',
  // )).toList();

  final _stepperData = [
    StepperItemData(
      id: '0',
      content: ({
        'name': 'Confirm Order',
        'occupation': 'Flutter Development',
        'mobileNumber': '7318459902',
        'email': 'subhashchandras7318@gmail.com',
        'born_date': '28/01/2025',
        'icon': AppAssets.shippingConfirmTruck,
        "contact_list": {
          "LinkedIn": "https://www.linkedin.com/in/subhashcs/",
          "Portfolio": "https://subhashdev121.github.io/subhash/#/",
        }
      }),
      avatar: 'https://avatars.githubusercontent.com/u/70679949?v=4',
    ),
    StepperItemData(
      id: '1',
      content: ({
        'name': 'Order Packed',
        'occupation': 'Flutter Development',
        'mobileNumber': '7318459902',
        'email': 'subhashchandras7318@gmail.com',
        'born_date': '05/02/2025',
        'icon': '',
        "contact_list": {
          "LinkedIn": "https://www.linkedin.com/in/subhashcs/",
          "Portfolio": "https://subhashdev121.github.io/subhash/#/",
        }
      }),
      avatar: 'https://avatars.githubusercontent.com/u/70679949?v=4',
    ),
    StepperItemData(
      id: '2',
      content: ({
        'name': 'Out of Delivery',
        'occupation': 'Flutter Development',
        'mobileNumber': '7318459902',
        'email': 'subhashchandras7318@gmail.com',
        'born_date': '05/02/2025',
        'icon': '',
        "contact_list": {
          "LinkedIn": "https://www.linkedin.com/in/subhashcs/",
          "Portfolio": "https://subhashdev121.github.io/subhash/#/",
        }
      }),
      avatar: 'https://avatars.githubusercontent.com/u/70679949?v=4',
    ),
    StepperItemData(
      id: '3',
      content: ({
        'name': 'Expected Delivery',
        'occupation': 'Flutter Development',
        'mobileNumber': '7318459902',
        'email': 'subhashchandras7318@gmail.com',
        'born_date': '05/02/2025',
        'born_date': '05/02/2025',
        'icon': AppAssets.expectedTrackTruck,
        "contact_list": {
          "LinkedIn": "https://www.linkedin.com/in/subhashcs/",
          "Portfolio": "https://subhashdev121.github.io/subhash/#/",
        }
      }),
      avatar: 'https://avatars.githubusercontent.com/u/70679949?v=4',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 1000,
      child: StepperListView(
        showStepperInLast: false,
        stepperData: _stepperData,
        stepAvatar: (_, data) {
          final stepData = data as StepperItemData;
          return PreferredSize(
            preferredSize: const Size.fromRadius(20),
            child: Row(
              children: [
                Visibility(
                  visible: stepData.content['icon'].toString().isEmpty ? false : true,
                  child: Container(
                    height: 35, width: 35,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: stepData.content['id'].toString() == 0 ? AppColors.darkGreenColor : AppColors.greenColor,
                        shape: BoxShape.circle),
                    child: ClipRRect(
                      // stepData.content['icon']
                      child: SvgPicture.asset(stepData.content['icon'], color: AppColors.whiteColor,),
                    ),
                  ),
                ),
                // CircleAvatar(
                //   backgroundImage: AssetImage(stepData.content['icons']),
                //   // backgroundImage: NetworkImage(
                //   //   stepData.avatar!,
                //   // ),
                // ),
                SizedBox(width: 20,),
                // Container(
                //   // color: Colors.red,
                //   width: MediaQuery.of(context).size.width * 0.7,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       // stepData.content['id'].toString() == 0
                //       addText700(stepData.content['name'], color: AppColors.blackColor, fontSize: 15),
                //       addText400("Booking Date : 12/01/2025".trim(),
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //           color: AppColors.blackColor, fontSize: 13),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        },
        // stepWidget: (_, data) {
        //   final stepData = data as StepperItemData;
        //   return PreferredSize(
        //     preferredSize: const Size.fromWidth(30),
        //     child: Text(
        //       stepData.content['born_date'] ?? '',
        //       style: TextStyle(
        //         color: theme.primaryColor,
        //         fontSize: 13,
        //       ),
        //       textAlign: TextAlign.center,
        //     ),
        //   );
        // },
        stepContentWidget: (_, data) {
          final stepData = data as StepperItemData;
          return Container(
            height: 100,
          );
          return Container(
            // margin: const EdgeInsets.only(
            //   top: 20,
            // ),
            padding: const EdgeInsets.all(
              15,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(7),
              visualDensity: const VisualDensity(
                vertical: -4,
                horizontal: -4,
              ),
              title: Text(stepData.content['name'] ?? ''),
              subtitle: Text(stepData.content['name'] ?? ''),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(8),
              //   side: BorderSide(
              //     color: theme.dividerColor,
              //     width: 0.8,
              //   ),
              // ),
            ),
          );
        },
        stepperThemeData: StepperThemeData(
          lineColor: theme.primaryColor,
          lineWidth: 5,
        ),
        physics: const BouncingScrollPhysics(),
      ),
    );
  }


}

