import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sumission_2/pages/search_page.dart';
import 'package:sumission_2/provider/restaurant.provider.dart';
import 'package:sumission_2/services/api_service.dart';
import 'package:sumission_2/widgets/card_restaurant.dart';
import 'package:sumission_2/widgets/platform.widget.dart';

class Homepage extends StatelessWidget {
  TextEditingController controller =
      new TextEditingController(text: 'Default text');
  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(
                restaurant: restaurant,
              );
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _searchWidget() {
    return Row(
      children: [
        TextField(
          // onChanged: (){},
          decoration: const InputDecoration(
              labelText: 'Search', suffixIcon: Icon(Icons.search)),
        ),
        _buildList()
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: ChangeNotifierProvider(
        create: (_) =>
            RestaurantProvider(apiService: ApiService(), type: "getAll"),
        child: _buildList(),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Restaurant'),
        transitionBetweenRoutes: true,
        trailing: GestureDetector(
          child: Icon(CupertinoIcons.search),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchPage()));
          },
        ),
      ),
      child: ChangeNotifierProvider(
        create: (_) =>
            RestaurantProvider(apiService: ApiService(), type: "getAll"),
        child: _buildList(),
      ),
      // child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sumission_2/controllers/controller.dart';

// class HomePage extends StatelessWidget {
//   final _controller = Get.find<Controller>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Restaurant"),
//         ),
//         body: SafeArea(
//           child: Obx(() => _controller.isLoading.value
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : _buildScreen()),
//         ));
//   }

//   Widget _buildScreen() {
//     return ListView.builder(
//       itemCount: _controller.restList.length,
//       itemBuilder: (context, index) {
//         return Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             InkWell(
//               onTap: () => {
//                 Get.toNamed("/restaurant/" + _controller.restList[index].id)
//               },
//               child: Container(
//                   margin: const EdgeInsets.only(left: 20, right: 20),
//                   padding: const EdgeInsets.only(left: 20),
//                   height: 80,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20)),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 35,
//                         backgroundImage: NetworkImage(
//                             "https://restaurant-api.dicoding.dev/images/medium/" +
//                                 _controller.restList[index].pictureId),
//                       ),
//                       const SizedBox(
//                         width: 30,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             _controller.restList[index].name,
//                             style: const TextStyle(
//                                 color: Colors.black, fontSize: 18),
//                           ),
//                           Text(_controller.restList[index].city,
//                               style: const TextStyle(
//                                   color: Colors.black, fontSize: 18)),
//                           Text(_controller.restList[index].rating.toString(),
//                               style: const TextStyle(
//                                   color: Colors.black, fontSize: 18)),
//                         ],
//                       ),
//                     ],
//                   )),
//             ),
//             const SizedBox(
//               height: 10,
//             )
//           ],
//         );
//       },
//     );
//   }
// }
