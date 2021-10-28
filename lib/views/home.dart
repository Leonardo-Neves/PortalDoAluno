import 'package:flutter/material.dart';

// Utils
import 'package:projeto/modules/CustomColor.dart';
//import 'package:projeto/modules/utils.dart';

// Packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

// App
import 'package:projeto/controller/home.controller.dart';
import 'package:projeto/modules/utils.dart';
import 'package:projeto/base_widget.dart';

// Pages
import 'package:projeto/views/grades.dart';
import 'package:projeto/views/finance.dart';
import 'package:projeto/views/schedule.dart';
import 'package:projeto/views/requirements.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CarouselController _carouselSliderController = CarouselController();
  List images = [];
  dynamic user;

  void initState() {
    super.initState();

    // Use Future.delayed to get the context from the view
    Future.delayed(Duration.zero, () async {
      HomeController homeController =
          new HomeController(api: Provider.of(context, listen: false));
      var imagesNews = await homeController.getImagesNews();

      var userData = homeController.getStudent();
      setState(() {
        user = userData;
        images = imagesNews;
      });
    });
  }

  Widget subTitle(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: Color(CustomColor.BlueNormal),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    @override
    Future<dynamic> _navegateToGrades() async {
      return await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => Grades(),
        ),
      );
    }

    Future<dynamic> _navegateToFinance() async {
      return await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => Finance(),
        ),
      );
    }

    Future<dynamic> _navegateToSchedule() async {
      return await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => Schedule(),
        ),
      );
    }

    Future<dynamic> _navegateToRequirements() async {
      return await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => Requirements(),
        ),
      );
    }

    return BaseWidget<HomeController>(
      model: HomeController(api: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(CustomColor.WhiteLight),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Header(
                    user: user,
                    homeController: model,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  subTitle('Notícias'),
                  SizedBox(
                    height: 10.0,
                  ),
                  (() {
                    if (images.length != 0) {
                      return Carousel(
                        carouselSliderController: _carouselSliderController,
                        images: images,
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset('asset/image/advertise2.png'),
                        ),
                      );
                    }
                  }()),
                  SizedBox(
                    height: 10.0,
                  ),
                  subTitle('Módulos'),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: size.width,
                    child: GridView.count(
                      primary: true,
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      childAspectRatio: (10.0 / 6.0),
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: [
                        ModulesItem(
                          navigation: _navegateToGrades,
                          imageBackground: 'asset/image/grades.png',
                          icon: Icons.menu_book_rounded,
                          name: 'Notas',
                        ),
                        ModulesItem(
                          navigation: _navegateToFinance,
                          imageBackground: 'asset/image/finance.png',
                          icon: Icons.attach_money,
                          name: 'Financeiro',
                        ),
                        ModulesItem(
                          navigation: _navegateToSchedule,
                          imageBackground: 'asset/image/schedule.png',
                          icon: Icons.schedule,
                          name: 'Horários',
                        ),
                        /*
                        ModulesItem(
                          navigation: _navegateToRequirements,
                          imageBackground: 'asset/image/requirements.png',
                          icon: Icons.description,
                          name: 'Requerimento',
                        ),
                        */
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            color: Color(CustomColor.OrangeNormal),
            borderRadius: BorderRadius.circular(200.0),
          ),
          height: size.width * 0.16,
          width: size.width * 0.16,
          child: IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              color: Color(CustomColor.White),
              onPressed: () {
                Utils.launchURL();
              }),
        ),
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  final List images;
  final CarouselController carouselSliderController;

  const Carousel({
    Key? key,
    required this.images,
    required this.carouselSliderController,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int initialValue = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              enlargeCenterPage: true,
              aspectRatio: 1.6,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() => initialValue = index);
              }),
          items: widget.images
              .map(
                (image) => Container(
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      child: Image.network(image,
                          fit: BoxFit.cover, width: 1000.0),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.asMap().entries.map((image) {
            var position = image.key;
            return GestureDetector(
              onTap: () =>
                  widget.carouselSliderController.animateToPage(image.key),
              child: Container(
                height: 8.0,
                width: 8.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 3.0,
                ),
                decoration: BoxDecoration(
                  color: position == initialValue
                      ? Color(CustomColor.OrangeNormal)
                      : Color(CustomColor.BlueNormal),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ModulesItem extends StatelessWidget {
  final Function navigation;
  final String imageBackground;
  final IconData icon;
  final String name;

  const ModulesItem(
      {Key? key,
      required this.navigation,
      required this.imageBackground,
      required this.icon,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () => navigation(),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: AssetImage(imageBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: size.width * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Color(CustomColor.Black).withOpacity(0.2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 28.0,
                color: Color(CustomColor.White),
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(CustomColor.White),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final dynamic user;
  final HomeController homeController;

  const Header({Key? key, required this.user, required this.homeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 32.0,
        right: 32.0,
        top: 32.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bem vindo',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(CustomColor.BlueNormal),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    user != null ? user.name.split(' ')[0] : '--/--',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(CustomColor.BlueNormal),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    'RA ${user != null ? user.ra : '--/--'}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(CustomColor.OrangeNormal),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  homeController.logout(context);
                },
                icon: Icon(
                  Icons.logout,
                  size: 24.0,
                  color: Color(CustomColor.OrangeNormal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
