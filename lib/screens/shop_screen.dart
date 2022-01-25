import 'package:flutter/material.dart';
import 'package:shop_screen/models/plant_model.dart';
import 'package:shop_screen/screens/plant_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with TickerProviderStateMixin {
  late TabController? _tabController;
  late PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 5, vsync: this);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  _plantSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 500.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PlantScreen(plant: plants[index]),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
              decoration: BoxDecoration(
                color: const Color(0xFF32A060),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Hero(
                      tag: plants[index].imageUrl,
                      child: Image(
                        fit: BoxFit.cover,
                        height: 280,
                        width: 280,
                        image: AssetImage('assets/images/plant$index.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'FROM',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          '\$${plants[index].price}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 30,
                    bottom: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plants[index].category.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          plants[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 4,
              child: RawMaterialButton(
                padding: const EdgeInsets.all(15),
                shape: const CircleBorder(),
                elevation: 2,
                fillColor: Colors.black,
                child: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(
                  Icons.menu,
                  size: 30.0,
                  color: Colors.grey,
                ),
                Icon(
                  Icons.shopping_cart,
                  size: 30.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          const Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: Text(
              'Top Picks',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.withOpacity(0.6),
            labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            isScrollable: true,
            tabs: const [
              Tab(
                child: Text(
                  'Top',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Outdoor',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Indoor',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'New Arrivals',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Limited Edition',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          SizedBox(
            height: size.height * 0.65,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _selectedPage = index;
                });
              },
              itemCount: plants.length,
              itemBuilder: (BuildContext context, int index) {
                return _plantSelector(index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  plants[_selectedPage].description,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
