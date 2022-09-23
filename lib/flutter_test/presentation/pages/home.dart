import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test02/core/pretty_printer.dart';
import 'package:machine_test02/flutter_test/domain/entities/home_enity.dart';
import 'package:machine_test02/flutter_test/presentation/constants.dart';
import 'package:machine_test02/flutter_test/presentation/manager/controller/home_controller.dart';
import 'package:machine_test02/flutter_test/presentation/style/app_colors.dart';

import '../widgets/custom_carousal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    scrollController.addListener(() {
      prettyPrint(scrollController.position.pixels.toString());
    });
    final homeController = Get.find<HomeController>();
    var items = const [
      HomeTopCard(
        title: null,
        amount: null,
        debts: null,
        icon: null,
        color: AppColors.titleHalfGrey,
      ),
      HomeTopCard(
        title: AppStrings.oweME,
        amount: 1250,
        debts: 2,
        icon: AppAssets.arrowDown,
        color: AppColors.titleGreen,
      ),
      HomeTopCard(
        title: AppStrings.iOwe,
        amount: 1130,
        debts: 2,
        icon: AppAssets.arrowUp,
        color: AppColors.titleOrange,
      ),
      HomeTopCard(
        title: null,
        amount: null,
        debts: null,
        icon: null,
        color: AppColors.titleHalfBlue,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.gradientStartingColor,
      body: Stack(
        children: [
          NestedScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            // body: Container(),
            body: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.bodyColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "My debts",
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          Text("See All",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                        child: NotificationListener<ScrollNotification>(
                      onNotification: (s) {
                        if (homeController.limitHasReached.value == false &&
                            s.metrics.pixels == s.metrics.maxScrollExtent) {
                          homeController.get();
                        }
                        return true;
                      },
                      child: Obx(() => ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(top: 12),
                          shrinkWrap: true,
                          itemCount: homeController.homeList.length + 1,
                          itemBuilder: (context, index) =>
                              index == homeController.homeList.length
                                  ? homeController.limitHasReached.value
                                      ? Container()
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                  : HomeListTile(
                                      data: homeController.homeList[index]))),
                    ))
                  ],
                ),
              ),
            ),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: AppColors.gradientStartingColor,
                  leading: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(AppAssets.profileImage))),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(AppAssets.notifications)),
                    )
                  ],
                  title: Text(
                    AppStrings.home,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  centerTitle: true,
                  pinned: true,
                  collapsedHeight: 120,
                  expandedHeight: MediaQuery.of(context).size.height * 0.35,
                  flexibleSpace: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, bottom: 0, right: 8),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 100),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(30)),
                              gradient: AppColors.homeGradient()),
                          child: CustomCarousal(
                            items: items,
                          ),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              decoration: const BoxDecoration(
                                  color: AppColors.bodyColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                            )),
                        Positioned(
                            right: 0,
                            bottom: -2,
                            left: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                HomeRoundButton(
                                  image: "assets/icons/plus.png",
                                  name: AppStrings.newString,
                                ),
                                HomeRoundButton(
                                  image: "assets/icons/topright-arrow.png",
                                  name: AppStrings.payOff,
                                ),
                                HomeRoundButton(
                                  image: "assets/icons/bottomleft_arrow.png",
                                  name: AppStrings.lend,
                                ),
                                HomeRoundButton(
                                  image: "assets/icons/grid.png",
                                  name: AppStrings.more,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                )
              ];
            },
          ),
          // Positioned(
          //     top: MediaQuery.of(context).size.width * 0.5 + kToolbarHeight,
          //     left: 0,
          //     right: 0,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: const [
          //         HomeRoundButton(image: "assets/icons/plus.png"),
          //         HomeRoundButton(image: "assets/icons/topright-arrow.png"),
          //         HomeRoundButton(image: "assets/icons/bottomleft_arrow.png"),
          //         HomeRoundButton(image: "assets/icons/grid.png"),
          //       ],
          //     ))
        ],
      ),
    );
  }
}

class HomeListTile extends StatelessWidget {
  final HomeEntity data;
  const HomeListTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(data.img!))),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name ?? "",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.until ?? "",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data.amount ?? "",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "out of ${data.outOfAmount ?? " "}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeRoundButton extends StatelessWidget {
  final String image;
  final String name;
  const HomeRoundButton({Key? key, required this.image, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.roundTileColor, shape: BoxShape.circle),
              child: Center(
                child:
                    SizedBox(width: 20, height: 20, child: Image.asset(image)),
              ),
            ),
          ),
        ),
        Text(
          name,
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

class HomeTopCard extends StatelessWidget {
  final String? title;
  final int? amount;
  final int? debts;
  final String? icon;
  final Color? color;

  const HomeTopCard(
      {Key? key,
      required this.title,
      required this.amount,
      required this.debts,
      required this.icon,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 200,
        decoration: BoxDecoration(
            color: color ?? Colors.red,
            borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Positioned(
                top: 5,
                right: 5,
                child: icon == null
                    ? Container()
                    : Image.asset(
                        icon!,
                        width: 50,
                        height: 50,
                      )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                title == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          title!,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                amount == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "\$\t${amount.toString()}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              fontSize: 20),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                debts == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "$debts ${AppStrings.debts}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class HomeList extends StatelessWidget {
//   final List
//   const HomeList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
