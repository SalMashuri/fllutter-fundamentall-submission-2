import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sumission_2/provider/restaurant.provider.dart';
import 'package:sumission_2/services/api_service.dart';
import 'package:sumission_2/widgets/card_restaurant.dart';
import 'package:sumission_2/widgets/platform.widget.dart';

class SearchPage extends StatefulWidget {
  final String? query;
  SearchPage({Key? key, this.query});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? get query => widget.query;

  TextEditingController controller = new TextEditingController();

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
          return Scaffold(
            body: Center(child: Text("Tidak Ditemukan")),
          );
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextField(
        onSubmitted: (value) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchPage(query: value)));
        },
        autofocus: true, //Display the keyboard when TextField is displayed
        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        textInputAction:
            TextInputAction.search, //Specify the action button on the keyboard
        decoration: InputDecoration(
          //Style of TextField
          enabledBorder: UnderlineInputBorder(
              //Default TextField border
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(
              //Borders when a TextField is in focus
              borderSide: BorderSide(color: Colors.white)),
          hintText: 'Search', //Text that is displayed when nothing is entered.
          hintStyle: TextStyle(
            //Style of hintText
            color: Colors.white60,
            fontSize: 20,
          ),
        ),
      )),
      body: ChangeNotifierProvider(
        create: (_) => RestaurantProvider(
            apiService: ApiService(), type: "search", query: query),
        child: _buildList(),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoTextField(
          controller: controller,
          onSubmitted: (value) async {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchPage(query: value)));
          },
        ),
        transitionBetweenRoutes: true,
        trailing: GestureDetector(
          child: Icon(CupertinoIcons.search),
          onTap: () {},
        ),
      ),
      child: ChangeNotifierProvider(
        create: (_) => RestaurantProvider(
            apiService: ApiService(), type: "search", query: query),
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
