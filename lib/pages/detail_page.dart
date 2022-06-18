import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sumission_2/provider/restaurant.provider.dart';
import 'package:sumission_2/services/api_service.dart';
import 'package:sumission_2/widgets/pill_widget.dart';
import 'package:sumission_2/widgets/platform.widget.dart';
import 'package:sumission_2/widgets/sliver_sub_head.dart';

class DetailPage extends StatelessWidget {
  final String id;
  const DetailPage({Key? key, required this.id}) : super(key: key);

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, _state, _) {
        if (_state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (_state.state == ResultState.HasData) {
          var result = _state.resultDetail?.restaurant;
          print(result);
          return Scaffold(
            body: SafeArea(
                child: ListView(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.6),
                                BlendMode.darken),
                            image: NetworkImage(
                              "https://restaurant-api.dicoding.dev/images/medium/" +
                                  result!.pictureId,
                            ),
                            fit: BoxFit.cover),
                      ),
                      height: 200,
                      width: double.infinity,
                    ),
                    Text(result.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                result.name,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${result.address}, ${result.city}',
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                result.rating.toString(),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        result.description,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Foods',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: result.menus.foods.map((item) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(right: 10, bottom: 20),
                              height: 150,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(18)),
                              child: Center(
                                  child: Text(item.name,
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.center)),
                            );
                          }).toList(),
                        ),
                      ),
                      Text(
                        'Drinks',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: result.menus.drinks.map((item) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(right: 10, bottom: 20),
                              height: 150,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: const Color(0xffb2dfdb),
                                  borderRadius: BorderRadius.circular(18)),
                              child: Center(
                                  child: Text(item.name,
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.center)),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Comment',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: result.customerReviews.map((item) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.purpleAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    const SizedBox(height: 5),
                                    Text(item.date,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                    const SizedBox(height: 8),
                                    Text(
                                      item.review,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
          );
        } else if (_state.state == ResultState.NoData) {
          return Center(child: Text(_state.message));
        } else if (_state.state == ResultState.Error) {
          return Center(child: Text(_state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (_) => RestaurantProvider(
            apiService: ApiService(), type: "getDetail", id: id),
        child: _buildList(),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Restaurant'),
        transitionBetweenRoutes: false,
        automaticallyImplyLeading: true,
      ),
      child: ChangeNotifierProvider(
        create: (_) => RestaurantProvider(
            apiService: ApiService(), type: "getDetail", id: id),
        child: _buildList(),
      ),
      // child: _buildList(),
    );
  }

  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sumission_2/controllers/controller.dart';
// import 'package:sumission_2/widgets/pill_widget.dart';
// import 'package:sumission_2/widgets/sliver_subb_head.dart';

// class DetailPage extends StatefulWidget {
//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   final _controller = Get.find<Controller>();

//   String id = Get.parameters['id'].toString();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(id);

//     return Scaffold(
//         body: Obx(
//       () => _controller.isLoading.value
//           ? Center(child: CircularProgressIndicator())
//           : 
// CustomScrollView(
//               slivers: [
//                 SliverAppBar(
//                   title: Text(
//                     _controller.restaurant[0].name,
//                     style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                   backgroundColor: Colors.black.withOpacity(0.2),
//                   expandedHeight: 200,
//                   flexibleSpace: FlexibleSpaceBar(
//                       background: Container(
//                     decoration: BoxDecoration(
//                         color: const Color(0xff030001),
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           colorFilter: ColorFilter.mode(
//                               Colors.black.withOpacity(0.5), BlendMode.dstATop),
//                           image: NetworkImage(
//                               "https://restaurant-api.dicoding.dev/images/medium/" +
//                                   _controller.restaurant[0].pictureId),
//                         ),
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             bottomRight: Radius.circular(20))),
//                   )),
//                 ),
//                 SliverToBoxAdapter(
//                   child: Padding(
//                       padding: const EdgeInsets.all(15),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Location : ${_controller.restaurant[0].city}"),
//                           Text("rating ${_controller.restaurant[0].rating}"),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           Text(_controller.restaurant[0].description),
//                         ],
//                       )),
//                 ),
//                 SliverSubHeader(
//                   text: 'Foods',
//                 ),
//                 SliverPadding(
//                   padding: const EdgeInsets.all(15),
//                   sliver: SliverGrid.count(
//                       mainAxisSpacing: 15,
//                       crossAxisSpacing: 10,
//                       crossAxisCount: 2,
//                       childAspectRatio: 3,
//                       children: _controller.restaurant[0].menus.foods
//                           .map((e) => PillWidget(e.name))
//                           .toList()),
//                 ),
//                 SliverSubHeader(
//                   text: 'Drinks',
//                 ),
//                 SliverPadding(
//                   padding: const EdgeInsets.all(15),
//                   sliver: SliverGrid.count(
//                       mainAxisSpacing: 15,
//                       crossAxisSpacing: 10,
//                       crossAxisCount: 2,
//                       childAspectRatio: 3,
//                       children: _controller.restaurant[0].menus.drinks
//                           .map((e) => PillWidget(e.name))
//                           .toList()),
//                 ),
//               ],
//             ),
//     ));
//   }
// }
