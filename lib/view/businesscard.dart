import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controller/bannercontroller.dart';
import '../utils/colors.dart';

class Businesscard extends StatelessWidget {
  const Businesscard({super.key});

  @override
  Widget build(BuildContext context) {
    final Bannerevent businesscard = Get.put(Bannerevent());
    final List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                'Business Card',
                style: TextStyle(
                  color: AppColors.scaffoldBackgroundColor,
                  letterSpacing: .5,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                itemBuilder: (context) {
                  return dropdownItems.map((String item) {
                    return PopupMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList();
                },
                onSelected: (selectedItem) {
                  businesscard.updatelist(selectedItem);
                  print('Selected item: $selectedItem');
                },
                // child: Row(
                //   children: [
                //     Text('Dropdown'),
                //     Icon(Icons.arrow_drop_down),
                //   ],
                // ),
              ),
            ],
            expandedHeight: 75,
          ),
          Obx(() => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var temp = businesscard.businesscard_;

                    return ZoomTapAnimation(
                      enableLongTapRepeatEvent: false,
                      longTapRepeatDuration: const Duration(milliseconds: 100),
                      begin: 1.0,
                      end: 0.93,
                      beginDuration: const Duration(milliseconds: 20),
                      endDuration: const Duration(milliseconds: 120),
                      beginCurve: Curves.decelerate,
                      endCurve: Curves.fastOutSlowIn,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    temp[index]["name"].toString(),
                                  ),
                                  const SizedBox(width: 10),
                                  const HeroIcon(
                                    HeroIcons.link,
                                    size: 20.0,
                                  ),
                                ],
                              ),
                              const Divider(),
                              const SizedBox(height: 15),
                              Image.network(
                                temp[index]['imageUrl'],
                              ),
                              Text(
                                temp[index]['description'].toString(),
                                style: TextStyle(fontSize: 15),
                                maxLines: 4,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: businesscard.businesscard_.length,
                ),
              )),
        ],
      ),
    );
  }
}
