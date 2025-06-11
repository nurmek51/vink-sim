import 'package:flex_travel_sim/features/tariffs_and_countries/widgets/country_list_tile.dart';
import 'package:flutter/material.dart';

class TariffsAndCountriesScreen extends StatelessWidget {
  const TariffsAndCountriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 20);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Тарифы и страны', style: titleStyle),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: horizontalPadding,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CountryListTile(
                        imagePath: 'assets/icons/russian_flag.svg',
                        countryTitle: 'Страна ${index + 1}',
                        countrySubtitle: 'Описание страны ${index + 1}',
                        price: '\$${(index + 1) * 10}',
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
