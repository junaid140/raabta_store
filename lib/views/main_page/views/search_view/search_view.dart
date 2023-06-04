import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:markaz_clone/modals/search_modals/search_modal.dart';
import 'package:markaz_clone/widgets/app_formfield.dart';
import 'package:markaz_clone/widgets/image_loader.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../controllers/main_page_controllers/main_page_views_controllers/search_view_controller.dart';
import '../../../../utils/app_navigations.dart';
import '../../../../utils/app_urls.dart';
import '../single_product_details/product_details_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final SearchViewController _controller = SearchViewController();
  late List<Docs> _searchResults;
  late List<Docs> _allProducts = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchResults = [];
    _fetchAllProducts();
  }

  bool _isLoading = true;

  Future<void> _fetchAllProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final List<Docs> products = await _controller.getAllProducts();

      setState(() {
        _allProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _searchProducts(String keyword) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final List<Docs> results =
          await _controller.searchProducts(keyword: keyword);

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AppFormfield(
            controller: _searchController,
            onChanged: (value) {
              _searchProducts(value);
            },
            prefixIcon: const Icon(Icons.search),
            contentPadding: const EdgeInsets.all(10),
            hintText: "Search your product here ...",
            hintFontSize: 12,
          ),
          Expanded(
            child: ListView(
              children: [
                _isLoading
                    ? _buildLoadingIndicator()
                    : _buildProductList(_searchResults.isNotEmpty ? _searchResults : _allProducts),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return  StaggeredGrid.count(
      mainAxisSpacing: 12,
      crossAxisSpacing: 8,
      crossAxisCount: 3,
      children: List.generate(
        13,
            (index) {
          return StaggeredGridTile.count(
              mainAxisCellCount: index % 7 == 0 ? 3 : 1,
              crossAxisCellCount: 1,
              child: Shimmer.fromColors(
                period: const Duration(seconds: 4),
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[200]!,
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.grey,
                ),
              ));
        },
      ),
    );
  }

  Widget _buildProductList(List<Docs> products) {
    if (products.isEmpty) {
      return Center(
        child: Text("No products found for the keyword."),
      );
    }

    return StaggeredGrid.count(
      mainAxisSpacing: 12,
      crossAxisSpacing: 8,
      crossAxisCount: 3,
      children: List.generate(
        products.length,
            (index) {
          final product = products[index];
          return StaggeredGridTile.count(
            mainAxisCellCount: index % 6 == 0 ? 2 : 1,
            crossAxisCellCount: 1,
            child: InkWell(
              onTap: () {
                AppNavigations.to(
                  context,
                  nextScreen: ProductDetailsView(
                    productId: product.sId.toString(),
                  ),
                );
              },
              child: ImageLoader(imageUrl: "${Urls.productsImageUrl}${product.images!.first}",)
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoProductFound() {
    return Center(
      child: Text("No products found for the keyword."),
    );
  }

}

// if (controller.isLoading)
//   StaggeredGrid.count(
//     mainAxisSpacing: 12,
//     crossAxisSpacing: 8,
//     crossAxisCount: 3,
//     children: List.generate(
//       13,
//       (index) {
//         return StaggeredGridTile.count(
//             mainAxisCellCount: index % 6 == 0 ? 2 : 1,
//             crossAxisCellCount: 1,
//             child: Shimmer.fromColors(
//               period: const Duration(seconds: 4),
//               baseColor: Colors.grey[400]!,
//               highlightColor: Colors.grey[200]!,
//               child: Container(
//                 height: 50,
//                 width: 50,
//                 color: Colors.grey,
//               ),
//             ));
//       },
//     ),
//   ),
// if (controller.productList.isEmpty && !controller.isLoading)
//   Center(
//     child: Text(
//       "No search results found  for the ' ${controller.searchController.text.toString()} '",
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ),
// if (controller.productList.isNotEmpty)
