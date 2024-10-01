// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:dio/dio.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'login.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final List<CryptoPack> _cryptoPacks = [
//      CryptoPack(
//       name: 'Trendsetters',
//       description: 'Cutting-edge innovation with pioneering...',
//       minInvestment: 5000.00,
//       percentageChange: 0.0,
//       trend: 'Moderately High',
//       icon: Icons.trending_up,
//       coinIds: ['bitcoin', 'ethereum', 'cardano'],
//       about: 'Trendsetters pack focuses on cryptocurrencies that are leading the way in terms of innovation and market influence.',
//       id: 'trendsetters',
//     ),
//     CryptoPack(
//       name: 'Metaverse',
//       description: 'Leading metaverse tokens',
//       minInvestment: 2500.00,
//       percentageChange: 0.0,
//       trend: 'Very High',
//       icon: Icons.computer,
//       coinIds: ['decentraland', 'the-sandbox', 'axie-infinity', 'enjincoin'],
//       about: 'Metaverse pack includes top-performing tokens in the metaverse space, representing virtual worlds and digital assets.',
//       id: 'metaverse',
//     ),
//     CryptoPack(
//       name: 'Starter',
//       description: 'The two undisputed market-leaders',
//       minInvestment: 2500.00,
//       percentageChange: 0.0,
//       trend: 'Moderate',
//       icon: Icons.star,
//       coinIds: ['bitcoin', 'ethereum'],
//       about: 'Starter pack contains the two most prominent cryptocurrencies: Bitcoin and Ethereum, suitable for beginners.',
//       id: 'starter',
//     ),
//     CryptoPack(
//       name: 'Ultimate Alts of Tomorrow',
//       description: 'The undisputed Alt Coin selection',
//       minInvestment: 2500.00,
//       percentageChange: 0.0,
//       trend: 'Moderate',
//       icon: Icons.monetization_on,
//       coinIds: ['cardano', 'solana', 'polkadot', 'avalanche-2'],
//       about: 'Ultimate Alts pack features a selection of promising altcoins with potential for future growth.',
//       id: 'ultimate_alts',
//     ),
//     CryptoPack(
//       name: 'HighRiskHighReward',
//       description: 'High-risk investments with potential for high rewards',
//       minInvestment: 5000.00,
//       percentageChange: 0.0,
//       trend: 'High',
//       icon: Icons.warning,
//       coinIds: ['shiba-inu', 'dogecoin'],
//       about: 'HighRiskHighReward pack includes volatile cryptocurrencies with the potential for significant returns.',
//       id: 'high_risk_high_reward',
//     ),
//     CryptoPack(
//       name: 'Balanced',
//       description: 'A balanced portfolio of stable and volatile assets',
//       minInvestment: 3000.00,
//       percentageChange: 0.0,
//       trend: 'Medium',
//       icon: Icons.balance,
//       coinIds: ['bitcoin', 'ethereum', 'tether', 'cardano', 'solana'],
//       about: 'Balanced pack provides a mix of stable and volatile cryptocurrencies for a well-rounded investment.',
//       id: 'balanced',
//     ),
//   ];
// class ApiError extends Error {
//   final String message;
//   final int? statusCode;

//   ApiError({required this.message, this.statusCode});
// }

// class CryptoPack {
//   final String name;
//   final String description;
//   final double minInvestment;
//   double percentageChange;
//   final String trend;
//   final IconData icon;
//   final String id;
//   final String about;
//   final List<String> coinIds;

//   CryptoPack({
//     required this.name,
//     required this.description,
//     required this.minInvestment,
//     required this.percentageChange,
//     required this.trend,
//     required this.icon,
//     required this.id,
//     required this.about,
//     required this.coinIds,
//   });
// }

// class CryptoHolding {
//   final String symbol;
//   final String name;
//   double quantity;
//   double averagePrice;
//   double currentPrice;
//   double currentValue;
//   double investedAmount;
//   double profitLoss;
//   double dailyProfitLoss;

//   CryptoHolding({
//     required this.symbol,
//     required this.name,
//     required this.quantity,
//     required this.averagePrice,
//     required this.currentPrice,
//     required this.currentValue,
//     required this.investedAmount,
//     required this.profitLoss,
//     required this.dailyProfitLoss,
//   });

//   factory CryptoHolding.fromJson(Map<String, dynamic> json) {
//     return CryptoHolding(
//       symbol: json['symbol'],
//       name: json['name'],
//       quantity: json['quantity'],
//       averagePrice: json['averagePrice'],
//       currentPrice: json['currentPrice'],
//       currentValue: json['currentValue'],
//       investedAmount: json['investedAmount'],
//       profitLoss: json['profitLoss'],
//       dailyProfitLoss: json['dailyProfitLoss'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'symbol': symbol,
//       'name': name,
//       'quantity': quantity,
//       'averagePrice': averagePrice,
//       'currentPrice': currentPrice,
//       'currentValue': currentValue,
//       'investedAmount': investedAmount,
//       'profitLoss': profitLoss,
//       'dailyProfitLoss': dailyProfitLoss,
//     };
//   }
// }

// class CachedData<T> {
//   final T data;
//   final DateTime timestamp;

//   CachedData({required this.data, required this.timestamp});
// }

// class CryptoPackCache {
//   final Map<String, CachedData<List<dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 15);

//   Future<void> setCryptoPackData(String packId, List<dynamic> data) async {
//     _cache[packId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   List<dynamic>? getCryptoPackData(String packId) {
//     if (_cache.containsKey(packId) && !_isCacheExpired(packId)) {
//       return _cache[packId]!.data;
//     }
//     return null;
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class CryptoApiService {
//   final Dio _dio = Dio();
//   final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 5);

// //   CryptoApiService() {
// //     _dio.interceptors.add(InterceptorsWrapper(
// //       onError: (DioError e, ErrorInterceptorHandler handler) {
// //         ApiError error;
// //         if (e.response != null) {
// //           error = ApiError(message: e.response!.data['message'], statusCode: e.response!.statusCode);
// //         } else {
// //           error = ApiError(message: e.message);
// //         }
// //         throw error;
// //       },
// //     ));
// //   }

// CryptoApiService() {
//   _dio.interceptors.add(InterceptorsWrapper(
//     onError: (DioError e, ErrorInterceptorHandler handler) {
//       ApiError error;
//       if (e.response != null) {
//         error = ApiError(
//           message: e.response!.data['message'] ?? 'Unknown error',
//           statusCode: e.response!.statusCode
//         );
//       } else {
//         error = ApiError(message: e.message ?? 'Unknown error');
//       }
//       throw error;
//     },
//   ));
// }
//   Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
//     if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
//       return _cache[symbol]!.data;
//     }

//     try {
//       final response = await _dio.get(
//           'https://api.coingecko.com/api/v3/simple/price?ids=$symbol&vs_currencies=usd&include_24hr_change=true');
//       final data = {
//         'currentPrice': response.data[symbol]['usd'],
//         'priceChange24h': response.data[symbol]['usd_24h_change'],
//       };
//       _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
//       return data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to load price data');
//     }
//   }

//   Future<Map<String, dynamic>> searchCrypto(String query) async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/search?query=$query');
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to search crypto');
//     }
//   }

//   Future<List<dynamic>> fetchCryptoData(String coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds,
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchBatchCryptoData(List<String> coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds.join(','),
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return Map.fromIterable(response.data, key: (item) => item['id'], value: (item) => item);
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch batch data');
//     }
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class HoldingsProvider with ChangeNotifier {
//   final CryptoApiService _apiService = CryptoApiService();
//   final CryptoPackCache _cryptoPackCache = CryptoPackCache();
//   List<CryptoHolding> _holdings = [];
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _isSearching = false;
//   bool _isLoadingSearch = false;

//   List<CryptoHolding> get holdings => _holdings;
//   List<Map<String, dynamic>> get searchResults => _searchResults;
//   bool get isSearching => _isSearching;
//   bool get isLoadingSearch => _isLoadingSearch;

//   Future<void> fetchHoldings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = prefs.getStringList('holdings') ?? [];
//       _holdings = holdingsJson
//           .map((json) => CryptoHolding.fromJson(jsonDecode(json)))
//           .toList();
//       await _updateHoldingsData();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching holdings: $e');
//     }
//   }

//   Future<void> _updateHoldingsData() async {
//     final futures = _holdings.map((holding) => _apiService.getCurrentPriceData(holding.symbol)).toList();
//     final results = await Future.wait(futures);

//     for (var i = 0; i < _holdings.length; i++) {
//       try {
//         final priceData = results[i];
//         _holdings[i].currentPrice = priceData['currentPrice'].toDouble();
//         _holdings[i].currentValue = _holdings[i].quantity * _holdings[i].currentPrice;
//         _holdings[i].profitLoss = _holdings[i].currentValue - _holdings[i].investedAmount;
//         _holdings[i].dailyProfitLoss = _holdings[i].currentValue * (priceData['priceChange24h'] / 100);
//       } catch (e) {
//         print('Error updating holding data for ${_holdings[i].symbol}: $e');
//       }
//     }
//   }

//   Future<void> searchCrypto(String searchTerm) async {
//     _isSearching = searchTerm.isNotEmpty;
//     if (_isSearching) {
//       _isLoadingSearch = true;
//       notifyListeners();
//       try {
//         final results = await _apiService.searchCrypto(searchTerm);
//         _searchResults = List<Map<String, dynamic>>.from(results['coins']);
//       } catch (e) {
//         print('Error searching crypto: $e');
//         _searchResults = [];
//       }
//       _isLoadingSearch = false;
//     } else {
//       _searchResults = [];
//     }
//     notifyListeners();
//   }

//   Future<void> addHolding(String symbol, String name, double quantity, double averagePrice) async {
//       try {
//       final priceData = await _apiService.getCurrentPriceData(symbol);
//       final currentPrice = priceData['currentPrice'].toDouble();
//       final currentValue = quantity * currentPrice;
//       final investedAmount = quantity * averagePrice;
//       final profitLoss = currentValue - investedAmount;
//       final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//       final existingHoldingIndex = _holdings.indexWhere((holding) => holding.symbol == symbol);

//       if (existingHoldingIndex != -1) {
//         final existingHolding = _holdings[existingHoldingIndex];
//         final newQuantity = existingHolding.quantity + quantity;
//         final newInvestedAmount = existingHolding.investedAmount + investedAmount;
//         final newAveragePrice = newInvestedAmount / newQuantity;

//         _holdings[existingHoldingIndex].quantity = newQuantity;
//         _holdings[existingHoldingIndex].averagePrice = newAveragePrice;
//         _holdings[existingHoldingIndex].investedAmount = newInvestedAmount;
//         _holdings[existingHoldingIndex].currentPrice = currentPrice;
//         _holdings[existingHoldingIndex].currentValue = newQuantity * currentPrice;
//         _holdings[existingHoldingIndex].profitLoss = _holdings[existingHoldingIndex].currentValue - _holdings[existingHoldingIndex].investedAmount;
//         _holdings[existingHoldingIndex].dailyProfitLoss = _holdings[existingHoldingIndex].currentValue * (priceData['priceChange24h'] / 100);
//       } else {
//         final newHolding = CryptoHolding(
//           symbol: symbol,
//           name: name,
//           quantity: quantity,
//           averagePrice: averagePrice,
//           currentPrice: currentPrice,
//           currentValue: currentValue,
//           investedAmount: investedAmount,
//           profitLoss: profitLoss,
//           dailyProfitLoss: dailyProfitLoss,
//         );

//         _holdings.add(newHolding);
//       }

//       await _saveHoldings();
//       notifyListeners();
//     } catch (e) {
//       print('Error adding holding: $e');
//     }
//   }

//   Future<void> updateHolding(String symbol, double quantity, double averagePrice) async {
//      final index = _holdings.indexWhere((holding) => holding.symbol == symbol);
//     if (index != -1) {
//       try {
//         final priceData = await _apiService.getCurrentPriceData(symbol);
//         final currentValue = quantity * priceData['currentPrice'];
//         final investedAmount = quantity * averagePrice;
//         final profitLoss = currentValue - investedAmount;
//         final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//         _holdings[index].quantity = quantity;
//         _holdings[index].averagePrice = averagePrice;
//         _holdings[index].currentPrice = priceData['currentPrice'];
//         _holdings[index].currentValue = currentValue;
//         _holdings[index].investedAmount = investedAmount;
//         _holdings[index].profitLoss = profitLoss;
//         _holdings[index].dailyProfitLoss = dailyProfitLoss;

//         await _saveHoldings();
//         notifyListeners();
//       } catch (e) {
//         print('Error updating holding: $e');
//       }
//     }
//   }

//   void removeHolding(String symbol) {
//      _holdings.removeWhere((holding) => holding.symbol == symbol);
//     _saveHoldings();
//     notifyListeners();
//   }

//   double getTotalValue() {
//     return _holdings.fold(0, (sum, holding) => sum + holding.currentValue);
//   }

//   Future<void> _saveHoldings() async {
//      try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = _holdings.map((holding) => jsonEncode(holding.toJson())).toList();
//       await prefs.setStringList('holdings', holdingsJson);
//     } catch (e) {
//       print('Error saving holdings: $e');
//     }
//   }

//   Future<void> preloadCryptoPacks(List<CryptoPack> cryptoPacks) async {
//     final allCoinIds = cryptoPacks.expand((pack) => pack.coinIds).toSet().toList();
//     try {
//       final batchData = await _apiService.fetchBatchCryptoData(allCoinIds);
//       for (var pack in cryptoPacks) {
//         final packData = pack.coinIds.map((id) => batchData[id]).toList();
//         await _cryptoPackCache.setCryptoPackData(pack.id, packData);
//       }
//     } catch (e) {
//       print('Error preloading crypto packs: $e');
//     }
//   }

// }

// class AppTheme {
//   static const primaryColor = Color(0xFF2196F3);
//   static const secondaryColor = Color(0xFF4CAF50);
//   static const backgroundColor = Color(0xFFF5F5F5);
//   static const cardColor = Colors.white;
//   static const textColor = Color(0xFF333333);
//   static const lightTextColor = Color(0xFF666666);

//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: primaryColor,
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: secondaryColor,
//       ),
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: AppBarTheme(
//         color: primaryColor,
//         elevation: 0,
//       ),
//       cardTheme: CardTheme(
//         color: cardColor,
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
//         titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
//         bodyMedium: TextStyle(color: textColor, fontSize: 14),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: primaryColor,
//         textTheme: ButtonTextTheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }
// class CryptoPackScreen extends StatefulWidget {
//   @override
//   _CryptoPackScreenState createState() => _CryptoPackScreenState();
// }

// class _CryptoPackScreenState extends State<CryptoPackScreen> {////////////////////////////////////////////////////////////////////////////////////////
//   final CryptoApiService _apiService = CryptoApiService();
//   int _currentPage = 0;
//   static const int _packsPerPage = 6;

//   @override
//   void initState() {
//     super.initState();
//     _calculatePercentageChange();
//     _preloadCryptoPacks();
//   }

//    void _preloadCryptoPacks() {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);
//     holdingsProvider.preloadCryptoPacks(_cryptoPacks);
//   }

//   void _calculatePercentageChange() async {
//     for (var pack in _cryptoPacks) {
//       try {
//         double percentageChange = await _fetchPercentageChange(pack.coinIds);
//         setState(() {
//           pack.percentageChange = percentageChange;
//         });
//       } catch (e) {
//         print('Error calculating percentage change for ${pack.name}: $e');
//         setState(() {
//           pack.percentageChange = pack.percentageChange;
//         });
//       }
//     }
//   }

//   Future<double> _fetchPercentageChange(List<String> coinIds) async {
//     try {
//       final ids = coinIds.join(',');
//       final response = await _apiService.fetchCryptoData(ids);
//       if (response.isNotEmpty) {
//         final totalChange = response.fold(0.0, (sum, coinData) {
//           return sum + (coinData['price_change_percentage_24h'] ?? 0.0);
//         });
//         return totalChange / response.length;
//       }
//       return 0.0;
//     } catch (e) {
//       print('Error fetching percentage change: $e');
//       return 0.0;
//     }
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CryptoPack', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         elevation: 0,
//       ),
//       drawer: _buildDrawer(context),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('ALL CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryColor,
//                     foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Coming soon!')),
//                         );
//                       },
//                       child: Text('MY CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.secondaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(16.0),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final packIndex = _currentPage * _packsPerPage + index;
//                   if (packIndex >= _cryptoPacks.length) {
//                     return SizedBox.shrink();
//                   }
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CryptoPackDetailScreen(pack: _cryptoPacks[packIndex]),
//                         ),
//                       );
//                     },
//                     child: CryptoPackCard(pack: _cryptoPacks[packIndex]),
//                   );
//                 },
//                 childCount: _packsPerPage,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: AppTheme.primaryColor,
//             ),
//             child: Text(
//               'CryptoForYou',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.home),
//             title: Text('Home', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.account_balance_wallet),
//             title: Text('My Portfolio', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HoldingsScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('FAQ', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FAQScreen()),
//               );
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.support),
//             title: Text('Help & Support', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               launch('mailto:cryptoforyouhelp@gmail.com');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CryptoPackCard extends StatelessWidget {
//   final CryptoPack pack;

//   const CryptoPackCard({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.secondaryColor.withOpacity(0.1)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       pack.name,
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(pack.icon, color: AppTheme.primaryColor),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 pack.description,
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Spacer(),
//               Text(
//                 'Min Investment:',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//               ),
//               Text(
//                 '\$${pack.minInvestment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Change:',
//                     style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                   ),
//                   Text(
//                     '${pack.percentageChange.toStringAsFixed(2)}%',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: pack.percentageChange >= 0 ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Trend: ${pack.trend}',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CryptoPackDetailScreen(pack: pack),
//                       ),
//                     );
//                   },
//                   child: Text('Know More', style: TextStyle(fontSize: 12)),
//                   style: ElevatedButton.styleFrom(
//                backgroundColor    : AppTheme.primaryColor,
//                foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CryptoPackDetailScreen extends StatelessWidget {
//   final CryptoPack pack;
//   const CryptoPackDetailScreen({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(pack.name, style: TextStyle(color: Colors.white)),
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(pack.icon, size: 80, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoCard('About', pack.about),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Minimum Investment', '\$${pack.minInvestment.toStringAsFixed(2)}'),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Trend', pack.trend),
//                   SizedBox(height: 16),
//                   _buildInfoCard('24h Change', '${pack.percentageChange.toStringAsFixed(2)}%'),
//                   SizedBox(height: 24),
//                   Text(
//                     'Coin Distribution',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: FutureBuilder<List<dynamic>>(
//               future: _fetchCryptoData(context),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No data available', style: TextStyle(fontSize: 18)));
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         padding: EdgeInsets.all(16.0),
//                         child: PieChart(
//                           PieChartData(
//                             sections: getPieChartSections(snapshot.data!),
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                             borderData: FlBorderData(show: false),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) => _buildCoinListTile(snapshot.data![index]),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {

//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Investment functionality coming soon!')),
//             );
//           },
//           child: Text('Invest Now', style: TextStyle(fontSize: 18)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppTheme.primaryColor,
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(value, style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCoinListTile(dynamic coin) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: coin['image'],
//           width: 40,
//           height: 40,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         title: Text(coin['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text('${coin['current_price'].toStringAsFixed(2)} USD'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
//               style: TextStyle(
//                 color: coin['price_change_percentage_24h'] >= 0 ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text('24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
//   static const Map<String, Map<String, double>> _packPercentages = {
//      'trendsetters': {
//       'bitcoin': 0.4,
//       'ethereum': 0.3,
//       'cardano': 0.3,
//     },
//     'metaverse': {
//       'decentraland': 0.25,
//       'the-sandbox': 0.25,
//       'axie-infinity': 0.25,
//       'enjincoin': 0.25,
//     },
//     'starter': {
//       'bitcoin': 0.6,
//       'ethereum': 0.4,
//     },
//     'ultimate_alts': {
//       'cardano': 0.3,
//       'solana': 0.3,
//       'polkadot': 0.2,
//       'avalanche-2': 0.2,
//     },
//     'high_risk_high_reward': {
//       'shiba-inu': 0.5,
//       'dogecoin': 0.5,
//     },
//     'balanced': {
//       'bitcoin': 0.3,
//       'ethereum': 0.3,
//       'tether': 0.2,
//       'cardano': 0.1,
//       'solana': 0.1,
//     },
//   };

//   Future<List<dynamic>> _fetchCryptoData(BuildContext context) async {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);

//     final cachedData = holdingsProvider._cryptoPackCache.getCryptoPackData(pack.id);
//     if (cachedData != null) {
//       return cachedData;
//     }

//     final cryptoApiService = CryptoApiService();
//     final coinIds = _packPercentages[pack.id]?.keys.join(',') ?? '';
//     final data = await cryptoApiService.fetchCryptoData(coinIds);
//     await holdingsProvider._cryptoPackCache.setCryptoPackData(pack.id, data);
//     return data;
//   }

//   List<PieChartSectionData> getPieChartSections(List<dynamic> cryptoData) {
//     List<PieChartSectionData> sections = [];
//     final packPercentages = _packPercentages[pack.id] ?? {};
//     final colors = [
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.purple,
//       Colors.orange,
//     ];

//     int colorIndex = 0;
//     for (var coin in cryptoData) {
//       final percentage = packPercentages[coin['id']] ?? 0;
//       sections.add(
//         PieChartSectionData(
//           value: percentage,
//           title: '${coin['symbol'].toUpperCase()}\n${(percentage * 100).toStringAsFixed(0)}%',
//           color: colors[colorIndex % colors.length],
//           radius: 40,
//           titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//       colorIndex++;
//     }

//     return sections;
//   }
// }

// class FAQScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FAQ'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           ExpansionTile(
//             title: Text('What is CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'CryptoPack is a selection of curated cryptocurrency portfolios designed to suit various investment strategies.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How do I invest in a CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'You can invest in a CryptoPack by selecting your desired pack and making a minimum investment as specified.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Is there a risk in investing in cryptocurrencies?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, investing in cryptocurrencies carries risks due to their volatile nature. It is advisable to do thorough research and invest wisely.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How is the percentage change calculated?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'The percentage change is calculated based on the change in the value of the cryptocurrencies in the pack over the past 24 hours.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Can I track my investments?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, you can track your investments through the "My CryptoPacks" section, which will be available soon.',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HoldingsScreen extends StatefulWidget {
//   @override
//   _HoldingsScreenState createState() => _HoldingsScreenState();
// }

// class _HoldingsScreenState extends State<HoldingsScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _averagePriceController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _quantityController.dispose();
//     _averagePriceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: _buildHoldingsTheme(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My Portfolio'),
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             _buildSearchBar(),
//             _buildPortfolioOverview(),
//             Expanded(
//               child: Consumer<HoldingsProvider>(
//                 builder: (context, provider, child) {
//                   return Column(
//                     children: [
//                       if (provider.isSearching)
//                         _buildSearchResults(provider)
//                       else
//                         _buildHoldingsList(provider),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ThemeData _buildHoldingsTheme() {
//     return ThemeData(
//       primaryColor: const Color(0xFF6200EE),
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: Color(0xFF03DAC6),
//       ),
//       scaffoldBackgroundColor: Color(0xFFF5F5F5),
//       cardTheme: CardTheme(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6200EE)),
//         titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//         bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => context.read<HoldingsProvider>().searchCrypto(value),
//         decoration: InputDecoration(
//           hintText: 'Search cryptocurrencies...',
//           prefixIcon: Icon(Icons.search),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _searchController.clear();
//               context.read<HoldingsProvider>().searchCrypto('');
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPortfolioOverview() {
//     return Consumer<HoldingsProvider>(
//       builder: (context, provider, child) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Portfolio Value',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '${provider.getTotalValue().toStringAsFixed(2)} USD',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchResults(HoldingsProvider provider) {
//     return Expanded(
//       child: provider.isLoadingSearch
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: provider.searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = provider.searchResults[index];
//                 return ListTile(
//                   leading: CachedNetworkImage(
//                     imageUrl: result['large'] ?? '',
//                     width: 40,
//                     height: 40,
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                   title: Text(result['name']),
//                   subtitle: Text(result['symbol']),
//                   onTap: () => _showAddHoldingDialog(context, result, provider),
//                 );
//               },
//             ),
//     );
//   }

// Widget _buildHoldingsList(HoldingsProvider provider) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: provider.holdings.length,
//         itemBuilder: (context, index) {
//           final holding = provider.holdings[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     holding.name,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   Text(
//                     holding.symbol.toUpperCase(),
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Quantity: ${holding.quantity.toStringAsFixed(4)}'),
//                       Text('Avg. Price: ${holding.averagePrice.toStringAsFixed(2)} USD'),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Current Value: ${holding.currentValue.toStringAsFixed(2)} USD'),
//                       Text(
//                         'P/L: ${holding.profitLoss.toStringAsFixed(2)} USD',
//                         style: TextStyle(
//                           color: holding.profitLoss >= 0 ? Colors.green : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: false,
//                           holding: holding,
//                         ),
//                         child: Text('Add'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: true,
//                           holding: holding,
//                         ),
//                         child: Text('Edit'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showRemoveHoldingDialog(context, holding, provider),
//                         child: Text('Remove'),
//                         style: TextButton.styleFrom(foregroundColor: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//  void _showAddHoldingDialog(BuildContext context, Map<String, dynamic>? result, HoldingsProvider provider, {bool isEdit = false, CryptoHolding? holding}) {
//   if (isEdit) {
//     _quantityController.text = '';
//     _averagePriceController.text = holding!.averagePrice.toString();
//   } else {
//     _quantityController.clear();
//     _averagePriceController.clear();
//   }

//   String operation = 'Add';

//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Text(isEdit ? 'Edit Holding' : 'Add Holding'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isEdit)
//                   DropdownButton<String>(
//                     value: operation,
//                     items: ['Add', 'Subtract'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         operation = newValue!;
//                       });
//                     },
//                   ),
//                 TextField(
//                   controller: _quantityController,
//                   decoration: InputDecoration(
//                     labelText: 'Quantity',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _averagePriceController,
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   final newQuantity = double.tryParse(_quantityController.text) ?? 0;
//                   final newPrice = double.tryParse(_averagePriceController.text) ?? 0;

//                   if (isEdit) {
//                     final operationMultiplier = operation == 'Add' ? 1 : -1;
//                     final totalValue = (holding!.quantity * holding.averagePrice) + (newQuantity * newPrice * operationMultiplier);
//                     final totalQuantity = holding.quantity + (newQuantity * operationMultiplier);

//                     if (totalQuantity <= 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Cannot subtract more than available quantity')),
//                       );
//                       return;
//                     }

//                     final newAveragePrice = totalValue / totalQuantity;

//                     provider.updateHolding(
//                       holding.symbol,
//                       totalQuantity,
//                       newAveragePrice,
//                     );
//                   } else {
//                     provider.addHolding(
//                       result!['id'],
//                       result['name'],
//                       newQuantity,
//                       newPrice,
//                     );
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text(isEdit ? 'Update' : 'Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
//  void _showRemoveHoldingDialog(BuildContext context, CryptoHolding holding, HoldingsProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Holding'),
//         content: Text('Are you sure you want to remove ${holding.name} from your portfolio?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//             style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               provider.removeHolding(holding.symbol);
//               Navigator.pop(context);
//             },
//             child: Text('Remove'),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CryptoPackScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 15, 14, 14),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'android/logo (1).jpg',
//               width: MediaQuery.of(context).size.width * 0.4,
//               height: MediaQuery.of(context).size.width * 0.4,
//             ),
//             SizedBox(height: 24),
//             Text(
//               'CryptoForYou',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 238, 242, 244),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// void main() async {
//  // WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://pajnoqsxkpaujmdskmjy.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBham5vcXN4a3BhdWptZHNrbWp5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDE3Mjk0NywiZXhwIjoyMDM1NzQ4OTQ3fQ.uZY4kBkg-yu8z29Xt8DLqtvkalD-FmMQyMjMzr8WTmM',
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) {
//         final provider = HoldingsProvider()..fetchHoldings();
//         provider.preloadCryptoPacks(_cryptoPacks);
//         return provider;
//       },

//       child: MyApp(),
//     ),
//   );
// }
//  final supabase = Supabase.instance.client;//////////////////////////////////////////////////////////////////////////////
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CryptoPack',
//       theme: AppTheme.lightTheme,
//       home: SignInPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:dio/dio.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'login.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final List<CryptoPack> _cryptoPacks = [
//      CryptoPack(
//       name: 'Trendsetters',
//       description: 'Cutting-edge innovation with pioneering...',
//       minInvestment: 5000.00,
//       percentageChange: 0.0,
//       trend: 'Moderately High',
//       icon: Icons.trending_up,
//       coinIds: ['bitcoin', 'ethereum', 'cardano'],
//       about: 'Trendsetters pack focuses on cryptocurrencies that are leading the way in terms of innovation and market influence.',
//       id: 'trendsetters',
//     ),
//     CryptoPack(
//       name: 'Metaverse',
//       description: 'Leading metaverse tokens',
//       minInvestment: 2500.00,
//       percentageChange: 0.0,
//       trend: 'Very High',
//       icon: Icons.computer,
//       coinIds: ['decentraland', 'the-sandbox', 'axie-infinity', 'enjincoin'],
//       about: 'Metaverse pack includes top-performing tokens in the metaverse space, representing virtual worlds and digital assets.',
//       id: 'metaverse',
//     ),
//     CryptoPack(
//       name: 'Starter',
//       description: 'The two undisputed market-leaders',
//       minInvestment: 2500.00,
//       percentageChange: 0.0,
//       trend: 'Moderate',
//       icon: Icons.star,
//       coinIds: ['bitcoin', 'ethereum'],
//       about: 'Starter pack contains the two most prominent cryptocurrencies: Bitcoin and Ethereum, suitable for beginners.',
//       id: 'starter',
//     ),
//     CryptoPack(
//       name: 'Ultimate Alts of Tomorrow',
//       description: 'The undisputed Alt Coin selection',
//       minInvestment: 2500.00,
//       percentageChange: 0.0,
//       trend: 'Moderate',
//       icon: Icons.monetization_on,
//       coinIds: ['cardano', 'solana', 'polkadot', 'avalanche-2'],
//       about: 'Ultimate Alts pack features a selection of promising altcoins with potential for future growth.',
//       id: 'ultimate_alts',
//     ),
//     CryptoPack(
//       name: 'HighRiskHighReward',
//       description: 'High-risk investments with potential for high rewards',
//       minInvestment: 5000.00,
//       percentageChange: 0.0,
//       trend: 'High',
//       icon: Icons.warning,
//       coinIds: ['shiba-inu', 'dogecoin'],
//       about: 'HighRiskHighReward pack includes volatile cryptocurrencies with the potential for significant returns.',
//       id: 'high_risk_high_reward',
//     ),
//     CryptoPack(
//       name: 'Balanced',
//       description: 'A balanced portfolio of stable and volatile assets',
//       minInvestment: 3000.00,
//       percentageChange: 0.0,
//       trend: 'Medium',
//       icon: Icons.balance,
//       coinIds: ['bitcoin', 'ethereum', 'tether', 'cardano', 'solana'],
//       about: 'Balanced pack provides a mix of stable and volatile cryptocurrencies for a well-rounded investment.',
//       id: 'balanced',
//     ),
//   ];
// class ApiError extends Error {
//   final String message;
//   final int? statusCode;

//   ApiError({required this.message, this.statusCode});
// }

// class CryptoPack {
//   final String name;
//   final String description;
//   final double minInvestment;
//   double percentageChange;
//   final String trend;
//   final IconData icon;
//   final String id;
//   final String about;
//   final List<String> coinIds;

//   CryptoPack({
//     required this.name,
//     required this.description,
//     required this.minInvestment,
//     required this.percentageChange,
//     required this.trend,
//     required this.icon,
//     required this.id,
//     required this.about,
//     required this.coinIds,
//   });
// }

// class CryptoHolding {
//   final String symbol;
//   final String name;
//   double quantity;
//   double averagePrice;
//   double currentPrice;
//   double currentValue;
//   double investedAmount;
//   double profitLoss;
//   double dailyProfitLoss;

//   CryptoHolding({
//     required this.symbol,
//     required this.name,
//     required this.quantity,
//     required this.averagePrice,
//     required this.currentPrice,
//     required this.currentValue,
//     required this.investedAmount,
//     required this.profitLoss,
//     required this.dailyProfitLoss,
//   });

//   factory CryptoHolding.fromJson(Map<String, dynamic> json) {
//     return CryptoHolding(
//       symbol: json['symbol'],
//       name: json['name'],
//       quantity: json['quantity'],
//       averagePrice: json['averagePrice'],
//       currentPrice: json['currentPrice'],
//       currentValue: json['currentValue'],
//       investedAmount: json['investedAmount'],
//       profitLoss: json['profitLoss'],
//       dailyProfitLoss: json['dailyProfitLoss'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'symbol': symbol,
//       'name': name,
//       'quantity': quantity,
//       'averagePrice': averagePrice,
//       'currentPrice': currentPrice,
//       'currentValue': currentValue,
//       'investedAmount': investedAmount,
//       'profitLoss': profitLoss,
//       'dailyProfitLoss': dailyProfitLoss,
//     };
//   }
// }

// class CachedData<T> {
//   final T data;
//   final DateTime timestamp;

//   CachedData({required this.data, required this.timestamp});
// }

// class CryptoPackCache {
//   final Map<String, CachedData<List<dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 15);

//   Future<void> setCryptoPackData(String packId, List<dynamic> data) async {
//     _cache[packId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   List<dynamic>? getCryptoPackData(String packId) {
//     if (_cache.containsKey(packId) && !_isCacheExpired(packId)) {
//       return _cache[packId]!.data;
//     }
//     return null;
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class CryptoApiService {
//   final Dio _dio = Dio();
//   final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 5);

// CryptoApiService() {
//   _dio.interceptors.add(InterceptorsWrapper(
//     onError: (DioError e, ErrorInterceptorHandler handler) {
//       ApiError error;
//       if (e.response != null) {
//         error = ApiError(
//           message: e.response!.data['message'] ?? 'Unknown error',
//           statusCode: e.response!.statusCode
//         );
//       } else {
//         error = ApiError(message: e.message ?? 'Unknown error');
//       }
//       throw error;
//     },
//   ));
// }
//   Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
//     if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
//       return _cache[symbol]!.data;
//     }

//     try {
//       final response = await _dio.get(
//           'https://api.coingecko.com/api/v3/simple/price?ids=$symbol&vs_currencies=usd&include_24hr_change=true');
//       final data = {
//         'currentPrice': response.data[symbol]['usd'],
//         'priceChange24h': response.data[symbol]['usd_24h_change'],
//       };
//       _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
//       return data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to load price data');
//     }
//   }

//   Future<Map<String, dynamic>> searchCrypto(String query) async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/search?query=$query');
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to search crypto');
//     }
//   }

//   Future<List<dynamic>> fetchCryptoData(String coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds,
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchBatchCryptoData(List<String> coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds.join(','),
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return Map.fromIterable(response.data, key: (item) => item['id'], value: (item) => item);
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch batch data');
//     }
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class HoldingsProvider with ChangeNotifier {
//   final CryptoApiService _apiService = CryptoApiService();
//   final CryptoPackCache _cryptoPackCache = CryptoPackCache();
//   List<CryptoHolding> _holdings = [];
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _isSearching = false;
//   bool _isLoadingSearch = false;

//   List<CryptoHolding> get holdings => _holdings;
//   List<Map<String, dynamic>> get searchResults => _searchResults;
//   bool get isSearching => _isSearching;
//   bool get isLoadingSearch => _isLoadingSearch;

//   Future<void> fetchHoldings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = prefs.getStringList('holdings') ?? [];
//       _holdings = holdingsJson
//           .map((json) => CryptoHolding.fromJson(jsonDecode(json)))
//           .toList();
//       await _updateHoldingsData();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching holdings: $e');
//     }
//   }

//   Future<void> _updateHoldingsData() async {
//     final futures = _holdings.map((holding) => _apiService.getCurrentPriceData(holding.symbol)).toList();
//     final results = await Future.wait(futures);

//     for (var i = 0; i < _holdings.length; i++) {
//       try {
//         final priceData = results[i];
//         _holdings[i].currentPrice = priceData['currentPrice'].toDouble();
//         _holdings[i].currentValue = _holdings[i].quantity * _holdings[i].currentPrice;
//         _holdings[i].profitLoss = _holdings[i].currentValue - _holdings[i].investedAmount;
//         _holdings[i].dailyProfitLoss = _holdings[i].currentValue * (priceData['priceChange24h'] / 100);
//       } catch (e) {
//         print('Error updating holding data for ${_holdings[i].symbol}: $e');
//       }
//     }
//   }

//   Future<void> searchCrypto(String searchTerm) async {
//     _isSearching = searchTerm.isNotEmpty;
//     if (_isSearching) {
//       _isLoadingSearch = true;
//       notifyListeners();
//       try {
//         final results = await _apiService.searchCrypto(searchTerm);
//         _searchResults = List<Map<String, dynamic>>.from(results['coins']);
//       } catch (e) {
//         print('Error searching crypto: $e');
//         _searchResults = [];
//       }
//       _isLoadingSearch = false;
//     } else {
//       _searchResults = [];
//     }
//     notifyListeners();
//   }

//   Future<void> addHolding(String symbol, String name, double quantity, double averagePrice) async {
//       try {
//       final priceData = await _apiService.getCurrentPriceData(symbol);
//       final currentPrice = priceData['currentPrice'].toDouble();
//       final currentValue = quantity * currentPrice;
//       final investedAmount = quantity * averagePrice;
//       final profitLoss = currentValue - investedAmount;
//       final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//       final existingHoldingIndex = _holdings.indexWhere((holding) => holding.symbol == symbol);

//       if (existingHoldingIndex != -1) {
//         final existingHolding = _holdings[existingHoldingIndex];
//         final newQuantity = existingHolding.quantity + quantity;
//         final newInvestedAmount = existingHolding.investedAmount + investedAmount;
//         final newAveragePrice = newInvestedAmount / newQuantity;

//         _holdings[existingHoldingIndex].quantity = newQuantity;
//         _holdings[existingHoldingIndex].averagePrice = newAveragePrice;
//         _holdings[existingHoldingIndex].investedAmount = newInvestedAmount;
//         _holdings[existingHoldingIndex].currentPrice = currentPrice;
//         _holdings[existingHoldingIndex].currentValue = newQuantity * currentPrice;
//         _holdings[existingHoldingIndex].profitLoss = _holdings[existingHoldingIndex].currentValue - _holdings[existingHoldingIndex].investedAmount;
//         _holdings[existingHoldingIndex].dailyProfitLoss = _holdings[existingHoldingIndex].currentValue * (priceData['priceChange24h'] / 100);
//       } else {
//         final newHolding = CryptoHolding(
//           symbol: symbol,
//           name: name,
//           quantity: quantity,
//           averagePrice: averagePrice,
//           currentPrice: currentPrice,
//           currentValue: currentValue,
//           investedAmount: investedAmount,
//           profitLoss: profitLoss,
//           dailyProfitLoss: dailyProfitLoss,
//         );

//         _holdings.add(newHolding);
//       }

//       await _saveHoldings();
//       notifyListeners();
//     } catch (e) {
//       print('Error adding holding: $e');
//     }
//   }

//   Future<void> updateHolding(String symbol, double quantity, double averagePrice) async {
//      final index = _holdings.indexWhere((holding) => holding.symbol == symbol);
//     if (index != -1) {
//       try {
//         final priceData = await _apiService.getCurrentPriceData(symbol);
//         final currentValue = quantity * priceData['currentPrice'];
//         final investedAmount = quantity * averagePrice;
//         final profitLoss = currentValue - investedAmount;
//         final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//         _holdings[index].quantity = quantity;
//         _holdings[index].averagePrice = averagePrice;
//         _holdings[index].currentPrice = priceData['currentPrice'];
//         _holdings[index].currentValue = currentValue;
//         _holdings[index].investedAmount = investedAmount;
//         _holdings[index].profitLoss = profitLoss;
//         _holdings[index].dailyProfitLoss = dailyProfitLoss;

//         await _saveHoldings();
//         notifyListeners();
//       } catch (e) {
//         print('Error updating holding: $e');
//       }
//     }
//   }

//   void removeHolding(String symbol) {
//      _holdings.removeWhere((holding) => holding.symbol == symbol);
//     _saveHoldings();
//     notifyListeners();
//   }

//   double getTotalValue() {
//     return _holdings.fold(0, (sum, holding) => sum + holding.currentValue);
//   }

//   Future<void> _saveHoldings() async {
//      try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = _holdings.map((holding) => jsonEncode(holding.toJson())).toList();
//       await prefs.setStringList('holdings', holdingsJson);
//     } catch (e) {
//       print('Error saving holdings: $e');
//     }
//   }

//   Future<void> preloadCryptoPacks(List<CryptoPack> cryptoPacks) async {
//     final allCoinIds = cryptoPacks.expand((pack) => pack.coinIds).toSet().toList();
//     try {
//       final batchData = await _apiService.fetchBatchCryptoData(allCoinIds);
//       for (var pack in cryptoPacks) {
//         final packData = pack.coinIds.map((id) => batchData[id]).toList();
//         await _cryptoPackCache.setCryptoPackData(pack.id, packData);
//       }
//     } catch (e) {
//       print('Error preloading crypto packs: $e');
//     }
//   }

// }

// class AppTheme {
//   static const primaryColor = Color(0xFF2196F3);
//   static const secondaryColor = Color(0xFF4CAF50);
//   static const backgroundColor = Color(0xFFF5F5F5);
//   static const cardColor = Colors.white;
//   static const textColor = Color(0xFF333333);
//   static const lightTextColor = Color(0xFF666666);

//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: primaryColor,
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: secondaryColor,
//       ),
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: AppBarTheme(
//         color: primaryColor,
//         elevation: 0,
//       ),
//       cardTheme: CardTheme(
//         color: cardColor,
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
//         titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
//         bodyMedium: TextStyle(color: textColor, fontSize: 14),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: primaryColor,
//         textTheme: ButtonTextTheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = supabase.auth.currentUser;
//     final userData = user?.userMetadata;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await supabase.auth.signOut();
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => SignInPage()),
//                 (route) => false,
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Email: ${user?.email ?? 'N/A'}'),
//             SizedBox(height: 16),
//             Text('First Name: ${userData?['first_name'] ?? 'N/A'}'),
//             SizedBox(height: 8),
//             Text('Last Name: ${userData?['last_name'] ?? 'N/A'}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class CryptoPackScreen extends StatefulWidget {
//   @override
//   _CryptoPackScreenState createState() => _CryptoPackScreenState();
// }

// class _CryptoPackScreenState extends State<CryptoPackScreen> {////////////////////////////////////////////////////////////////////////////////////////
//   final CryptoApiService _apiService = CryptoApiService();
//   int _currentPage = 0;
//   static const int _packsPerPage = 6;

//   @override
//   void initState() {
//     super.initState();
//     _calculatePercentageChange();
//     _preloadCryptoPacks();
//   }

//    void _preloadCryptoPacks() {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);
//     holdingsProvider.preloadCryptoPacks(_cryptoPacks);
//   }

//   void _calculatePercentageChange() async {
//     for (var pack in _cryptoPacks) {
//       try {
//         double percentageChange = await _fetchPercentageChange(pack.coinIds);
//         setState(() {
//           pack.percentageChange = percentageChange;
//         });
//       } catch (e) {
//         print('Error calculating percentage change for ${pack.name}: $e');
//         setState(() {
//           pack.percentageChange = pack.percentageChange;
//         });
//       }
//     }
//   }

//   Future<double> _fetchPercentageChange(List<String> coinIds) async {
//     try {
//       final ids = coinIds.join(',');
//       final response = await _apiService.fetchCryptoData(ids);
//       if (response.isNotEmpty) {
//         final totalChange = response.fold(0.0, (sum, coinData) {
//           return sum + (coinData['price_change_percentage_24h'] ?? 0.0);
//         });
//         return totalChange / response.length;
//       }
//       return 0.0;
//     } catch (e) {
//       print('Error fetching percentage change: $e');
//       return 0.0;
//     }
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CryptoPack', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         elevation: 0,
//          actions: [
//           IconButton(
//             icon: Icon(Icons.account_circle),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfileScreen()),
//               );
//             },
//           ),
//         ],
//       ),

//       drawer: _buildDrawer(context),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('ALL CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryColor,
//                     foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Coming soon!')),
//                         );
//                       },
//                       child: Text('MY CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.secondaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(16.0),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final packIndex = _currentPage * _packsPerPage + index;
//                   if (packIndex >= _cryptoPacks.length) {
//                     return SizedBox.shrink();
//                   }
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CryptoPackDetailScreen(pack: _cryptoPacks[packIndex]),
//                         ),
//                       );
//                     },
//                     child: CryptoPackCard(pack: _cryptoPacks[packIndex]),
//                   );
//                 },
//                 childCount: _packsPerPage,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: AppTheme.primaryColor,
//             ),
//             child: Text(
//               'CryptoForYou',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.home),
//             title: Text('Home', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.account_balance_wallet),
//             title: Text('My Portfolio', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HoldingsScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('FAQ', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FAQScreen()),
//               );
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.support),
//             title: Text('Help & Support', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               launch('mailto:cryptoforyouhelp@gmail.com');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CryptoPackCard extends StatelessWidget {
//   final CryptoPack pack;

//   const CryptoPackCard({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.secondaryColor.withOpacity(0.1)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       pack.name,
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(pack.icon, color: AppTheme.primaryColor),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 pack.description,
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Spacer(),
//               Text(
//                 'Min Investment:',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//               ),
//               Text(
//                 '\$${pack.minInvestment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Change:',
//                     style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                   ),
//                   Text(
//                     '${pack.percentageChange.toStringAsFixed(2)}%',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: pack.percentageChange >= 0 ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Trend: ${pack.trend}',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CryptoPackDetailScreen(pack: pack),
//                       ),
//                     );
//                   },
//                   child: Text('Know More', style: TextStyle(fontSize: 12)),
//                   style: ElevatedButton.styleFrom(
//                backgroundColor    : AppTheme.primaryColor,
//                foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CryptoPackDetailScreen extends StatelessWidget {
//   final CryptoPack pack;
//   const CryptoPackDetailScreen({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(pack.name, style: TextStyle(color: Colors.white)),
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(pack.icon, size: 80, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoCard('About', pack.about),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Minimum Investment', '\$${pack.minInvestment.toStringAsFixed(2)}'),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Trend', pack.trend),
//                   SizedBox(height: 16),
//                   _buildInfoCard('24h Change', '${pack.percentageChange.toStringAsFixed(2)}%'),
//                   SizedBox(height: 24),
//                   Text(
//                     'Coin Distribution',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: FutureBuilder<List<dynamic>>(
//               future: _fetchCryptoData(context),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No data available', style: TextStyle(fontSize: 18)));
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         padding: EdgeInsets.all(16.0),
//                         child: PieChart(
//                           PieChartData(
//                             sections: getPieChartSections(snapshot.data!),
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                             borderData: FlBorderData(show: false),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) => _buildCoinListTile(snapshot.data![index]),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {

//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Investment functionality coming soon!')),
//             );
//           },
//           child: Text('Invest Now', style: TextStyle(fontSize: 18)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppTheme.primaryColor,
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(value, style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCoinListTile(dynamic coin) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: coin['image'],
//           width: 40,
//           height: 40,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         title: Text(coin['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text('${coin['current_price'].toStringAsFixed(2)} USD'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
//               style: TextStyle(
//                 color: coin['price_change_percentage_24h'] >= 0 ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text('24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
//   static const Map<String, Map<String, double>> _packPercentages = {
//      'trendsetters': {
//       'bitcoin': 0.4,
//       'ethereum': 0.3,
//       'cardano': 0.3,
//     },
//     'metaverse': {
//       'decentraland': 0.25,
//       'the-sandbox': 0.25,
//       'axie-infinity': 0.25,
//       'enjincoin': 0.25,
//     },
//     'starter': {
//       'bitcoin': 0.6,
//       'ethereum': 0.4,
//     },
//     'ultimate_alts': {
//       'cardano': 0.3,
//       'solana': 0.3,
//       'polkadot': 0.2,
//       'avalanche-2': 0.2,
//     },
//     'high_risk_high_reward': {
//       'shiba-inu': 0.5,
//       'dogecoin': 0.5,
//     },
//     'balanced': {
//       'bitcoin': 0.3,
//       'ethereum': 0.3,
//       'tether': 0.2,
//       'cardano': 0.1,
//       'solana': 0.1,
//     },
//   };

//   Future<List<dynamic>> _fetchCryptoData(BuildContext context) async {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);

//     final cachedData = holdingsProvider._cryptoPackCache.getCryptoPackData(pack.id);
//     if (cachedData != null) {
//       return cachedData;
//     }

//     final cryptoApiService = CryptoApiService();
//     final coinIds = _packPercentages[pack.id]?.keys.join(',') ?? '';
//     final data = await cryptoApiService.fetchCryptoData(coinIds);
//     await holdingsProvider._cryptoPackCache.setCryptoPackData(pack.id, data);
//     return data;
//   }

//   List<PieChartSectionData> getPieChartSections(List<dynamic> cryptoData) {
//     List<PieChartSectionData> sections = [];
//     final packPercentages = _packPercentages[pack.id] ?? {};
//     final colors = [
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.purple,
//       Colors.orange,
//     ];

//     int colorIndex = 0;
//     for (var coin in cryptoData) {
//       final percentage = packPercentages[coin['id']] ?? 0;
//       sections.add(
//         PieChartSectionData(
//           value: percentage,
//           title: '${coin['symbol'].toUpperCase()}\n${(percentage * 100).toStringAsFixed(0)}%',
//           color: colors[colorIndex % colors.length],
//           radius: 40,
//           titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//       colorIndex++;
//     }

//     return sections;
//   }
// }

// class FAQScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FAQ'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           ExpansionTile(
//             title: Text('What is CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'CryptoPack is a selection of curated cryptocurrency portfolios designed to suit various investment strategies.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How do I invest in a CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'You can invest in a CryptoPack by selecting your desired pack and making a minimum investment as specified.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Is there a risk in investing in cryptocurrencies?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, investing in cryptocurrencies carries risks due to their volatile nature. It is advisable to do thorough research and invest wisely.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How is the percentage change calculated?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'The percentage change is calculated based on the change in the value of the cryptocurrencies in the pack over the past 24 hours.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Can I track my investments?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, you can track your investments through the "My CryptoPacks" section, which will be available soon.',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HoldingsScreen extends StatefulWidget {
//   @override
//   _HoldingsScreenState createState() => _HoldingsScreenState();
// }

// class _HoldingsScreenState extends State<HoldingsScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _averagePriceController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _quantityController.dispose();
//     _averagePriceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: _buildHoldingsTheme(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My Portfolio'),
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             _buildSearchBar(),
//             _buildPortfolioOverview(),
//             Expanded(
//               child: Consumer<HoldingsProvider>(
//                 builder: (context, provider, child) {
//                   return Column(
//                     children: [
//                       if (provider.isSearching)
//                         _buildSearchResults(provider)
//                       else
//                         _buildHoldingsList(provider),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ThemeData _buildHoldingsTheme() {
//     return ThemeData(
//       primaryColor: const Color(0xFF6200EE),
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: Color(0xFF03DAC6),
//       ),
//       scaffoldBackgroundColor: Color(0xFFF5F5F5),
//       cardTheme: CardTheme(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6200EE)),
//         titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//         bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => context.read<HoldingsProvider>().searchCrypto(value),
//         decoration: InputDecoration(
//           hintText: 'Search cryptocurrencies...',
//           prefixIcon: Icon(Icons.search),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _searchController.clear();
//               context.read<HoldingsProvider>().searchCrypto('');
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPortfolioOverview() {
//     return Consumer<HoldingsProvider>(
//       builder: (context, provider, child) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Portfolio Value',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '${provider.getTotalValue().toStringAsFixed(2)} USD',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchResults(HoldingsProvider provider) {
//     return Expanded(
//       child: provider.isLoadingSearch
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: provider.searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = provider.searchResults[index];
//                 return ListTile(
//                   leading: CachedNetworkImage(
//                     imageUrl: result['large'] ?? '',
//                     width: 40,
//                     height: 40,
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                   title: Text(result['name']),
//                   subtitle: Text(result['symbol']),
//                   onTap: () => _showAddHoldingDialog(context, result, provider),
//                 );
//               },
//             ),
//     );
//   }

// Widget _buildHoldingsList(HoldingsProvider provider) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: provider.holdings.length,
//         itemBuilder: (context, index) {
//           final holding = provider.holdings[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     holding.name,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   Text(
//                     holding.symbol.toUpperCase(),
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Quantity: ${holding.quantity.toStringAsFixed(4)}'),
//                       Text('Avg. Price: ${holding.averagePrice.toStringAsFixed(2)} USD'),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Current Value: ${holding.currentValue.toStringAsFixed(2)} USD'),
//                       Text(
//                         'P/L: ${holding.profitLoss.toStringAsFixed(2)} USD',
//                         style: TextStyle(
//                           color: holding.profitLoss >= 0 ? Colors.green : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: false,
//                           holding: holding,
//                         ),
//                         child: Text('Add'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: true,
//                           holding: holding,
//                         ),
//                         child: Text('Edit'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showRemoveHoldingDialog(context, holding, provider),
//                         child: Text('Remove'),
//                         style: TextButton.styleFrom(foregroundColor: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//  void _showAddHoldingDialog(BuildContext context, Map<String, dynamic>? result, HoldingsProvider provider, {bool isEdit = false, CryptoHolding? holding}) {
//   if (isEdit) {
//     _quantityController.text = '';
//     _averagePriceController.text = holding!.averagePrice.toString();
//   } else {
//     _quantityController.clear();
//     _averagePriceController.clear();
//   }

//   String operation = 'Add';

//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Text(isEdit ? 'Edit Holding' : 'Add Holding'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isEdit)
//                   DropdownButton<String>(
//                     value: operation,
//                     items: ['Add', 'Subtract'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         operation = newValue!;
//                       });
//                     },
//                   ),
//                 TextField(
//                   controller: _quantityController,
//                   decoration: InputDecoration(
//                     labelText: 'Quantity',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _averagePriceController,
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   final newQuantity = double.tryParse(_quantityController.text) ?? 0;
//                   final newPrice = double.tryParse(_averagePriceController.text) ?? 0;

//                   if (isEdit) {
//                     final operationMultiplier = operation == 'Add' ? 1 : -1;
//                     final totalValue = (holding!.quantity * holding.averagePrice) + (newQuantity * newPrice * operationMultiplier);
//                     final totalQuantity = holding.quantity + (newQuantity * operationMultiplier);

//                     if (totalQuantity <= 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Cannot subtract more than available quantity')),
//                       );
//                       return;
//                     }

//                     final newAveragePrice = totalValue / totalQuantity;

//                     provider.updateHolding(
//                       holding.symbol,
//                       totalQuantity,
//                       newAveragePrice,
//                     );
//                   } else {
//                     provider.addHolding(
//                       result!['id'],
//                       result['name'],
//                       newQuantity,
//                       newPrice,
//                     );
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text(isEdit ? 'Update' : 'Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
//  void _showRemoveHoldingDialog(BuildContext context, CryptoHolding holding, HoldingsProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Holding'),
//         content: Text('Are you sure you want to remove ${holding.name} from your portfolio?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//             style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               provider.removeHolding(holding.symbol);
//               Navigator.pop(context);
//             },
//             child: Text('Remove'),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CryptoPackScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 15, 14, 14),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'android/logo (1).jpg',
//               width: MediaQuery.of(context).size.width * 0.4,
//               height: MediaQuery.of(context).size.width * 0.4,
//             ),
//             SizedBox(height: 24),
//             Text(
//               'CryptoForYou',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 238, 242, 244),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// void main() async {
//  // WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://pajnoqsxkpaujmdskmjy.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBham5vcXN4a3BhdWptZHNrbWp5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDE3Mjk0NywiZXhwIjoyMDM1NzQ4OTQ3fQ.uZY4kBkg-yu8z29Xt8DLqtvkalD-FmMQyMjMzr8WTmM',
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) {
//         final provider = HoldingsProvider()..fetchHoldings();
//         provider.preloadCryptoPacks(_cryptoPacks);
//         return provider;
//       },

//       child: MyApp(),
//     ),
//   );
// }
//  final supabase = Supabase.instance.client;//////////////////////////////////////////////////////////////////////////////
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CryptoPack',
//       theme: AppTheme.lightTheme,
//       home: SignInPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// import 'profile.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:dio/dio.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'login.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final List<CryptoPack> _cryptoPacks = [
//      CryptoPack(
//       name: 'Trendsetters',
//       description: 'Cutting-edge innovation with pioneering...',
//       minInvestment: 5000.00,
//       percentageChange: 0.0,
//       trend: 'Moderately High',
//       icon: Icons.trending_up,
//       coinIds: ['bitcoin', 'ethereum', 'cardano'],
//       about: 'Trendsetters pack focuses on cryptocurrencies that are leading the way in terms of innovation and market influence.',
//       id: 'trendsetters',
//     ),
//     CryptoPack(
//       name: 'Metaverse',
//       description: 'Leading metaverse tokens',
//       minInvestment: 2500.00,
//       percentageChange: 0.0,
//       trend: 'Very High',
//       icon: Icons.computer,
//       coinIds: ['decentraland', 'the-sandbox', 'axie-infinity', 'enjincoin'],
//       about: 'Metaverse pack includes top-performing tokens in the metaverse space, representing virtual worlds and digital assets.',
//       id: 'metaverse',
//     ),
//     CryptoPack(
//       name: 'Starter',
//       description: 'The two undisputed market-leaders',
//       minInvestment: 2500.00,
//       percentageChange: 0.0,
//       trend: 'Moderate',
//       icon: Icons.star,
//       coinIds: ['bitcoin', 'ethereum'],
//       about: 'Starter pack contains the two most prominent cryptocurrencies: Bitcoin and Ethereum, suitable for beginners.',
//       id: 'starter',
//     ),
//     CryptoPack(
//       name: 'Ultimate Alts of Tomorrow',
//       description: 'The undisputed Alt Coin selection',
//       minInvestment: 2500.00,
//       percentageChange: 0.0,
//       trend: 'Moderate',
//       icon: Icons.monetization_on,
//       coinIds: ['cardano', 'solana', 'polkadot', 'avalanche-2'],
//       about: 'Ultimate Alts pack features a selection of promising altcoins with potential for future growth.',
//       id: 'ultimate_alts',
//     ),
//     CryptoPack(
//       name: 'HighRiskHighReward',
//       description: 'High-risk investments with potential for high rewards',
//       minInvestment: 5000.00,
//       percentageChange: 0.0,
//       trend: 'High',
//       icon: Icons.warning,
//       coinIds: ['shiba-inu', 'dogecoin'],
//       about: 'HighRiskHighReward pack includes volatile cryptocurrencies with the potential for significant returns.',
//       id: 'high_risk_high_reward',
//     ),
//     CryptoPack(
//       name: 'Balanced',
//       description: 'A balanced portfolio of stable and volatile assets',
//       minInvestment: 3000.00,
//       percentageChange: 0.0,
//       trend: 'Medium',
//       icon: Icons.balance,
//       coinIds: ['bitcoin', 'ethereum', 'tether', 'cardano', 'solana'],
//       about: 'Balanced pack provides a mix of stable and volatile cryptocurrencies for a well-rounded investment.',
//       id: 'balanced',
//     ),
//   ];
// class ApiError extends Error {
//   final String message;
//   final int? statusCode;

//   ApiError({required this.message, this.statusCode});
// }

// class CryptoPack {
//   final String name;
//   final String description;
//   final double minInvestment;
//   double percentageChange;
//   final String trend;
//   final IconData icon;
//   final String id;
//   final String about;
//   final List<String> coinIds;

//   CryptoPack({
//     required this.name,
//     required this.description,
//     required this.minInvestment,
//     required this.percentageChange,
//     required this.trend,
//     required this.icon,
//     required this.id,
//     required this.about,
//     required this.coinIds,
//   });
// }

// class CryptoHolding {
//   final String symbol;
//   final String name;
//   double quantity;
//   double averagePrice;
//   double currentPrice;
//   double currentValue;
//   double investedAmount;
//   double profitLoss;
//   double dailyProfitLoss;

//   CryptoHolding({
//     required this.symbol,
//     required this.name,
//     required this.quantity,
//     required this.averagePrice,
//     required this.currentPrice,
//     required this.currentValue,
//     required this.investedAmount,
//     required this.profitLoss,
//     required this.dailyProfitLoss,
//   });

//   factory CryptoHolding.fromJson(Map<String, dynamic> json) {
//     return CryptoHolding(
//       symbol: json['symbol'],
//       name: json['name'],
//       quantity: json['quantity'],
//       averagePrice: json['averagePrice'],
//       currentPrice: json['currentPrice'],
//       currentValue: json['currentValue'],
//       investedAmount: json['investedAmount'],
//       profitLoss: json['profitLoss'],
//       dailyProfitLoss: json['dailyProfitLoss'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'symbol': symbol,
//       'name': name,
//       'quantity': quantity,
//       'averagePrice': averagePrice,
//       'currentPrice': currentPrice,
//       'currentValue': currentValue,
//       'investedAmount': investedAmount,
//       'profitLoss': profitLoss,
//       'dailyProfitLoss': dailyProfitLoss,
//     };
//   }
// }

// class CachedData<T> {
//   final T data;
//   final DateTime timestamp;

//   CachedData({required this.data, required this.timestamp});
// }

// class CryptoPackCache {
//   final Map<String, CachedData<List<dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 15);

//   Future<void> setCryptoPackData(String packId, List<dynamic> data) async {
//     _cache[packId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   List<dynamic>? getCryptoPackData(String packId) {
//     if (_cache.containsKey(packId) && !_isCacheExpired(packId)) {
//       return _cache[packId]!.data;
//     }
//     return null;
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class CryptoApiService {
//   final Dio _dio = Dio();
//   final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 5);

// CryptoApiService() {
//   _dio.interceptors.add(InterceptorsWrapper(
//     onError: (DioError e, ErrorInterceptorHandler handler) {
//       ApiError error;
//       if (e.response != null) {
//         error = ApiError(
//           message: e.response!.data['message'] ?? 'Unknown error',
//           statusCode: e.response!.statusCode
//         );
//       } else {
//         error = ApiError(message: e.message ?? 'Unknown error');
//       }
//       throw error;
//     },
//   ));
// }
//   Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
//     if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
//       return _cache[symbol]!.data;
//     }

//     try {
//       final response = await _dio.get(
//           'https://api.coingecko.com/api/v3/simple/price?ids=$symbol&vs_currencies=usd&include_24hr_change=true');
//       final data = {
//         'currentPrice': response.data[symbol]['usd'],
//         'priceChange24h': response.data[symbol]['usd_24h_change'],
//       };
//       _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
//       return data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to load price data');
//     }
//   }

//   Future<Map<String, dynamic>> searchCrypto(String query) async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/search?query=$query');
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to search crypto');
//     }
//   }

//   Future<List<dynamic>> fetchCryptoData(String coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds,
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchBatchCryptoData(List<String> coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds.join(','),
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return Map.fromIterable(response.data, key: (item) => item['id'], value: (item) => item);
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch batch data');
//     }
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class HoldingsProvider with ChangeNotifier {
//   final CryptoApiService _apiService = CryptoApiService();
//   final CryptoPackCache _cryptoPackCache = CryptoPackCache();
//   List<CryptoHolding> _holdings = [];
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _isSearching = false;
//   bool _isLoadingSearch = false;

//   List<CryptoHolding> get holdings => _holdings;
//   List<Map<String, dynamic>> get searchResults => _searchResults;
//   bool get isSearching => _isSearching;
//   bool get isLoadingSearch => _isLoadingSearch;

//   Future<void> fetchHoldings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = prefs.getStringList('holdings') ?? [];
//       _holdings = holdingsJson
//           .map((json) => CryptoHolding.fromJson(jsonDecode(json)))
//           .toList();
//       await _updateHoldingsData();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching holdings: $e');
//     }
//   }

//   Future<void> _updateHoldingsData() async {
//     final futures = _holdings.map((holding) => _apiService.getCurrentPriceData(holding.symbol)).toList();
//     final results = await Future.wait(futures);

//     for (var i = 0; i < _holdings.length; i++) {
//       try {
//         final priceData = results[i];
//         _holdings[i].currentPrice = priceData['currentPrice'].toDouble();
//         _holdings[i].currentValue = _holdings[i].quantity * _holdings[i].currentPrice;
//         _holdings[i].profitLoss = _holdings[i].currentValue - _holdings[i].investedAmount;
//         _holdings[i].dailyProfitLoss = _holdings[i].currentValue * (priceData['priceChange24h'] / 100);
//       } catch (e) {
//         print('Error updating holding data for ${_holdings[i].symbol}: $e');
//       }
//     }
//   }

//   Future<void> searchCrypto(String searchTerm) async {
//     _isSearching = searchTerm.isNotEmpty;
//     if (_isSearching) {
//       _isLoadingSearch = true;
//       notifyListeners();
//       try {
//         final results = await _apiService.searchCrypto(searchTerm);
//         _searchResults = List<Map<String, dynamic>>.from(results['coins']);
//       } catch (e) {
//         print('Error searching crypto: $e');
//         _searchResults = [];
//       }
//       _isLoadingSearch = false;
//     } else {
//       _searchResults = [];
//     }
//     notifyListeners();
//   }

//   Future<void> addHolding(String symbol, String name, double quantity, double averagePrice) async {
//       try {
//       final priceData = await _apiService.getCurrentPriceData(symbol);
//       final currentPrice = priceData['currentPrice'].toDouble();
//       final currentValue = quantity * currentPrice;
//       final investedAmount = quantity * averagePrice;
//       final profitLoss = currentValue - investedAmount;
//       final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//       final existingHoldingIndex = _holdings.indexWhere((holding) => holding.symbol == symbol);

//       if (existingHoldingIndex != -1) {
//         final existingHolding = _holdings[existingHoldingIndex];
//         final newQuantity = existingHolding.quantity + quantity;
//         final newInvestedAmount = existingHolding.investedAmount + investedAmount;
//         final newAveragePrice = newInvestedAmount / newQuantity;

//         _holdings[existingHoldingIndex].quantity = newQuantity;
//         _holdings[existingHoldingIndex].averagePrice = newAveragePrice;
//         _holdings[existingHoldingIndex].investedAmount = newInvestedAmount;
//         _holdings[existingHoldingIndex].currentPrice = currentPrice;
//         _holdings[existingHoldingIndex].currentValue = newQuantity * currentPrice;
//         _holdings[existingHoldingIndex].profitLoss = _holdings[existingHoldingIndex].currentValue - _holdings[existingHoldingIndex].investedAmount;
//         _holdings[existingHoldingIndex].dailyProfitLoss = _holdings[existingHoldingIndex].currentValue * (priceData['priceChange24h'] / 100);
//       } else {
//         final newHolding = CryptoHolding(
//           symbol: symbol,
//           name: name,
//           quantity: quantity,
//           averagePrice: averagePrice,
//           currentPrice: currentPrice,
//           currentValue: currentValue,
//           investedAmount: investedAmount,
//           profitLoss: profitLoss,
//           dailyProfitLoss: dailyProfitLoss,
//         );

//         _holdings.add(newHolding);
//       }

//       await _saveHoldings();
//       notifyListeners();
//     } catch (e) {
//       print('Error adding holding: $e');
//     }
//   }

//   Future<void> updateHolding(String symbol, double quantity, double averagePrice) async {
//      final index = _holdings.indexWhere((holding) => holding.symbol == symbol);
//     if (index != -1) {
//       try {
//         final priceData = await _apiService.getCurrentPriceData(symbol);
//         final currentValue = quantity * priceData['currentPrice'];
//         final investedAmount = quantity * averagePrice;
//         final profitLoss = currentValue - investedAmount;
//         final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//         _holdings[index].quantity = quantity;
//         _holdings[index].averagePrice = averagePrice;
//         _holdings[index].currentPrice = priceData['currentPrice'];
//         _holdings[index].currentValue = currentValue;
//         _holdings[index].investedAmount = investedAmount;
//         _holdings[index].profitLoss = profitLoss;
//         _holdings[index].dailyProfitLoss = dailyProfitLoss;

//         await _saveHoldings();
//         notifyListeners();
//       } catch (e) {
//         print('Error updating holding: $e');
//       }
//     }
//   }

//   void removeHolding(String symbol) {
//      _holdings.removeWhere((holding) => holding.symbol == symbol);
//     _saveHoldings();
//     notifyListeners();
//   }

//   double getTotalValue() {
//     return _holdings.fold(0, (sum, holding) => sum + holding.currentValue);
//   }

//   Future<void> _saveHoldings() async {
//      try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = _holdings.map((holding) => jsonEncode(holding.toJson())).toList();
//       await prefs.setStringList('holdings', holdingsJson);
//     } catch (e) {
//       print('Error saving holdings: $e');
//     }
//   }

//   Future<void> preloadCryptoPacks(List<CryptoPack> cryptoPacks) async {
//     final allCoinIds = cryptoPacks.expand((pack) => pack.coinIds).toSet().toList();
//     try {
//       final batchData = await _apiService.fetchBatchCryptoData(allCoinIds);
//       for (var pack in cryptoPacks) {
//         final packData = pack.coinIds.map((id) => batchData[id]).toList();
//         await _cryptoPackCache.setCryptoPackData(pack.id, packData);
//       }
//     } catch (e) {
//       print('Error preloading crypto packs: $e');
//     }
//   }

// }

// class AppTheme {
//   static const primaryColor = Color(0xFF2196F3);
//   static const secondaryColor = Color(0xFF4CAF50);
//   static const backgroundColor = Color(0xFFF5F5F5);
//   static const cardColor = Colors.white;
//   static const textColor = Color(0xFF333333);
//   static const lightTextColor = Color(0xFF666666);

//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: primaryColor,
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: secondaryColor,
//       ),
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: AppBarTheme(
//         color: primaryColor,
//         elevation: 0,
//       ),
//       cardTheme: CardTheme(
//         color: cardColor,
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
//         titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
//         bodyMedium: TextStyle(color: textColor, fontSize: 14),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: primaryColor,
//         textTheme: ButtonTextTheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }

// class CryptoPackScreen extends StatefulWidget {
//   @override
//   _CryptoPackScreenState createState() => _CryptoPackScreenState();
// }

// class _CryptoPackScreenState extends State<CryptoPackScreen> {////////////////////////////////////////////////////////////////////////////////////////
//   final CryptoApiService _apiService = CryptoApiService();
//   int _currentPage = 0;
//   static const int _packsPerPage = 6;

//   @override
//   void initState() {
//     super.initState();
//     _calculatePercentageChange();
//     _preloadCryptoPacks();
//   }

//    void _preloadCryptoPacks() {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);
//     holdingsProvider.preloadCryptoPacks(_cryptoPacks);
//   }

//   void _calculatePercentageChange() async {
//     for (var pack in _cryptoPacks) {
//       try {
//         double percentageChange = await _fetchPercentageChange(pack.coinIds);
//         setState(() {
//           pack.percentageChange = percentageChange;
//         });
//       } catch (e) {
//         print('Error calculating percentage change for ${pack.name}: $e');
//         setState(() {
//           pack.percentageChange = pack.percentageChange;
//         });
//       }
//     }
//   }

//   Future<double> _fetchPercentageChange(List<String> coinIds) async {
//     try {
//       final ids = coinIds.join(',');
//       final response = await _apiService.fetchCryptoData(ids);
//       if (response.isNotEmpty) {
//         final totalChange = response.fold(0.0, (sum, coinData) {
//           return sum + (coinData['price_change_percentage_24h'] ?? 0.0);
//         });
//         return totalChange / response.length;
//       }
//       return 0.0;
//     } catch (e) {
//       print('Error fetching percentage change: $e');
//       return 0.0;
//     }
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CryptoPack', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         elevation: 0,
//       ),
//       drawer: _buildDrawer(context),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('ALL CRYPTOPACKS', style: TextStyle(fontSize: 12)),//12/////////////////////////////////////////////////////////////////////////////////////////////////////
//                       style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryColor,
//                     foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Coming soon!')),
//                         );
//                       },
//                       child: Text('MY CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.secondaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(16.0),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final packIndex = _currentPage * _packsPerPage + index;
//                   if (packIndex >= _cryptoPacks.length) {
//                     return SizedBox.shrink();
//                   }
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CryptoPackDetailScreen(pack: _cryptoPacks[packIndex]),
//                         ),
//                       );
//                     },
//                     child: CryptoPackCard(pack: _cryptoPacks[packIndex]),
//                   );
//                 },
//                 childCount: _packsPerPage,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//  Widget _buildDrawer(BuildContext context) {
//   final user = supabase.auth.currentUser;
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         UserAccountsDrawerHeader(
//           accountName: Text(user?.userMetadata?['first_name'] ?? 'User'),
//           accountEmail: Text(user?.email ?? ''),
//           currentAccountPicture: CircleAvatar(
//             backgroundImage: NetworkImage(
//               'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//             ),
//           ),
//           decoration: BoxDecoration(
//             color: AppTheme.primaryColor,
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.home),
//           title: Text('Home', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//   leading: Icon(Icons.account_circle),
//   title: Text('Profile', style: TextStyle(fontSize: 18)),
//   onTap: () {
//     Navigator.pop(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfilePage()),
//     );
//   },
// ),
//         ListTile(
//           leading: Icon(Icons.account_balance_wallet),
//           title: Text('My Portfolio', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HoldingsScreen()),
//             );
//           },
//         ),
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('FAQ', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FAQScreen()),
//               );
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.support),
//             title: Text('Help & Support', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               launch('mailto:cryptoforyouhelp@gmail.com');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CryptoPackCard extends StatelessWidget {
//   final CryptoPack pack;

//   const CryptoPackCard({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.secondaryColor.withOpacity(0.1)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(9.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       pack.name,
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(pack.icon, color: AppTheme.primaryColor),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 pack.description,
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Spacer(),
//               Text(
//                 'Min Investment:',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//               ),
//               Text(
//                 '\$${pack.minInvestment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Change:',
//                     style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                   ),
//                   Text(
//                     '${pack.percentageChange.toStringAsFixed(2)}%',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: pack.percentageChange >= 0 ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Trend: ${pack.trend}',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CryptoPackDetailScreen(pack: pack),
//                       ),
//                     );
//                   },
//                   child: Text('Know More', style: TextStyle(fontSize: 12)),
//                   style: ElevatedButton.styleFrom(
//                backgroundColor    : AppTheme.primaryColor,
//                foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CryptoPackDetailScreen extends StatelessWidget {
//   final CryptoPack pack;
//   const CryptoPackDetailScreen({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(pack.name, style: TextStyle(color: Colors.white)),
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(pack.icon, size: 80, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoCard('About', pack.about),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Minimum Investment', '\$${pack.minInvestment.toStringAsFixed(2)}'),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Trend', pack.trend),
//                   SizedBox(height: 16),
//                   _buildInfoCard('24h Change', '${pack.percentageChange.toStringAsFixed(2)}%'),
//                   SizedBox(height: 24),
//                   Text(
//                     'Coin Distribution',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: FutureBuilder<List<dynamic>>(
//               future: _fetchCryptoData(context),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No data available', style: TextStyle(fontSize: 18)));
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         padding: EdgeInsets.all(16.0),
//                         child: PieChart(
//                           PieChartData(
//                             sections: getPieChartSections(snapshot.data!),
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                             borderData: FlBorderData(show: false),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) => _buildCoinListTile(snapshot.data![index]),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {

//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Investment functionality coming soon!')),
//             );
//           },
//           child: Text('Invest Now', style: TextStyle(fontSize: 18)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppTheme.primaryColor,
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(value, style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCoinListTile(dynamic coin) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: coin['image'],
//           width: 40,
//           height: 40,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         title: Text(coin['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text('${coin['current_price'].toStringAsFixed(2)} USD'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
//               style: TextStyle(
//                 color: coin['price_change_percentage_24h'] >= 0 ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text('24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
//   static const Map<String, Map<String, double>> _packPercentages = {
//      'trendsetters': {
//       'bitcoin': 0.4,
//       'ethereum': 0.3,
//       'cardano': 0.3,
//     },
//     'metaverse': {
//       'decentraland': 0.25,
//       'the-sandbox': 0.25,
//       'axie-infinity': 0.25,
//       'enjincoin': 0.25,
//     },
//     'starter': {
//       'bitcoin': 0.6,
//       'ethereum': 0.4,
//     },
//     'ultimate_alts': {
//       'cardano': 0.3,
//       'solana': 0.3,
//       'polkadot': 0.2,
//       'avalanche-2': 0.2,
//     },
//     'high_risk_high_reward': {
//       'shiba-inu': 0.5,
//       'dogecoin': 0.5,
//     },
//     'balanced': {
//       'bitcoin': 0.3,
//       'ethereum': 0.3,
//       'tether': 0.2,
//       'cardano': 0.1,
//       'solana': 0.1,
//     },
//   };

//   Future<List<dynamic>> _fetchCryptoData(BuildContext context) async {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);

//     final cachedData = holdingsProvider._cryptoPackCache.getCryptoPackData(pack.id);
//     if (cachedData != null) {
//       return cachedData;
//     }

//     final cryptoApiService = CryptoApiService();
//     final coinIds = _packPercentages[pack.id]?.keys.join(',') ?? '';
//     final data = await cryptoApiService.fetchCryptoData(coinIds);
//     await holdingsProvider._cryptoPackCache.setCryptoPackData(pack.id, data);
//     return data;
//   }

//   List<PieChartSectionData> getPieChartSections(List<dynamic> cryptoData) {
//     List<PieChartSectionData> sections = [];
//     final packPercentages = _packPercentages[pack.id] ?? {};
//     final colors = [
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.purple,
//       Colors.orange,
//     ];

//     int colorIndex = 0;
//     for (var coin in cryptoData) {
//       final percentage = packPercentages[coin['id']] ?? 0;
//       sections.add(
//         PieChartSectionData(
//           value: percentage,
//           title: '${coin['symbol'].toUpperCase()}\n${(percentage * 100).toStringAsFixed(0)}%',
//           color: colors[colorIndex % colors.length],
//           radius: 40,
//           titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//       colorIndex++;
//     }

//     return sections;
//   }
// }

// class FAQScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FAQ'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           ExpansionTile(
//             title: Text('What is CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'CryptoPack is a selection of curated cryptocurrency portfolios designed to suit various investment strategies.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How do I invest in a CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'You can invest in a CryptoPack by selecting your desired pack and making a minimum investment as specified.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Is there a risk in investing in cryptocurrencies?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, investing in cryptocurrencies carries risks due to their volatile nature. It is advisable to do thorough research and invest wisely.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How is the percentage change calculated?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'The percentage change is calculated based on the change in the value of the cryptocurrencies in the pack over the past 24 hours.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Can I track my investments?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, you can track your investments through the "My CryptoPacks" section, which will be available soon.',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HoldingsScreen extends StatefulWidget {
//   @override
//   _HoldingsScreenState createState() => _HoldingsScreenState();
// }

// class _HoldingsScreenState extends State<HoldingsScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _averagePriceController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _quantityController.dispose();
//     _averagePriceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: _buildHoldingsTheme(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My Portfolio'),
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             _buildSearchBar(),
//             _buildPortfolioOverview(),
//             Expanded(
//               child: Consumer<HoldingsProvider>(
//                 builder: (context, provider, child) {
//                   return Column(
//                     children: [
//                       if (provider.isSearching)
//                         _buildSearchResults(provider)
//                       else
//                         _buildHoldingsList(provider),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ThemeData _buildHoldingsTheme() {
//     return ThemeData(
//       primaryColor: const Color(0xFF6200EE),
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: Color(0xFF03DAC6),
//       ),
//       scaffoldBackgroundColor: Color(0xFFF5F5F5),
//       cardTheme: CardTheme(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6200EE)),
//         titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//         bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => context.read<HoldingsProvider>().searchCrypto(value),
//         decoration: InputDecoration(
//           hintText: 'Search cryptocurrencies...',
//           prefixIcon: Icon(Icons.search),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _searchController.clear();
//               context.read<HoldingsProvider>().searchCrypto('');
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPortfolioOverview() {
//     return Consumer<HoldingsProvider>(
//       builder: (context, provider, child) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Portfolio Value',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '${provider.getTotalValue().toStringAsFixed(2)} USD',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchResults(HoldingsProvider provider) {
//     return Expanded(
//       child: provider.isLoadingSearch
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: provider.searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = provider.searchResults[index];
//                 return ListTile(
//                   leading: CachedNetworkImage(
//                     imageUrl: result['large'] ?? '',
//                     width: 40,
//                     height: 40,
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                   title: Text(result['name']),
//                   subtitle: Text(result['symbol']),
//                   onTap: () => _showAddHoldingDialog(context, result, provider),
//                 );
//               },
//             ),
//     );
//   }

// Widget _buildHoldingsList(HoldingsProvider provider) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: provider.holdings.length,
//         itemBuilder: (context, index) {
//           final holding = provider.holdings[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     holding.name,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   Text(
//                     holding.symbol.toUpperCase(),
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Quantity: ${holding.quantity.toStringAsFixed(4)}'),
//                       Text('Avg. Price: ${holding.averagePrice.toStringAsFixed(2)} USD'),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Current Value: ${holding.currentValue.toStringAsFixed(2)} USD'),
//                       Text(
//                         'P/L: ${holding.profitLoss.toStringAsFixed(2)} USD',
//                         style: TextStyle(
//                           color: holding.profitLoss >= 0 ? Colors.green : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: false,
//                           holding: holding,
//                         ),
//                         child: Text('Add'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: true,
//                           holding: holding,
//                         ),
//                         child: Text('Edit'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showRemoveHoldingDialog(context, holding, provider),
//                         child: Text('Remove'),
//                         style: TextButton.styleFrom(foregroundColor: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//  void _showAddHoldingDialog(BuildContext context, Map<String, dynamic>? result, HoldingsProvider provider, {bool isEdit = false, CryptoHolding? holding}) {
//   if (isEdit) {
//     _quantityController.text = '';
//     _averagePriceController.text = holding!.averagePrice.toString();
//   } else {
//     _quantityController.clear();
//     _averagePriceController.clear();
//   }

//   String operation = 'Add';

//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Text(isEdit ? 'Edit Holding' : 'Add Holding'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isEdit)
//                   DropdownButton<String>(
//                     value: operation,
//                     items: ['Add', 'Subtract'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         operation = newValue!;
//                       });
//                     },
//                   ),
//                 TextField(
//                   controller: _quantityController,
//                   decoration: InputDecoration(
//                     labelText: 'Quantity',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _averagePriceController,
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   final newQuantity = double.tryParse(_quantityController.text) ?? 0;
//                   final newPrice = double.tryParse(_averagePriceController.text) ?? 0;

//                   if (isEdit) {
//                     final operationMultiplier = operation == 'Add' ? 1 : -1;
//                     final totalValue = (holding!.quantity * holding.averagePrice) + (newQuantity * newPrice * operationMultiplier);
//                     final totalQuantity = holding.quantity + (newQuantity * operationMultiplier);

//                     if (totalQuantity <= 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Cannot subtract more than available quantity')),
//                       );
//                       return;
//                     }

//                     final newAveragePrice = totalValue / totalQuantity;

//                     provider.updateHolding(
//                       holding.symbol,
//                       totalQuantity,
//                       newAveragePrice,
//                     );
//                   } else {
//                     provider.addHolding(
//                       result!['id'],
//                       result['name'],
//                       newQuantity,
//                       newPrice,
//                     );
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text(isEdit ? 'Update' : 'Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
//  void _showRemoveHoldingDialog(BuildContext context, CryptoHolding holding, HoldingsProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Holding'),
//         content: Text('Are you sure you want to remove ${holding.name} from your portfolio?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//             style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               provider.removeHolding(holding.symbol);
//               Navigator.pop(context);
//             },
//             child: Text('Remove'),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CryptoPackScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 15, 14, 14),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'android/logo (1).jpg',
//               width: MediaQuery.of(context).size.width * 0.4,
//               height: MediaQuery.of(context).size.width * 0.4,
//             ),
//             SizedBox(height: 24),
//             Text(
//               'CryptoForYou',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 238, 242, 244),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// void main() async {
//  // WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://pajnoqsxkpaujmdskmjy.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBham5vcXN4a3BhdWptZHNrbWp5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDE3Mjk0NywiZXhwIjoyMDM1NzQ4OTQ3fQ.uZY4kBkg-yu8z29Xt8DLqtvkalD-FmMQyMjMzr8WTmM',
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) {
//         final provider = HoldingsProvider()..fetchHoldings();
//         provider.preloadCryptoPacks(_cryptoPacks);
//         return provider;
//       },

//       child: MyApp(),
//     ),
//   );
// }
//  final supabase = Supabase.instance.client;//////////////////////////////////////////////////////////////////////////////
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CryptoPack',
//       theme: AppTheme.lightTheme,
//       home: SignInPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// import 'profile.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:dio/dio.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'login.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final List<CryptoPack> _cryptoPacks = [
//        CryptoPack(
//     name: 'RAW Frontrunners',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['ix-swap', 'realio-network', 'clearpool', 'polytrade', 'maple'],
//     about: 'RAW Frontrunners pack focuses on cryptocurrencies that are leading the way in terms of innovation and market influence.',
//     id: 'RAW Frontrunners',
//   ),
//   CryptoPack(
//     name: 'CeDefi-Defi & Privacy',
//     description: 'Leading DeFi and privacy tokens',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Very High',
//     icon: Icons.security,
//     coinIds: ['fideum', 'oasis-network'],
//     about: 'CeDefi-Defi & Privacy pack includes top-performing tokens in the DeFi and privacy space.',
//     id: 'CeDefi-Defi & Privacy',
//   ),
//   CryptoPack(
//     name: 'High Caps',
//     description: 'The market-leading cryptocurrencies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.star,
//     coinIds: ['bitcoin', 'ethereum', 'chainlink'],
//     about: 'high caps pack contains the most prominent cryptocurrencies, suitable for beginners and experienced investors.',
//     id: 'high caps',
//   ),
//   CryptoPack(
//     name: 'Ultimate Alts of Tomorrow',
//     description: 'The undisputed Alt Coin selection',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.monetization_on,
//     coinIds: ['cardano', 'solana', 'polkadot', 'avalanche-2'],
//     about: 'Ultimate Alts pack features a selection of promising altcoins with potential for future growth.',
//     id: 'ultimate_alts',
//   ),
//    CryptoPack(
//     name: 'HighRiskHighReward',
//     description: 'High-risk investments with potential for high rewards',
//     RecommendedInvestment: 250.00,
//     percentageChange: 0.0,
//     trend: 'High',
//     icon: Icons.warning,
//     coinIds: ['maga', ],
//     about: 'HighRiskHighReward pack includes volatile cryptocurrencies with the potential for significant returns.',
//     id: 'high_risk_high_reward',
//   ),
//   CryptoPack(
//     name: 'Artificial Intelligence',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 500.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['near'],
//     about: 'Artificial Intelligence pack focuses on cryptocurrencies that are leading the way in terms of innovation in artificial intelligence and market influence.',
//     id: 'Artificial Intelligence',
//   )
//   ];
// class ApiError extends Error {
//   final String message;
//   final int? statusCode;

//   ApiError({required this.message, this.statusCode});
// }

// class CryptoPack {
//   final String name;
//   final String description;
//   final double RecommendedInvestment;
//   double percentageChange;
//   final String trend;
//   final IconData icon;
//   final String id;
//   final String about;
//   final List<String> coinIds;

//   CryptoPack({
//     required this.name,
//     required this.description,
//     required this.RecommendedInvestment,
//     required this.percentageChange,
//     required this.trend,
//     required this.icon,
//     required this.id,
//     required this.about,
//     required this.coinIds,
//   });
// }

// class CryptoHolding {
//   final String symbol;
//   final String name;
//   double quantity;
//   double averagePrice;
//   double currentPrice;
//   double currentValue;
//   double investedAmount;
//   double profitLoss;
//   double dailyProfitLoss;

//   CryptoHolding({
//     required this.symbol,
//     required this.name,
//     required this.quantity,
//     required this.averagePrice,
//     required this.currentPrice,
//     required this.currentValue,
//     required this.investedAmount,
//     required this.profitLoss,
//     required this.dailyProfitLoss,
//   });

//   factory CryptoHolding.fromJson(Map<String, dynamic> json) {
//     return CryptoHolding(
//       symbol: json['symbol'],
//       name: json['name'],
//       quantity: json['quantity'],
//       averagePrice: json['averagePrice'],
//       currentPrice: json['currentPrice'],
//       currentValue: json['currentValue'],
//       investedAmount: json['investedAmount'],
//       profitLoss: json['profitLoss'],
//       dailyProfitLoss: json['dailyProfitLoss'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'symbol': symbol,
//       'name': name,
//       'quantity': quantity,
//       'averagePrice': averagePrice,
//       'currentPrice': currentPrice,
//       'currentValue': currentValue,
//       'investedAmount': investedAmount,
//       'profitLoss': profitLoss,
//       'dailyProfitLoss': dailyProfitLoss,
//     };
//   }
// }

// class CachedData<T> {
//   final T data;
//   final DateTime timestamp;

//   CachedData({required this.data, required this.timestamp});
// }

// class CryptoPackCache {
//   final Map<String, CachedData<List<dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 15);

//   Future<void> setCryptoPackData(String packId, List<dynamic> data) async {
//     _cache[packId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   List<dynamic>? getCryptoPackData(String packId) {
//     if (_cache.containsKey(packId) && !_isCacheExpired(packId)) {
//       return _cache[packId]!.data;
//     }
//     return null;
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class CryptoApiService {
//   final Dio _dio = Dio();
//   final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 5);

// CryptoApiService() {
//   _dio.interceptors.add(InterceptorsWrapper(
//     onError: (DioError e, ErrorInterceptorHandler handler) {
//       ApiError error;
//       if (e.response != null) {
//         error = ApiError(
//           message: e.response!.data['message'] ?? 'Unknown error',
//           statusCode: e.response!.statusCode
//         );
//       } else {
//         error = ApiError(message: e.message ?? 'Unknown error');
//       }
//       throw error;
//     },
//   ));
// }
//   Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
//     if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
//       return _cache[symbol]!.data;
//     }

//     try {
//       final response = await _dio.get(
//           'https://api.coingecko.com/api/v3/simple/price?ids=$symbol&vs_currencies=usd&include_24hr_change=true');
//       final data = {
//         'currentPrice': response.data[symbol]['usd'],
//         'priceChange24h': response.data[symbol]['usd_24h_change'],
//       };
//       _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
//       return data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to load price data');
//     }
//   }

//   Future<Map<String, dynamic>> searchCrypto(String query) async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/search?query=$query');
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to search crypto');
//     }
//   }

//   Future<List<dynamic>> fetchCryptoData(String coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds,
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchBatchCryptoData(List<String> coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds.join(','),
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return Map.fromIterable(response.data, key: (item) => item['id'], value: (item) => item);
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch batch data');
//     }
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class HoldingsProvider with ChangeNotifier {
//   final CryptoApiService _apiService = CryptoApiService();
//   final CryptoPackCache _cryptoPackCache = CryptoPackCache();
//   List<CryptoHolding> _holdings = [];
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _isSearching = false;
//   bool _isLoadingSearch = false;

//   List<CryptoHolding> get holdings => _holdings;
//   List<Map<String, dynamic>> get searchResults => _searchResults;
//   bool get isSearching => _isSearching;
//   bool get isLoadingSearch => _isLoadingSearch;

//   Future<void> fetchHoldings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = prefs.getStringList('holdings') ?? [];
//       _holdings = holdingsJson
//           .map((json) => CryptoHolding.fromJson(jsonDecode(json)))
//           .toList();
//       await _updateHoldingsData();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching holdings: $e');
//     }
//   }

//   Future<void> _updateHoldingsData() async {
//     final futures = _holdings.map((holding) => _apiService.getCurrentPriceData(holding.symbol)).toList();
//     final results = await Future.wait(futures);

//     for (var i = 0; i < _holdings.length; i++) {
//       try {
//         final priceData = results[i];
//         _holdings[i].currentPrice = priceData['currentPrice'].toDouble();
//         _holdings[i].currentValue = _holdings[i].quantity * _holdings[i].currentPrice;
//         _holdings[i].profitLoss = _holdings[i].currentValue - _holdings[i].investedAmount;
//         _holdings[i].dailyProfitLoss = _holdings[i].currentValue * (priceData['priceChange24h'] / 100);
//       } catch (e) {
//         print('Error updating holding data for ${_holdings[i].symbol}: $e');
//       }
//     }
//   }

//   Future<void> searchCrypto(String searchTerm) async {
//     _isSearching = searchTerm.isNotEmpty;
//     if (_isSearching) {
//       _isLoadingSearch = true;
//       notifyListeners();
//       try {
//         final results = await _apiService.searchCrypto(searchTerm);
//         _searchResults = List<Map<String, dynamic>>.from(results['coins']);
//       } catch (e) {
//         print('Error searching crypto: $e');
//         _searchResults = [];
//       }
//       _isLoadingSearch = false;
//     } else {
//       _searchResults = [];
//     }
//     notifyListeners();
//   }

//   Future<void> addHolding(String symbol, String name, double quantity, double averagePrice) async {
//       try {
//       final priceData = await _apiService.getCurrentPriceData(symbol);
//       final currentPrice = priceData['currentPrice'].toDouble();
//       final currentValue = quantity * currentPrice;
//       final investedAmount = quantity * averagePrice;
//       final profitLoss = currentValue - investedAmount;
//       final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//       final existingHoldingIndex = _holdings.indexWhere((holding) => holding.symbol == symbol);

//       if (existingHoldingIndex != -1) {
//         final existingHolding = _holdings[existingHoldingIndex];
//         final newQuantity = existingHolding.quantity + quantity;
//         final newInvestedAmount = existingHolding.investedAmount + investedAmount;
//         final newAveragePrice = newInvestedAmount / newQuantity;

//         _holdings[existingHoldingIndex].quantity = newQuantity;
//         _holdings[existingHoldingIndex].averagePrice = newAveragePrice;
//         _holdings[existingHoldingIndex].investedAmount = newInvestedAmount;
//         _holdings[existingHoldingIndex].currentPrice = currentPrice;
//         _holdings[existingHoldingIndex].currentValue = newQuantity * currentPrice;
//         _holdings[existingHoldingIndex].profitLoss = _holdings[existingHoldingIndex].currentValue - _holdings[existingHoldingIndex].investedAmount;
//         _holdings[existingHoldingIndex].dailyProfitLoss = _holdings[existingHoldingIndex].currentValue * (priceData['priceChange24h'] / 100);
//       } else {
//         final newHolding = CryptoHolding(
//           symbol: symbol,
//           name: name,
//           quantity: quantity,
//           averagePrice: averagePrice,
//           currentPrice: currentPrice,
//           currentValue: currentValue,
//           investedAmount: investedAmount,
//           profitLoss: profitLoss,
//           dailyProfitLoss: dailyProfitLoss,
//         );

//         _holdings.add(newHolding);
//       }

//       await _saveHoldings();
//       notifyListeners();
//     } catch (e) {
//       print('Error adding holding: $e');
//     }
//   }

//   Future<void> updateHolding(String symbol, double quantity, double averagePrice) async {
//      final index = _holdings.indexWhere((holding) => holding.symbol == symbol);
//     if (index != -1) {
//       try {
//         final priceData = await _apiService.getCurrentPriceData(symbol);
//         final currentValue = quantity * priceData['currentPrice'];
//         final investedAmount = quantity * averagePrice;
//         final profitLoss = currentValue - investedAmount;
//         final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//         _holdings[index].quantity = quantity;
//         _holdings[index].averagePrice = averagePrice;
//         _holdings[index].currentPrice = priceData['currentPrice'];
//         _holdings[index].currentValue = currentValue;
//         _holdings[index].investedAmount = investedAmount;
//         _holdings[index].profitLoss = profitLoss;
//         _holdings[index].dailyProfitLoss = dailyProfitLoss;

//         await _saveHoldings();
//         notifyListeners();
//       } catch (e) {
//         print('Error updating holding: $e');
//       }
//     }
//   }

//   void removeHolding(String symbol) {
//      _holdings.removeWhere((holding) => holding.symbol == symbol);
//     _saveHoldings();
//     notifyListeners();
//   }

//   double getTotalValue() {
//     return _holdings.fold(0, (sum, holding) => sum + holding.currentValue);
//   }

//   Future<void> _saveHoldings() async {
//      try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = _holdings.map((holding) => jsonEncode(holding.toJson())).toList();
//       await prefs.setStringList('holdings', holdingsJson);
//     } catch (e) {
//       print('Error saving holdings: $e');
//     }
//   }

//   Future<void> preloadCryptoPacks(List<CryptoPack> cryptoPacks) async {
//     final allCoinIds = cryptoPacks.expand((pack) => pack.coinIds).toSet().toList();
//     try {
//       final batchData = await _apiService.fetchBatchCryptoData(allCoinIds);
//       for (var pack in cryptoPacks) {
//         final packData = pack.coinIds.map((id) => batchData[id]).toList();
//         await _cryptoPackCache.setCryptoPackData(pack.id, packData);
//       }
//     } catch (e) {
//       print('Error preloading crypto packs: $e');
//     }
//   }

// }

// class AppTheme {
//   static const primaryColor = Color(0xFF2196F3);
//   static const secondaryColor = Color(0xFF4CAF50);
//   static const backgroundColor = Color(0xFFF5F5F5);
//   static const cardColor = Colors.white;
//   static const textColor = Color(0xFF333333);
//   static const lightTextColor = Color(0xFF666666);

//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: primaryColor,
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: secondaryColor,
//       ),
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: AppBarTheme(
//         color: primaryColor,
//         elevation: 0,
//       ),
//       cardTheme: CardTheme(
//         color: cardColor,
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
//         titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
//         bodyMedium: TextStyle(color: textColor, fontSize: 14),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: primaryColor,
//         textTheme: ButtonTextTheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }

// class CryptoPackScreen extends StatefulWidget {
//   @override
//   _CryptoPackScreenState createState() => _CryptoPackScreenState();
// }

// class _CryptoPackScreenState extends State<CryptoPackScreen> {////////////////////////////////////////////////////////////////////////////////////////
//   final CryptoApiService _apiService = CryptoApiService();
//   int _currentPage = 0;
//   static const int _packsPerPage = 6;

//   @override
//   void initState() {
//     super.initState();
//     _calculatePercentageChange();
//     _preloadCryptoPacks();
//   }

//    void _preloadCryptoPacks() {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);
//     holdingsProvider.preloadCryptoPacks(_cryptoPacks);
//   }

//   void _calculatePercentageChange() async {
//     for (var pack in _cryptoPacks) {
//       try {
//         double percentageChange = await _fetchPercentageChange(pack.coinIds);
//         setState(() {
//           pack.percentageChange = percentageChange;
//         });
//       } catch (e) {
//         print('Error calculating percentage change for ${pack.name}: $e');
//         setState(() {
//           pack.percentageChange = pack.percentageChange;
//         });
//       }
//     }
//   }

//   Future<double> _fetchPercentageChange(List<String> coinIds) async {
//     try {
//       final ids = coinIds.join(',');
//       final response = await _apiService.fetchCryptoData(ids);
//       if (response.isNotEmpty) {
//         final totalChange = response.fold(0.0, (sum, coinData) {
//           return sum + (coinData['price_change_percentage_24h'] ?? 0.0);
//         });
//         return totalChange / response.length;
//       }
//       return 0.0;
//     } catch (e) {
//       print('Error fetching percentage change: $e');
//       return 0.0;
//     }
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CryptoPack', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         elevation: 0,
//       ),
//       drawer: _buildDrawer(context),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('ALL CRYPTOPACKS', style: TextStyle(fontSize: 12)),//12/////////////////////////////////////////////////////////////////////////////////////////////////////
//                       style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryColor,
//                     foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Coming soon!')),
//                         );
//                       },
//                       child: Text('MY CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.secondaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(16.0),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final packIndex = _currentPage * _packsPerPage + index;
//                   if (packIndex >= _cryptoPacks.length) {
//                     return SizedBox.shrink();
//                   }
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CryptoPackDetailScreen(pack: _cryptoPacks[packIndex]),
//                         ),
//                       );
//                     },
//                     child: CryptoPackCard(pack: _cryptoPacks[packIndex]),
//                   );
//                 },
//                 childCount: _packsPerPage,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//  Widget _buildDrawer(BuildContext context) {
//   final user = supabase.auth.currentUser;
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         UserAccountsDrawerHeader(
//           accountName: Text(user?.userMetadata?['first_name'] ?? 'User'),
//           accountEmail: Text(user?.email ?? ''),
//           currentAccountPicture: CircleAvatar(
//             backgroundImage: NetworkImage(
//               'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//             ),
//           ),
//           decoration: BoxDecoration(
//             color: AppTheme.primaryColor,
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.home),
//           title: Text('Home', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//   leading: Icon(Icons.account_circle),
//   title: Text('Profile', style: TextStyle(fontSize: 18)),
//   onTap: () {
//     Navigator.pop(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfilePage()),
//     );
//   },
// ),
//         ListTile(
//           leading: Icon(Icons.account_balance_wallet),
//           title: Text('My Portfolio', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HoldingsScreen()),
//             );
//           },
//         ),
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('FAQ', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FAQScreen()),
//               );
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.support),
//             title: Text('Help & Support', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               launch('mailto:cryptoforyouhelp@gmail.com');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CryptoPackCard extends StatelessWidget {
//   final CryptoPack pack;

//   const CryptoPackCard({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.secondaryColor.withOpacity(0.1)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(9.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       pack.name,
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(pack.icon, color: AppTheme.primaryColor),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 pack.description,
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Spacer(),
//               Text(
//                 'Rec.investement:',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//               ),
//               Text(
//                 '\$${pack.RecommendedInvestment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Change:',
//                     style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                   ),
//                   Text(
//                     '${pack.percentageChange.toStringAsFixed(2)}%',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: pack.percentageChange >= 0 ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Trend: ${pack.trend}',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CryptoPackDetailScreen(pack: pack),
//                       ),
//                     );
//                   },
//                   child: Text('Know More', style: TextStyle(fontSize: 12)),
//                   style: ElevatedButton.styleFrom(
//                backgroundColor    : AppTheme.primaryColor,
//                foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CryptoPackDetailScreen extends StatelessWidget {
//   final CryptoPack pack;
//   const CryptoPackDetailScreen({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(pack.name, style: TextStyle(color: Colors.white)),
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(pack.icon, size: 80, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoCard('About', pack.about),
//                   SizedBox(height: 16),
//                   _buildInfoCard('RecommendedInvestment', '\$${pack.RecommendedInvestment.toStringAsFixed(2)}'),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Trend', pack.trend),
//                   SizedBox(height: 16),
//                   _buildInfoCard('24h Change', '${pack.percentageChange.toStringAsFixed(2)}%'),
//                   SizedBox(height: 24),
//                   Text(
//                     'Coin Distribution',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: FutureBuilder<List<dynamic>>(
//               future: _fetchCryptoData(context),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No data available', style: TextStyle(fontSize: 18)));
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         padding: EdgeInsets.all(16.0),
//                         child: PieChart(
//                           PieChartData(
//                             sections: getPieChartSections(snapshot.data!),
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                             borderData: FlBorderData(show: false),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) => _buildCoinListTile(snapshot.data![index]),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {

//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Investment functionality coming soon!')),
//             );
//           },
//           child: Text('Invest Now', style: TextStyle(fontSize: 18)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppTheme.primaryColor,
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(value, style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCoinListTile(dynamic coin) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: coin['image'],
//           width: 40,
//           height: 40,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         title: Text(coin['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text('${coin['current_price'].toStringAsFixed(2)} USD'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
//               style: TextStyle(
//                 color: coin['price_change_percentage_24h'] >= 0 ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text('24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
//   static const Map<String, Map<String, double>> _packPercentages = {
//     'RAW Frontrunners': {
//     'ix-swap': 0.2,
//     'realio-network': 0.2,
//     'clearpool': 0.2,
//     'polytrade': 0.2,
//     'maple': 0.2,
//   },
//   'CeDefi-Defi & Privacy': {
//     'fideum': 0.5,
//     'oasis-network': 0.5,
//   },
//   'High Caps': {
//     'bitcoin': 0.4,
//     'ethereum': 0.4,
//     'chainlink': 0.2,
//   },
//   'ultimate_alts': {
//     'cardano': 0.3,
//     'solana': 0.3,
//     'polkadot': 0.2,
//     'avalanche-2': 0.2,
//   },
//  'high_risk_high_reward': {
//       'maga': 1,

//     },
//   'Artificial Intelligence': {
//       'near': 1,
//     },
//   };

//   Future<List<dynamic>> _fetchCryptoData(BuildContext context) async {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);

//     final cachedData = holdingsProvider._cryptoPackCache.getCryptoPackData(pack.id);
//     if (cachedData != null) {
//       return cachedData;
//     }

//     final cryptoApiService = CryptoApiService();
//     final coinIds = _packPercentages[pack.id]?.keys.join(',') ?? '';
//     final data = await cryptoApiService.fetchCryptoData(coinIds);
//     await holdingsProvider._cryptoPackCache.setCryptoPackData(pack.id, data);
//     return data;
//   }

//   List<PieChartSectionData> getPieChartSections(List<dynamic> cryptoData) {
//     List<PieChartSectionData> sections = [];
//     final packPercentages = _packPercentages[pack.id] ?? {};
//     final colors = [
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.purple,
//       Colors.orange,
//     ];

//     int colorIndex = 0;
//     for (var coin in cryptoData) {
//       final percentage = packPercentages[coin['id']] ?? 0;
//       sections.add(
//         PieChartSectionData(
//           value: percentage,
//           title: '${coin['symbol'].toUpperCase()}\n${(percentage * 100).toStringAsFixed(0)}%',
//           color: colors[colorIndex % colors.length],
//           radius: 40,
//           titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//       colorIndex++;
//     }

//     return sections;
//   }
// }

// class FAQScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FAQ'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           ExpansionTile(
//             title: Text('What is CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'CryptoPack is a selection of curated cryptocurrency portfolios designed to suit various investment strategies.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How do I invest in a CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'You can invest in a CryptoPack by selecting your desired pack and making a minimum investment as specified.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Is there a risk in investing in cryptocurrencies?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, investing in cryptocurrencies carries risks due to their volatile nature. It is advisable to do thorough research and invest wisely.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How is the percentage change calculated?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'The percentage change is calculated based on the change in the value of the cryptocurrencies in the pack over the past 24 hours.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Can I track my investments?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, you can track your investments through the "My CryptoPacks" section, which will be available soon.',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HoldingsScreen extends StatefulWidget {
//   @override
//   _HoldingsScreenState createState() => _HoldingsScreenState();
// }

// class _HoldingsScreenState extends State<HoldingsScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _averagePriceController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _quantityController.dispose();
//     _averagePriceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: _buildHoldingsTheme(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My Portfolio'),
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             _buildSearchBar(),
//             _buildPortfolioOverview(),
//             Expanded(
//               child: Consumer<HoldingsProvider>(
//                 builder: (context, provider, child) {
//                   return Column(
//                     children: [
//                       if (provider.isSearching)
//                         _buildSearchResults(provider)
//                       else
//                         _buildHoldingsList(provider),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ThemeData _buildHoldingsTheme() {
//     return ThemeData(
//       primaryColor: const Color(0xFF6200EE),
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: Color(0xFF03DAC6),
//       ),
//       scaffoldBackgroundColor: Color(0xFFF5F5F5),
//       cardTheme: CardTheme(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6200EE)),
//         titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//         bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => context.read<HoldingsProvider>().searchCrypto(value),
//         decoration: InputDecoration(
//           hintText: 'Search cryptocurrencies...',
//           prefixIcon: Icon(Icons.search),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _searchController.clear();
//               context.read<HoldingsProvider>().searchCrypto('');
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPortfolioOverview() {
//     return Consumer<HoldingsProvider>(
//       builder: (context, provider, child) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Portfolio Value',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '${provider.getTotalValue().toStringAsFixed(2)} USD',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchResults(HoldingsProvider provider) {
//     return Expanded(
//       child: provider.isLoadingSearch
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: provider.searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = provider.searchResults[index];
//                 return ListTile(
//                   leading: CachedNetworkImage(
//                     imageUrl: result['large'] ?? '',
//                     width: 40,
//                     height: 40,
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                   title: Text(result['name']),
//                   subtitle: Text(result['symbol']),
//                   onTap: () => _showAddHoldingDialog(context, result, provider),
//                 );
//               },
//             ),
//     );
//   }

// Widget _buildHoldingsList(HoldingsProvider provider) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: provider.holdings.length,
//         itemBuilder: (context, index) {
//           final holding = provider.holdings[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     holding.name,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   Text(
//                     holding.symbol.toUpperCase(),
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Quantity: ${holding.quantity.toStringAsFixed(4)}'),
//                       Text('Avg. Price: ${holding.averagePrice.toStringAsFixed(2)} USD'),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Current Value: ${holding.currentValue.toStringAsFixed(2)} USD'),
//                       Text(
//                         'P/L: ${holding.profitLoss.toStringAsFixed(2)} USD',
//                         style: TextStyle(
//                           color: holding.profitLoss >= 0 ? Colors.green : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: false,
//                           holding: holding,
//                         ),
//                         child: Text('Add'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: true,
//                           holding: holding,
//                         ),
//                         child: Text('Edit'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showRemoveHoldingDialog(context, holding, provider),
//                         child: Text('Remove'),
//                         style: TextButton.styleFrom(foregroundColor: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//  void _showAddHoldingDialog(BuildContext context, Map<String, dynamic>? result, HoldingsProvider provider, {bool isEdit = false, CryptoHolding? holding}) {
//   if (isEdit) {
//     _quantityController.text = '';
//     _averagePriceController.text = holding!.averagePrice.toString();
//   } else {
//     _quantityController.clear();
//     _averagePriceController.clear();
//   }

//   String operation = 'Add';

//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Text(isEdit ? 'Edit Holding' : 'Add Holding'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isEdit)
//                   DropdownButton<String>(
//                     value: operation,
//                     items: ['Add', 'Subtract'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         operation = newValue!;
//                       });
//                     },
//                   ),
//                 TextField(
//                   controller: _quantityController,
//                   decoration: InputDecoration(
//                     labelText: 'Quantity',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _averagePriceController,
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   final newQuantity = double.tryParse(_quantityController.text) ?? 0;
//                   final newPrice = double.tryParse(_averagePriceController.text) ?? 0;

//                   if (isEdit) {
//                     final operationMultiplier = operation == 'Add' ? 1 : -1;
//                     final totalValue = (holding!.quantity * holding.averagePrice) + (newQuantity * newPrice * operationMultiplier);
//                     final totalQuantity = holding.quantity + (newQuantity * operationMultiplier);

//                     if (totalQuantity <= 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Cannot subtract more than available quantity')),
//                       );
//                       return;
//                     }

//                     final newAveragePrice = totalValue / totalQuantity;

//                     provider.updateHolding(
//                       holding.symbol,
//                       totalQuantity,
//                       newAveragePrice,
//                     );
//                   } else {
//                     provider.addHolding(
//                       result!['id'],
//                       result['name'],
//                       newQuantity,
//                       newPrice,
//                     );
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text(isEdit ? 'Update' : 'Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
//  void _showRemoveHoldingDialog(BuildContext context, CryptoHolding holding, HoldingsProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Holding'),
//         content: Text('Are you sure you want to remove ${holding.name} from your portfolio?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//             style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               provider.removeHolding(holding.symbol);
//               Navigator.pop(context);
//             },
//             child: Text('Remove'),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CryptoPackScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 15, 14, 14),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'android/logo (1).jpg',
//               width: MediaQuery.of(context).size.width * 0.4,
//               height: MediaQuery.of(context).size.width * 0.4,
//             ),
//             SizedBox(height: 24),
//             Text(
//               'CryptoForYou',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 238, 242, 244),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// void main() async {
//  // WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://pajnoqsxkpaujmdskmjy.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBham5vcXN4a3BhdWptZHNrbWp5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDE3Mjk0NywiZXhwIjoyMDM1NzQ4OTQ3fQ.uZY4kBkg-yu8z29Xt8DLqtvkalD-FmMQyMjMzr8WTmM',
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) {
//         final provider = HoldingsProvider()..fetchHoldings();
//         provider.preloadCryptoPacks(_cryptoPacks);
//         return provider;
//       },

//       child: MyApp(),
//     ),
//   );
// }
//  final supabase = Supabase.instance.client;//////////////////////////////////////////////////////////////////////////////
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CryptoPack',
//       theme: AppTheme.lightTheme,
//       home: SignInPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// import 'profile.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:dio/dio.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'login.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final List<CryptoPack> _cryptoPacks = [
//        CryptoPack(
//     name: 'RAW Frontrunners',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['ix-swap', 'realio-network', 'clearpool', 'polytrade', 'maple'],
//     about: 'RAW Frontrunners pack focuses on cryptocurrencies that are leading the way in terms of innovation and market influence.',
//     id: 'RAW Frontrunners',
//   ),
//   CryptoPack(
//     name: 'CeDefi-Defi & Privacy',
//     description: 'Leading DeFi and privacy tokens',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Very High',
//     icon: Icons.security,
//     coinIds: ['fideum', 'oasis-network'],
//     about: 'CeDefi-Defi & Privacy pack includes top-performing tokens in the DeFi and privacy space.',
//     id: 'CeDefi-Defi & Privacy',
//   ),
//   CryptoPack(
//     name: 'High Caps',
//     description: 'The market-leading cryptocurrencies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.star,
//     coinIds: ['bitcoin', 'ethereum', 'chainlink'],
//     about: 'high caps pack contains the most prominent cryptocurrencies, suitable for beginners and experienced investors.',
//     id: 'High Caps',
//   ),
//   CryptoPack(
//     name: 'Ultimate Alts of Tomorrow',
//     description: 'The undisputed Alt Coin selection',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.monetization_on,
//     coinIds: ['cardano', 'solana', 'polkadot', 'avalanche-2'],
//     about: 'Ultimate Alts pack features a selection of promising altcoins with potential for future growth.',
//     id: 'ultimate_alts',
//   ),
//    CryptoPack(
//     name: 'HighRiskHighReward',
//     description: 'High-risk investments with potential for high rewards',
//     RecommendedInvestment: 250.00,
//     percentageChange: 0.0,
//     trend: 'High',
//     icon: Icons.warning,
//     coinIds: ['maga', ],
//     about: 'HighRiskHighReward pack includes volatile cryptocurrencies with the potential for significant returns.',
//     id: 'high_risk_high_reward',
//   ),
//   CryptoPack(
//     name: 'Artificial Intelligence',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 500.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['near'],
//     about: 'Artificial Intelligence pack focuses on cryptocurrencies that are leading the way in terms of innovation in artificial intelligence and market influence.',
//     id: 'Artificial Intelligence',
//   )
//   ];
// class ApiError extends Error {
//   final String message;
//   final int? statusCode;

//   ApiError({required this.message, this.statusCode});
// }

// class CryptoPack {
//   final String name;
//   final String description;
//   final double RecommendedInvestment;
//   double percentageChange;
//   final String trend;
//   final IconData icon;
//   final String id;
//   final String about;
//   final List<String> coinIds;

//   CryptoPack({
//     required this.name,
//     required this.description,
//     required this.RecommendedInvestment,
//     required this.percentageChange,
//     required this.trend,
//     required this.icon,
//     required this.id,
//     required this.about,
//     required this.coinIds,
//   });
// }

// class CryptoHolding {
//   final String symbol;
//   final String name;
//   double quantity;
//   double averagePrice;
//   double currentPrice;
//   double currentValue;
//   double investedAmount;
//   double profitLoss;
//   double dailyProfitLoss;

//   CryptoHolding({
//     required this.symbol,
//     required this.name,
//     required this.quantity,
//     required this.averagePrice,
//     required this.currentPrice,
//     required this.currentValue,
//     required this.investedAmount,
//     required this.profitLoss,
//     required this.dailyProfitLoss,
//   });

//   factory CryptoHolding.fromJson(Map<String, dynamic> json) {
//     return CryptoHolding(
//       symbol: json['symbol'],
//       name: json['name'],
//       quantity: json['quantity'],
//       averagePrice: json['averagePrice'],
//       currentPrice: json['currentPrice'],
//       currentValue: json['currentValue'],
//       investedAmount: json['investedAmount'],
//       profitLoss: json['profitLoss'],
//       dailyProfitLoss: json['dailyProfitLoss'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'symbol': symbol,
//       'name': name,
//       'quantity': quantity,
//       'averagePrice': averagePrice,
//       'currentPrice': currentPrice,
//       'currentValue': currentValue,
//       'investedAmount': investedAmount,
//       'profitLoss': profitLoss,
//       'dailyProfitLoss': dailyProfitLoss,
//     };
//   }
// }

// class CachedData<T> {
//   final T data;
//   final DateTime timestamp;

//   CachedData({required this.data, required this.timestamp});
// }

// class CryptoPackCache {
//   final Map<String, CachedData<List<dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 15);

//   Future<void> setCryptoPackData(String packId, List<dynamic> data) async {
//     _cache[packId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   List<dynamic>? getCryptoPackData(String packId) {
//     if (_cache.containsKey(packId) && !_isCacheExpired(packId)) {
//       return _cache[packId]!.data;
//     }
//     return null;
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class CryptoApiService {
//   final Dio _dio = Dio();
//   final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 5);

// CryptoApiService() {
//   _dio.interceptors.add(InterceptorsWrapper(
//     onError: (DioError e, ErrorInterceptorHandler handler) {
//       ApiError error;
//       if (e.response != null) {
//         error = ApiError(
//           message: e.response!.data['message'] ?? 'Unknown error',
//           statusCode: e.response!.statusCode
//         );
//       } else {
//         error = ApiError(message: e.message ?? 'Unknown error');
//       }
//       throw error;
//     },
//   ));
// }
//   Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
//     if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
//       return _cache[symbol]!.data;
//     }

//     try {
//       final response = await _dio.get(
//           'https://api.coingecko.com/api/v3/simple/price?ids=$symbol&vs_currencies=usd&include_24hr_change=true');
//       final data = {
//         'currentPrice': response.data[symbol]['usd'],
//         'priceChange24h': response.data[symbol]['usd_24h_change'],
//       };
//       _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
//       return data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to load price data');
//     }
//   }

//   Future<Map<String, dynamic>> searchCrypto(String query) async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/search?query=$query');
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to search crypto');
//     }
//   }

//   Future<List<dynamic>> fetchCryptoData(String coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds,
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchBatchCryptoData(List<String> coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds.join(','),
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return Map.fromIterable(response.data, key: (item) => item['id'], value: (item) => item);
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch batch data');
//     }
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class HoldingsProvider with ChangeNotifier {
//   final CryptoApiService _apiService = CryptoApiService();
//   final CryptoPackCache _cryptoPackCache = CryptoPackCache();
//   List<CryptoHolding> _holdings = [];
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _isSearching = false;
//   bool _isLoadingSearch = false;

//   List<CryptoHolding> get holdings => _holdings;
//   List<Map<String, dynamic>> get searchResults => _searchResults;
//   bool get isSearching => _isSearching;
//   bool get isLoadingSearch => _isLoadingSearch;

//   Future<void> fetchHoldings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = prefs.getStringList('holdings') ?? [];
//       _holdings = holdingsJson
//           .map((json) => CryptoHolding.fromJson(jsonDecode(json)))
//           .toList();
//       await _updateHoldingsData();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching holdings: $e');
//     }
//   }

//   Future<void> _updateHoldingsData() async {
//     final futures = _holdings.map((holding) => _apiService.getCurrentPriceData(holding.symbol)).toList();
//     final results = await Future.wait(futures);

//     for (var i = 0; i < _holdings.length; i++) {
//       try {
//         final priceData = results[i];
//         _holdings[i].currentPrice = priceData['currentPrice'].toDouble();
//         _holdings[i].currentValue = _holdings[i].quantity * _holdings[i].currentPrice;
//         _holdings[i].profitLoss = _holdings[i].currentValue - _holdings[i].investedAmount;
//         _holdings[i].dailyProfitLoss = _holdings[i].currentValue * (priceData['priceChange24h'] / 100);
//       } catch (e) {
//         print('Error updating holding data for ${_holdings[i].symbol}: $e');
//       }
//     }
//   }

//   Future<void> searchCrypto(String searchTerm) async {
//     _isSearching = searchTerm.isNotEmpty;
//     if (_isSearching) {
//       _isLoadingSearch = true;
//       notifyListeners();
//       try {
//         final results = await _apiService.searchCrypto(searchTerm);
//         _searchResults = List<Map<String, dynamic>>.from(results['coins']);
//       } catch (e) {
//         print('Error searching crypto: $e');
//         _searchResults = [];
//       }
//       _isLoadingSearch = false;
//     } else {
//       _searchResults = [];
//     }
//     notifyListeners();
//   }

//   Future<void> addHolding(String symbol, String name, double quantity, double averagePrice) async {
//       try {
//       final priceData = await _apiService.getCurrentPriceData(symbol);
//       final currentPrice = priceData['currentPrice'].toDouble();
//       final currentValue = quantity * currentPrice;
//       final investedAmount = quantity * averagePrice;
//       final profitLoss = currentValue - investedAmount;
//       final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//       final existingHoldingIndex = _holdings.indexWhere((holding) => holding.symbol == symbol);

//       if (existingHoldingIndex != -1) {
//         final existingHolding = _holdings[existingHoldingIndex];
//         final newQuantity = existingHolding.quantity + quantity;
//         final newInvestedAmount = existingHolding.investedAmount + investedAmount;
//         final newAveragePrice = newInvestedAmount / newQuantity;

//         _holdings[existingHoldingIndex].quantity = newQuantity;
//         _holdings[existingHoldingIndex].averagePrice = newAveragePrice;
//         _holdings[existingHoldingIndex].investedAmount = newInvestedAmount;
//         _holdings[existingHoldingIndex].currentPrice = currentPrice;
//         _holdings[existingHoldingIndex].currentValue = newQuantity * currentPrice;
//         _holdings[existingHoldingIndex].profitLoss = _holdings[existingHoldingIndex].currentValue - _holdings[existingHoldingIndex].investedAmount;
//         _holdings[existingHoldingIndex].dailyProfitLoss = _holdings[existingHoldingIndex].currentValue * (priceData['priceChange24h'] / 100);
//       } else {
//         final newHolding = CryptoHolding(
//           symbol: symbol,
//           name: name,
//           quantity: quantity,
//           averagePrice: averagePrice,
//           currentPrice: currentPrice,
//           currentValue: currentValue,
//           investedAmount: investedAmount,
//           profitLoss: profitLoss,
//           dailyProfitLoss: dailyProfitLoss,
//         );

//         _holdings.add(newHolding);
//       }

//       await _saveHoldings();
//       notifyListeners();
//     } catch (e) {
//       print('Error adding holding: $e');
//     }
//   }

//   Future<void> updateHolding(String symbol, double quantity, double averagePrice) async {
//      final index = _holdings.indexWhere((holding) => holding.symbol == symbol);
//     if (index != -1) {
//       try {
//         final priceData = await _apiService.getCurrentPriceData(symbol);
//         final currentValue = quantity * priceData['currentPrice'];
//         final investedAmount = quantity * averagePrice;
//         final profitLoss = currentValue - investedAmount;
//         final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//         _holdings[index].quantity = quantity;
//         _holdings[index].averagePrice = averagePrice;
//         _holdings[index].currentPrice = priceData['currentPrice'];
//         _holdings[index].currentValue = currentValue;
//         _holdings[index].investedAmount = investedAmount;
//         _holdings[index].profitLoss = profitLoss;
//         _holdings[index].dailyProfitLoss = dailyProfitLoss;

//         await _saveHoldings();
//         notifyListeners();
//       } catch (e) {
//         print('Error updating holding: $e');
//       }
//     }
//   }

//   void removeHolding(String symbol) {
//      _holdings.removeWhere((holding) => holding.symbol == symbol);
//     _saveHoldings();
//     notifyListeners();
//   }

//   double getTotalValue() {
//     return _holdings.fold(0, (sum, holding) => sum + holding.currentValue);
//   }

//   Future<void> _saveHoldings() async {
//      try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = _holdings.map((holding) => jsonEncode(holding.toJson())).toList();
//       await prefs.setStringList('holdings', holdingsJson);
//     } catch (e) {
//       print('Error saving holdings: $e');
//     }
//   }

//   Future<void> preloadCryptoPacks(List<CryptoPack> cryptoPacks) async {
//     final allCoinIds = cryptoPacks.expand((pack) => pack.coinIds).toSet().toList();
//     try {
//       final batchData = await _apiService.fetchBatchCryptoData(allCoinIds);
//       for (var pack in cryptoPacks) {
//         final packData = pack.coinIds.map((id) => batchData[id]).toList();
//         await _cryptoPackCache.setCryptoPackData(pack.id, packData);
//       }
//     } catch (e) {
//       print('Error preloading crypto packs: $e');
//     }
//   }

// }

// class AppTheme {
//   static const primaryColor = Color(0xFF2196F3);
//   static const secondaryColor = Color(0xFF4CAF50);
//   static const backgroundColor = Color(0xFFF5F5F5);
//   static const cardColor = Colors.white;
//   static const textColor = Color(0xFF333333);
//   static const lightTextColor = Color(0xFF666666);

//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: primaryColor,
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: secondaryColor,
//       ),
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: AppBarTheme(
//         color: primaryColor,
//         elevation: 0,
//       ),
//       cardTheme: CardTheme(
//         color: cardColor,
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
//         titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
//         bodyMedium: TextStyle(color: textColor, fontSize: 14),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: primaryColor,
//         textTheme: ButtonTextTheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }

// class CryptoPackScreen extends StatefulWidget {
//   @override
//   _CryptoPackScreenState createState() => _CryptoPackScreenState();
// }

// class _CryptoPackScreenState extends State<CryptoPackScreen> {////////////////////////////////////////////////////////////////////////////////////////
//   final CryptoApiService _apiService = CryptoApiService();
//   int _currentPage = 0;
//   static const int _packsPerPage = 6;

//   @override
//   void initState() {
//     super.initState();
//     _calculatePercentageChange();
//     _preloadCryptoPacks();
//   }

//    void _preloadCryptoPacks() {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);
//     holdingsProvider.preloadCryptoPacks(_cryptoPacks);
//   }

//   void _calculatePercentageChange() async {
//     for (var pack in _cryptoPacks) {
//       try {
//         double percentageChange = await _fetchPercentageChange(pack.coinIds);
//         setState(() {
//           pack.percentageChange = percentageChange;
//         });
//       } catch (e) {
//         print('Error calculating percentage change for ${pack.name}: $e');
//         setState(() {
//           pack.percentageChange = pack.percentageChange;
//         });
//       }
//     }
//   }

//   Future<double> _fetchPercentageChange(List<String> coinIds) async {
//     try {
//       final ids = coinIds.join(',');
//       final response = await _apiService.fetchCryptoData(ids);
//       if (response.isNotEmpty) {
//         final totalChange = response.fold(0.0, (sum, coinData) {
//           return sum + (coinData['price_change_percentage_24h'] ?? 0.0);
//         });
//         return totalChange / response.length;
//       }
//       return 0.0;
//     } catch (e) {
//       print('Error fetching percentage change: $e');
//       return 0.0;
//     }
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CryptoPack', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         elevation: 0,
//       ),
//       drawer: _buildDrawer(context),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('ALL CRYPTOPACKS', style: TextStyle(fontSize: 12)),//12/////////////////////////////////////////////////////////////////////////////////////////////////////
//                       style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryColor,
//                     foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Coming soon!')),
//                         );
//                       },
//                       child: Text('MY CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.secondaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(16.0),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final packIndex = _currentPage * _packsPerPage + index;
//                   if (packIndex >= _cryptoPacks.length) {
//                     return SizedBox.shrink();
//                   }
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CryptoPackDetailScreen(pack: _cryptoPacks[packIndex]),
//                         ),
//                       );
//                     },
//                     child: CryptoPackCard(pack: _cryptoPacks[packIndex]),
//                   );
//                 },
//                 childCount: _packsPerPage,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//  Widget _buildDrawer(BuildContext context) {
//   final user = supabase.auth.currentUser;
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         UserAccountsDrawerHeader(
//           accountName: Text(user?.userMetadata?['first_name'] ?? 'User'),
//           accountEmail: Text(user?.email ?? ''),
//           currentAccountPicture: CircleAvatar(
//             backgroundImage: NetworkImage(
//               'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//             ),
//           ),
//           decoration: BoxDecoration(
//             color: AppTheme.primaryColor,
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.home),
//           title: Text('Home', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//   leading: Icon(Icons.account_circle),
//   title: Text('Profile', style: TextStyle(fontSize: 18)),
//   onTap: () {
//     Navigator.pop(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfilePage()),
//     );
//   },
// ),
//         ListTile(
//           leading: Icon(Icons.account_balance_wallet),
//           title: Text('My Portfolio', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HoldingsScreen()),
//             );
//           },
//         ),
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('FAQ', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FAQScreen()),
//               );
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.support),
//             title: Text('Help & Support', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               launch('mailto:cryptoforyouhelp@gmail.com');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CryptoPackCard extends StatelessWidget {
//   final CryptoPack pack;

//   const CryptoPackCard({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.secondaryColor.withOpacity(0.1)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(9.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       pack.name,
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(pack.icon, color: AppTheme.primaryColor),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 pack.description,
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Spacer(),
//               Text(
//                 'Rec.investement:',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//               ),
//               Text(
//                 '\$${pack.RecommendedInvestment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Change:',
//                     style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                   ),
//                   Text(
//                     '${pack.percentageChange.toStringAsFixed(2)}%',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: pack.percentageChange >= 0 ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Trend: ${pack.trend}',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CryptoPackDetailScreen(pack: pack),
//                       ),
//                     );
//                   },
//                   child: Text('Know More', style: TextStyle(fontSize: 12)),
//                   style: ElevatedButton.styleFrom(
//                backgroundColor    : AppTheme.primaryColor,
//                foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CryptoPackDetailScreen extends StatelessWidget {
//   final CryptoPack pack;
//   const CryptoPackDetailScreen({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(pack.name, style: TextStyle(color: Colors.white)),
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(pack.icon, size: 80, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoCard('About', pack.about),
//                   SizedBox(height: 16),
//                   _buildInfoCard('RecommendedInvestment', '\$${pack.RecommendedInvestment.toStringAsFixed(2)}'),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Trend', pack.trend),
//                   SizedBox(height: 16),
//                   _buildInfoCard('24h Change', '${pack.percentageChange.toStringAsFixed(2)}%'),
//                   SizedBox(height: 24),
//                   Text(
//                     'Coin Distribution',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: FutureBuilder<List<dynamic>>(
//               future: _fetchCryptoData(context),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No data available', style: TextStyle(fontSize: 18)));
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         padding: EdgeInsets.all(16.0),
//                         child: PieChart(
//                           PieChartData(
//                             sections: getPieChartSections(snapshot.data!),
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                             borderData: FlBorderData(show: false),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) => _buildCoinListTile(snapshot.data![index]),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Investment functionality coming soon!')),
//             );
//           },
//           child: Text('Invest Now', style: TextStyle(fontSize: 18)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppTheme.primaryColor,
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(value, style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCoinListTile(dynamic coin) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: coin['image'],
//           width: 40,
//           height: 40,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         title: Text(coin['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text('${coin['current_price'].toStringAsFixed(2)} USD'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
//               style: TextStyle(
//                 color: coin['price_change_percentage_24h'] >= 0 ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text('24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }

//   static const Map<String, Map<String, double>> _packPercentages = {
//     'RAW Frontrunners': {
//       'ix-swap': 0.2,
//       'realio-network': 0.2,
//       'clearpool': 0.2,
//       'polytrade': 0.2,
//       'maple': 0.2,
//     },
//     'CeDefi-Defi & Privacy': {
//       'fideum': 0.5,
//       'oasis-network': 0.5,
//     },
//     'High Caps': {
//       'bitcoin': 0.4,
//       'ethereum': 0.4,
//       'chainlink': 0.2,
//     },
//     'ultimate_alts': {
//       'cardano': 0.3,
//       'solana': 0.3,
//       'polkadot': 0.2,
//       'avalanche-2': 0.2,
//     },
//     'high_risk_high_reward': {
//       'maga': 1,
//     },
//     'Artificial Intelligence': {
//       'near': 1,
//     },
//   };

//   Future<List<dynamic>> _fetchCryptoData(BuildContext context) async {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);

//     final cachedData = holdingsProvider._cryptoPackCache.getCryptoPackData(pack.id);
//     if (cachedData != null) {
//       return cachedData;
//     }

//     final cryptoApiService = CryptoApiService();
//     final coinIds = _packPercentages[pack.id]?.keys.join(',') ?? '';
//     final data = await cryptoApiService.fetchCryptoData(coinIds);
//     await holdingsProvider._cryptoPackCache.setCryptoPackData(pack.id, data);
//     return data;
//   }

//   List<PieChartSectionData> getPieChartSections(List<dynamic> cryptoData) {
//     List<PieChartSectionData> sections = [];
//     final packPercentages = _packPercentages[pack.id] ?? {};
//     final colors = [
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.purple,
//       Colors.orange,
//     ];

//     int colorIndex = 0;
//     for (var coin in cryptoData) {
//       final percentage = packPercentages[coin['id']] ?? 0;
//       sections.add(
//         PieChartSectionData(
//           value: percentage,
//           title: '${coin['symbol'].toUpperCase()}\n${(percentage * 100).toStringAsFixed(0)}%',
//           color: colors[colorIndex % colors.length],
//           radius: 40,
//           titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//       colorIndex++;
//     }

//     return sections;
//   }
// }

// class FAQScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FAQ'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           ExpansionTile(
//             title: Text('What is CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'CryptoPack is a selection of curated cryptocurrency portfolios designed to suit various investment strategies.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How do I invest in a CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'You can invest in a CryptoPack by selecting your desired pack and making a minimum investment as specified.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Is there a risk in investing in cryptocurrencies?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, investing in cryptocurrencies carries risks due to their volatile nature. It is advisable to do thorough research and invest wisely.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How is the percentage change calculated?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'The percentage change is calculated based on the change in the value of the cryptocurrencies in the pack over the past 24 hours.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Can I track my investments?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, you can track your investments through the "My CryptoPacks" section, which will be available soon.',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HoldingsScreen extends StatefulWidget {
//   @override
//   _HoldingsScreenState createState() => _HoldingsScreenState();
// }

// class _HoldingsScreenState extends State<HoldingsScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _averagePriceController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _quantityController.dispose();
//     _averagePriceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: _buildHoldingsTheme(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My Portfolio'),
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             _buildSearchBar(),
//             _buildPortfolioOverview(),
//             Expanded(
//               child: Consumer<HoldingsProvider>(
//                 builder: (context, provider, child) {
//                   return Column(
//                     children: [
//                       if (provider.isSearching)
//                         _buildSearchResults(provider)
//                       else
//                         _buildHoldingsList(provider),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ThemeData _buildHoldingsTheme() {
//     return ThemeData(
//       primaryColor: const Color(0xFF6200EE),
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: Color(0xFF03DAC6),
//       ),
//       scaffoldBackgroundColor: Color(0xFFF5F5F5),
//       cardTheme: CardTheme(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6200EE)),
//         titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//         bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => context.read<HoldingsProvider>().searchCrypto(value),
//         decoration: InputDecoration(
//           hintText: 'Search cryptocurrencies...',
//           prefixIcon: Icon(Icons.search),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _searchController.clear();
//               context.read<HoldingsProvider>().searchCrypto('');
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPortfolioOverview() {
//     return Consumer<HoldingsProvider>(
//       builder: (context, provider, child) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Portfolio Value',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '${provider.getTotalValue().toStringAsFixed(2)} USD',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchResults(HoldingsProvider provider) {
//     return Expanded(
//       child: provider.isLoadingSearch
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: provider.searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = provider.searchResults[index];
//                 return ListTile(
//                   leading: CachedNetworkImage(
//                     imageUrl: result['large'] ?? '',
//                     width: 40,
//                     height: 40,
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                   title: Text(result['name']),
//                   subtitle: Text(result['symbol']),
//                   onTap: () => _showAddHoldingDialog(context, result, provider),
//                 );
//               },
//             ),
//     );
//   }

// Widget _buildHoldingsList(HoldingsProvider provider) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: provider.holdings.length,
//         itemBuilder: (context, index) {
//           final holding = provider.holdings[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     holding.name,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   Text(
//                     holding.symbol.toUpperCase(),
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Quantity: ${holding.quantity.toStringAsFixed(4)}'),
//                       Text('Avg. Price: ${holding.averagePrice.toStringAsFixed(2)} USD'),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Current Value: ${holding.currentValue.toStringAsFixed(2)} USD'),
//                       Text(
//                         'P/L: ${holding.profitLoss.toStringAsFixed(2)} USD',
//                         style: TextStyle(
//                           color: holding.profitLoss >= 0 ? Colors.green : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: false,
//                           holding: holding,
//                         ),
//                         child: Text('Add'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: true,
//                           holding: holding,
//                         ),
//                         child: Text('Edit'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showRemoveHoldingDialog(context, holding, provider),
//                         child: Text('Remove'),
//                         style: TextButton.styleFrom(foregroundColor: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//  void _showAddHoldingDialog(BuildContext context, Map<String, dynamic>? result, HoldingsProvider provider, {bool isEdit = false, CryptoHolding? holding}) {
//   if (isEdit) {
//     _quantityController.text = '';
//     _averagePriceController.text = holding!.averagePrice.toString();
//   } else {
//     _quantityController.clear();
//     _averagePriceController.clear();
//   }

//   String operation = 'Add';

//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Text(isEdit ? 'Edit Holding' : 'Add Holding'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isEdit)
//                   DropdownButton<String>(
//                     value: operation,
//                     items: ['Add', 'Subtract'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         operation = newValue!;
//                       });
//                     },
//                   ),
//                 TextField(
//                   controller: _quantityController,
//                   decoration: InputDecoration(
//                     labelText: 'Quantity',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _averagePriceController,
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   final newQuantity = double.tryParse(_quantityController.text) ?? 0;
//                   final newPrice = double.tryParse(_averagePriceController.text) ?? 0;

//                   if (isEdit) {
//                     final operationMultiplier = operation == 'Add' ? 1 : -1;
//                     final totalValue = (holding!.quantity * holding.averagePrice) + (newQuantity * newPrice * operationMultiplier);
//                     final totalQuantity = holding.quantity + (newQuantity * operationMultiplier);

//                     if (totalQuantity <= 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Cannot subtract more than available quantity')),
//                       );
//                       return;
//                     }

//                     final newAveragePrice = totalValue / totalQuantity;

//                     provider.updateHolding(
//                       holding.symbol,
//                       totalQuantity,
//                       newAveragePrice,
//                     );
//                   } else {
//                     provider.addHolding(
//                       result!['id'],
//                       result['name'],
//                       newQuantity,
//                       newPrice,
//                     );
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text(isEdit ? 'Update' : 'Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
//  void _showRemoveHoldingDialog(BuildContext context, CryptoHolding holding, HoldingsProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Holding'),
//         content: Text('Are you sure you want to remove ${holding.name} from your portfolio?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//             style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               provider.removeHolding(holding.symbol);
//               Navigator.pop(context);
//             },
//             child: Text('Remove'),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CryptoPackScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 15, 14, 14),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'android/logo (1).jpg',
//               width: MediaQuery.of(context).size.width * 0.4,
//               height: MediaQuery.of(context).size.width * 0.4,
//             ),
//             SizedBox(height: 24),
//             Text(
//               'CryptoForYou',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 238, 242, 244),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// void main() async {
//  // WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://pajnoqsxkpaujmdskmjy.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBham5vcXN4a3BhdWptZHNrbWp5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDE3Mjk0NywiZXhwIjoyMDM1NzQ4OTQ3fQ.uZY4kBkg-yu8z29Xt8DLqtvkalD-FmMQyMjMzr8WTmM',
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) {
//         final provider = HoldingsProvider()..fetchHoldings();
//         provider.preloadCryptoPacks(_cryptoPacks);
//         return provider;
//       },

//       child: MyApp(),
//     ),
//   );
// }
//  final supabase = Supabase.instance.client;//////////////////////////////////////////////////////////////////////////////
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CryptoPack',
//       theme: AppTheme.lightTheme,
//       home: SignInPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// import 'dart:math';
// import 'profile.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:dio/dio.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'login.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final List<CryptoPack> _cryptoPacks = [
//        CryptoPack(
//     name: 'RAW Frontrunners',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['ix-swap', 'realio-network', 'clearpool', 'polytrade', 'maple'],
//     about: 'RAW Frontrunners pack focuses on cryptocurrencies that are leading the way in terms of innovation and market influence.',
//     id: 'RAW Frontrunners',
//   ),
//   CryptoPack(
//     name: 'CeDefi-Defi & Privacy',
//     description: 'Leading DeFi and privacy tokens',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Very High',
//     icon: Icons.security,
//     coinIds: ['fideum', 'oasis-network'],
//     about: 'CeDefi-Defi & Privacy pack includes top-performing tokens in the DeFi and privacy space.',
//     id: 'CeDefi-Defi & Privacy',
//   ),
//   CryptoPack(
//     name: 'High Caps',
//     description: 'The market-leading cryptocurrencies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.star,
//     coinIds: ['bitcoin', 'ethereum', 'chainlink'],
//     about: 'high caps pack contains the most prominent cryptocurrencies, suitable for beginners and experienced investors.',
//     id: 'High Caps',
//   ),
//   CryptoPack(
//     name: 'Ultimate Alts of Tomorrow',
//     description: 'The undisputed Alt Coin selection',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.monetization_on,
//     coinIds: ['cardano', 'solana', 'polkadot', 'avalanche-2'],
//     about: 'Ultimate Alts pack features a selection of promising altcoins with potential for future growth.',
//     id: 'ultimate_alts',
//   ),
//    CryptoPack(
//     name: 'HighRiskHighReward',
//     description: 'High-risk investments with potential for high rewards',
//     RecommendedInvestment: 250.00,
//     percentageChange: 0.0,
//     trend: 'High',
//     icon: Icons.warning,
//     coinIds: ['maga', ],
//     about: 'HighRiskHighReward pack includes volatile cryptocurrencies with the potential for significant returns.',
//     id: 'high_risk_high_reward',
//   ),
//   CryptoPack(
//     name: 'Artificial Intelligence',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 500.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['near'],
//     about: 'Artificial Intelligence pack focuses on cryptocurrencies that are leading the way in terms of innovation in artificial intelligence and market influence.',
//     id: 'Artificial Intelligence',
//   )
//   ];
// class ApiError extends Error {
//   final String message;
//   final int? statusCode;

//   ApiError({required this.message, this.statusCode});
// }

// class CryptoPack {
//   final String name;
//   final String description;
//   final double RecommendedInvestment;
//   double percentageChange;
//   final String trend;
//   final IconData icon;
//   final String id;
//   final String about;
//   final List<String> coinIds;

//   CryptoPack({
//     required this.name,
//     required this.description,
//     required this.RecommendedInvestment,
//     required this.percentageChange,
//     required this.trend,
//     required this.icon,
//     required this.id,
//     required this.about,
//     required this.coinIds,
//   });
// }

// class CryptoHolding {
//   final String symbol;
//   final String name;
//   double quantity;
//   double averagePrice;
//   double currentPrice;
//   double currentValue;
//   double investedAmount;
//   double profitLoss;
//   double dailyProfitLoss;

//   CryptoHolding({
//     required this.symbol,
//     required this.name,
//     required this.quantity,
//     required this.averagePrice,
//     required this.currentPrice,
//     required this.currentValue,
//     required this.investedAmount,
//     required this.profitLoss,
//     required this.dailyProfitLoss,
//   });

//   factory CryptoHolding.fromJson(Map<String, dynamic> json) {
//     return CryptoHolding(
//       symbol: json['symbol'],
//       name: json['name'],
//       quantity: json['quantity'],
//       averagePrice: json['averagePrice'],
//       currentPrice: json['currentPrice'],
//       currentValue: json['currentValue'],
//       investedAmount: json['investedAmount'],
//       profitLoss: json['profitLoss'],
//       dailyProfitLoss: json['dailyProfitLoss'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'symbol': symbol,
//       'name': name,
//       'quantity': quantity,
//       'averagePrice': averagePrice,
//       'currentPrice': currentPrice,
//       'currentValue': currentValue,
//       'investedAmount': investedAmount,
//       'profitLoss': profitLoss,
//       'dailyProfitLoss': dailyProfitLoss,
//     };
//   }
// }
// class DetailedCryptoData {
//   final String id;
//   final String name;
//   final String symbol;
//   final String description;
//   final String image;
//   final double currentPrice;
//   final double marketCap;
//   final double tradingVolume;
//   final double priceChange24h;
//   final double marketCapRank;
//   final List<List<double>> historicalData;
//   final Map<String, dynamic> communityData;
//   final Map<String, dynamic> developerData;

//   DetailedCryptoData({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.description,
//     required this.image,
//     required this.currentPrice,
//     required this.marketCap,
//     required this.tradingVolume,
//     required this.priceChange24h,
//     required this.marketCapRank,
//     required this.historicalData,
//     required this.communityData,
//     required this.developerData,
//   });

//   factory DetailedCryptoData.fromJson(Map<String, dynamic> json, List<dynamic> historicalData) {
//     return DetailedCryptoData(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       symbol: json['symbol'] ?? '',
//       description: json['description']['en'] ?? '',
//       image: json['image']['large'] ?? '',
//       currentPrice: (json['market_data']['current_price']['usd'] ?? 0).toDouble(),
//       marketCap: (json['market_data']['market_cap']['usd'] ?? 0).toDouble(),
//       tradingVolume: (json['market_data']['total_volume']['usd'] ?? 0).toDouble(),
//       priceChange24h: (json['market_data']['price_change_percentage_24h'] ?? 0).toDouble(),
//       marketCapRank: (json['market_cap_rank'] ?? 0).toDouble(),
//       historicalData: (historicalData as List<dynamic>).map((data) =>
//         [data[0] as double? ?? 0.0, data[1] as double? ?? 0.0]).toList(),
//       communityData: json['community_data'] ?? {},
//       developerData: json['developer_data'] ?? {},
//     );
//   }
// }
// class CachedData<T> {
//   final T data;
//   final DateTime timestamp;

//   CachedData({required this.data, required this.timestamp});
// }

// class CryptoPackCache {
//   final Map<String, CachedData<List<dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 15);

//   Future<void> setCryptoPackData(String packId, List<dynamic> data) async {
//     _cache[packId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   List<dynamic>? getCryptoPackData(String packId) {
//     if (_cache.containsKey(packId) && !_isCacheExpired(packId)) {
//       return _cache[packId]!.data;
//     }
//     return null;
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class CryptoApiService {
//   final Dio _dio = Dio();
//   final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 5);

//   CryptoApiService() {
//     _dio.interceptors.add(InterceptorsWrapper(
//       onError: (DioError e, ErrorInterceptorHandler handler) {
//         ApiError error;
//         if (e.response != null) {
//           error = ApiError(
//             message: e.response!.data['message'] ?? 'Unknown error',
//             statusCode: e.response!.statusCode
//           );
//         } else {
//           error = ApiError(message: e.message ?? 'Unknown error');
//         }
//         throw error;
//       },
//     ));
//   }

//   Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
//     if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
//       return _cache[symbol]!.data;
//     }

//     try {
//       final response = await _dio.get(
//           'https://api.coingecko.com/api/v3/simple/price?ids=$symbol&vs_currencies=usd&include_24hr_change=true');
//       final data = {
//         'currentPrice': response.data[symbol]['usd'],
//         'priceChange24h': response.data[symbol]['usd_24h_change'],
//       };
//       _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
//       return data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to load price data');
//     }
//   }

//   Future<Map<String, dynamic>> searchCrypto(String query) async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/search?query=$query');
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to search crypto');
//     }
//   }

//   Future<List<dynamic>> fetchCryptoData(String coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds,
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchBatchCryptoData(List<String> coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds.join(','),
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return Map.fromIterable(response.data, key: (item) => item['id'], value: (item) => item);
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch batch data');
//     }
//   }
// Future<Map<String, dynamic>> fetchDetailedCoinData(String coinId) async {
//   try {
//     final response = await _dio.get(
//       'https://api.coingecko.com/api/v3/coins/$coinId',
//       queryParameters: {
//         'localization': 'false',
//         'tickers': 'false',
//         'market_data': 'true',
//         'community_data': 'true',
//         'developer_data': 'true',
//       },
//     );
//     return response.data ?? {};
//   } catch (e) {
//     print('Error fetching detailed coin data: $e');
//     throw ApiError(message: 'Failed to fetch detailed coin data');
//   }
// }

// Future<List<dynamic>> fetchCoinMarketChart(String coinId, int days) async {
//   try {
//     final response = await _dio.get(
//       'https://api.coingecko.com/api/v3/coins/$coinId/market_chart',
//       queryParameters: {
//         'vs_currency': 'usd',
//         'days': days,
//       },
//     );
//     return response.data['prices'] ?? [];
//   } catch (e) {
//     print('Error fetching market chart data: $e');
//     throw ApiError(message: 'Failed to fetch market chart data');
//   }
// }

//   Future<Map<String, dynamic>> fetchGlobalData() async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/global');
//       return response.data['data'];
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch global data');
//     }
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class HoldingsProvider with ChangeNotifier {
//   final CryptoApiService _apiService = CryptoApiService();
//   final CryptoPackCache _cryptoPackCache = CryptoPackCache();
//   List<CryptoHolding> _holdings = [];
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _isSearching = false;
//   bool _isLoadingSearch = false;

//   List<CryptoHolding> get holdings => _holdings;
//   List<Map<String, dynamic>> get searchResults => _searchResults;
//   bool get isSearching => _isSearching;
//   bool get isLoadingSearch => _isLoadingSearch;

//   Future<void> fetchHoldings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = prefs.getStringList('holdings') ?? [];
//       _holdings = holdingsJson
//           .map((json) => CryptoHolding.fromJson(jsonDecode(json)))
//           .toList();
//       await _updateHoldingsData();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching holdings: $e');
//     }
//   }

//   Future<void> _updateHoldingsData() async {
//     final futures = _holdings.map((holding) => _apiService.getCurrentPriceData(holding.symbol)).toList();
//     final results = await Future.wait(futures);

//     for (var i = 0; i < _holdings.length; i++) {
//       try {
//         final priceData = results[i];
//         _holdings[i].currentPrice = priceData['currentPrice'].toDouble();
//         _holdings[i].currentValue = _holdings[i].quantity * _holdings[i].currentPrice;
//         _holdings[i].profitLoss = _holdings[i].currentValue - _holdings[i].investedAmount;
//         _holdings[i].dailyProfitLoss = _holdings[i].currentValue * (priceData['priceChange24h'] / 100);
//       } catch (e) {
//         print('Error updating holding data for ${_holdings[i].symbol}: $e');
//       }
//     }
//   }

//   Future<void> searchCrypto(String searchTerm) async {
//     _isSearching = searchTerm.isNotEmpty;
//     if (_isSearching) {
//       _isLoadingSearch = true;
//       notifyListeners();
//       try {
//         final results = await _apiService.searchCrypto(searchTerm);
//         _searchResults = List<Map<String, dynamic>>.from(results['coins']);
//       } catch (e) {
//         print('Error searching crypto: $e');
//         _searchResults = [];
//       }
//       _isLoadingSearch = false;
//     } else {
//       _searchResults = [];
//     }
//     notifyListeners();
//   }

//   Future<void> addHolding(String symbol, String name, double quantity, double averagePrice) async {
//       try {
//       final priceData = await _apiService.getCurrentPriceData(symbol);
//       final currentPrice = priceData['currentPrice'].toDouble();
//       final currentValue = quantity * currentPrice;
//       final investedAmount = quantity * averagePrice;
//       final profitLoss = currentValue - investedAmount;
//       final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//       final existingHoldingIndex = _holdings.indexWhere((holding) => holding.symbol == symbol);

//       if (existingHoldingIndex != -1) {
//         final existingHolding = _holdings[existingHoldingIndex];
//         final newQuantity = existingHolding.quantity + quantity;
//         final newInvestedAmount = existingHolding.investedAmount + investedAmount;
//         final newAveragePrice = newInvestedAmount / newQuantity;

//         _holdings[existingHoldingIndex].quantity = newQuantity;
//         _holdings[existingHoldingIndex].averagePrice = newAveragePrice;
//         _holdings[existingHoldingIndex].investedAmount = newInvestedAmount;
//         _holdings[existingHoldingIndex].currentPrice = currentPrice;
//         _holdings[existingHoldingIndex].currentValue = newQuantity * currentPrice;
//         _holdings[existingHoldingIndex].profitLoss = _holdings[existingHoldingIndex].currentValue - _holdings[existingHoldingIndex].investedAmount;
//         _holdings[existingHoldingIndex].dailyProfitLoss = _holdings[existingHoldingIndex].currentValue * (priceData['priceChange24h'] / 100);
//       } else {
//         final newHolding = CryptoHolding(
//           symbol: symbol,
//           name: name,
//           quantity: quantity,
//           averagePrice: averagePrice,
//           currentPrice: currentPrice,
//           currentValue: currentValue,
//           investedAmount: investedAmount,
//           profitLoss: profitLoss,
//           dailyProfitLoss: dailyProfitLoss,
//         );

//         _holdings.add(newHolding);
//       }

//       await _saveHoldings();
//       notifyListeners();
//     } catch (e) {
//       print('Error adding holding: $e');
//     }
//   }

//   Future<void> updateHolding(String symbol, double quantity, double averagePrice) async {
//      final index = _holdings.indexWhere((holding) => holding.symbol == symbol);
//     if (index != -1) {
//       try {
//         final priceData = await _apiService.getCurrentPriceData(symbol);
//         final currentValue = quantity * priceData['currentPrice'];
//         final investedAmount = quantity * averagePrice;
//         final profitLoss = currentValue - investedAmount;
//         final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//         _holdings[index].quantity = quantity;
//         _holdings[index].averagePrice = averagePrice;
//         _holdings[index].currentPrice = priceData['currentPrice'];
//         _holdings[index].currentValue = currentValue;
//         _holdings[index].investedAmount = investedAmount;
//         _holdings[index].profitLoss = profitLoss;
//         _holdings[index].dailyProfitLoss = dailyProfitLoss;

//         await _saveHoldings();
//         notifyListeners();
//       } catch (e) {
//         print('Error updating holding: $e');
//       }
//     }
//   }

//   void removeHolding(String symbol) {
//      _holdings.removeWhere((holding) => holding.symbol == symbol);
//     _saveHoldings();
//     notifyListeners();
//   }

//   double getTotalValue() {
//     return _holdings.fold(0, (sum, holding) => sum + holding.currentValue);
//   }

//   Future<void> _saveHoldings() async {
//      try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = _holdings.map((holding) => jsonEncode(holding.toJson())).toList();
//       await prefs.setStringList('holdings', holdingsJson);
//     } catch (e) {
//       print('Error saving holdings: $e');
//     }
//   }

//   Future<void> preloadCryptoPacks(List<CryptoPack> cryptoPacks) async {
//     final allCoinIds = cryptoPacks.expand((pack) => pack.coinIds).toSet().toList();
//     try {
//       final batchData = await _apiService.fetchBatchCryptoData(allCoinIds);
//       for (var pack in cryptoPacks) {
//         final packData = pack.coinIds.map((id) => batchData[id]).toList();
//         await _cryptoPackCache.setCryptoPackData(pack.id, packData);
//       }
//     } catch (e) {
//       print('Error preloading crypto packs: $e');
//     }
//   }

// }

// class AppTheme {
//   static const primaryColor = Color(0xFF2196F3);
//   static const secondaryColor = Color(0xFF4CAF50);
//   static const backgroundColor = Color(0xFFF5F5F5);
//   static const cardColor = Colors.white;
//   static const textColor = Color(0xFF333333);
//   static const lightTextColor = Color(0xFF666666);

//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: primaryColor,
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: secondaryColor,
//       ),
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: AppBarTheme(
//         color: primaryColor,
//         elevation: 0,
//       ),
//       cardTheme: CardTheme(
//         color: cardColor,
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
//         titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
//         bodyMedium: TextStyle(color: textColor, fontSize: 14),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: primaryColor,
//         textTheme: ButtonTextTheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }

// class CryptoPackScreen extends StatefulWidget {
//   @override
//   _CryptoPackScreenState createState() => _CryptoPackScreenState();
// }

// class _CryptoPackScreenState extends State<CryptoPackScreen> {////////////////////////////////////////////////////////////////////////////////////////
//   final CryptoApiService _apiService = CryptoApiService();
//   int _currentPage = 0;
//   static const int _packsPerPage = 6;

//   @override
//   void initState() {
//     super.initState();
//     _calculatePercentageChange();
//     _preloadCryptoPacks();
//   }

//    void _preloadCryptoPacks() {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);
//     holdingsProvider.preloadCryptoPacks(_cryptoPacks);
//   }

//   void _calculatePercentageChange() async {
//     for (var pack in _cryptoPacks) {
//       try {
//         double percentageChange = await _fetchPercentageChange(pack.coinIds);
//         setState(() {
//           pack.percentageChange = percentageChange;
//         });
//       } catch (e) {
//         print('Error calculating percentage change for ${pack.name}: $e');
//         setState(() {
//           pack.percentageChange = pack.percentageChange;
//         });
//       }
//     }
//   }

//   Future<double> _fetchPercentageChange(List<String> coinIds) async {
//     try {
//       final ids = coinIds.join(',');
//       final response = await _apiService.fetchCryptoData(ids);
//       if (response.isNotEmpty) {
//         final totalChange = response.fold(0.0, (sum, coinData) {
//           return sum + (coinData['price_change_percentage_24h'] ?? 0.0);
//         });
//         return totalChange / response.length;
//       }
//       return 0.0;
//     } catch (e) {
//       print('Error fetching percentage change: $e');
//       return 0.0;
//     }
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CryptoPack', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         elevation: 0,
//       ),
//       drawer: _buildDrawer(context),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('ALL CRYPTOPACKS', style: TextStyle(fontSize: 12)),//12/////////////////////////////////////////////////////////////////////////////////////////////////////
//                       style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryColor,
//                     foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Coming soon!')),
//                         );
//                       },
//                       child: Text('MY CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.secondaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(16.0),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final packIndex = _currentPage * _packsPerPage + index;
//                   if (packIndex >= _cryptoPacks.length) {
//                     return SizedBox.shrink();
//                   }
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CryptoPackDetailScreen(pack: _cryptoPacks[packIndex]),
//                         ),
//                       );
//                     },
//                     child: CryptoPackCard(pack: _cryptoPacks[packIndex]),
//                   );
//                 },
//                 childCount: _packsPerPage,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//  Widget _buildDrawer(BuildContext context) {
//   final user = supabase.auth.currentUser;
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         UserAccountsDrawerHeader(
//           accountName: Text(user?.userMetadata?['first_name'] ?? 'User'),
//           accountEmail: Text(user?.email ?? ''),
//           currentAccountPicture: CircleAvatar(
//             backgroundImage: NetworkImage(
//               'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//             ),
//           ),
//           decoration: BoxDecoration(
//             color: AppTheme.primaryColor,
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.home),
//           title: Text('Home', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//   leading: Icon(Icons.account_circle),
//   title: Text('Profile', style: TextStyle(fontSize: 18)),
//   onTap: () {
//     Navigator.pop(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfilePage()),
//     );
//   },
// ),
//         ListTile(
//           leading: Icon(Icons.account_balance_wallet),
//           title: Text('My Portfolio', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HoldingsScreen()),
//             );
//           },
//         ),
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('FAQ', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FAQScreen()),
//               );
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.support),
//             title: Text('Help & Support', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               launch('mailto:cryptoforyouhelp@gmail.com');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CryptoPackCard extends StatelessWidget {
//   final CryptoPack pack;

//   const CryptoPackCard({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.secondaryColor.withOpacity(0.1)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(9.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       pack.name,
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(pack.icon, color: AppTheme.primaryColor),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 pack.description,
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Spacer(),
//               Text(
//                 'Rec.investement:',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//               ),
//               Text(
//                 '\$${pack.RecommendedInvestment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Change:',
//                     style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                   ),
//                   Text(
//                     '${pack.percentageChange.toStringAsFixed(2)}%',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: pack.percentageChange >= 0 ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Trend: ${pack.trend}',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CryptoPackDetailScreen(pack: pack),
//                       ),
//                     );
//                   },
//                   child: Text('Know More', style: TextStyle(fontSize: 12)),
//                   style: ElevatedButton.styleFrom(
//                backgroundColor    : AppTheme.primaryColor,
//                foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class CryptoDetailScreen extends StatefulWidget {
//   final String coinId;

//   CryptoDetailScreen({Key? key, required this.coinId}) : super(key: key);

//   @override
//   _CryptoDetailScreenState createState() => _CryptoDetailScreenState();
// }

// class _CryptoDetailScreenState extends State<CryptoDetailScreen> {
//   final CryptoApiService _apiService = CryptoApiService();
//   Future<DetailedCryptoData>? _cryptoDataFuture;

//   @override
//   void initState() {
//     super.initState();
//     _cryptoDataFuture = _fetchDetailedCryptoData();
//   }

//   Future<DetailedCryptoData> _fetchDetailedCryptoData() async {
//     try {
//       final coinData = await _apiService.fetchDetailedCoinData(widget.coinId);
//       final historicalData = await _apiService.fetchCoinMarketChart(widget.coinId, 30);
//       return DetailedCryptoData.fromJson(coinData, historicalData);
//     } catch (e) {
//       print('Error in _fetchDetailedCryptoData: $e');
//       throw e;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crypto Details'),
//       ),
//       body: FutureBuilder<DetailedCryptoData>(
//         future: _cryptoDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return _buildErrorWidget(snapshot.error.toString());
//           } else if (!snapshot.hasData) {
//             return _buildErrorWidget('No data available');
//           }

//           final data = snapshot.data!;
//           return RefreshIndicator(
//             onRefresh: () async {
//               setState(() {
//                 _cryptoDataFuture = _fetchDetailedCryptoData();
//               });
//             },
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildHeader(data),
//                   SizedBox(height: 16),
//                   _buildMarketData(data),
//                   SizedBox(height: 16),
//                   _buildDescription(data),
//                   SizedBox(height: 16),
//                   _buildPriceChart(data),
//                   SizedBox(height: 16),
//                   _buildCommunityData(data),
//                   SizedBox(height: 16),
//                   _buildDeveloperData(data),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildErrorWidget(String errorMessage) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 60, color: Colors.red),
//           SizedBox(height: 16),
//           Text(
//             'Error loading data',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text(
//             errorMessage,
//             style: TextStyle(fontSize: 14),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _cryptoDataFuture = _fetchDetailedCryptoData();
//               });
//             },
//             child: Text('Retry'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(DetailedCryptoData data) {
//     return Row(
//       children: [
//         CachedNetworkImage(
//           imageUrl: data.image,
//           width: 50,
//           height: 50,
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(data.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//               Text(data.symbol.toUpperCase(), style: TextStyle(fontSize: 16)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMarketData(DetailedCryptoData data) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Market Data', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             _buildDataRow('Current Price', '\$${data.currentPrice.toStringAsFixed(2)}'),
//             _buildDataRow('Market Cap', '\$${data.marketCap.toStringAsFixed(0)}'),
//             _buildDataRow('Trading Volume', '\$${data.tradingVolume.toStringAsFixed(0)}'),
//             _buildDataRow('24h Change', '${data.priceChange24h.toStringAsFixed(2)}%'),
//             _buildDataRow('Market Cap Rank', '#${data.marketCapRank.toStringAsFixed(0)}'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDescription(DetailedCryptoData data) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(data.description),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPriceChart(DetailedCryptoData data) {
//     if (data.historicalData.isEmpty) {
//       return Center(child: Text('No historical data available'));
//     }

//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Price Chart (30 days)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Container(
//               height: 200,
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(show: false),
//                   titlesData: FlTitlesData(show: false),
//                   borderData: FlBorderData(show: true),
//                   minX: data.historicalData.first[0],
//                   maxX: data.historicalData.last[0],
//                   minY: data.historicalData.map((e) => e[1]).reduce(min),
//                   maxY: data.historicalData.map((e) => e[1]).reduce(max),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: data.historicalData.map((e) => FlSpot(e[0], e[1])).toList(),
//                       isCurved: true,
//                       color: Colors.blue,
//                       dotData: FlDotData(show: false),
//                       belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCommunityData(DetailedCryptoData data) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Community Data', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             _buildDataRow('Twitter Followers', data.communityData['twitter_followers'].toString()),
//             _buildDataRow('Reddit Subscribers', data.communityData['reddit_subscribers'].toString()),
//             _buildDataRow('Telegram Channel User Count', data.communityData['telegram_channel_user_count'].toString()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDeveloperData(DetailedCryptoData data) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Developer Data', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             _buildDataRow('Forks', data.developerData['forks'].toString()),
//             _buildDataRow('Stars', data.developerData['stars'].toString()),
//             _buildDataRow('Subscribers', data.developerData['subscribers'].toString()),
//             _buildDataRow('Total Issues', data.developerData['total_issues'].toString()),
//             _buildDataRow('Closed Issues', data.developerData['closed_issues'].toString()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDataRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
//           Text(value),
//         ],
//       ),
//     );
//   }
// }
// class CryptoPackDetailScreen extends StatelessWidget {
//   final CryptoPack pack;
//   const CryptoPackDetailScreen({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(pack.name, style: TextStyle(color: Colors.white)),
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(pack.icon, size: 80, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoCard('About', pack.about),
//                   SizedBox(height: 16),
//                   _buildInfoCard('RecommendedInvestment', '\$${pack.RecommendedInvestment.toStringAsFixed(2)}'),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Trend', pack.trend),
//                   SizedBox(height: 16),
//                   _buildInfoCard('24h Change', '${pack.percentageChange.toStringAsFixed(2)}%'),
//                   SizedBox(height: 24),
//                   Text(
//                     'Coin Distribution',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: FutureBuilder<List<dynamic>>(
//               future: _fetchCryptoData(context),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No data available', style: TextStyle(fontSize: 18)));
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         padding: EdgeInsets.all(16.0),
//                         child: PieChart(
//                           PieChartData(
//                             sections: getPieChartSections(snapshot.data!),
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                             borderData: FlBorderData(show: false),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) => _buildCoinListTile(context, snapshot.data![index]),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Investment functionality coming soon!')),
//             );
//           },
//           child: Text('Invest Now', style: TextStyle(fontSize: 18)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppTheme.primaryColor,
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(value, style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCoinListTile(BuildContext context, dynamic coin) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: coin['image'],
//           width: 40,
//           height: 40,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         title: Text(coin['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text('${coin['current_price'].toStringAsFixed(2)} USD'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
//               style: TextStyle(
//                 color: coin['price_change_percentage_24h'] >= 0 ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text('24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CryptoDetailScreen(coinId: coin['id']),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<List<dynamic>> _fetchCryptoData(BuildContext context) async {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);

//     final cachedData = holdingsProvider._cryptoPackCache.getCryptoPackData(pack.id);
//     if (cachedData != null) {
//       return cachedData;
//     }

//     final cryptoApiService = CryptoApiService();
//     final coinIds = _packPercentages[pack.id]?.keys.join(',') ?? '';
//     final data = await cryptoApiService.fetchCryptoData(coinIds);
//     await holdingsProvider._cryptoPackCache.setCryptoPackData(pack.id, data);
//     return data;
//   }

//   List<PieChartSectionData> getPieChartSections(List<dynamic> cryptoData) {
//     List<PieChartSectionData> sections = [];
//     final packPercentages = _packPercentages[pack.id] ?? {};
//     final colors = [
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.purple,
//       Colors.orange,
//     ];

//     int colorIndex = 0;
//     for (var coin in cryptoData) {
//       final percentage = packPercentages[coin['id']] ?? 0;
//       sections.add(
//         PieChartSectionData(
//           value: percentage,
//           title: '${coin['symbol'].toUpperCase()}\n${(percentage * 100).toStringAsFixed(0)}%',
//           color: colors[colorIndex % colors.length],
//           radius: 40,
//           titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//       colorIndex++;
//     }

//     return sections;
//   }

//   static const Map<String, Map<String, double>> _packPercentages = {
//     'RAW Frontrunners': {
//       'ix-swap': 0.2,
//       'realio-network': 0.2,
//       'clearpool': 0.2,
//       'polytrade': 0.2,
//       'maple': 0.2,
//     },
//     'CeDefi-Defi & Privacy': {
//       'fideum': 0.5,
//       'oasis-network': 0.5,
//     },
//     'High Caps': {
//       'bitcoin': 0.4,
//       'ethereum': 0.4,
//       'chainlink': 0.2,
//     },
//     'ultimate_alts': {
//       'cardano': 0.3,
//       'solana': 0.3,
//       'polkadot': 0.2,
//       'avalanche-2': 0.2,
//     },
//     'high_risk_high_reward': {
//       'maga': 1,
//     },
//     'Artificial Intelligence': {
//       'near': 1,
//     },
//   };
// }

// class FAQScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FAQ'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           ExpansionTile(
//             title: Text('What is CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'CryptoPack is a selection of curated cryptocurrency portfolios designed to suit various investment strategies.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How do I invest in a CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'You can invest in a CryptoPack by selecting your desired pack and making a minimum investment as specified.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Is there a risk in investing in cryptocurrencies?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, investing in cryptocurrencies carries risks due to their volatile nature. It is advisable to do thorough research and invest wisely.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How is the percentage change calculated?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'The percentage change is calculated based on the change in the value of the cryptocurrencies in the pack over the past 24 hours.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Can I track my investments?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, you can track your investments through the "My CryptoPacks" section, which will be available soon.',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HoldingsScreen extends StatefulWidget {
//   @override
//   _HoldingsScreenState createState() => _HoldingsScreenState();
// }

// class _HoldingsScreenState extends State<HoldingsScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _averagePriceController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _quantityController.dispose();
//     _averagePriceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: _buildHoldingsTheme(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My Portfolio'),
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             _buildSearchBar(),
//             _buildPortfolioOverview(),
//             Expanded(
//               child: Consumer<HoldingsProvider>(
//                 builder: (context, provider, child) {
//                   return Column(
//                     children: [
//                       if (provider.isSearching)
//                         _buildSearchResults(provider)
//                       else
//                         _buildHoldingsList(provider),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ThemeData _buildHoldingsTheme() {
//     return ThemeData(
//       primaryColor: const Color(0xFF6200EE),
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: Color(0xFF03DAC6),
//       ),
//       scaffoldBackgroundColor: Color(0xFFF5F5F5),
//       cardTheme: CardTheme(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6200EE)),
//         titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//         bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => context.read<HoldingsProvider>().searchCrypto(value),
//         decoration: InputDecoration(
//           hintText: 'Search cryptocurrencies...',
//           prefixIcon: Icon(Icons.search),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _searchController.clear();
//               context.read<HoldingsProvider>().searchCrypto('');
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPortfolioOverview() {
//     return Consumer<HoldingsProvider>(
//       builder: (context, provider, child) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Portfolio Value',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '${provider.getTotalValue().toStringAsFixed(2)} USD',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchResults(HoldingsProvider provider) {
//     return Expanded(
//       child: provider.isLoadingSearch
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: provider.searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = provider.searchResults[index];
//                 return ListTile(
//                   leading: CachedNetworkImage(
//                     imageUrl: result['large'] ?? '',
//                     width: 40,
//                     height: 40,
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                   title: Text(result['name']),
//                   subtitle: Text(result['symbol']),
//                   onTap: () => _showAddHoldingDialog(context, result, provider),
//                 );
//               },
//             ),
//     );
//   }

// Widget _buildHoldingsList(HoldingsProvider provider) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: provider.holdings.length,
//         itemBuilder: (context, index) {
//           final holding = provider.holdings[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     holding.name,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   Text(
//                     holding.symbol.toUpperCase(),
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Quantity: ${holding.quantity.toStringAsFixed(4)}'),
//                       Text('Avg. Price: ${holding.averagePrice.toStringAsFixed(2)} USD'),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Current Value: ${holding.currentValue.toStringAsFixed(2)} USD'),
//                       Text(
//                         'P/L: ${holding.profitLoss.toStringAsFixed(2)} USD',
//                         style: TextStyle(
//                           color: holding.profitLoss >= 0 ? Colors.green : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: false,
//                           holding: holding,
//                         ),
//                         child: Text('Add'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: true,
//                           holding: holding,
//                         ),
//                         child: Text('Edit'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showRemoveHoldingDialog(context, holding, provider),
//                         child: Text('Remove'),
//                         style: TextButton.styleFrom(foregroundColor: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//  void _showAddHoldingDialog(BuildContext context, Map<String, dynamic>? result, HoldingsProvider provider, {bool isEdit = false, CryptoHolding? holding}) {
//   if (isEdit) {
//     _quantityController.text = '';
//     _averagePriceController.text = holding!.averagePrice.toString();
//   } else {
//     _quantityController.clear();
//     _averagePriceController.clear();
//   }

//   String operation = 'Add';

//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Text(isEdit ? 'Edit Holding' : 'Add Holding'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isEdit)
//                   DropdownButton<String>(
//                     value: operation,
//                     items: ['Add', 'Subtract'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         operation = newValue!;
//                       });
//                     },
//                   ),
//                 TextField(
//                   controller: _quantityController,
//                   decoration: InputDecoration(
//                     labelText: 'Quantity',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _averagePriceController,
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   final newQuantity = double.tryParse(_quantityController.text) ?? 0;
//                   final newPrice = double.tryParse(_averagePriceController.text) ?? 0;

//                   if (isEdit) {
//                     final operationMultiplier = operation == 'Add' ? 1 : -1;
//                     final totalValue = (holding!.quantity * holding.averagePrice) + (newQuantity * newPrice * operationMultiplier);
//                     final totalQuantity = holding.quantity + (newQuantity * operationMultiplier);

//                     if (totalQuantity <= 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Cannot subtract more than available quantity')),
//                       );
//                       return;
//                     }

//                     final newAveragePrice = totalValue / totalQuantity;

//                     provider.updateHolding(
//                       holding.symbol,
//                       totalQuantity,
//                       newAveragePrice,
//                     );
//                   } else {
//                     provider.addHolding(
//                       result!['id'],
//                       result['name'],
//                       newQuantity,
//                       newPrice,
//                     );
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text(isEdit ? 'Update' : 'Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
//  void _showRemoveHoldingDialog(BuildContext context, CryptoHolding holding, HoldingsProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Holding'),
//         content: Text('Are you sure you want to remove ${holding.name} from your portfolio?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//             style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               provider.removeHolding(holding.symbol);
//               Navigator.pop(context);
//             },
//             child: Text('Remove'),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CryptoPackScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 15, 14, 14),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'android/logo (1).jpg',
//               width: MediaQuery.of(context).size.width * 0.4,
//               height: MediaQuery.of(context).size.width * 0.4,
//             ),
//             SizedBox(height: 24),
//             Text(
//               'CryptoForYou',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 238, 242, 244),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// void main() async {
//  // WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://pajnoqsxkpaujmdskmjy.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBham5vcXN4a3BhdWptZHNrbWp5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDE3Mjk0NywiZXhwIjoyMDM1NzQ4OTQ3fQ.uZY4kBkg-yu8z29Xt8DLqtvkalD-FmMQyMjMzr8WTmM',
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) {
//         final provider = HoldingsProvider()..fetchHoldings();
//         provider.preloadCryptoPacks(_cryptoPacks);
//         return provider;
//       },

//       child: MyApp(),
//     ),
//   );
// }
//  final supabase = Supabase.instance.client;//////////////////////////////////////////////////////////////////////////////
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CryptoPack',
//       theme: AppTheme.lightTheme,
//       home: SignInPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// import 'profile.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:dio/dio.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'login.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final List<CryptoPack> _cryptoPacks = [
//        CryptoPack(
//     name: 'RAW Frontrunners',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['ix-swap', 'realio-network', 'clearpool', 'polytrade', 'maple'],
//     about: 'RAW Frontrunners pack focuses on cryptocurrencies that are leading the way in terms of innovation and market influence.',
//     id: 'RAW Frontrunners',
//   ),
//   CryptoPack(
//     name: 'CeDefi-Defi & Privacy',
//     description: 'Leading DeFi and privacy tokens',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Very High',
//     icon: Icons.security,
//     coinIds: ['fideum', 'oasis-network'],
//     about: 'CeDefi-Defi & Privacy pack includes top-performing tokens in the DeFi and privacy space.',
//     id: 'CeDefi-Defi & Privacy',
//   ),
//   CryptoPack(
//     name: 'High Caps',
//     description: 'The market-leading cryptocurrencies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.star,
//     coinIds: ['bitcoin', 'ethereum', 'chainlink'],
//     about: 'high caps pack contains the most prominent cryptocurrencies, suitable for beginners and experienced investors.',
//     id: 'High Caps',
//   ),
//   CryptoPack(
//     name: 'Ultimate Alts of Tomorrow',
//     description: 'The undisputed Alt Coin selection',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.monetization_on,
//     coinIds: ['cardano', 'solana', 'polkadot', 'avalanche-2'],
//     about: 'Ultimate Alts pack features a selection of promising altcoins with potential for future growth.',
//     id: 'ultimate_alts',
//   ),
//    CryptoPack(
//     name: 'HighRiskHighReward',
//     description: 'High-risk investments with potential for high rewards',
//     RecommendedInvestment: 250.00,
//     percentageChange: 0.0,
//     trend: 'High',
//     icon: Icons.warning,
//     coinIds: ['maga', ],
//     about: 'HighRiskHighReward pack includes volatile cryptocurrencies with the potential for significant returns.',
//     id: 'high_risk_high_reward',
//   ),
//   CryptoPack(
//     name: 'Artificial Intelligence',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 500.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['near'],
//     about: 'Artificial Intelligence pack focuses on cryptocurrencies that are leading the way in terms of innovation in artificial intelligence and market influence.',
//     id: 'Artificial Intelligence',
//   )
//   ];
// class ApiError extends Error {
//   final String message;
//   final int? statusCode;

//   ApiError({required this.message, this.statusCode});
// }

// class CryptoPack {
//   final String name;
//   final String description;
//   final double RecommendedInvestment;
//   double percentageChange;
//   final String trend;
//   final IconData icon;
//   final String id;
//   final String about;
//   final List<String> coinIds;

//   CryptoPack({
//     required this.name,
//     required this.description,
//     required this.RecommendedInvestment,
//     required this.percentageChange,
//     required this.trend,
//     required this.icon,
//     required this.id,
//     required this.about,
//     required this.coinIds,
//   });
// }

// class CryptoHolding {
//   final String symbol;
//   final String name;
//   double quantity;
//   double averagePrice;
//   double currentPrice;
//   double currentValue;
//   double investedAmount;
//   double profitLoss;
//   double dailyProfitLoss;

//   CryptoHolding({
//     required this.symbol,
//     required this.name,
//     required this.quantity,
//     required this.averagePrice,
//     required this.currentPrice,
//     required this.currentValue,
//     required this.investedAmount,
//     required this.profitLoss,
//     required this.dailyProfitLoss,
//   });

//   factory CryptoHolding.fromJson(Map<String, dynamic> json) {
//     return CryptoHolding(
//       symbol: json['symbol'],
//       name: json['name'],
//       quantity: json['quantity'],
//       averagePrice: json['averagePrice'],
//       currentPrice: json['currentPrice'],
//       currentValue: json['currentValue'],
//       investedAmount: json['investedAmount'],
//       profitLoss: json['profitLoss'],
//       dailyProfitLoss: json['dailyProfitLoss'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'symbol': symbol,
//       'name': name,
//       'quantity': quantity,
//       'averagePrice': averagePrice,
//       'currentPrice': currentPrice,
//       'currentValue': currentValue,
//       'investedAmount': investedAmount,
//       'profitLoss': profitLoss,
//       'dailyProfitLoss': dailyProfitLoss,
//     };
//   }
// }
// class DetailedCryptoData {
//   final String id;
//   final String name;
//   final String symbol;
//   final String description;
//   final String image;
//   final double currentPrice;
//   final double marketCap;
//   final double tradingVolume;
//   final double priceChange24h;
//   final double marketCapRank;
//   final List<List<double>> historicalData;
//   final Map<String, dynamic> communityData;
//   final Map<String, dynamic> developerData;

//   DetailedCryptoData({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.description,
//     required this.image,
//     required this.currentPrice,
//     required this.marketCap,
//     required this.tradingVolume,
//     required this.priceChange24h,
//     required this.marketCapRank,
//     required this.historicalData,
//     required this.communityData,
//     required this.developerData,
//   });

//   factory DetailedCryptoData.fromJson(Map<String, dynamic> json, List<dynamic> historicalData) {
//     return DetailedCryptoData(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       symbol: json['symbol'] ?? '',
//       description: json['description']['en'] ?? '',
//       image: json['image']['large'] ?? '',
//       currentPrice: (json['market_data']['current_price']['usd'] ?? 0).toDouble(),
//       marketCap: (json['market_data']['market_cap']['usd'] ?? 0).toDouble(),
//       tradingVolume: (json['market_data']['total_volume']['usd'] ?? 0).toDouble(),
//       priceChange24h: (json['market_data']['price_change_percentage_24h'] ?? 0).toDouble(),
//       marketCapRank: (json['market_cap_rank'] ?? 0).toDouble(),
//       historicalData: (historicalData as List<dynamic>).map((data) =>
//         [data[0] as double? ?? 0.0, data[1] as double? ?? 0.0]).toList(),
//       communityData: json['community_data'] ?? {},
//       developerData: json['developer_data'] ?? {},
//     );
//   }
// }
// class CachedData<T> {
//   final T data;
//   final DateTime timestamp;

//   CachedData({required this.data, required this.timestamp});
// }

// class CryptoPackCache {
//   final Map<String, CachedData<List<dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 15);

//   Future<void> setCryptoPackData(String packId, List<dynamic> data) async {
//     _cache[packId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   List<dynamic>? getCryptoPackData(String packId) {
//     if (_cache.containsKey(packId) && !_isCacheExpired(packId)) {
//       return _cache[packId]!.data;
//     }
//     return null;
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class CryptoApiService {
//   final Dio _dio = Dio();
//   final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 5);

//   CryptoApiService() {
//     _dio.interceptors.add(InterceptorsWrapper(
//       onError: (DioError e, ErrorInterceptorHandler handler) {
//         ApiError error;
//         if (e.response != null) {
//           error = ApiError(
//             message: e.response!.data['message'] ?? 'Unknown error',
//             statusCode: e.response!.statusCode
//           );
//         } else {
//           error = ApiError(message: e.message ?? 'Unknown error');
//         }
//         throw error;
//       },
//     ));
//   }

//   Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
//     if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
//       return _cache[symbol]!.data;
//     }

//     try {
//       final response = await _dio.get(
//           'https://api.coingecko.com/api/v3/simple/price?ids=$symbol&vs_currencies=usd&include_24hr_change=true');
//       final data = {
//         'currentPrice': response.data[symbol]['usd'],
//         'priceChange24h': response.data[symbol]['usd_24h_change'],
//       };
//       _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
//       return data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to load price data');
//     }
//   }

//   Future<Map<String, dynamic>> searchCrypto(String query) async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/search?query=$query');
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to search crypto');
//     }
//   }

//   Future<List<dynamic>> fetchCryptoData(String coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds,
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchBatchCryptoData(List<String> coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds.join(','),
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return Map.fromIterable(response.data, key: (item) => item['id'], value: (item) => item);
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch batch data');
//     }
//   }
// Future<Map<String, dynamic>> fetchDetailedCoinData(String coinId) async {
//   try {
//     final response = await _dio.get(
//       'https://api.coingecko.com/api/v3/coins/$coinId',
//       queryParameters: {
//         'localization': 'false',
//         'tickers': 'false',
//         'market_data': 'true',
//         'community_data': 'true',
//         'developer_data': 'true',
//       },
//     );
//     return response.data ?? {};
//   } catch (e) {
//     print('Error fetching detailed coin data: $e');
//     throw ApiError(message: 'Failed to fetch detailed coin data');
//   }
// }

// Future<List<dynamic>> fetchCoinMarketChart(String coinId, int days) async {
//   try {
//     final response = await _dio.get(
//       'https://api.coingecko.com/api/v3/coins/$coinId/market_chart',
//       queryParameters: {
//         'vs_currency': 'usd',
//         'days': days,
//       },
//     );
//     return response.data['prices'] ?? [];
//   } catch (e) {
//     print('Error fetching market chart data: $e');
//     throw ApiError(message: 'Failed to fetch market chart data');
//   }
// }

//   Future<Map<String, dynamic>> fetchGlobalData() async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/global');
//       return response.data['data'];
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch global data');
//     }
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class HoldingsProvider with ChangeNotifier {
//   final CryptoApiService _apiService = CryptoApiService();
//   final CryptoPackCache _cryptoPackCache = CryptoPackCache();
//   List<CryptoHolding> _holdings = [];
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _isSearching = false;
//   bool _isLoadingSearch = false;

//   List<CryptoHolding> get holdings => _holdings;
//   List<Map<String, dynamic>> get searchResults => _searchResults;
//   bool get isSearching => _isSearching;
//   bool get isLoadingSearch => _isLoadingSearch;

//   Future<void> fetchHoldings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = prefs.getStringList('holdings') ?? [];
//       _holdings = holdingsJson
//           .map((json) => CryptoHolding.fromJson(jsonDecode(json)))
//           .toList();
//       await _updateHoldingsData();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching holdings: $e');
//     }
//   }

//   Future<void> _updateHoldingsData() async {
//     final futures = _holdings.map((holding) => _apiService.getCurrentPriceData(holding.symbol)).toList();
//     final results = await Future.wait(futures);

//     for (var i = 0; i < _holdings.length; i++) {
//       try {
//         final priceData = results[i];
//         _holdings[i].currentPrice = priceData['currentPrice'].toDouble();
//         _holdings[i].currentValue = _holdings[i].quantity * _holdings[i].currentPrice;
//         _holdings[i].profitLoss = _holdings[i].currentValue - _holdings[i].investedAmount;
//         _holdings[i].dailyProfitLoss = _holdings[i].currentValue * (priceData['priceChange24h'] / 100);
//       } catch (e) {
//         print('Error updating holding data for ${_holdings[i].symbol}: $e');
//       }
//     }
//   }

//   Future<void> searchCrypto(String searchTerm) async {
//     _isSearching = searchTerm.isNotEmpty;
//     if (_isSearching) {
//       _isLoadingSearch = true;
//       notifyListeners();
//       try {
//         final results = await _apiService.searchCrypto(searchTerm);
//         _searchResults = List<Map<String, dynamic>>.from(results['coins']);
//       } catch (e) {
//         print('Error searching crypto: $e');
//         _searchResults = [];
//       }
//       _isLoadingSearch = false;
//     } else {
//       _searchResults = [];
//     }
//     notifyListeners();
//   }

//   Future<void> addHolding(String symbol, String name, double quantity, double averagePrice) async {
//       try {
//       final priceData = await _apiService.getCurrentPriceData(symbol);
//       final currentPrice = priceData['currentPrice'].toDouble();
//       final currentValue = quantity * currentPrice;
//       final investedAmount = quantity * averagePrice;
//       final profitLoss = currentValue - investedAmount;
//       final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//       final existingHoldingIndex = _holdings.indexWhere((holding) => holding.symbol == symbol);

//       if (existingHoldingIndex != -1) {
//         final existingHolding = _holdings[existingHoldingIndex];
//         final newQuantity = existingHolding.quantity + quantity;
//         final newInvestedAmount = existingHolding.investedAmount + investedAmount;
//         final newAveragePrice = newInvestedAmount / newQuantity;

//         _holdings[existingHoldingIndex].quantity = newQuantity;
//         _holdings[existingHoldingIndex].averagePrice = newAveragePrice;
//         _holdings[existingHoldingIndex].investedAmount = newInvestedAmount;
//         _holdings[existingHoldingIndex].currentPrice = currentPrice;
//         _holdings[existingHoldingIndex].currentValue = newQuantity * currentPrice;
//         _holdings[existingHoldingIndex].profitLoss = _holdings[existingHoldingIndex].currentValue - _holdings[existingHoldingIndex].investedAmount;
//         _holdings[existingHoldingIndex].dailyProfitLoss = _holdings[existingHoldingIndex].currentValue * (priceData['priceChange24h'] / 100);
//       } else {
//         final newHolding = CryptoHolding(
//           symbol: symbol,
//           name: name,
//           quantity: quantity,
//           averagePrice: averagePrice,
//           currentPrice: currentPrice,
//           currentValue: currentValue,
//           investedAmount: investedAmount,
//           profitLoss: profitLoss,
//           dailyProfitLoss: dailyProfitLoss,
//         );

//         _holdings.add(newHolding);
//       }

//       await _saveHoldings();
//       notifyListeners();
//     } catch (e) {
//       print('Error adding holding: $e');
//     }
//   }

//   Future<void> updateHolding(String symbol, double quantity, double averagePrice) async {
//      final index = _holdings.indexWhere((holding) => holding.symbol == symbol);
//     if (index != -1) {
//       try {
//         final priceData = await _apiService.getCurrentPriceData(symbol);
//         final currentValue = quantity * priceData['currentPrice'];
//         final investedAmount = quantity * averagePrice;
//         final profitLoss = currentValue - investedAmount;
//         final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//         _holdings[index].quantity = quantity;
//         _holdings[index].averagePrice = averagePrice;
//         _holdings[index].currentPrice = priceData['currentPrice'];
//         _holdings[index].currentValue = currentValue;
//         _holdings[index].investedAmount = investedAmount;
//         _holdings[index].profitLoss = profitLoss;
//         _holdings[index].dailyProfitLoss = dailyProfitLoss;

//         await _saveHoldings();
//         notifyListeners();
//       } catch (e) {
//         print('Error updating holding: $e');
//       }
//     }
//   }

//   void removeHolding(String symbol) {
//      _holdings.removeWhere((holding) => holding.symbol == symbol);
//     _saveHoldings();
//     notifyListeners();
//   }

//   double getTotalValue() {
//     return _holdings.fold(0, (sum, holding) => sum + holding.currentValue);
//   }

//   Future<void> _saveHoldings() async {
//      try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = _holdings.map((holding) => jsonEncode(holding.toJson())).toList();
//       await prefs.setStringList('holdings', holdingsJson);
//     } catch (e) {
//       print('Error saving holdings: $e');
//     }
//   }

//   Future<void> preloadCryptoPacks(List<CryptoPack> cryptoPacks) async {
//     final allCoinIds = cryptoPacks.expand((pack) => pack.coinIds).toSet().toList();
//     try {
//       final batchData = await _apiService.fetchBatchCryptoData(allCoinIds);
//       for (var pack in cryptoPacks) {
//         final packData = pack.coinIds.map((id) => batchData[id]).toList();
//         await _cryptoPackCache.setCryptoPackData(pack.id, packData);
//       }
//     } catch (e) {
//       print('Error preloading crypto packs: $e');
//     }
//   }

// }

// class AppTheme {
//   static const primaryColor = Color(0xFF2196F3);
//   static const secondaryColor = Color(0xFF4CAF50);
//   static const backgroundColor = Color(0xFFF5F5F5);
//   static const cardColor = Colors.white;
//   static const textColor = Color(0xFF333333);
//   static const lightTextColor = Color(0xFF666666);

//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: primaryColor,
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: secondaryColor,
//       ),
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: AppBarTheme(
//         color: primaryColor,
//         elevation: 0,
//       ),
//       cardTheme: CardTheme(
//         color: cardColor,
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
//         titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
//         bodyMedium: TextStyle(color: textColor, fontSize: 14),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: primaryColor,
//         textTheme: ButtonTextTheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }

// class CryptoPackScreen extends StatefulWidget {
//   @override
//   _CryptoPackScreenState createState() => _CryptoPackScreenState();
// }

// class _CryptoPackScreenState extends State<CryptoPackScreen> {////////////////////////////////////////////////////////////////////////////////////////
//   final CryptoApiService _apiService = CryptoApiService();
//   int _currentPage = 0;
//   static const int _packsPerPage = 6;

//   @override
//   void initState() {
//     super.initState();
//     _calculatePercentageChange();
//     _preloadCryptoPacks();
//   }

//    void _preloadCryptoPacks() {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);
//     holdingsProvider.preloadCryptoPacks(_cryptoPacks);
//   }

//   void _calculatePercentageChange() async {
//     for (var pack in _cryptoPacks) {
//       try {
//         double percentageChange = await _fetchPercentageChange(pack.coinIds);
//         setState(() {
//           pack.percentageChange = percentageChange;
//         });
//       } catch (e) {
//         print('Error calculating percentage change for ${pack.name}: $e');
//         setState(() {
//           pack.percentageChange = pack.percentageChange;
//         });
//       }
//     }
//   }

//   Future<double> _fetchPercentageChange(List<String> coinIds) async {
//     try {
//       final ids = coinIds.join(',');
//       final response = await _apiService.fetchCryptoData(ids);
//       if (response.isNotEmpty) {
//         final totalChange = response.fold(0.0, (sum, coinData) {
//           return sum + (coinData['price_change_percentage_24h'] ?? 0.0);
//         });
//         return totalChange / response.length;
//       }
//       return 0.0;
//     } catch (e) {
//       print('Error fetching percentage change: $e');
//       return 0.0;
//     }
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CryptoPack', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         elevation: 0,
//       ),
//       drawer: _buildDrawer(context),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('ALL CRYPTOPACKS', style: TextStyle(fontSize: 12)),//12/////////////////////////////////////////////////////////////////////////////////////////////////////
//                       style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryColor,
//                     foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Coming soon!')),
//                         );
//                       },
//                       child: Text('MY CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.secondaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(16.0),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final packIndex = _currentPage * _packsPerPage + index;
//                   if (packIndex >= _cryptoPacks.length) {
//                     return SizedBox.shrink();
//                   }
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CryptoPackDetailScreen(pack: _cryptoPacks[packIndex]),
//                         ),
//                       );
//                     },
//                     child: CryptoPackCard(pack: _cryptoPacks[packIndex]),
//                   );
//                 },
//                 childCount: _packsPerPage,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//  Widget _buildDrawer(BuildContext context) {
//   final user = supabase.auth.currentUser;
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         UserAccountsDrawerHeader(
//           accountName: Text(user?.userMetadata?['first_name'] ?? 'User'),
//           accountEmail: Text(user?.email ?? ''),
//           currentAccountPicture: CircleAvatar(
//             backgroundImage: NetworkImage(
//               'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//             ),
//           ),
//           decoration: BoxDecoration(
//             color: AppTheme.primaryColor,
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.home),
//           title: Text('Home', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//   leading: Icon(Icons.account_circle),
//   title: Text('Profile', style: TextStyle(fontSize: 18)),
//   onTap: () {
//     Navigator.pop(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfilePage()),
//     );
//   },
// ),
//         ListTile(
//           leading: Icon(Icons.account_balance_wallet),
//           title: Text('My Portfolio', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HoldingsScreen()),
//             );
//           },
//         ),
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('FAQ', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FAQScreen()),
//               );
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.support),
//             title: Text('Help & Support', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               launch('mailto:cryptoforyouhelp@gmail.com');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CryptoPackCard extends StatelessWidget {
//   final CryptoPack pack;

//   const CryptoPackCard({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.secondaryColor.withOpacity(0.1)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(9.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       pack.name,
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(pack.icon, color: AppTheme.primaryColor),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 pack.description,
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Spacer(),
//               Text(
//                 'Rec.investement:',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//               ),
//               Text(
//                 '\$${pack.RecommendedInvestment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Change:',
//                     style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                   ),
//                   Text(
//                     '${pack.percentageChange.toStringAsFixed(2)}%',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: pack.percentageChange >= 0 ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Trend: ${pack.trend}',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CryptoPackDetailScreen(pack: pack),
//                       ),
//                     );
//                   },
//                   child: Text('Know More', style: TextStyle(fontSize: 12)),
//                   style: ElevatedButton.styleFrom(
//                backgroundColor    : AppTheme.primaryColor,
//                foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CryptoDataRepository {
//   final CryptoApiService _apiService;
//   final Map<String, CachedData<DetailedCryptoData>> _cache = {};
//   static const Duration _cacheDuration = Duration(hours: 1);

//   CryptoDataRepository(this._apiService);

//   Future<DetailedCryptoData?> getCachedDetailedCryptoData(String coinId) async {
//     final cachedData = _cache[coinId];
//     if (cachedData != null && !_isCacheExpired(cachedData.timestamp)) {
//       return cachedData.data;
//     }
//     return null;
//   }

//   Future<void> cacheDetailedCryptoData(String coinId, DetailedCryptoData data) async {
//     _cache[coinId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   bool _isCacheExpired(DateTime timestamp) {
//     return DateTime.now().difference(timestamp) > _cacheDuration;
//   }

//   Future<DetailedCryptoData> fetchDetailedCryptoData(String coinId, int days) async {
//     final coinData = await _apiService.fetchDetailedCoinData(coinId);
//     final historicalData = await _apiService.fetchCoinMarketChart(coinId, days);
//     return DetailedCryptoData.fromJson(coinData, historicalData);
//   }

//   Future<List<List<double>>> fetchAdditionalHistoricalData(String coinId, int fromDays, int toDays) async {
//   final historicalData = await _apiService.fetchCoinMarketChart(coinId, toDays);
//   return (historicalData as List<dynamic>)
//       .sublist(fromDays * 24)
//       .map((data) => [
//             (data[0] as num).toDouble(),
//             (data[1] as num).toDouble(),
//           ])
//       .toList();
// }

//   Future<String?> getNextCoinId(String currentCoinId) async {
//     return null;
//   }

//   Future<void> prefetchDetailedCryptoData(String coinId, int days) async {
//     try {
//       final data = await fetchDetailedCryptoData(coinId, days);
//       await cacheDetailedCryptoData(coinId, data);
//     } catch (e) {
//       print('Error prefetching data for $coinId: $e');
//     }
//   }
// }

// class CryptoDetailScreen extends StatefulWidget {
//   final String coinId;

//   CryptoDetailScreen({Key? key, required this.coinId}) : super(key: key);

//   @override
//   _CryptoDetailScreenState createState() => _CryptoDetailScreenState();
// }

// class _CryptoDetailScreenState extends State<CryptoDetailScreen> {
//   final CryptoApiService apiService = CryptoApiService();
//   late Future<DetailedCryptoData> _cryptoDataFuture;

//   @override
//   void initState() {
//     super.initState();
//     _cryptoDataFuture = _fetchDetailedCryptoData();
//   }

//   Future<DetailedCryptoData> _fetchDetailedCryptoData() async {
//     try {
//       final coinData = await apiService.fetchDetailedCoinData(widget.coinId);
//       return DetailedCryptoData.fromJson(coinData, []);
//     } catch (e) {
//       throw Exception('Failed to load crypto data');
//     }
//   }

//   Future<void> _refreshData() async {
//     setState(() {
//       _cryptoDataFuture = _fetchDetailedCryptoData();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crypto Details'),
//       ),
//       body: RefreshIndicator(
//         onRefresh: _refreshData,
//         child: FutureBuilder<DetailedCryptoData>(
//           future: _cryptoDataFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error loading data. Pull to refresh.'),
//               );
//             } else if (!snapshot.hasData) {
//               return Center(child: Text('No data available'));
//             }

//             final data = snapshot.data!;
//             return SingleChildScrollView(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildHeader(data),
//                   SizedBox(height: 16),
//                   _buildPriceInfo(data),
//                   SizedBox(height: 16),
//                   _buildDescription(data),
//                   SizedBox(height: 16),
//                   _buildMarketData(data),
//                   SizedBox(height: 16),
//                   _buildWebsiteLink(data),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(DetailedCryptoData data) {
//     return Row(
//       children: [
//         CachedNetworkImage(
//           imageUrl: data.image,
//           width: 50,
//           height: 50,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(data.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//               Text(data.symbol.toUpperCase(), style: TextStyle(fontSize: 16)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPriceInfo(DetailedCryptoData data) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Current Price: \$${data.currentPrice.toStringAsFixed(2)}'),
//             Text('24h Change: ${data.priceChange24h.toStringAsFixed(2)}%'),
//             Text('Market Cap: \$${data.marketCap.toStringAsFixed(0)}'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDescription(DetailedCryptoData data) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(data.description),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMarketData(DetailedCryptoData data) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Market Data', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text('Trading Volume: \$${data.tradingVolume.toStringAsFixed(0)}'),
//             Text('Market Cap Rank: ${data.marketCapRank.toInt()}'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWebsiteLink(DetailedCryptoData data) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Official Website', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             InkWell(
//               onTap: () async {
//                 final url = data.communityData['official_forum_url'] as List<dynamic>;
//                 if (url.isNotEmpty && await canLaunch(url[0])) {
//                   await launch(url[0]);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Could not launch website')),
//                   );
//                 }
//               },
//               child: Text(
//                 'Visit Website',
//                 style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CryptoPackDetailScreen extends StatelessWidget {
//   final CryptoPack pack;
//   const CryptoPackDetailScreen({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(pack.name, style: TextStyle(color: Colors.white)),
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(pack.icon, size: 80, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoCard('About', pack.about),
//                   SizedBox(height: 16),
//                   _buildInfoCard('RecommendedInvestment', '\$${pack.RecommendedInvestment.toStringAsFixed(2)}'),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Trend', pack.trend),
//                   SizedBox(height: 16),
//                   _buildInfoCard('24h Change', '${pack.percentageChange.toStringAsFixed(2)}%'),
//                   SizedBox(height: 24),
//                   Text(
//                     'Coin Distribution',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: FutureBuilder<List<dynamic>>(
//               future: _fetchCryptoData(context),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No data available', style: TextStyle(fontSize: 18)));
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         padding: EdgeInsets.all(16.0),
//                         child: PieChart(
//                           PieChartData(
//                             sections: getPieChartSections(snapshot.data!),
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                             borderData: FlBorderData(show: false),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) => _buildCoinListTile(context, snapshot.data![index]),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Investment functionality coming soon!')),
//             );
//           },
//           child: Text('Invest Now', style: TextStyle(fontSize: 18)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppTheme.primaryColor,
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(value, style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCoinListTile(BuildContext context, dynamic coin) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: coin['image'],
//           width: 40,
//           height: 40,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         title: Text(coin['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text('${coin['current_price'].toStringAsFixed(2)} USD'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
//               style: TextStyle(
//                 color: coin['price_change_percentage_24h'] >= 0 ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text('24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CryptoDetailScreen(coinId: coin['id']),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<List<dynamic>> _fetchCryptoData(BuildContext context) async {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);

//     final cachedData = holdingsProvider._cryptoPackCache.getCryptoPackData(pack.id);
//     if (cachedData != null) {
//       return cachedData;
//     }

//     final cryptoApiService = CryptoApiService();
//     final coinIds = _packPercentages[pack.id]?.keys.join(',') ?? '';
//     final data = await cryptoApiService.fetchCryptoData(coinIds);
//     await holdingsProvider._cryptoPackCache.setCryptoPackData(pack.id, data);
//     return data;
//   }

//   List<PieChartSectionData> getPieChartSections(List<dynamic> cryptoData) {
//     List<PieChartSectionData> sections = [];
//     final packPercentages = _packPercentages[pack.id] ?? {};
//     final colors = [
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.purple,
//       Colors.orange,
//     ];

//     int colorIndex = 0;
//     for (var coin in cryptoData) {
//       final percentage = packPercentages[coin['id']] ?? 0;
//       sections.add(
//         PieChartSectionData(
//           value: percentage,
//           title: '${coin['symbol'].toUpperCase()}\n${(percentage * 100).toStringAsFixed(0)}%',
//           color: colors[colorIndex % colors.length],
//           radius: 40,
//           titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//       colorIndex++;
//     }

//     return sections;
//   }

//   static const Map<String, Map<String, double>> _packPercentages = {
//     'RAW Frontrunners': {
//       'ix-swap': 0.2,
//       'realio-network': 0.2,
//       'clearpool': 0.2,
//       'polytrade': 0.2,
//       'maple': 0.2,
//     },
//     'CeDefi-Defi & Privacy': {
//       'fideum': 0.5,
//       'oasis-network': 0.5,
//     },
//     'High Caps': {
//       'bitcoin': 0.4,
//       'ethereum': 0.4,
//       'chainlink': 0.2,
//     },
//     'ultimate_alts': {
//       'cardano': 0.3,
//       'solana': 0.3,
//       'polkadot': 0.2,
//       'avalanche-2': 0.2,
//     },
//     'high_risk_high_reward': {
//       'maga': 1,
//     },
//     'Artificial Intelligence': {
//       'near': 1,
//     },
//   };
// }

// class FAQScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FAQ'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           ExpansionTile(
//             title: Text('What is CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'CryptoPack is a selection of curated cryptocurrency portfolios designed to suit various investment strategies.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How do I invest in a CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'You can invest in a CryptoPack by selecting your desired pack and making a minimum investment as specified.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Is there a risk in investing in cryptocurrencies?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, investing in cryptocurrencies carries risks due to their volatile nature. It is advisable to do thorough research and invest wisely.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How is the percentage change calculated?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'The percentage change is calculated based on the change in the value of the cryptocurrencies in the pack over the past 24 hours.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Can I track my investments?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, you can track your investments through the "My CryptoPacks" section, which will be available soon.',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HoldingsScreen extends StatefulWidget {
//   @override
//   _HoldingsScreenState createState() => _HoldingsScreenState();
// }

// class _HoldingsScreenState extends State<HoldingsScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _averagePriceController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _quantityController.dispose();
//     _averagePriceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: _buildHoldingsTheme(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My Portfolio'),
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             _buildSearchBar(),
//             _buildPortfolioOverview(),
//             Expanded(
//               child: Consumer<HoldingsProvider>(
//                 builder: (context, provider, child) {
//                   return Column(
//                     children: [
//                       if (provider.isSearching)
//                         _buildSearchResults(provider)
//                       else
//                         _buildHoldingsList(provider),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ThemeData _buildHoldingsTheme() {
//     return ThemeData(
//       primaryColor: const Color(0xFF6200EE),
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: Color(0xFF03DAC6),
//       ),
//       scaffoldBackgroundColor: Color(0xFFF5F5F5),
//       cardTheme: CardTheme(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6200EE)),
//         titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//         bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => context.read<HoldingsProvider>().searchCrypto(value),
//         decoration: InputDecoration(
//           hintText: 'Search cryptocurrencies...',
//           prefixIcon: Icon(Icons.search),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _searchController.clear();
//               context.read<HoldingsProvider>().searchCrypto('');
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPortfolioOverview() {
//     return Consumer<HoldingsProvider>(
//       builder: (context, provider, child) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Portfolio Value',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '${provider.getTotalValue().toStringAsFixed(2)} USD',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchResults(HoldingsProvider provider) {
//     return Expanded(
//       child: provider.isLoadingSearch
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: provider.searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = provider.searchResults[index];
//                 return ListTile(
//                   leading: CachedNetworkImage(
//                     imageUrl: result['large'] ?? '',
//                     width: 40,
//                     height: 40,
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                   title: Text(result['name']),
//                   subtitle: Text(result['symbol']),
//                   onTap: () => _showAddHoldingDialog(context, result, provider),
//                 );
//               },
//             ),
//     );
//   }

// Widget _buildHoldingsList(HoldingsProvider provider) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: provider.holdings.length,
//         itemBuilder: (context, index) {
//           final holding = provider.holdings[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     holding.name,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   Text(
//                     holding.symbol.toUpperCase(),
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Quantity: ${holding.quantity.toStringAsFixed(4)}'),
//                       Text('Avg. Price: ${holding.averagePrice.toStringAsFixed(2)} USD'),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Current Value: ${holding.currentValue.toStringAsFixed(2)} USD'),
//                       Text(
//                         'P/L: ${holding.profitLoss.toStringAsFixed(2)} USD',
//                         style: TextStyle(
//                           color: holding.profitLoss >= 0 ? Colors.green : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: false,
//                           holding: holding,
//                         ),
//                         child: Text('Add'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: true,
//                           holding: holding,
//                         ),
//                         child: Text('Edit'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showRemoveHoldingDialog(context, holding, provider),
//                         child: Text('Remove'),
//                         style: TextButton.styleFrom(foregroundColor: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//  void _showAddHoldingDialog(BuildContext context, Map<String, dynamic>? result, HoldingsProvider provider, {bool isEdit = false, CryptoHolding? holding}) {
//   if (isEdit) {
//     _quantityController.text = '';
//     _averagePriceController.text = holding!.averagePrice.toString();
//   } else {
//     _quantityController.clear();
//     _averagePriceController.clear();
//   }

//   String operation = 'Add';

//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Text(isEdit ? 'Edit Holding' : 'Add Holding'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isEdit)
//                   DropdownButton<String>(
//                     value: operation,
//                     items: ['Add', 'Subtract'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         operation = newValue!;
//                       });
//                     },
//                   ),
//                 TextField(
//                   controller: _quantityController,
//                   decoration: InputDecoration(
//                     labelText: 'Quantity',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _averagePriceController,
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   final newQuantity = double.tryParse(_quantityController.text) ?? 0;
//                   final newPrice = double.tryParse(_averagePriceController.text) ?? 0;

//                   if (isEdit) {
//                     final operationMultiplier = operation == 'Add' ? 1 : -1;
//                     final totalValue = (holding!.quantity * holding.averagePrice) + (newQuantity * newPrice * operationMultiplier);
//                     final totalQuantity = holding.quantity + (newQuantity * operationMultiplier);

//                     if (totalQuantity <= 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Cannot subtract more than available quantity')),
//                       );
//                       return;
//                     }

//                     final newAveragePrice = totalValue / totalQuantity;

//                     provider.updateHolding(
//                       holding.symbol,
//                       totalQuantity,
//                       newAveragePrice,
//                     );
//                   } else {
//                     provider.addHolding(
//                       result!['id'],
//                       result['name'],
//                       newQuantity,
//                       newPrice,
//                     );
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text(isEdit ? 'Update' : 'Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
//  void _showRemoveHoldingDialog(BuildContext context, CryptoHolding holding, HoldingsProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Holding'),
//         content: Text('Are you sure you want to remove ${holding.name} from your portfolio?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//             style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               provider.removeHolding(holding.symbol);
//               Navigator.pop(context);
//             },
//             child: Text('Remove'),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CryptoPackScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 15, 14, 14),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'android/logo (1).jpg',
//               width: MediaQuery.of(context).size.width * 0.4,
//               height: MediaQuery.of(context).size.width * 0.4,
//             ),
//             SizedBox(height: 24),
//             Text(
//               'CryptoForYou',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 238, 242, 244),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// void main() async {
//  // WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://pajnoqsxkpaujmdskmjy.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBham5vcXN4a3BhdWptZHNrbWp5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDE3Mjk0NywiZXhwIjoyMDM1NzQ4OTQ3fQ.uZY4kBkg-yu8z29Xt8DLqtvkalD-FmMQyMjMzr8WTmM',
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) {
//         final provider = HoldingsProvider()..fetchHoldings();
//         provider.preloadCryptoPacks(_cryptoPacks);
//         return provider;
//       },

//       child: MyApp(),
//     ),
//   );
// }
//  final supabase = Supabase.instance.client;//////////////////////////////////////////////////////////////////////////////
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CryptoPack',
//       theme: AppTheme.lightTheme,
//       home: SignInPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// import 'package:shimmer/shimmer.dart';
// import 'package:http/http.dart' as http;
// import 'profile.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:dio/dio.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'login.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final List<CryptoPack> _cryptoPacks = [
//        CryptoPack(
//     name: 'RAW Frontrunners',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['ix-swap', 'realio-network', 'clearpool', 'polytrade', 'maple'],
//     about: 'RAW Frontrunners pack focuses on cryptocurrencies that are leading the way in terms of innovation and market influence.',
//     id: 'RAW Frontrunners',
//   ),
//   CryptoPack(
//     name: 'CeDefi-Defi & Privacy',
//     description: 'Leading DeFi and privacy tokens',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Very High',
//     icon: Icons.security,
//     coinIds: ['fideum', 'oasis-network'],
//     about: 'CeDefi-Defi & Privacy pack includes top-performing tokens in the DeFi and privacy space.',
//     id: 'CeDefi-Defi & Privacy',
//   ),
//   CryptoPack(
//     name: 'High Caps',
//     description: 'The market-leading cryptocurrencies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.star,
//     coinIds: ['bitcoin', 'ethereum', 'chainlink'],
//     about: 'high caps pack contains the most prominent cryptocurrencies, suitable for beginners and experienced investors.',
//     id: 'High Caps',
//   ),
//   CryptoPack(
//     name: 'Ultimate Alts of Tomorrow',
//     description: 'The undisputed Alt Coin selection',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.monetization_on,
//     coinIds: ['cardano', 'solana', 'polkadot', 'avalanche-2'],
//     about: 'Ultimate Alts pack features a selection of promising altcoins with potential for future growth.',
//     id: 'ultimate_alts',
//   ),
//    CryptoPack(
//     name: 'HighRiskHighReward',
//     description: 'High-risk investments with potential for high rewards',
//     RecommendedInvestment: 250.00,
//     percentageChange: 0.0,
//     trend: 'High',
//     icon: Icons.warning,
//     coinIds: ['maga', ],
//     about: 'HighRiskHighReward pack includes volatile cryptocurrencies with the potential for significant returns.',
//     id: 'high_risk_high_reward',
//   ),
//   CryptoPack(
//     name: 'Artificial Intelligence',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 500.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['near'],
//     about: 'Artificial Intelligence pack focuses on cryptocurrencies that are leading the way in terms of innovation in artificial intelligence and market influence.',
//     id: 'Artificial Intelligence',
//   )
//   ];
// class ApiError extends Error {
//   final String message;
//   final int? statusCode;

//   ApiError({required this.message, this.statusCode});
// }

// class CryptoPack {
//   final String name;
//   final String description;
//   final double RecommendedInvestment;
//   double percentageChange;
//   final String trend;
//   final IconData icon;
//   final String id;
//   final String about;
//   final List<String> coinIds;

//   CryptoPack({
//     required this.name,
//     required this.description,
//     required this.RecommendedInvestment,
//     required this.percentageChange,
//     required this.trend,
//     required this.icon,
//     required this.id,
//     required this.about,
//     required this.coinIds,
//   });
// }

// class CryptoHolding {
//   final String symbol;
//   final String name;
//   double quantity;
//   double averagePrice;
//   double currentPrice;
//   double currentValue;
//   double investedAmount;
//   double profitLoss;
//   double dailyProfitLoss;

//   CryptoHolding({
//     required this.symbol,
//     required this.name,
//     required this.quantity,
//     required this.averagePrice,
//     required this.currentPrice,
//     required this.currentValue,
//     required this.investedAmount,
//     required this.profitLoss,
//     required this.dailyProfitLoss,
//   });

//   factory CryptoHolding.fromJson(Map<String, dynamic> json) {
//     return CryptoHolding(
//       symbol: json['symbol'],
//       name: json['name'],
//       quantity: json['quantity'],
//       averagePrice: json['averagePrice'],
//       currentPrice: json['currentPrice'],
//       currentValue: json['currentValue'],
//       investedAmount: json['investedAmount'],
//       profitLoss: json['profitLoss'],
//       dailyProfitLoss: json['dailyProfitLoss'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'symbol': symbol,
//       'name': name,
//       'quantity': quantity,
//       'averagePrice': averagePrice,
//       'currentPrice': currentPrice,
//       'currentValue': currentValue,
//       'investedAmount': investedAmount,
//       'profitLoss': profitLoss,
//       'dailyProfitLoss': dailyProfitLoss,
//     };
//   }
// }
// class DetailedCryptoData {
//   final String id;
//   final String name;
//   final String symbol;
//   final String description;
//   final String image;
//   final double currentPrice;
//   final double marketCap;
//   final double tradingVolume;
//   final double priceChange24h;
//   final double marketCapRank;
//   final List<List<double>> historicalData;
//   final Map<String, dynamic> communityData;
//   final Map<String, dynamic> developerData;

//   DetailedCryptoData({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.description,
//     required this.image,
//     required this.currentPrice,
//     required this.marketCap,
//     required this.tradingVolume,
//     required this.priceChange24h,
//     required this.marketCapRank,
//     required this.historicalData,
//     required this.communityData,
//     required this.developerData,
//   });

//   factory DetailedCryptoData.fromJson(Map<String, dynamic> json, List<dynamic> historicalData) {
//     return DetailedCryptoData(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       symbol: json['symbol'] ?? '',
//       description: json['description']['en'] ?? '',
//       image: json['image']['large'] ?? '',
//       currentPrice: (json['market_data']['current_price']['usd'] ?? 0).toDouble(),
//       marketCap: (json['market_data']['market_cap']['usd'] ?? 0).toDouble(),
//       tradingVolume: (json['market_data']['total_volume']['usd'] ?? 0).toDouble(),
//       priceChange24h: (json['market_data']['price_change_percentage_24h'] ?? 0).toDouble(),
//       marketCapRank: (json['market_cap_rank'] ?? 0).toDouble(),
//       historicalData: (historicalData as List<dynamic>).map((data) =>
//         [data[0] as double? ?? 0.0, data[1] as double? ?? 0.0]).toList(),
//       communityData: json['community_data'] ?? {},
//       developerData: json['developer_data'] ?? {},
//     );
//   }
// }
// class CachedData<T> {
//   final T data;
//   final DateTime timestamp;

//   CachedData({required this.data, required this.timestamp});
// }

// class CryptoPackCache {
//   final Map<String, CachedData<List<dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 15);

//   Future<void> setCryptoPackData(String packId, List<dynamic> data) async {
//     _cache[packId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   List<dynamic>? getCryptoPackData(String packId) {
//     if (_cache.containsKey(packId) && !_isCacheExpired(packId)) {
//       return _cache[packId]!.data;
//     }
//     return null;
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class CryptoApiService {
//   final Dio _dio = Dio();
//   final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 5);

//   CryptoApiService() {
//     _dio.interceptors.add(InterceptorsWrapper(
//       onError: (DioError e, ErrorInterceptorHandler handler) {
//         ApiError error;
//         if (e.response != null) {
//           error = ApiError(
//             message: e.response!.data['message'] ?? 'Unknown error',
//             statusCode: e.response!.statusCode
//           );
//         } else {
//           error = ApiError(message: e.message ?? 'Unknown error');
//         }
//         throw error;
//       },
//     ));
//   }

//   Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
//     if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
//       return _cache[symbol]!.data;
//     }

//     try {
//       final response = await _dio.get(
//           'https://api.coingecko.com/api/v3/simple/price?ids=$symbol&vs_currencies=usd&include_24hr_change=true');
//       final data = {
//         'currentPrice': response.data[symbol]['usd'],
//         'priceChange24h': response.data[symbol]['usd_24h_change'],
//       };
//       _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
//       return data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to load price data');
//     }
//   }

//   Future<Map<String, dynamic>> searchCrypto(String query) async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/search?query=$query');
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to search crypto');
//     }
//   }

//   Future<List<dynamic>> fetchCryptoData(String coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds,
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchBatchCryptoData(List<String> coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds.join(','),
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return Map.fromIterable(response.data, key: (item) => item['id'], value: (item) => item);
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch batch data');
//     }
//   }
// Future<Map<String, dynamic>> fetchDetailedCoinData(String coinId) async {
//   try {
//     final response = await _dio.get(
//       'https://api.coingecko.com/api/v3/coins/$coinId',
//       queryParameters: {
//         'localization': 'false',
//         'tickers': 'false',
//         'market_data': 'true',
//         'community_data': 'true',
//         'developer_data': 'true',
//       },
//     );
//     return response.data ?? {};
//   } catch (e) {
//     print('Error fetching detailed coin data: $e');
//     throw ApiError(message: 'Failed to fetch detailed coin data');
//   }
// }

// Future<List<dynamic>> fetchCoinMarketChart(String coinId, int days) async {
//   try {
//     final response = await _dio.get(
//       'https://api.coingecko.com/api/v3/coins/$coinId/market_chart',
//       queryParameters: {
//         'vs_currency': 'usd',
//         'days': days,
//       },
//     );
//     return response.data['prices'] ?? [];
//   } catch (e) {
//     print('Error fetching market chart data: $e');
//     throw ApiError(message: 'Failed to fetch market chart data');
//   }
// }

//   Future<Map<String, dynamic>> fetchGlobalData() async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/global');
//       return response.data['data'];
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch global data');
//     }
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class HoldingsProvider with ChangeNotifier {
//   final CryptoApiService _apiService = CryptoApiService();
//   final CryptoPackCache _cryptoPackCache = CryptoPackCache();
//   List<CryptoHolding> _holdings = [];
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _isSearching = false;
//   bool _isLoadingSearch = false;

//   List<CryptoHolding> get holdings => _holdings;
//   List<Map<String, dynamic>> get searchResults => _searchResults;
//   bool get isSearching => _isSearching;
//   bool get isLoadingSearch => _isLoadingSearch;

//   Future<void> fetchHoldings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = prefs.getStringList('holdings') ?? [];
//       _holdings = holdingsJson
//           .map((json) => CryptoHolding.fromJson(jsonDecode(json)))
//           .toList();
//       await _updateHoldingsData();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching holdings: $e');
//     }
//   }

//   Future<void> _updateHoldingsData() async {
//     final futures = _holdings.map((holding) => _apiService.getCurrentPriceData(holding.symbol)).toList();
//     final results = await Future.wait(futures);

//     for (var i = 0; i < _holdings.length; i++) {
//       try {
//         final priceData = results[i];
//         _holdings[i].currentPrice = priceData['currentPrice'].toDouble();
//         _holdings[i].currentValue = _holdings[i].quantity * _holdings[i].currentPrice;
//         _holdings[i].profitLoss = _holdings[i].currentValue - _holdings[i].investedAmount;
//         _holdings[i].dailyProfitLoss = _holdings[i].currentValue * (priceData['priceChange24h'] / 100);
//       } catch (e) {
//         print('Error updating holding data for ${_holdings[i].symbol}: $e');
//       }
//     }
//   }

//   Future<void> searchCrypto(String searchTerm) async {
//     _isSearching = searchTerm.isNotEmpty;
//     if (_isSearching) {
//       _isLoadingSearch = true;
//       notifyListeners();
//       try {
//         final results = await _apiService.searchCrypto(searchTerm);
//         _searchResults = List<Map<String, dynamic>>.from(results['coins']);
//       } catch (e) {
//         print('Error searching crypto: $e');
//         _searchResults = [];
//       }
//       _isLoadingSearch = false;
//     } else {
//       _searchResults = [];
//     }
//     notifyListeners();
//   }

//   Future<void> addHolding(String symbol, String name, double quantity, double averagePrice) async {
//       try {
//       final priceData = await _apiService.getCurrentPriceData(symbol);
//       final currentPrice = priceData['currentPrice'].toDouble();
//       final currentValue = quantity * currentPrice;
//       final investedAmount = quantity * averagePrice;
//       final profitLoss = currentValue - investedAmount;
//       final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//       final existingHoldingIndex = _holdings.indexWhere((holding) => holding.symbol == symbol);

//       if (existingHoldingIndex != -1) {
//         final existingHolding = _holdings[existingHoldingIndex];
//         final newQuantity = existingHolding.quantity + quantity;
//         final newInvestedAmount = existingHolding.investedAmount + investedAmount;
//         final newAveragePrice = newInvestedAmount / newQuantity;

//         _holdings[existingHoldingIndex].quantity = newQuantity;
//         _holdings[existingHoldingIndex].averagePrice = newAveragePrice;
//         _holdings[existingHoldingIndex].investedAmount = newInvestedAmount;
//         _holdings[existingHoldingIndex].currentPrice = currentPrice;
//         _holdings[existingHoldingIndex].currentValue = newQuantity * currentPrice;
//         _holdings[existingHoldingIndex].profitLoss = _holdings[existingHoldingIndex].currentValue - _holdings[existingHoldingIndex].investedAmount;
//         _holdings[existingHoldingIndex].dailyProfitLoss = _holdings[existingHoldingIndex].currentValue * (priceData['priceChange24h'] / 100);
//       } else {
//         final newHolding = CryptoHolding(
//           symbol: symbol,
//           name: name,
//           quantity: quantity,
//           averagePrice: averagePrice,
//           currentPrice: currentPrice,
//           currentValue: currentValue,
//           investedAmount: investedAmount,
//           profitLoss: profitLoss,
//           dailyProfitLoss: dailyProfitLoss,
//         );

//         _holdings.add(newHolding);
//       }

//       await _saveHoldings();
//       notifyListeners();
//     } catch (e) {
//       print('Error adding holding: $e');
//     }
//   }

//   Future<void> updateHolding(String symbol, double quantity, double averagePrice) async {
//      final index = _holdings.indexWhere((holding) => holding.symbol == symbol);
//     if (index != -1) {
//       try {
//         final priceData = await _apiService.getCurrentPriceData(symbol);
//         final currentValue = quantity * priceData['currentPrice'];
//         final investedAmount = quantity * averagePrice;
//         final profitLoss = currentValue - investedAmount;
//         final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//         _holdings[index].quantity = quantity;
//         _holdings[index].averagePrice = averagePrice;
//         _holdings[index].currentPrice = priceData['currentPrice'];
//         _holdings[index].currentValue = currentValue;
//         _holdings[index].investedAmount = investedAmount;
//         _holdings[index].profitLoss = profitLoss;
//         _holdings[index].dailyProfitLoss = dailyProfitLoss;

//         await _saveHoldings();
//         notifyListeners();
//       } catch (e) {
//         print('Error updating holding: $e');
//       }
//     }
//   }

//   void removeHolding(String symbol) {
//      _holdings.removeWhere((holding) => holding.symbol == symbol);
//     _saveHoldings();
//     notifyListeners();
//   }

//   double getTotalValue() {
//     return _holdings.fold(0, (sum, holding) => sum + holding.currentValue);
//   }

//   Future<void> _saveHoldings() async {
//      try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = _holdings.map((holding) => jsonEncode(holding.toJson())).toList();
//       await prefs.setStringList('holdings', holdingsJson);
//     } catch (e) {
//       print('Error saving holdings: $e');
//     }
//   }

//   Future<void> preloadCryptoPacks(List<CryptoPack> cryptoPacks) async {
//     final allCoinIds = cryptoPacks.expand((pack) => pack.coinIds).toSet().toList();
//     try {
//       final batchData = await _apiService.fetchBatchCryptoData(allCoinIds);
//       for (var pack in cryptoPacks) {
//         final packData = pack.coinIds.map((id) => batchData[id]).toList();
//         await _cryptoPackCache.setCryptoPackData(pack.id, packData);
//       }
//     } catch (e) {
//       print('Error preloading crypto packs: $e');
//     }
//   }

// }

// class AppTheme {
//   static const primaryColor = Color(0xFF2196F3);
//   static const secondaryColor = Color(0xFF4CAF50);
//   static const backgroundColor = Color(0xFFF5F5F5);
//   static const cardColor = Colors.white;
//   static const textColor = Color(0xFF333333);
//   static const lightTextColor = Color(0xFF666666);

//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: primaryColor,
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: secondaryColor,
//       ),
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: AppBarTheme(
//         color: primaryColor,
//         elevation: 0,
//       ),
//       cardTheme: CardTheme(
//         color: cardColor,
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
//         titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
//         bodyMedium: TextStyle(color: textColor, fontSize: 14),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: primaryColor,
//         textTheme: ButtonTextTheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }

// class CryptoPackScreen extends StatefulWidget {
//   @override
//   _CryptoPackScreenState createState() => _CryptoPackScreenState();
// }

// class _CryptoPackScreenState extends State<CryptoPackScreen> {////////////////////////////////////////////////////////////////////////////////////////
//   final CryptoApiService _apiService = CryptoApiService();
//   int _currentPage = 0;
//   static const int _packsPerPage = 6;

//   @override
//   void initState() {
//     super.initState();
//     _calculatePercentageChange();
//     _preloadCryptoPacks();
//   }

//    void _preloadCryptoPacks() {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);
//     holdingsProvider.preloadCryptoPacks(_cryptoPacks);
//   }

//   void _calculatePercentageChange() async {
//     for (var pack in _cryptoPacks) {
//       try {
//         double percentageChange = await _fetchPercentageChange(pack.coinIds);
//         setState(() {
//           pack.percentageChange = percentageChange;
//         });
//       } catch (e) {
//         print('Error calculating percentage change for ${pack.name}: $e');
//         setState(() {
//           pack.percentageChange = pack.percentageChange;
//         });
//       }
//     }
//   }

//   Future<double> _fetchPercentageChange(List<String> coinIds) async {
//     try {
//       final ids = coinIds.join(',');
//       final response = await _apiService.fetchCryptoData(ids);
//       if (response.isNotEmpty) {
//         final totalChange = response.fold(0.0, (sum, coinData) {
//           return sum + (coinData['price_change_percentage_24h'] ?? 0.0);
//         });
//         return totalChange / response.length;
//       }
//       return 0.0;
//     } catch (e) {
//       print('Error fetching percentage change: $e');
//       return 0.0;
//     }
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CryptoPack', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         elevation: 0,
//       ),
//       drawer: _buildDrawer(context),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('ALL CRYPTOPACKS', style: TextStyle(fontSize: 12)),//12/////////////////////////////////////////////////////////////////////////////////////////////////////
//                       style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryColor,
//                     foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Coming soon!')),
//                         );
//                       },
//                       child: Text('MY CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.secondaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(16.0),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final packIndex = _currentPage * _packsPerPage + index;
//                   if (packIndex >= _cryptoPacks.length) {
//                     return SizedBox.shrink();
//                   }
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CryptoPackDetailScreen(pack: _cryptoPacks[packIndex]),
//                         ),
//                       );
//                     },
//                     child: CryptoPackCard(pack: _cryptoPacks[packIndex]),
//                   );
//                 },
//                 childCount: _packsPerPage,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//  Widget _buildDrawer(BuildContext context) {
//   final user = supabase.auth.currentUser;
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         UserAccountsDrawerHeader(
//           accountName: Text(user?.userMetadata?['first_name'] ?? 'User'),
//           accountEmail: Text(user?.email ?? ''),
//           currentAccountPicture: CircleAvatar(
//             backgroundImage: NetworkImage(
//               'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//             ),
//           ),
//           decoration: BoxDecoration(
//             color: AppTheme.primaryColor,
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.home),
//           title: Text('Home', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//   leading: Icon(Icons.account_circle),
//   title: Text('Profile', style: TextStyle(fontSize: 18)),
//   onTap: () {
//     Navigator.pop(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfilePage()),
//     );
//   },
// ),
//         ListTile(
//           leading: Icon(Icons.account_balance_wallet),
//           title: Text('My Portfolio', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HoldingsScreen()),
//             );
//           },
//         ),
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('FAQ', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FAQScreen()),
//               );
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.support),
//             title: Text('Help & Support', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               launch('mailto:cryptoforyouhelp@gmail.com');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CryptoPackCard extends StatelessWidget {
//   final CryptoPack pack;

//   const CryptoPackCard({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.secondaryColor.withOpacity(0.1)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(9.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       pack.name,
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(pack.icon, color: AppTheme.primaryColor),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 pack.description,
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Spacer(),
//               Text(
//                 'Rec.investement:',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//               ),
//               Text(
//                 '\$${pack.RecommendedInvestment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Change:',
//                     style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                   ),
//                   Text(
//                     '${pack.percentageChange.toStringAsFixed(2)}%',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: pack.percentageChange >= 0 ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Trend: ${pack.trend}',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CryptoPackDetailScreen(pack: pack),
//                       ),
//                     );
//                   },
//                   child: Text('Know More', style: TextStyle(fontSize: 12)),
//                   style: ElevatedButton.styleFrom(
//                backgroundColor    : AppTheme.primaryColor,
//                foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CryptoDataRepository {
//   final CryptoApiService _apiService;
//   final Map<String, CachedData<DetailedCryptoData>> _cache = {};
//   static const Duration _cacheDuration = Duration(hours: 1);

//   CryptoDataRepository(this._apiService);

//   Future<DetailedCryptoData?> getCachedDetailedCryptoData(String coinId) async {
//     final cachedData = _cache[coinId];
//     if (cachedData != null && !_isCacheExpired(cachedData.timestamp)) {
//       return cachedData.data;
//     }
//     return null;
//   }

//   Future<void> cacheDetailedCryptoData(String coinId, DetailedCryptoData data) async {
//     _cache[coinId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   bool _isCacheExpired(DateTime timestamp) {
//     return DateTime.now().difference(timestamp) > _cacheDuration;
//   }

//   Future<DetailedCryptoData> fetchDetailedCryptoData(String coinId, int days) async {
//     final coinData = await _apiService.fetchDetailedCoinData(coinId);
//     final historicalData = await _apiService.fetchCoinMarketChart(coinId, days);
//     return DetailedCryptoData.fromJson(coinData, historicalData);
//   }

//   Future<List<List<double>>> fetchAdditionalHistoricalData(String coinId, int fromDays, int toDays) async {
//   final historicalData = await _apiService.fetchCoinMarketChart(coinId, toDays);
//   return (historicalData as List<dynamic>)
//       .sublist(fromDays * 24)
//       .map((data) => [
//             (data[0] as num).toDouble(),
//             (data[1] as num).toDouble(),
//           ])
//       .toList();
// }

//   Future<String?> getNextCoinId(String currentCoinId) async {
//     return null;
//   }

//   Future<void> prefetchDetailedCryptoData(String coinId, int days) async {
//     try {
//       final data = await fetchDetailedCryptoData(coinId, days);
//       await cacheDetailedCryptoData(coinId, data);
//     } catch (e) {
//       print('Error prefetching data for $coinId: $e');
//     }
//   }
// }

// class CryptoDetailScreen extends StatefulWidget {
//   final String coinId;

//   CryptoDetailScreen({required this.coinId});

//   @override
//   _CryptoDetailScreenState createState() => _CryptoDetailScreenState();
// }

// class _CryptoDetailScreenState extends State<CryptoDetailScreen> {
//   Map<String, dynamic>? data;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cachedData = prefs.getString('crypto_data_${widget.coinId}');
//     if (cachedData != null) {
//       setState(() {
//         data = jsonDecode(cachedData);
//         isLoading = false;
//       });
//     } else {
//       final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/${widget.coinId}'));
//       if (response.statusCode == 200) {
//         final fetchedData = jsonDecode(response.body);
//         await prefs.setString('crypto_data_${widget.coinId}', jsonEncode(fetchedData));
//         setState(() {
//           data = fetchedData;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Error'),
//               content: Text('Failed to load data'),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crypto Details'),
//       ),
//       body: isLoading
//           ? Center(
//               child: Shimmer.fromColors(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 100,
//                       color: Colors.grey[300],
//                     ),
//                     SizedBox(height: 16),
//                     Container(
//                       width: 200,
//                       height: 20,
//                       color: Colors.grey[300],
//                     ),
//                     SizedBox(height: 16),
//                     Container(
//                       width: 150,
//                       height: 20,
//                       color: Colors.grey[300],
//                     ),
//                   ],
//                 ),
//                 baseColor: Colors.grey[300]!,
//                 highlightColor: Colors.grey[100]!,
//               ),
//             )
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     data?['name'] ?? '',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     data?['symbol'] ?? '',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Price: \$${data?['market_data']['current_price']['usd'] ?? ''}',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Market Cap: \$${data?['market_data']['market_cap']['usd'] ?? ''}',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     '24h Volume: \$${data?['market_data']['total_volume']['usd'] ?? ''}',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Description',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     data?['description']['en'] ?? '',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

// class CryptoPackDetailScreen extends StatelessWidget {
//   final CryptoPack pack;
//   const CryptoPackDetailScreen({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(pack.name, style: TextStyle(color: Colors.white)),
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(pack.icon, size: 80, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoCard('About', pack.about),
//                   SizedBox(height: 16),
//                   _buildInfoCard('RecommendedInvestment', '\$${pack.RecommendedInvestment.toStringAsFixed(2)}'),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Trend', pack.trend),
//                   SizedBox(height: 16),
//                   _buildInfoCard('24h Change', '${pack.percentageChange.toStringAsFixed(2)}%'),
//                   SizedBox(height: 24),
//                   Text(
//                     'Coin Distribution',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: FutureBuilder<List<dynamic>>(
//               future: _fetchCryptoData(context),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No data available', style: TextStyle(fontSize: 18)));
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         padding: EdgeInsets.all(16.0),
//                         child: PieChart(
//                           PieChartData(
//                             sections: getPieChartSections(snapshot.data!),
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                             borderData: FlBorderData(show: false),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) => _buildCoinListTile(context, snapshot.data![index]),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Investment functionality coming soon!')),
//             );
//           },
//           child: Text('Invest Now', style: TextStyle(fontSize: 18)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppTheme.primaryColor,
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(value, style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCoinListTile(BuildContext context, dynamic coin) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: coin['image'],
//           width: 40,
//           height: 40,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         title: Text(coin['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text('${coin['current_price'].toStringAsFixed(2)} USD'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
//               style: TextStyle(
//                 color: coin['price_change_percentage_24h'] >= 0 ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text('24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CryptoDetailScreen(coinId: coin['id']),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<List<dynamic>> _fetchCryptoData(BuildContext context) async {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);

//     final cachedData = holdingsProvider._cryptoPackCache.getCryptoPackData(pack.id);
//     if (cachedData != null) {
//       return cachedData;
//     }

//     final cryptoApiService = CryptoApiService();
//     final coinIds = _packPercentages[pack.id]?.keys.join(',') ?? '';
//     final data = await cryptoApiService.fetchCryptoData(coinIds);
//     await holdingsProvider._cryptoPackCache.setCryptoPackData(pack.id, data);
//     return data;
//   }

//   List<PieChartSectionData> getPieChartSections(List<dynamic> cryptoData) {
//     List<PieChartSectionData> sections = [];
//     final packPercentages = _packPercentages[pack.id] ?? {};
//     final colors = [
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.purple,
//       Colors.orange,
//     ];

//     int colorIndex = 0;
//     for (var coin in cryptoData) {
//       final percentage = packPercentages[coin['id']] ?? 0;
//       sections.add(
//         PieChartSectionData(
//           value: percentage,
//           title: '${coin['symbol'].toUpperCase()}\n${(percentage * 100).toStringAsFixed(0)}%',
//           color: colors[colorIndex % colors.length],
//           radius: 40,
//           titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//       colorIndex++;
//     }

//     return sections;
//   }

//   static const Map<String, Map<String, double>> _packPercentages = {
//     'RAW Frontrunners': {
//       'ix-swap': 0.2,
//       'realio-network': 0.2,
//       'clearpool': 0.2,
//       'polytrade': 0.2,
//       'maple': 0.2,
//     },
//     'CeDefi-Defi & Privacy': {
//       'fideum': 0.5,
//       'oasis-network': 0.5,
//     },
//     'High Caps': {
//       'bitcoin': 0.4,
//       'ethereum': 0.4,
//       'chainlink': 0.2,
//     },
//     'ultimate_alts': {
//       'cardano': 0.3,
//       'solana': 0.3,
//       'polkadot': 0.2,
//       'avalanche-2': 0.2,
//     },
//     'high_risk_high_reward': {
//       'maga': 1,
//     },
//     'Artificial Intelligence': {
//       'near': 1,
//     },
//   };
// }

// class FAQScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FAQ'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           ExpansionTile(
//             title: Text('What is CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'CryptoPack is a selection of curated cryptocurrency portfolios designed to suit various investment strategies.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How do I invest in a CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'You can invest in a CryptoPack by selecting your desired pack and making a minimum investment as specified.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Is there a risk in investing in cryptocurrencies?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, investing in cryptocurrencies carries risks due to their volatile nature. It is advisable to do thorough research and invest wisely.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How is the percentage change calculated?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'The percentage change is calculated based on the change in the value of the cryptocurrencies in the pack over the past 24 hours.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Can I track my investments?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, you can track your investments through the "My CryptoPacks" section, which will be available soon.',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HoldingsScreen extends StatefulWidget {
//   @override
//   _HoldingsScreenState createState() => _HoldingsScreenState();
// }

// class _HoldingsScreenState extends State<HoldingsScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _averagePriceController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _quantityController.dispose();
//     _averagePriceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: _buildHoldingsTheme(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My Portfolio'),
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             _buildSearchBar(),
//             _buildPortfolioOverview(),
//             Expanded(
//               child: Consumer<HoldingsProvider>(
//                 builder: (context, provider, child) {
//                   return Column(
//                     children: [
//                       if (provider.isSearching)
//                         _buildSearchResults(provider)
//                       else
//                         _buildHoldingsList(provider),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ThemeData _buildHoldingsTheme() {
//     return ThemeData(
//       primaryColor: const Color(0xFF6200EE),
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: Color(0xFF03DAC6),
//       ),
//       scaffoldBackgroundColor: Color(0xFFF5F5F5),
//       cardTheme: CardTheme(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6200EE)),
//         titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//         bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => context.read<HoldingsProvider>().searchCrypto(value),
//         decoration: InputDecoration(
//           hintText: 'Search cryptocurrencies...',
//           prefixIcon: Icon(Icons.search),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _searchController.clear();
//               context.read<HoldingsProvider>().searchCrypto('');
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPortfolioOverview() {
//     return Consumer<HoldingsProvider>(
//       builder: (context, provider, child) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Portfolio Value',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '${provider.getTotalValue().toStringAsFixed(2)} USD',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchResults(HoldingsProvider provider) {
//     return Expanded(
//       child: provider.isLoadingSearch
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: provider.searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = provider.searchResults[index];
//                 return ListTile(
//                   leading: CachedNetworkImage(
//                     imageUrl: result['large'] ?? '',
//                     width: 40,
//                     height: 40,
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                   title: Text(result['name']),
//                   subtitle: Text(result['symbol']),
//                   onTap: () => _showAddHoldingDialog(context, result, provider),
//                 );
//               },
//             ),
//     );
//   }

// Widget _buildHoldingsList(HoldingsProvider provider) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: provider.holdings.length,
//         itemBuilder: (context, index) {
//           final holding = provider.holdings[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     holding.name,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   Text(
//                     holding.symbol.toUpperCase(),
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Quantity: ${holding.quantity.toStringAsFixed(4)}'),
//                       Text('Avg. Price: ${holding.averagePrice.toStringAsFixed(2)} USD'),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Current Value: ${holding.currentValue.toStringAsFixed(2)} USD'),
//                       Text(
//                         'P/L: ${holding.profitLoss.toStringAsFixed(2)} USD',
//                         style: TextStyle(
//                           color: holding.profitLoss >= 0 ? Colors.green : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: false,
//                           holding: holding,
//                         ),
//                         child: Text('Add'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: true,
//                           holding: holding,
//                         ),
//                         child: Text('Edit'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showRemoveHoldingDialog(context, holding, provider),
//                         child: Text('Remove'),
//                         style: TextButton.styleFrom(foregroundColor: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//  void _showAddHoldingDialog(BuildContext context, Map<String, dynamic>? result, HoldingsProvider provider, {bool isEdit = false, CryptoHolding? holding}) {
//   if (isEdit) {
//     _quantityController.text = '';
//     _averagePriceController.text = holding!.averagePrice.toString();
//   } else {
//     _quantityController.clear();
//     _averagePriceController.clear();
//   }

//   String operation = 'Add';

//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Text(isEdit ? 'Edit Holding' : 'Add Holding'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isEdit)
//                   DropdownButton<String>(
//                     value: operation,
//                     items: ['Add', 'Subtract'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         operation = newValue!;
//                       });
//                     },
//                   ),
//                 TextField(
//                   controller: _quantityController,
//                   decoration: InputDecoration(
//                     labelText: 'Quantity',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _averagePriceController,
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   final newQuantity = double.tryParse(_quantityController.text) ?? 0;
//                   final newPrice = double.tryParse(_averagePriceController.text) ?? 0;

//                   if (isEdit) {
//                     final operationMultiplier = operation == 'Add' ? 1 : -1;
//                     final totalValue = (holding!.quantity * holding.averagePrice) + (newQuantity * newPrice * operationMultiplier);
//                     final totalQuantity = holding.quantity + (newQuantity * operationMultiplier);

//                     if (totalQuantity <= 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Cannot subtract more than available quantity')),
//                       );
//                       return;
//                     }

//                     final newAveragePrice = totalValue / totalQuantity;

//                     provider.updateHolding(
//                       holding.symbol,
//                       totalQuantity,
//                       newAveragePrice,
//                     );
//                   } else {
//                     provider.addHolding(
//                       result!['id'],
//                       result['name'],
//                       newQuantity,
//                       newPrice,
//                     );
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text(isEdit ? 'Update' : 'Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
//  void _showRemoveHoldingDialog(BuildContext context, CryptoHolding holding, HoldingsProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Holding'),
//         content: Text('Are you sure you want to remove ${holding.name} from your portfolio?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//             style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               provider.removeHolding(holding.symbol);
//               Navigator.pop(context);
//             },
//             child: Text('Remove'),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CryptoPackScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 15, 14, 14),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'android/logo (1).jpg',
//               width: MediaQuery.of(context).size.width * 0.4,
//               height: MediaQuery.of(context).size.width * 0.4,
//             ),
//             SizedBox(height: 24),
//             Text(
//               'CryptoForYou',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 238, 242, 244),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// void main() async {
//  // WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://pajnoqsxkpaujmdskmjy.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBham5vcXN4a3BhdWptZHNrbWp5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDE3Mjk0NywiZXhwIjoyMDM1NzQ4OTQ3fQ.uZY4kBkg-yu8z29Xt8DLqtvkalD-FmMQyMjMzr8WTmM',
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) {
//         final provider = HoldingsProvider()..fetchHoldings();
//         provider.preloadCryptoPacks(_cryptoPacks);
//         return provider;
//       },

//       child: MyApp(),
//     ),
//   );
// }
//  final supabase = Supabase.instance.client;//////////////////////////////////////////////////////////////////////////////
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CryptoPack',
//       theme: AppTheme.lightTheme,
//       home: SignInPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// import 'package:intl/intl.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:http/http.dart' as http;
// import 'profile.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:dio/dio.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'login.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final List<CryptoPack> _cryptoPacks = [
//        CryptoPack(
//     name: 'RAW Frontrunners',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['ix-swap', 'realio-network', 'clearpool', 'polytrade', 'maple'],
//     about: 'RAW Frontrunners pack focuses on cryptocurrencies that are leading the way in terms of innovation and market influence.',
//     id: 'RAW Frontrunners',
//   ),
//   CryptoPack(
//     name: 'CeDefi-Defi & Privacy',
//     description: 'Leading DeFi and privacy tokens',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Very High',
//     icon: Icons.security,
//     coinIds: ['fideum', 'oasis-network'],
//     about: 'CeDefi-Defi & Privacy pack includes top-performing tokens in the DeFi and privacy space.',
//     id: 'CeDefi-Defi & Privacy',
//   ),
//   CryptoPack(
//     name: 'High Caps',
//     description: 'The market-leading cryptocurrencies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.star,
//     coinIds: ['bitcoin', 'ethereum', 'chainlink'],
//     about: 'high caps pack contains the most prominent cryptocurrencies, suitable for beginners and experienced investors.',
//     id: 'High Caps',
//   ),
//   CryptoPack(
//     name: 'Ultimate Alts of Tomorrow',
//     description: 'The undisputed Alt Coin selection',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.monetization_on,
//     coinIds: ['cardano', 'solana', 'polkadot', 'avalanche-2'],
//     about: 'Ultimate Alts pack features a selection of promising altcoins with potential for future growth.',
//     id: 'ultimate_alts',
//   ),
//    CryptoPack(
//     name: 'HighRiskHighReward',
//     description: 'High-risk investments with potential for high rewards',
//     RecommendedInvestment: 250.00,
//     percentageChange: 0.0,
//     trend: 'High',
//     icon: Icons.warning,
//     coinIds: ['maga', ],
//     about: 'HighRiskHighReward pack includes volatile cryptocurrencies with the potential for significant returns.',
//     id: 'high_risk_high_reward',
//   ),
//   CryptoPack(
//     name: 'Artificial Intelligence',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 500.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['near'],
//     about: 'Artificial Intelligence pack focuses on cryptocurrencies that are leading the way in terms of innovation in artificial intelligence and market influence.',
//     id: 'Artificial Intelligence',
//   )
//   ];
// class ApiError extends Error {
//   final String message;
//   final int? statusCode;

//   ApiError({required this.message, this.statusCode});
// }

// class CryptoPack {
//   final String name;
//   final String description;
//   final double RecommendedInvestment;
//   double percentageChange;
//   final String trend;
//   final IconData icon;
//   final String id;
//   final String about;
//   final List<String> coinIds;

//   CryptoPack({
//     required this.name,
//     required this.description,
//     required this.RecommendedInvestment,
//     required this.percentageChange,
//     required this.trend,
//     required this.icon,
//     required this.id,
//     required this.about,
//     required this.coinIds,
//   });
// }

// class CryptoHolding {
//   final String symbol;
//   final String name;
//   double quantity;
//   double averagePrice;
//   double currentPrice;
//   double currentValue;
//   double investedAmount;
//   double profitLoss;
//   double dailyProfitLoss;

//   CryptoHolding({
//     required this.symbol,
//     required this.name,
//     required this.quantity,
//     required this.averagePrice,
//     required this.currentPrice,
//     required this.currentValue,
//     required this.investedAmount,
//     required this.profitLoss,
//     required this.dailyProfitLoss,
//   });

//   factory CryptoHolding.fromJson(Map<String, dynamic> json) {
//     return CryptoHolding(
//       symbol: json['symbol'],
//       name: json['name'],
//       quantity: json['quantity'],
//       averagePrice: json['averagePrice'],
//       currentPrice: json['currentPrice'],
//       currentValue: json['currentValue'],
//       investedAmount: json['investedAmount'],
//       profitLoss: json['profitLoss'],
//       dailyProfitLoss: json['dailyProfitLoss'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'symbol': symbol,
//       'name': name,
//       'quantity': quantity,
//       'averagePrice': averagePrice,
//       'currentPrice': currentPrice,
//       'currentValue': currentValue,
//       'investedAmount': investedAmount,
//       'profitLoss': profitLoss,
//       'dailyProfitLoss': dailyProfitLoss,
//     };
//   }
// }
// class DetailedCryptoData {
//   final String id;
//   final String name;
//   final String symbol;
//   final String description;
//   final String image;
//   final double currentPrice;
//   final double marketCap;
//   final double tradingVolume;
//   final double priceChange24h;
//   final double marketCapRank;
//   final List<List<double>> historicalData;
//   final Map<String, dynamic> communityData;
//   final Map<String, dynamic> developerData;

//   DetailedCryptoData({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.description,
//     required this.image,
//     required this.currentPrice,
//     required this.marketCap,
//     required this.tradingVolume,
//     required this.priceChange24h,
//     required this.marketCapRank,
//     required this.historicalData,
//     required this.communityData,
//     required this.developerData,
//   });

//   factory DetailedCryptoData.fromJson(Map<String, dynamic> json, List<dynamic> historicalData) {
//     return DetailedCryptoData(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       symbol: json['symbol'] ?? '',
//       description: json['description']['en'] ?? '',
//       image: json['image']['large'] ?? '',
//       currentPrice: (json['market_data']['current_price']['usd'] ?? 0).toDouble(),
//       marketCap: (json['market_data']['market_cap']['usd'] ?? 0).toDouble(),
//       tradingVolume: (json['market_data']['total_volume']['usd'] ?? 0).toDouble(),
//       priceChange24h: (json['market_data']['price_change_percentage_24h'] ?? 0).toDouble(),
//       marketCapRank: (json['market_cap_rank'] ?? 0).toDouble(),
//       historicalData: (historicalData as List<dynamic>).map((data) =>
//         [data[0] as double? ?? 0.0, data[1] as double? ?? 0.0]).toList(),
//       communityData: json['community_data'] ?? {},
//       developerData: json['developer_data'] ?? {},
//     );
//   }
// }
// class CachedData<T> {
//   final T data;
//   final DateTime timestamp;

//   CachedData({required this.data, required this.timestamp});
// }

// class CryptoPackCache {
//   final Map<String, CachedData<List<dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 15);

//   Future<void> setCryptoPackData(String packId, List<dynamic> data) async {
//     _cache[packId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   List<dynamic>? getCryptoPackData(String packId) {
//     if (_cache.containsKey(packId) && !_isCacheExpired(packId)) {
//       return _cache[packId]!.data;
//     }
//     return null;
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class CryptoApiService {
//   final Dio _dio = Dio();
//   final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 5);

//   CryptoApiService() {
//     _dio.interceptors.add(InterceptorsWrapper(
//       onError: (DioError e, ErrorInterceptorHandler handler) {
//         ApiError error;
//         if (e.response != null) {
//           error = ApiError(
//             message: e.response!.data['message'] ?? 'Unknown error',
//             statusCode: e.response!.statusCode
//           );
//         } else {
//           error = ApiError(message: e.message ?? 'Unknown error');
//         }
//         throw error;
//       },
//     ));
//   }

//   Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
//     if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
//       return _cache[symbol]!.data;
//     }

//     try {
//       final response = await _dio.get(
//           'https://api.coingecko.com/api/v3/simple/price?ids=$symbol&vs_currencies=usd&include_24hr_change=true');
//       final data = {
//         'currentPrice': response.data[symbol]['usd'],
//         'priceChange24h': response.data[symbol]['usd_24h_change'],
//       };
//       _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
//       return data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to load price data');
//     }
//   }

//   Future<Map<String, dynamic>> searchCrypto(String query) async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/search?query=$query');
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to search crypto');
//     }
//   }

//   Future<List<dynamic>> fetchCryptoData(String coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds,
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchBatchCryptoData(List<String> coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds.join(','),
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return Map.fromIterable(response.data, key: (item) => item['id'], value: (item) => item);
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch batch data');
//     }
//   }
// Future<Map<String, dynamic>> fetchDetailedCoinData(String coinId) async {
//   try {
//     final response = await _dio.get(
//       'https://api.coingecko.com/api/v3/coins/$coinId',
//       queryParameters: {
//         'localization': 'false',
//         'tickers': 'false',
//         'market_data': 'true',
//         'community_data': 'true',
//         'developer_data': 'true',
//       },
//     );
//     return response.data ?? {};
//   } catch (e) {
//     print('Error fetching detailed coin data: $e');
//     throw ApiError(message: 'Failed to fetch detailed coin data');
//   }
// }

// Future<List<dynamic>> fetchCoinMarketChart(String coinId, int days) async {
//   try {
//     final response = await _dio.get(
//       'https://api.coingecko.com/api/v3/coins/$coinId/market_chart',
//       queryParameters: {
//         'vs_currency': 'usd',
//         'days': days,
//       },
//     );
//     return response.data['prices'] ?? [];
//   } catch (e) {
//     print('Error fetching market chart data: $e');
//     throw ApiError(message: 'Failed to fetch market chart data');
//   }
// }

//   Future<Map<String, dynamic>> fetchGlobalData() async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/global');
//       return response.data['data'];
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch global data');
//     }
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class HoldingsProvider with ChangeNotifier {
//   final CryptoApiService _apiService = CryptoApiService();
//   final CryptoPackCache _cryptoPackCache = CryptoPackCache();
//   List<CryptoHolding> _holdings = [];
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _isSearching = false;
//   bool _isLoadingSearch = false;

//   List<CryptoHolding> get holdings => _holdings;
//   List<Map<String, dynamic>> get searchResults => _searchResults;
//   bool get isSearching => _isSearching;
//   bool get isLoadingSearch => _isLoadingSearch;

//   Future<void> fetchHoldings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = prefs.getStringList('holdings') ?? [];
//       _holdings = holdingsJson
//           .map((json) => CryptoHolding.fromJson(jsonDecode(json)))
//           .toList();
//       await _updateHoldingsData();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching holdings: $e');
//     }
//   }

//   Future<void> _updateHoldingsData() async {
//     final futures = _holdings.map((holding) => _apiService.getCurrentPriceData(holding.symbol)).toList();
//     final results = await Future.wait(futures);

//     for (var i = 0; i < _holdings.length; i++) {
//       try {
//         final priceData = results[i];
//         _holdings[i].currentPrice = priceData['currentPrice'].toDouble();
//         _holdings[i].currentValue = _holdings[i].quantity * _holdings[i].currentPrice;
//         _holdings[i].profitLoss = _holdings[i].currentValue - _holdings[i].investedAmount;
//         _holdings[i].dailyProfitLoss = _holdings[i].currentValue * (priceData['priceChange24h'] / 100);
//       } catch (e) {
//         print('Error updating holding data for ${_holdings[i].symbol}: $e');
//       }
//     }
//   }

//   Future<void> searchCrypto(String searchTerm) async {
//     _isSearching = searchTerm.isNotEmpty;
//     if (_isSearching) {
//       _isLoadingSearch = true;
//       notifyListeners();
//       try {
//         final results = await _apiService.searchCrypto(searchTerm);
//         _searchResults = List<Map<String, dynamic>>.from(results['coins']);
//       } catch (e) {
//         print('Error searching crypto: $e');
//         _searchResults = [];
//       }
//       _isLoadingSearch = false;
//     } else {
//       _searchResults = [];
//     }
//     notifyListeners();
//   }

//   Future<void> addHolding(String symbol, String name, double quantity, double averagePrice) async {
//       try {
//       final priceData = await _apiService.getCurrentPriceData(symbol);
//       final currentPrice = priceData['currentPrice'].toDouble();
//       final currentValue = quantity * currentPrice;
//       final investedAmount = quantity * averagePrice;
//       final profitLoss = currentValue - investedAmount;
//       final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//       final existingHoldingIndex = _holdings.indexWhere((holding) => holding.symbol == symbol);

//       if (existingHoldingIndex != -1) {
//         final existingHolding = _holdings[existingHoldingIndex];
//         final newQuantity = existingHolding.quantity + quantity;
//         final newInvestedAmount = existingHolding.investedAmount + investedAmount;
//         final newAveragePrice = newInvestedAmount / newQuantity;

//         _holdings[existingHoldingIndex].quantity = newQuantity;
//         _holdings[existingHoldingIndex].averagePrice = newAveragePrice;
//         _holdings[existingHoldingIndex].investedAmount = newInvestedAmount;
//         _holdings[existingHoldingIndex].currentPrice = currentPrice;
//         _holdings[existingHoldingIndex].currentValue = newQuantity * currentPrice;
//         _holdings[existingHoldingIndex].profitLoss = _holdings[existingHoldingIndex].currentValue - _holdings[existingHoldingIndex].investedAmount;
//         _holdings[existingHoldingIndex].dailyProfitLoss = _holdings[existingHoldingIndex].currentValue * (priceData['priceChange24h'] / 100);
//       } else {
//         final newHolding = CryptoHolding(
//           symbol: symbol,
//           name: name,
//           quantity: quantity,
//           averagePrice: averagePrice,
//           currentPrice: currentPrice,
//           currentValue: currentValue,
//           investedAmount: investedAmount,
//           profitLoss: profitLoss,
//           dailyProfitLoss: dailyProfitLoss,
//         );

//         _holdings.add(newHolding);
//       }

//       await _saveHoldings();
//       notifyListeners();
//     } catch (e) {
//       print('Error adding holding: $e');
//     }
//   }

//   Future<void> updateHolding(String symbol, double quantity, double averagePrice) async {
//      final index = _holdings.indexWhere((holding) => holding.symbol == symbol);
//     if (index != -1) {
//       try {
//         final priceData = await _apiService.getCurrentPriceData(symbol);
//         final currentValue = quantity * priceData['currentPrice'];
//         final investedAmount = quantity * averagePrice;
//         final profitLoss = currentValue - investedAmount;
//         final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//         _holdings[index].quantity = quantity;
//         _holdings[index].averagePrice = averagePrice;
//         _holdings[index].currentPrice = priceData['currentPrice'];
//         _holdings[index].currentValue = currentValue;
//         _holdings[index].investedAmount = investedAmount;
//         _holdings[index].profitLoss = profitLoss;
//         _holdings[index].dailyProfitLoss = dailyProfitLoss;

//         await _saveHoldings();
//         notifyListeners();
//       } catch (e) {
//         print('Error updating holding: $e');
//       }
//     }
//   }

//   void removeHolding(String symbol) {
//      _holdings.removeWhere((holding) => holding.symbol == symbol);
//     _saveHoldings();
//     notifyListeners();
//   }

//   double getTotalValue() {
//     return _holdings.fold(0, (sum, holding) => sum + holding.currentValue);
//   }

//   Future<void> _saveHoldings() async {
//      try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = _holdings.map((holding) => jsonEncode(holding.toJson())).toList();
//       await prefs.setStringList('holdings', holdingsJson);
//     } catch (e) {
//       print('Error saving holdings: $e');
//     }
//   }

//   Future<void> preloadCryptoPacks(List<CryptoPack> cryptoPacks) async {
//     final allCoinIds = cryptoPacks.expand((pack) => pack.coinIds).toSet().toList();
//     try {
//       final batchData = await _apiService.fetchBatchCryptoData(allCoinIds);
//       for (var pack in cryptoPacks) {
//         final packData = pack.coinIds.map((id) => batchData[id]).toList();
//         await _cryptoPackCache.setCryptoPackData(pack.id, packData);
//       }
//     } catch (e) {
//       print('Error preloading crypto packs: $e');
//     }
//   }

// }

// class AppTheme {
//   static const primaryColor = Color(0xFF2196F3);
//   static const secondaryColor = Color(0xFF4CAF50);
//   static const backgroundColor = Color(0xFFF5F5F5);
//   static const cardColor = Colors.white;
//   static const textColor = Color(0xFF333333);
//   static const lightTextColor = Color(0xFF666666);

//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: primaryColor,
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: secondaryColor,
//       ),
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: AppBarTheme(
//         color: primaryColor,
//         elevation: 0,
//       ),
//       cardTheme: CardTheme(
//         color: cardColor,
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
//         titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
//         bodyMedium: TextStyle(color: textColor, fontSize: 14),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: primaryColor,
//         textTheme: ButtonTextTheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }

// class CryptoPackScreen extends StatefulWidget {
//   @override
//   _CryptoPackScreenState createState() => _CryptoPackScreenState();
// }

// class _CryptoPackScreenState extends State<CryptoPackScreen> {////////////////////////////////////////////////////////////////////////////////////////
//   final CryptoApiService _apiService = CryptoApiService();
//   int _currentPage = 0;
//   static const int _packsPerPage = 6;

//   @override
//   void initState() {
//     super.initState();
//     _calculatePercentageChange();
//     _preloadCryptoPacks();
//   }

//    void _preloadCryptoPacks() {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);
//     holdingsProvider.preloadCryptoPacks(_cryptoPacks);
//   }

//   void _calculatePercentageChange() async {
//     for (var pack in _cryptoPacks) {
//       try {
//         double percentageChange = await _fetchPercentageChange(pack.coinIds);
//         setState(() {
//           pack.percentageChange = percentageChange;
//         });
//       } catch (e) {
//         print('Error calculating percentage change for ${pack.name}: $e');
//         setState(() {
//           pack.percentageChange = pack.percentageChange;
//         });
//       }
//     }
//   }

//   Future<double> _fetchPercentageChange(List<String> coinIds) async {
//     try {
//       final ids = coinIds.join(',');
//       final response = await _apiService.fetchCryptoData(ids);
//       if (response.isNotEmpty) {
//         final totalChange = response.fold(0.0, (sum, coinData) {
//           return sum + (coinData['price_change_percentage_24h'] ?? 0.0);
//         });
//         return totalChange / response.length;
//       }
//       return 0.0;
//     } catch (e) {
//       print('Error fetching percentage change: $e');
//       return 0.0;
//     }
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CryptoPack', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         elevation: 0,
//       ),
//       drawer: _buildDrawer(context),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('ALL CRYPTOPACKS', style: TextStyle(fontSize: 12)),//12/////////////////////////////////////////////////////////////////////////////////////////////////////
//                       style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryColor,
//                     foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Coming soon!')),
//                         );
//                       },
//                       child: Text('MY CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.secondaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(16.0),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final packIndex = _currentPage * _packsPerPage + index;
//                   if (packIndex >= _cryptoPacks.length) {
//                     return SizedBox.shrink();
//                   }
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CryptoPackDetailScreen(pack: _cryptoPacks[packIndex]),
//                         ),
//                       );
//                     },
//                     child: CryptoPackCard(pack: _cryptoPacks[packIndex]),
//                   );
//                 },
//                 childCount: _packsPerPage,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//  Widget _buildDrawer(BuildContext context) {
//   final user = supabase.auth.currentUser;
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         UserAccountsDrawerHeader(
//           accountName: Text(user?.userMetadata?['first_name'] ?? 'User'),
//           accountEmail: Text(user?.email ?? ''),
//           currentAccountPicture: CircleAvatar(
//             backgroundImage: NetworkImage(
//               'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//             ),
//           ),
//           decoration: BoxDecoration(
//             color: AppTheme.primaryColor,
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.home),
//           title: Text('Home', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//   leading: Icon(Icons.account_circle),
//   title: Text('Profile', style: TextStyle(fontSize: 18)),
//   onTap: () {
//     Navigator.pop(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfilePage()),
//     );
//   },
// ),
//         ListTile(
//           leading: Icon(Icons.account_balance_wallet),
//           title: Text('My Portfolio', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HoldingsScreen()),
//             );
//           },
//         ),
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('FAQ', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FAQScreen()),
//               );
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.support),
//             title: Text('Help & Support', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               launch('mailto:cryptoforyouhelp@gmail.com');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CryptoPackCard extends StatelessWidget {
//   final CryptoPack pack;

//   const CryptoPackCard({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.secondaryColor.withOpacity(0.1)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(9.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       pack.name,
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(pack.icon, color: AppTheme.primaryColor),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 pack.description,
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Spacer(),
//               Text(
//                 'Rec.investement:',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//               ),
//               Text(
//                 '\$${pack.RecommendedInvestment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Change:',
//                     style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                   ),
//                   Text(
//                     '${pack.percentageChange.toStringAsFixed(2)}%',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: pack.percentageChange >= 0 ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Trend: ${pack.trend}',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CryptoPackDetailScreen(pack: pack),
//                       ),
//                     );
//                   },
//                   child: Text('Know More', style: TextStyle(fontSize: 12)),
//                   style: ElevatedButton.styleFrom(
//                backgroundColor    : AppTheme.primaryColor,
//                foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CryptoDataRepository {
//   final CryptoApiService _apiService;
//   final Map<String, CachedData<DetailedCryptoData>> _cache = {};
//   static const Duration _cacheDuration = Duration(hours: 1);

//   CryptoDataRepository(this._apiService);

//   Future<DetailedCryptoData?> getCachedDetailedCryptoData(String coinId) async {
//     final cachedData = _cache[coinId];
//     if (cachedData != null && !_isCacheExpired(cachedData.timestamp)) {
//       return cachedData.data;
//     }
//     return null;
//   }

//   Future<void> cacheDetailedCryptoData(String coinId, DetailedCryptoData data) async {
//     _cache[coinId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   bool _isCacheExpired(DateTime timestamp) {
//     return DateTime.now().difference(timestamp) > _cacheDuration;
//   }

//   Future<DetailedCryptoData> fetchDetailedCryptoData(String coinId, int days) async {
//     final coinData = await _apiService.fetchDetailedCoinData(coinId);
//     final historicalData = await _apiService.fetchCoinMarketChart(coinId, days);
//     return DetailedCryptoData.fromJson(coinData, historicalData);
//   }

//   Future<List<List<double>>> fetchAdditionalHistoricalData(String coinId, int fromDays, int toDays) async {
//   final historicalData = await _apiService.fetchCoinMarketChart(coinId, toDays);
//   return (historicalData as List<dynamic>)
//       .sublist(fromDays * 24)
//       .map((data) => [
//             (data[0] as num).toDouble(),
//             (data[1] as num).toDouble(),
//           ])
//       .toList();
// }

//   Future<String?> getNextCoinId(String currentCoinId) async {
//     return null;
//   }

//   Future<void> prefetchDetailedCryptoData(String coinId, int days) async {
//     try {
//       final data = await fetchDetailedCryptoData(coinId, days);
//       await cacheDetailedCryptoData(coinId, data);
//     } catch (e) {
//       print('Error prefetching data for $coinId: $e');
//     }
//   }
// }

// class CryptoDetailScreen extends StatefulWidget {
//   final String coinId;

//   CryptoDetailScreen({required this.coinId});

//   @override
//   _CryptoDetailScreenState createState() => _CryptoDetailScreenState();
// }

// class _CryptoDetailScreenState extends State<CryptoDetailScreen> {
//   Map<String, dynamic>? data;
//   List<FlSpot> priceHistory = [];
//   bool isLoading = true;
//   late Timer _refreshTimer;
//   final NumberFormat currencyFormat = NumberFormat.currency(symbol: '\$');

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     _refreshTimer = Timer.periodic(Duration(minutes: 1), (Timer t) => fetchData());
//   }

//   @override
//   void dispose() {
//     _refreshTimer.cancel();
//     super.dispose();
//   }

//   Future<void> fetchData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cachedData = prefs.getString('crypto_data_${widget.coinId}');
//     final cachedTimestamp = prefs.getInt('crypto_data_timestamp_${widget.coinId}');

//     final currentTime = DateTime.now().millisecondsSinceEpoch;
//     final cacheExpiration = 5 * 60 * 1000; // 5 minutes

//     if (cachedData != null && cachedTimestamp != null && currentTime - cachedTimestamp < cacheExpiration) {
//       setState(() {
//         data = jsonDecode(cachedData);
//         isLoading = false;
//       });
//     } else {
//       try {
//         final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/${widget.coinId}'));
//         if (response.statusCode == 200) {
//           final fetchedData = jsonDecode(response.body);
//           await prefs.setString('crypto_data_${widget.coinId}', jsonEncode(fetchedData));
//           await prefs.setInt('crypto_data_timestamp_${widget.coinId}', currentTime);
//           setState(() {
//             data = fetchedData;
//             isLoading = false;
//           });
//         } else {
//           throw Exception('Failed to load data');
//         }
//       } catch (e) {
//         setState(() {
//           isLoading = false;
//         });
//         showErrorSnackBar('Failed to load data: ${e.toString()}');
//       }
//     }

//     await fetchPriceHistory();
//   }

//   Future<void> fetchPriceHistory() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://api.coingecko.com/api/v3/coins/${widget.coinId}/market_chart?vs_currency=usd&days=7'));
//       if (response.statusCode == 200) {
//         final List<dynamic> prices = jsonDecode(response.body)['prices'];
//         setState(() {
//           priceHistory = prices
//               .map((price) => FlSpot(price[0].toDouble(), price[1].toDouble()))
//               .toList();
//         });
//       } else {
//         throw Exception('Failed to load price history');
//       }
//     } catch (e) {
//       showErrorSnackBar('Failed to load price history: ${e.toString()}');
//     }
//   }

//   void showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   void launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       showErrorSnackBar('Could not launch $url');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crypto Details'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: fetchData,
//           ),
//         ],
//       ),
//       body: isLoading
//           ? ShimmerLoadingWidget()
//           : RefreshIndicator(
//               onRefresh: fetchData,
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CryptoHeader(data: data),
//                     SizedBox(height: 16),
//                     PriceInfo(data: data, currencyFormat: currencyFormat),
//                     SizedBox(height: 16),
//                     PriceChart(priceHistory: priceHistory),
//                     SizedBox(height: 16),
//                     Description(data: data),
//                     SizedBox(height: 16),
//                     Links(data: data, launchURL: launchURL),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// class CryptoHeader extends StatelessWidget {
//   final Map<String, dynamic>? data;

//   CryptoHeader({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Image.network(
//           data?['image']['large'] ?? '',
//           width: 50,
//           height: 50,
//         ),
//         SizedBox(width: 16),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               data?['name'] ?? '',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               data?['symbol']?.toUpperCase() ?? '',
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class PriceInfo extends StatelessWidget {
//   final Map<String, dynamic>? data;
//   final NumberFormat currencyFormat;

//   PriceInfo({required this.data, required this.currencyFormat});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Price: ${currencyFormat.format(data?['market_data']['current_price']['usd'] ?? 0)}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Market Cap: ${currencyFormat.format(data?['market_data']['market_cap']['usd'] ?? 0)}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '24h Volume: ${currencyFormat.format(data?['market_data']['total_volume']['usd'] ?? 0)}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '24h Change: ${(data?['market_data']['price_change_percentage_24h'] ?? 0).toStringAsFixed(2)}%',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: (data?['market_data']['price_change_percentage_24h'] ?? 0) >= 0
//                     ? Colors.green
//                     : Colors.red,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PriceChart extends StatelessWidget {
//   final List<FlSpot> priceHistory;

//   PriceChart({required this.priceHistory});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//           minX: priceHistory.first.x,
//           maxX: priceHistory.last.x,
//           minY: priceHistory.map((spot) => spot.y).reduce((a, b) => a < b ? a : b),
//           maxY: priceHistory.map((spot) => spot.y).reduce((a, b) => a > b ? a : b),
//           lineBarsData: [
//             LineChartBarData(
//               spots: priceHistory,
//               isCurved: true,
//               color: Theme.of(context).primaryColor,
//               barWidth: 2,
//               dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(show: true, color:
//                 Theme.of(context).primaryColor.withOpacity(0.3)
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Description extends StatelessWidget {
//   final Map<String, dynamic>? data;

//   Description({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Description',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               data?['description']['en'] ?? '',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Links extends StatelessWidget {
//   final Map<String, dynamic>? data;
//   final Function(String) launchURL;

//   Links({required this.data, required this.launchURL});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton.icon(
//           icon: Icon(Icons.language),
//           label: Text('Visit Official Website'),
//           onPressed: () => launchURL(data?['links']['homepage'][0] ?? ''),
//         ),
//         SizedBox(height: 8),
//         ElevatedButton.icon(
//           icon: Icon(Icons.description),
//           label: Text('Download White Paper'),
//           onPressed: () => launchURL(data?['links']['whitepaper'] ?? ''),
//         ),
//       ],
//     );
//   }
// }

// class ShimmerLoadingWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: ListView.builder(
//         itemCount: 5,
//         itemBuilder: (context, index) => Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 200,
//                 height: 24,
//                 color: Colors.white,
//               ),
//               SizedBox(height: 8),
//               Container(
//                 width: double.infinity,
//                 height: 16,
//                 color: Colors.white,
//               ),
//               SizedBox(height: 8),
//               Container(
//                 width: double.infinity,
//                 height: 16,
//                 color: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CryptoPackDetailScreen extends StatelessWidget {
//   final CryptoPack pack;
//   const CryptoPackDetailScreen({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(pack.name, style: TextStyle(color: Colors.white)),
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(pack.icon, size: 80, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoCard('About', pack.about),
//                   SizedBox(height: 16),
//                   _buildInfoCard('RecommendedInvestment', '\$${pack.RecommendedInvestment.toStringAsFixed(2)}'),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Trend', pack.trend),
//                   SizedBox(height: 16),
//                   _buildInfoCard('24h Change', '${pack.percentageChange.toStringAsFixed(2)}%'),
//                   SizedBox(height: 24),
//                   Text(
//                     'Coin Distribution',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: FutureBuilder<List<dynamic>>(
//               future: _fetchCryptoData(context),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No data available', style: TextStyle(fontSize: 18)));
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         padding: EdgeInsets.all(16.0),
//                         child: PieChart(
//                           PieChartData(
//                             sections: getPieChartSections(snapshot.data!),
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                             borderData: FlBorderData(show: false),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) => _buildCoinListTile(context, snapshot.data![index]),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Investment functionality coming soon!')),
//             );
//           },
//           child: Text('Invest Now', style: TextStyle(fontSize: 18)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppTheme.primaryColor,
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(value, style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCoinListTile(BuildContext context, dynamic coin) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: coin['image'],
//           width: 40,
//           height: 40,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         title: Text(coin['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text('${coin['current_price'].toStringAsFixed(2)} USD'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
//               style: TextStyle(
//                 color: coin['price_change_percentage_24h'] >= 0 ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text('24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CryptoDetailScreen(coinId: coin['id']),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<List<dynamic>> _fetchCryptoData(BuildContext context) async {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);

//     final cachedData = holdingsProvider._cryptoPackCache.getCryptoPackData(pack.id);
//     if (cachedData != null) {
//       return cachedData;
//     }

//     final cryptoApiService = CryptoApiService();
//     final coinIds = _packPercentages[pack.id]?.keys.join(',') ?? '';
//     final data = await cryptoApiService.fetchCryptoData(coinIds);
//     await holdingsProvider._cryptoPackCache.setCryptoPackData(pack.id, data);
//     return data;
//   }

//   List<PieChartSectionData> getPieChartSections(List<dynamic> cryptoData) {
//     List<PieChartSectionData> sections = [];
//     final packPercentages = _packPercentages[pack.id] ?? {};
//     final colors = [
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.purple,
//       Colors.orange,
//     ];

//     int colorIndex = 0;
//     for (var coin in cryptoData) {
//       final percentage = packPercentages[coin['id']] ?? 0;
//       sections.add(
//         PieChartSectionData(
//           value: percentage,
//           title: '${coin['symbol'].toUpperCase()}\n${(percentage * 100).toStringAsFixed(0)}%',
//           color: colors[colorIndex % colors.length],
//           radius: 40,
//           titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//       colorIndex++;
//     }

//     return sections;
//   }

//   static const Map<String, Map<String, double>> _packPercentages = {
//     'RAW Frontrunners': {
//       'ix-swap': 0.2,
//       'realio-network': 0.2,
//       'clearpool': 0.2,
//       'polytrade': 0.2,
//       'maple': 0.2,
//     },
//     'CeDefi-Defi & Privacy': {
//       'fideum': 0.5,
//       'oasis-network': 0.5,
//     },
//     'High Caps': {
//       'bitcoin': 0.4,
//       'ethereum': 0.4,
//       'chainlink': 0.2,
//     },
//     'ultimate_alts': {
//       'cardano': 0.3,
//       'solana': 0.3,
//       'polkadot': 0.2,
//       'avalanche-2': 0.2,
//     },
//     'high_risk_high_reward': {
//       'maga': 1,
//     },
//     'Artificial Intelligence': {
//       'near': 1,
//     },
//   };
// }

// class FAQScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FAQ'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           ExpansionTile(
//             title: Text('What is CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'CryptoPack is a selection of curated cryptocurrency portfolios designed to suit various investment strategies.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How do I invest in a CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'You can invest in a CryptoPack by selecting your desired pack and making a minimum investment as specified.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Is there a risk in investing in cryptocurrencies?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, investing in cryptocurrencies carries risks due to their volatile nature. It is advisable to do thorough research and invest wisely.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How is the percentage change calculated?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'The percentage change is calculated based on the change in the value of the cryptocurrencies in the pack over the past 24 hours.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Can I track my investments?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, you can track your investments through the "My CryptoPacks" section, which will be available soon.',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HoldingsScreen extends StatefulWidget {
//   @override
//   _HoldingsScreenState createState() => _HoldingsScreenState();
// }

// class _HoldingsScreenState extends State<HoldingsScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _averagePriceController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _quantityController.dispose();
//     _averagePriceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: _buildHoldingsTheme(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My Portfolio'),
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             _buildSearchBar(),
//             _buildPortfolioOverview(),
//             Expanded(
//               child: Consumer<HoldingsProvider>(
//                 builder: (context, provider, child) {
//                   return Column(
//                     children: [
//                       if (provider.isSearching)
//                         _buildSearchResults(provider)
//                       else
//                         _buildHoldingsList(provider),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ThemeData _buildHoldingsTheme() {
//     return ThemeData(
//       primaryColor: const Color(0xFF6200EE),
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: Color(0xFF03DAC6),
//       ),
//       scaffoldBackgroundColor: Color(0xFFF5F5F5),
//       cardTheme: CardTheme(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6200EE)),
//         titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//         bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => context.read<HoldingsProvider>().searchCrypto(value),
//         decoration: InputDecoration(
//           hintText: 'Search cryptocurrencies...',
//           prefixIcon: Icon(Icons.search),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _searchController.clear();
//               context.read<HoldingsProvider>().searchCrypto('');
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPortfolioOverview() {
//     return Consumer<HoldingsProvider>(
//       builder: (context, provider, child) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Portfolio Value',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '${provider.getTotalValue().toStringAsFixed(2)} USD',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchResults(HoldingsProvider provider) {
//     return Expanded(
//       child: provider.isLoadingSearch
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: provider.searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = provider.searchResults[index];
//                 return ListTile(
//                   leading: CachedNetworkImage(
//                     imageUrl: result['large'] ?? '',
//                     width: 40,
//                     height: 40,
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                   title: Text(result['name']),
//                   subtitle: Text(result['symbol']),
//                   onTap: () => _showAddHoldingDialog(context, result, provider),
//                 );
//               },
//             ),
//     );
//   }

// Widget _buildHoldingsList(HoldingsProvider provider) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: provider.holdings.length,
//         itemBuilder: (context, index) {
//           final holding = provider.holdings[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     holding.name,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   Text(
//                     holding.symbol.toUpperCase(),
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Quantity: ${holding.quantity.toStringAsFixed(4)}'),
//                       Text('Avg. Price: ${holding.averagePrice.toStringAsFixed(2)} USD'),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Current Value: ${holding.currentValue.toStringAsFixed(2)} USD'),
//                       Text(
//                         'P/L: ${holding.profitLoss.toStringAsFixed(2)} USD',
//                         style: TextStyle(
//                           color: holding.profitLoss >= 0 ? Colors.green : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: false,
//                           holding: holding,
//                         ),
//                         child: Text('Add'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: true,
//                           holding: holding,
//                         ),
//                         child: Text('Edit'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showRemoveHoldingDialog(context, holding, provider),
//                         child: Text('Remove'),
//                         style: TextButton.styleFrom(foregroundColor: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//  void _showAddHoldingDialog(BuildContext context, Map<String, dynamic>? result, HoldingsProvider provider, {bool isEdit = false, CryptoHolding? holding}) {
//   if (isEdit) {
//     _quantityController.text = '';
//     _averagePriceController.text = holding!.averagePrice.toString();
//   } else {
//     _quantityController.clear();
//     _averagePriceController.clear();
//   }

//   String operation = 'Add';

//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Text(isEdit ? 'Edit Holding' : 'Add Holding'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isEdit)
//                   DropdownButton<String>(
//                     value: operation,
//                     items: ['Add', 'Subtract'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         operation = newValue!;
//                       });
//                     },
//                   ),
//                 TextField(
//                   controller: _quantityController,
//                   decoration: InputDecoration(
//                     labelText: 'Quantity',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _averagePriceController,
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   final newQuantity = double.tryParse(_quantityController.text) ?? 0;
//                   final newPrice = double.tryParse(_averagePriceController.text) ?? 0;

//                   if (isEdit) {
//                     final operationMultiplier = operation == 'Add' ? 1 : -1;
//                     final totalValue = (holding!.quantity * holding.averagePrice) + (newQuantity * newPrice * operationMultiplier);
//                     final totalQuantity = holding.quantity + (newQuantity * operationMultiplier);

//                     if (totalQuantity <= 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Cannot subtract more than available quantity')),
//                       );
//                       return;
//                     }

//                     final newAveragePrice = totalValue / totalQuantity;

//                     provider.updateHolding(
//                       holding.symbol,
//                       totalQuantity,
//                       newAveragePrice,
//                     );
//                   } else {
//                     provider.addHolding(
//                       result!['id'],
//                       result['name'],
//                       newQuantity,
//                       newPrice,
//                     );
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text(isEdit ? 'Update' : 'Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
//  void _showRemoveHoldingDialog(BuildContext context, CryptoHolding holding, HoldingsProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Holding'),
//         content: Text('Are you sure you want to remove ${holding.name} from your portfolio?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//             style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               provider.removeHolding(holding.symbol);
//               Navigator.pop(context);
//             },
//             child: Text('Remove'),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CryptoPackScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 15, 14, 14),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'android/logo (1).jpg',
//               width: MediaQuery.of(context).size.width * 0.4,
//               height: MediaQuery.of(context).size.width * 0.4,
//             ),
//             SizedBox(height: 24),
//             Text(
//               'CryptoForYou',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 238, 242, 244),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// void main() async {
//  // WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://pajnoqsxkpaujmdskmjy.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBham5vcXN4a3BhdWptZHNrbWp5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDE3Mjk0NywiZXhwIjoyMDM1NzQ4OTQ3fQ.uZY4kBkg-yu8z29Xt8DLqtvkalD-FmMQyMjMzr8WTmM',
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) {
//         final provider = HoldingsProvider()..fetchHoldings();
//         provider.preloadCryptoPacks(_cryptoPacks);
//         return provider;
//       },

//       child: MyApp(),
//     ),
//   );
// }
//  final supabase = Supabase.instance.client;
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CryptoPack',
//       theme: AppTheme.lightTheme,
//       home: SignInPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'profile.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:dio/dio.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'login.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final List<CryptoPack> _cryptoPacks = [
//         CryptoPack(
//     name: 'RAW Frontrunners',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['ix-swap', 'realio-network', 'clearpool', 'polytrade', 'maple'],
//     about: 'RAW Frontrunners pack focuses on cryptocurrencies that are leading the way in terms of innovation and market influence.',
//     id: 'RAW Frontrunners',
//     officialLinks: {
//       'ix-swap': 'https://ixswap.io/',
//       'realio-network': 'https://realio.fund/',
//       'clearpool': 'https://clearpool.finance/',
//       'polytrade': 'https://polytrade.finance/',
//       'maple': 'https://maple.finance/',
//     },
//     whitepaperLinks: {
//       'ix-swap': 'https://ixswap.io/whitepaper',
//       'realio-network': 'https://realio.fund/whitepaper.pdf',
//       'clearpool': 'https://clearpool.finance/whitepaper.pdf',
//       'polytrade': 'https://polytrade.finance/whitepaper.pdf',
//       'maple': 'https://maple.finance/whitepaper.pdf',
//     },
//   ),
//   CryptoPack(
//     name: 'CeDefi-Defi & Privacy',
//     description: 'Leading DeFi and privacy tokens',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Very High',
//     icon: Icons.security,
//     coinIds: ['fideum', 'oasis-network'],
//     about: 'CeDefi-Defi & Privacy pack includes top-performing tokens in the DeFi and privacy space.',
//     id: 'CeDefi-Defi & Privacy',
//     officialLinks: {
//       'fideum': 'https://fideum.com/',
//       'oasis-network': 'https://oasisprotocol.org/',
//     },
//     whitepaperLinks: {
//       'fideum': 'https://fideum.com/whitepaper.pdf',
//       'oasis-network': 'https://oasisprotocol.org/papers/whitepaper.pdf',
//     },
//   ),
//   CryptoPack(
//     name: 'High Caps',
//     description: 'The market-leading cryptocurrencies',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.star,
//     coinIds: ['bitcoin', 'ethereum', 'chainlink'],
//     about: 'high caps pack contains the most prominent cryptocurrencies, suitable for beginners and experienced investors.',
//     id: 'High Caps',
//     officialLinks: {
//       'bitcoin': 'https://bitcoin.org/',
//       'ethereum': 'https://ethereum.org/',
//       'chainlink': 'https://chain.link/',
//     },
//     whitepaperLinks: {
//       'bitcoin': 'https://bitcoin.org/bitcoin.pdf',
//       'ethereum': 'https://ethereum.org/en/whitepaper/',
//       'chainlink': 'https://chain.link/whitepaper',
//     },
//   ),
//   CryptoPack(
//     name: 'Ultimate Alts of Tomorrow',
//     description: 'The undisputed Alt Coin selection',
//     RecommendedInvestment: 1000.00,
//     percentageChange: 0.0,
//     trend: 'Moderate',
//     icon: Icons.monetization_on,
//     coinIds: ['cardano', 'solana', 'polkadot', 'avalanche-2'],
//     about: 'Ultimate Alts pack features a selection of promising altcoins with potential for future growth.',
//     id: 'ultimate_alts',
//     officialLinks: {
//       'cardano': 'https://cardano.org/',
//       'solana': 'https://solana.com/',
//       'polkadot': 'https://polkadot.network/',
//       'avalanche-2': 'https://www.avax.network/',
//     },
//     whitepaperLinks: {
//       'cardano': 'https://why.cardano.org/en/introduction/motivation/',
//       'solana': 'https://solana.com/solana-whitepaper.pdf',
//       'polkadot': 'https://polkadot.network/PolkaDotPaper.pdf',
//       'avalanche-2': 'https://www.avalabs.org/whitepapers',
//     },
//   ),
//   CryptoPack(
//     name: 'HighRiskHighReward',
//     description: 'High-risk investments with potential for high rewards',
//     RecommendedInvestment: 250.00,
//     percentageChange: 0.0,
//     trend: 'High',
//     icon: Icons.warning,
//     coinIds: ['maga'],
//     about: 'HighRiskHighReward pack includes volatile cryptocurrencies with the potential for significant returns.',
//     id: 'high_risk_high_reward',
//     officialLinks: {
//       'maga': 'https://magacoin.io/',
//     },
//     whitepaperLinks: {
//       'maga': 'https://magacoin.io/whitepaper.pdf',
//     },
//   ),
//   CryptoPack(
//     name: 'Artificial Intelligence',
//     description: 'Cutting-edge innovation with pioneering technologies',
//     RecommendedInvestment: 500.00,
//     percentageChange: 0.0,
//     trend: 'Moderately High',
//     icon: Icons.trending_up,
//     coinIds: ['near'],
//     about: 'Artificial Intelligence pack focuses on cryptocurrencies that are leading the way in terms of innovation in artificial intelligence and market influence.',
//     id: 'Artificial Intelligence',
//     officialLinks: {
//       'near': 'https://near.org/',
//     },
//     whitepaperLinks: {
//       'near': 'https://near.org/papers/the-official-near-white-paper/',
//     },
//   )
// ];
// class ApiError extends Error {
//   final String message;
//   final int? statusCode;

//   ApiError({required this.message, this.statusCode});
// }

// class CryptoPack {
//   final String name;
//   final String description;
//   final double RecommendedInvestment;
//   double percentageChange;
//   final String trend;
//   final IconData icon;
//   final String id;
//   final String about;
//   final List<String> coinIds;
//   final Map<String, String> officialLinks;
//   final Map<String, String> whitepaperLinks;

//   CryptoPack({
//     required this.name,
//     required this.description,
//     required this.RecommendedInvestment,
//     required this.percentageChange,
//     required this.trend,
//     required this.icon,
//     required this.id,
//     required this.about,
//     required this.coinIds,
//      required this.officialLinks,
//     required this.whitepaperLinks,
//   });
// }

// class CryptoHolding {
//   final String symbol;
//   final String name;
//   double quantity;
//   double averagePrice;
//   double currentPrice;
//   double currentValue;
//   double investedAmount;
//   double profitLoss;
//   double dailyProfitLoss;

//   CryptoHolding({
//     required this.symbol,
//     required this.name,
//     required this.quantity,
//     required this.averagePrice,
//     required this.currentPrice,
//     required this.currentValue,
//     required this.investedAmount,
//     required this.profitLoss,
//     required this.dailyProfitLoss,
//   });

//   factory CryptoHolding.fromJson(Map<String, dynamic> json) {
//     return CryptoHolding(
//       symbol: json['symbol'],
//       name: json['name'],
//       quantity: json['quantity'],
//       averagePrice: json['averagePrice'],
//       currentPrice: json['currentPrice'],
//       currentValue: json['currentValue'],
//       investedAmount: json['investedAmount'],
//       profitLoss: json['profitLoss'],
//       dailyProfitLoss: json['dailyProfitLoss'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'symbol': symbol,
//       'name': name,
//       'quantity': quantity,
//       'averagePrice': averagePrice,
//       'currentPrice': currentPrice,
//       'currentValue': currentValue,
//       'investedAmount': investedAmount,
//       'profitLoss': profitLoss,
//       'dailyProfitLoss': dailyProfitLoss,
//     };
//   }
// }
// class DetailedCryptoData {
//   final String id;
//   final String name;
//   final String symbol;
//   final String description;
//   final String image;
//   final double currentPrice;
//   final double marketCap;
//   final double tradingVolume;
//   final double priceChange24h;
//   final double marketCapRank;
//   final List<List<double>> historicalData;
//   final Map<String, dynamic> communityData;
//   final Map<String, dynamic> developerData;

//   DetailedCryptoData({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.description,
//     required this.image,
//     required this.currentPrice,
//     required this.marketCap,
//     required this.tradingVolume,
//     required this.priceChange24h,
//     required this.marketCapRank,
//     required this.historicalData,
//     required this.communityData,
//     required this.developerData,
//   });

//   factory DetailedCryptoData.fromJson(Map<String, dynamic> json, List<dynamic> historicalData) {
//     return DetailedCryptoData(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       symbol: json['symbol'] ?? '',
//       description: json['description']['en'] ?? '',
//       image: json['image']['large'] ?? '',
//       currentPrice: (json['market_data']['current_price']['usd'] ?? 0).toDouble(),
//       marketCap: (json['market_data']['market_cap']['usd'] ?? 0).toDouble(),
//       tradingVolume: (json['market_data']['total_volume']['usd'] ?? 0).toDouble(),
//       priceChange24h: (json['market_data']['price_change_percentage_24h'] ?? 0).toDouble(),
//       marketCapRank: (json['market_cap_rank'] ?? 0).toDouble(),
//       historicalData: (historicalData as List<dynamic>).map((data) =>
//         [data[0] as double? ?? 0.0, data[1] as double? ?? 0.0]).toList(),
//       communityData: json['community_data'] ?? {},
//       developerData: json['developer_data'] ?? {},
//     );
//   }
// }
// class CachedData<T> {
//   final T data;
//   final DateTime timestamp;

//   CachedData({required this.data, required this.timestamp});
// }

// class CryptoPackCache {
//   final Map<String, CachedData<List<dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 15);

//   Future<void> setCryptoPackData(String packId, List<dynamic> data) async {
//     _cache[packId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   List<dynamic>? getCryptoPackData(String packId) {
//     if (_cache.containsKey(packId) && !_isCacheExpired(packId)) {
//       return _cache[packId]!.data;
//     }
//     return null;
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class CryptoApiService {
//   final Dio _dio = Dio();
//   final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 5);

//   CryptoApiService() {
//     _dio.interceptors.add(InterceptorsWrapper(
//       onError: (DioError e, ErrorInterceptorHandler handler) {
//         ApiError error;
//         if (e.response != null) {
//           error = ApiError(
//             message: e.response!.data['message'] ?? 'Unknown error',
//             statusCode: e.response!.statusCode
//           );
//         } else {
//           error = ApiError(message: e.message ?? 'Unknown error');
//         }
//         throw error;
//       },
//     ));
//   }

//   Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
//     if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
//       return _cache[symbol]!.data;
//     }

//     try {
//       final response = await _dio.get(
//           'https://api.coingecko.com/api/v3/simple/price?ids=$symbol&vs_currencies=usd&include_24hr_change=true');
//       final data = {
//         'currentPrice': response.data[symbol]['usd'],
//         'priceChange24h': response.data[symbol]['usd_24h_change'],
//       };
//       _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
//       return data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to load price data');
//     }
//   }

//   Future<Map<String, dynamic>> searchCrypto(String query) async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/search?query=$query');
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to search crypto');
//     }
//   }

//   Future<List<dynamic>> fetchCryptoData(String coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds,
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchBatchCryptoData(List<String> coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds.join(','),
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return Map.fromIterable(response.data, key: (item) => item['id'], value: (item) => item);
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch batch data');
//     }
//   }
// Future<Map<String, dynamic>> fetchDetailedCoinData(String coinId) async {
//   try {
//     final response = await _dio.get(
//       'https://api.coingecko.com/api/v3/coins/$coinId',
//       queryParameters: {
//         'localization': 'false',
//         'tickers': 'false',
//         'market_data': 'true',
//         'community_data': 'true',
//         'developer_data': 'true',
//       },
//     );
//     return response.data ?? {};
//   } catch (e) {
//     print('Error fetching detailed coin data: $e');
//     throw ApiError(message: 'Failed to fetch detailed coin data');
//   }
// }

// Future<List<dynamic>> fetchCoinMarketChart(String coinId, int days) async {
//   try {
//     final response = await _dio.get(
//       'https://api.coingecko.com/api/v3/coins/$coinId/market_chart',
//       queryParameters: {
//         'vs_currency': 'usd',
//         'days': days,
//       },
//     );
//     return response.data['prices'] ?? [];
//   } catch (e) {
//     print('Error fetching market chart data: $e');
//     throw ApiError(message: 'Failed to fetch market chart data');
//   }
// }

//   Future<Map<String, dynamic>> fetchGlobalData() async {
//     try {
//       final response = await _dio.get('https://api.coingecko.com/api/v3/global');
//       return response.data['data'];
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch global data');
//     }
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }

// class HoldingsProvider with ChangeNotifier {
//   final CryptoApiService _apiService = CryptoApiService();
//   final CryptoPackCache _cryptoPackCache = CryptoPackCache();
//   List<CryptoHolding> _holdings = [];
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _isSearching = false;
//   bool _isLoadingSearch = false;

//   List<CryptoHolding> get holdings => _holdings;
//   List<Map<String, dynamic>> get searchResults => _searchResults;
//   bool get isSearching => _isSearching;
//   bool get isLoadingSearch => _isLoadingSearch;

//   Future<void> fetchHoldings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = prefs.getStringList('holdings') ?? [];
//       _holdings = holdingsJson
//           .map((json) => CryptoHolding.fromJson(jsonDecode(json)))
//           .toList();
//       await _updateHoldingsData();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching holdings: $e');
//     }
//   }

//   Future<void> _updateHoldingsData() async {
//     final futures = _holdings.map((holding) => _apiService.getCurrentPriceData(holding.symbol)).toList();
//     final results = await Future.wait(futures);

//     for (var i = 0; i < _holdings.length; i++) {
//       try {
//         final priceData = results[i];
//         _holdings[i].currentPrice = priceData['currentPrice'].toDouble();
//         _holdings[i].currentValue = _holdings[i].quantity * _holdings[i].currentPrice;
//         _holdings[i].profitLoss = _holdings[i].currentValue - _holdings[i].investedAmount;
//         _holdings[i].dailyProfitLoss = _holdings[i].currentValue * (priceData['priceChange24h'] / 100);
//       } catch (e) {
//         print('Error updating holding data for ${_holdings[i].symbol}: $e');
//       }
//     }
//   }

//   Future<void> searchCrypto(String searchTerm) async {
//     _isSearching = searchTerm.isNotEmpty;
//     if (_isSearching) {
//       _isLoadingSearch = true;
//       notifyListeners();
//       try {
//         final results = await _apiService.searchCrypto(searchTerm);
//         _searchResults = List<Map<String, dynamic>>.from(results['coins']);
//       } catch (e) {
//         print('Error searching crypto: $e');
//         _searchResults = [];
//       }
//       _isLoadingSearch = false;
//     } else {
//       _searchResults = [];
//     }
//     notifyListeners();
//   }

//   Future<void> addHolding(String symbol, String name, double quantity, double averagePrice) async {
//       try {
//       final priceData = await _apiService.getCurrentPriceData(symbol);
//       final currentPrice = priceData['currentPrice'].toDouble();
//       final currentValue = quantity * currentPrice;
//       final investedAmount = quantity * averagePrice;
//       final profitLoss = currentValue - investedAmount;
//       final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//       final existingHoldingIndex = _holdings.indexWhere((holding) => holding.symbol == symbol);

//       if (existingHoldingIndex != -1) {
//         final existingHolding = _holdings[existingHoldingIndex];
//         final newQuantity = existingHolding.quantity + quantity;
//         final newInvestedAmount = existingHolding.investedAmount + investedAmount;
//         final newAveragePrice = newInvestedAmount / newQuantity;

//         _holdings[existingHoldingIndex].quantity = newQuantity;
//         _holdings[existingHoldingIndex].averagePrice = newAveragePrice;
//         _holdings[existingHoldingIndex].investedAmount = newInvestedAmount;
//         _holdings[existingHoldingIndex].currentPrice = currentPrice;
//         _holdings[existingHoldingIndex].currentValue = newQuantity * currentPrice;
//         _holdings[existingHoldingIndex].profitLoss = _holdings[existingHoldingIndex].currentValue - _holdings[existingHoldingIndex].investedAmount;
//         _holdings[existingHoldingIndex].dailyProfitLoss = _holdings[existingHoldingIndex].currentValue * (priceData['priceChange24h'] / 100);
//       } else {
//         final newHolding = CryptoHolding(
//           symbol: symbol,
//           name: name,
//           quantity: quantity,
//           averagePrice: averagePrice,
//           currentPrice: currentPrice,
//           currentValue: currentValue,
//           investedAmount: investedAmount,
//           profitLoss: profitLoss,
//           dailyProfitLoss: dailyProfitLoss,
//         );

//         _holdings.add(newHolding);
//       }

//       await _saveHoldings();
//       notifyListeners();
//     } catch (e) {
//       print('Error adding holding: $e');
//     }
//   }

//   Future<void> updateHolding(String symbol, double quantity, double averagePrice) async {
//      final index = _holdings.indexWhere((holding) => holding.symbol == symbol);
//     if (index != -1) {
//       try {
//         final priceData = await _apiService.getCurrentPriceData(symbol);
//         final currentValue = quantity * priceData['currentPrice'];
//         final investedAmount = quantity * averagePrice;
//         final profitLoss = currentValue - investedAmount;
//         final dailyProfitLoss = currentValue * (priceData['priceChange24h'] / 100);

//         _holdings[index].quantity = quantity;
//         _holdings[index].averagePrice = averagePrice;
//         _holdings[index].currentPrice = priceData['currentPrice'];
//         _holdings[index].currentValue = currentValue;
//         _holdings[index].investedAmount = investedAmount;
//         _holdings[index].profitLoss = profitLoss;
//         _holdings[index].dailyProfitLoss = dailyProfitLoss;

//         await _saveHoldings();
//         notifyListeners();
//       } catch (e) {
//         print('Error updating holding: $e');
//       }
//     }
//   }

//   void removeHolding(String symbol) {
//      _holdings.removeWhere((holding) => holding.symbol == symbol);
//     _saveHoldings();
//     notifyListeners();
//   }

//   double getTotalValue() {
//     return _holdings.fold(0, (sum, holding) => sum + holding.currentValue);
//   }

//   Future<void> _saveHoldings() async {
//      try {
//       final prefs = await SharedPreferences.getInstance();
//       final holdingsJson = _holdings.map((holding) => jsonEncode(holding.toJson())).toList();
//       await prefs.setStringList('holdings', holdingsJson);
//     } catch (e) {
//       print('Error saving holdings: $e');
//     }
//   }

//   Future<void> preloadCryptoPacks(List<CryptoPack> cryptoPacks) async {
//     final allCoinIds = cryptoPacks.expand((pack) => pack.coinIds).toSet().toList();
//     try {
//       final batchData = await _apiService.fetchBatchCryptoData(allCoinIds);
//       for (var pack in cryptoPacks) {
//         final packData = pack.coinIds.map((id) => batchData[id]).toList();
//         await _cryptoPackCache.setCryptoPackData(pack.id, packData);
//       }
//     } catch (e) {
//       print('Error preloading crypto packs: $e');
//     }
//   }

// }

// class AppTheme {
//   static const primaryColor = Color(0xFF2196F3);
//   static const secondaryColor = Color(0xFF4CAF50);
//   static const backgroundColor = Color(0xFFF5F5F5);
//   static const cardColor = Colors.white;
//   static const textColor = Color(0xFF333333);
//   static const lightTextColor = Color(0xFF666666);

//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: primaryColor,
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: secondaryColor,
//       ),
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: AppBarTheme(
//         color: primaryColor,
//         elevation: 0,
//       ),
//       cardTheme: CardTheme(
//         color: cardColor,
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
//         titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
//         bodyMedium: TextStyle(color: textColor, fontSize: 14),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: primaryColor,
//         textTheme: ButtonTextTheme.primary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }

// class CryptoPackScreen extends StatefulWidget {
//   @override
//   _CryptoPackScreenState createState() => _CryptoPackScreenState();
// }

// class _CryptoPackScreenState extends State<CryptoPackScreen> {////////////////////////////////////////////////////////////////////////////////////////
//   final CryptoApiService _apiService = CryptoApiService();
//   int _currentPage = 0;
//   static const int _packsPerPage = 6;

//   @override
//   void initState() {
//     super.initState();
//     _calculatePercentageChange();
//     _preloadCryptoPacks();
//   }

//    void _preloadCryptoPacks() {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);
//     holdingsProvider.preloadCryptoPacks(_cryptoPacks);
//   }

//   void _calculatePercentageChange() async {
//     for (var pack in _cryptoPacks) {
//       try {
//         double percentageChange = await _fetchPercentageChange(pack.coinIds);
//         setState(() {
//           pack.percentageChange = percentageChange;
//         });
//       } catch (e) {
//         print('Error calculating percentage change for ${pack.name}: $e');
//         setState(() {
//           pack.percentageChange = pack.percentageChange;
//         });
//       }
//     }
//   }

//   Future<double> _fetchPercentageChange(List<String> coinIds) async {
//     try {
//       final ids = coinIds.join(',');
//       final response = await _apiService.fetchCryptoData(ids);
//       if (response.isNotEmpty) {
//         final totalChange = response.fold(0.0, (sum, coinData) {
//           return sum + (coinData['price_change_percentage_24h'] ?? 0.0);
//         });
//         return totalChange / response.length;
//       }
//       return 0.0;
//     } catch (e) {
//       print('Error fetching percentage change: $e');
//       return 0.0;
//     }
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CryptoPack', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         elevation: 0,
//       ),
//       drawer: _buildDrawer(context),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('ALL CRYPTOPACKS', style: TextStyle(fontSize: 12)),//12/////////////////////////////////////////////////////////////////////////////////////////////////////
//                       style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.primaryColor,
//                     foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Coming soon!')),
//                         );
//                       },
//                       child: Text('MY CRYPTOPACKS', style: TextStyle(fontSize: 14)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.secondaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.all(16.0),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final packIndex = _currentPage * _packsPerPage + index;
//                   if (packIndex >= _cryptoPacks.length) {
//                     return SizedBox.shrink();
//                   }
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CryptoPackDetailScreen(pack: _cryptoPacks[packIndex]),
//                         ),
//                       );
//                     },
//                     child: CryptoPackCard(pack: _cryptoPacks[packIndex]),
//                   );
//                 },
//                 childCount: _packsPerPage,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//  Widget _buildDrawer(BuildContext context) {
//   final user = supabase.auth.currentUser;
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         UserAccountsDrawerHeader(
//           accountName: Text(user?.userMetadata?['first_name'] ?? 'User'),
//           accountEmail: Text(user?.email ?? ''),
//           currentAccountPicture: CircleAvatar(
//             backgroundImage: NetworkImage(
//               'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//             ),
//           ),
//           decoration: BoxDecoration(
//             color: AppTheme.primaryColor,
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.home),
//           title: Text('Home', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//   leading: Icon(Icons.account_circle),
//   title: Text('Profile', style: TextStyle(fontSize: 18)),
//   onTap: () {
//     Navigator.pop(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfilePage()),
//     );
//   },
// ),
//         ListTile(
//           leading: Icon(Icons.account_balance_wallet),
//           title: Text('My Portfolio', style: TextStyle(fontSize: 18)),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HoldingsScreen()),
//             );
//           },
//         ),
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('FAQ', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FAQScreen()),
//               );
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.support),
//             title: Text('Help & Support', style: TextStyle(fontSize: 18)),
//             onTap: () {
//               launch('mailto:cryptoforyouhelp@gmail.com');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CryptoPackCard extends StatelessWidget {
//   final CryptoPack pack;

//   const CryptoPackCard({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.secondaryColor.withOpacity(0.1)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(9.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       pack.name,
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(pack.icon, color: AppTheme.primaryColor),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 pack.description,
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Spacer(),
//               Text(
//                 'Rec.investement:',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//               ),
//               Text(
//                 '\$${pack.RecommendedInvestment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Change:',
//                     style: TextStyle(fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
//                   ),
//                   Text(
//                     '${pack.percentageChange.toStringAsFixed(2)}%',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: pack.percentageChange >= 0 ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Trend: ${pack.trend}',
//                 style: TextStyle(fontSize: 12, color: AppTheme.textColor),
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CryptoPackDetailScreen(pack: pack),
//                       ),
//                     );
//                   },
//                   child: Text('Know More', style: TextStyle(fontSize: 12)),
//                   style: ElevatedButton.styleFrom(
//                backgroundColor    : AppTheme.primaryColor,
//                foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CryptoDataRepository {
//   final CryptoApiService _apiService;
//   final Map<String, CachedData<DetailedCryptoData>> _cache = {};
//   static const Duration _cacheDuration = Duration(hours: 1);

//   CryptoDataRepository(this._apiService);

//   Future<DetailedCryptoData?> getCachedDetailedCryptoData(String coinId) async {
//     final cachedData = _cache[coinId];
//     if (cachedData != null && !_isCacheExpired(cachedData.timestamp)) {
//       return cachedData.data;
//     }
//     return null;
//   }

//   Future<void> cacheDetailedCryptoData(String coinId, DetailedCryptoData data) async {
//     _cache[coinId] = CachedData(data: data, timestamp: DateTime.now());
//   }

//   bool _isCacheExpired(DateTime timestamp) {
//     return DateTime.now().difference(timestamp) > _cacheDuration;
//   }

//   Future<DetailedCryptoData> fetchDetailedCryptoData(String coinId, int days) async {
//     final coinData = await _apiService.fetchDetailedCoinData(coinId);
//     final historicalData = await _apiService.fetchCoinMarketChart(coinId, days);
//     return DetailedCryptoData.fromJson(coinData, historicalData);
//   }

//   Future<List<List<double>>> fetchAdditionalHistoricalData(String coinId, int fromDays, int toDays) async {
//   final historicalData = await _apiService.fetchCoinMarketChart(coinId, toDays);
//   return (historicalData as List<dynamic>)
//       .sublist(fromDays * 24)
//       .map((data) => [
//             (data[0] as num).toDouble(),
//             (data[1] as num).toDouble(),
//           ])
//       .toList();
// }

//   Future<String?> getNextCoinId(String currentCoinId) async {
//     return null;
//   }

//   Future<void> prefetchDetailedCryptoData(String coinId, int days) async {
//     try {
//       final data = await fetchDetailedCryptoData(coinId, days);
//       await cacheDetailedCryptoData(coinId, data);
//     } catch (e) {
//       print('Error prefetching data for $coinId: $e');
//     }
//   }
// }

// class CryptoDetailScreen extends StatefulWidget {
//   final String coinId;

//   const CryptoDetailScreen({Key? key, required this.coinId}) : super(key: key);

//   @override
//   _CryptoDetailScreenState createState() => _CryptoDetailScreenState();
// }

// class _CryptoDetailScreenState extends State<CryptoDetailScreen> {
//   Map<String, dynamic>? data;
//   List<FlSpot> priceHistory = [];
//   bool isLoading = true;
//   late Timer _refreshTimer;
//   final NumberFormat currencyFormat = NumberFormat.currency(symbol: '\$');

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     _refreshTimer = Timer.periodic(const Duration(minutes: 1), (_) => fetchData());
//   }

//   @override
//   void dispose() {
//     _refreshTimer.cancel();
//     super.dispose();
//   }

//   Future<void> fetchData() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cachedData = prefs.getString('crypto_data_${widget.coinId}');
//       final cachedTimestamp = prefs.getInt('crypto_data_timestamp_${widget.coinId}');

//       final currentTime = DateTime.now().millisecondsSinceEpoch;
//       const cacheExpiration = 5 * 60 * 1000;

//       if (cachedData != null && cachedTimestamp != null && currentTime - cachedTimestamp < cacheExpiration) {
//         data = jsonDecode(cachedData);
//       } else {
//         final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/${widget.coinId}'));
//         if (response.statusCode == 200) {
//           final fetchedData = jsonDecode(response.body);
//           await prefs.setString('crypto_data_${widget.coinId}', jsonEncode(fetchedData));
//           await prefs.setInt('crypto_data_timestamp_${widget.coinId}', currentTime);
//           data = fetchedData;
//         }
//       }

//       await fetchPriceHistory();
//     } catch (e) {
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> fetchPriceHistory() async {
//   try {
//     final response = await http.get(Uri.parse(
//         'https://api.coingecko.com/api/v3/coins/${widget.coinId}/market_chart?vs_currency=usd&days=7'));
//     if (response.statusCode == 200) {
//       final List<dynamic> prices = jsonDecode(response.body)['prices'];
//       setState(() {
//         priceHistory = prices
//             .map((price) => FlSpot(price[0].toDouble(), price[1].toDouble()))
//             .toList();
//       });
//     } else {
//       setState(() {
//         priceHistory = [];
//       });
//     }
//   } catch (e) {
//     setState(() {
//       priceHistory = [];
//     });
//   }
// }

//   Future<void> launchURL(String urlString) async {
//     final Uri url = Uri.parse(urlString);
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Crypto Details'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: fetchData,
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : RefreshIndicator(
//               onRefresh: fetchData,
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CryptoHeader(data: data),
//                     const SizedBox(height: 16),
//                     PriceInfo(data: data, currencyFormat: currencyFormat),
//                     const SizedBox(height: 16),
//                     PriceChart(priceHistory: priceHistory),
//                     const SizedBox(height: 16),
//                     Description(data: data),
//                     const SizedBox(height: 16),
//                     Links(data: data, launchURL: launchURL),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// class CryptoHeader extends StatelessWidget {
//   final Map<String, dynamic>? data;

//   const CryptoHeader({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Image.network(
//           data?['image']['large'] ?? '',
//           width: 50,
//           height: 50,
//         ),
//         const SizedBox(width: 16),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               data?['name'] ?? '',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               data?['symbol']?.toUpperCase() ?? '',
//               style: const TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class PriceInfo extends StatelessWidget {
//   final Map<String, dynamic>? data;
//   final NumberFormat currencyFormat;

//   const PriceInfo({Key? key, required this.data, required this.currencyFormat}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Price: ${currencyFormat.format(data?['market_data']['current_price']['usd'] ?? 0)}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Market Cap: ${currencyFormat.format(data?['market_data']['market_cap']['usd'] ?? 0)}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '24h Volume: ${currencyFormat.format(data?['market_data']['total_volume']['usd'] ?? 0)}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '24h Change: ${(data?['market_data']['price_change_percentage_24h'] ?? 0).toStringAsFixed(2)}%',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: (data?['market_data']['price_change_percentage_24h'] ?? 0) >= 0
//                     ? Colors.green
//                     : Colors.red,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PriceChart extends StatelessWidget {
//   final List<FlSpot> priceHistory;

//   const PriceChart({Key? key, required this.priceHistory}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: priceHistory.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : LineChart(
//               LineChartData(
//                 gridData: FlGridData(show: false),
//                 titlesData: FlTitlesData(show: false),
//                 borderData: FlBorderData(show: false),
//                 minX: priceHistory.map((spot) => spot.x).reduce((a, b) => a < b ? a : b),
//                 maxX: priceHistory.map((spot) => spot.x).reduce((a, b) => a > b ? a : b),
//                 minY: priceHistory.map((spot) => spot.y).reduce((a, b) => a < b ? a : b),
//                 maxY: priceHistory.map((spot) => spot.y).reduce((a, b) => a > b ? a : b),
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: priceHistory,
//                     isCurved: true,
//                     color: Theme.of(context).primaryColor,
//                     barWidth: 2,
//                     dotData: FlDotData(show: false),
//                     belowBarData: BarAreaData(
//                       show: true,
//                       color: Theme.of(context).primaryColor.withOpacity(0.3),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

// class Description extends StatelessWidget {
//   final Map<String, dynamic>? data;

//   const Description({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Description',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               data?['description']['en'] ?? '',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Links extends StatelessWidget {
//   final Map<String, dynamic>? data;
//   final Function(String) launchURL;

//   const Links({Key? key, required this.data, required this.launchURL}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final List<String> homepageUrls = List<String>.from(data?['links']?['homepage'] ?? []);
//     final String? whitepaperUrl = data?['links']?['whitepaper'];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (homepageUrls.isNotEmpty && homepageUrls.first.isNotEmpty) ...[
//           const Text(
//             'Official Website:',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           _buildLinkRow(homepageUrls.first, 'Visit Website'),
//           const SizedBox(height: 16),
//         ],
//         if (whitepaperUrl != null && whitepaperUrl.isNotEmpty) ...[
//           const Text(
//             'Whitepaper:',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           _buildLinkRow(whitepaperUrl, 'View Whitepaper'),
//         ] else ...[
//           const Text(
//             'Whitepaper:',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const Text('No whitepaper available'),
//         ],
//       ],
//     );
//   }

//   Widget _buildLinkRow(String url, String label) {
//     return InkWell(
//       onTap: () => launchURL(url),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 label,
//                 style: const TextStyle(color: Colors.blue),
//               ),
//             ),
//             const Icon(Icons.open_in_new, color: Colors.blue),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CryptoPackDetailScreen extends StatelessWidget {
//   final CryptoPack pack;
//   const CryptoPackDetailScreen({Key? key, required this.pack}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(pack.name, style: TextStyle(color: Colors.white)),
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(pack.icon, size: 80, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoCard('About', pack.about),
//                   SizedBox(height: 16),
//                   _buildInfoCard('RecommendedInvestment', '\$${pack.RecommendedInvestment.toStringAsFixed(2)}'),
//                   SizedBox(height: 16),
//                   _buildInfoCard('Trend', pack.trend),
//                   SizedBox(height: 16),
//                   _buildInfoCard('24h Change', '${pack.percentageChange.toStringAsFixed(2)}%'),
//                   SizedBox(height: 24),
//                   Text(
//                     'Coin Distribution',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: FutureBuilder<List<dynamic>>(
//               future: _fetchCryptoData(context),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No data available', style: TextStyle(fontSize: 18)));
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         padding: EdgeInsets.all(16.0),
//                         child: PieChart(
//                           PieChartData(
//                             sections: getPieChartSections(snapshot.data!),
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                             borderData: FlBorderData(show: false),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) => _buildCoinListTile(context, snapshot.data![index]),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Investment functionality coming soon!')),
//             );
//           },
//           child: Text('Invest Now', style: TextStyle(fontSize: 18)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppTheme.primaryColor,
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(value, style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCoinListTile(BuildContext context, dynamic coin) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: coin['image'],
//           width: 40,
//           height: 40,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         title: Text(coin['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text('${coin['current_price'].toStringAsFixed(2)} USD'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
//               style: TextStyle(
//                 color: coin['price_change_percentage_24h'] >= 0 ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text('24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CryptoDetailScreen(coinId: coin['id']),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<List<dynamic>> _fetchCryptoData(BuildContext context) async {
//     final holdingsProvider = Provider.of<HoldingsProvider>(context, listen: false);

//     final cachedData = holdingsProvider._cryptoPackCache.getCryptoPackData(pack.id);
//     if (cachedData != null) {
//       return cachedData;
//     }

//     final cryptoApiService = CryptoApiService();
//     final coinIds = _packPercentages[pack.id]?.keys.join(',') ?? '';
//     final data = await cryptoApiService.fetchCryptoData(coinIds);
//     await holdingsProvider._cryptoPackCache.setCryptoPackData(pack.id, data);
//     return data;
//   }

//   List<PieChartSectionData> getPieChartSections(List<dynamic> cryptoData) {
//     List<PieChartSectionData> sections = [];
//     final packPercentages = _packPercentages[pack.id] ?? {};
//     final colors = [
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.purple,
//       Colors.orange,
//     ];

//     int colorIndex = 0;
//     for (var coin in cryptoData) {
//       final percentage = packPercentages[coin['id']] ?? 0;
//       sections.add(
//         PieChartSectionData(
//           value: percentage,
//           title: '${coin['symbol'].toUpperCase()}\n${(percentage * 100).toStringAsFixed(0)}%',
//           color: colors[colorIndex % colors.length],
//           radius: 40,
//           titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//       colorIndex++;
//     }

//     return sections;
//   }

//   static const Map<String, Map<String, double>> _packPercentages = {
//     'RAW Frontrunners': {
//       'ix-swap': 0.2,
//       'realio-network': 0.2,
//       'clearpool': 0.2,
//       'polytrade': 0.2,
//       'maple': 0.2,
//     },
//     'CeDefi-Defi & Privacy': {
//       'fideum': 0.5,
//       'oasis-network': 0.5,
//     },
//     'High Caps': {
//       'bitcoin': 0.4,
//       'ethereum': 0.4,
//       'chainlink': 0.2,
//     },
//     'ultimate_alts': {
//       'cardano': 0.3,
//       'solana': 0.3,
//       'polkadot': 0.2,
//       'avalanche-2': 0.2,
//     },
//     'high_risk_high_reward': {
//       'maga': 1,
//     },
//     'Artificial Intelligence': {
//       'near': 1,
//     },
//   };
// }

// class FAQScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FAQ'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           ExpansionTile(
//             title: Text('What is CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'CryptoPack is a selection of curated cryptocurrency portfolios designed to suit various investment strategies.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How do I invest in a CryptoPack?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'You can invest in a CryptoPack by selecting your desired pack and making a minimum investment as specified.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Is there a risk in investing in cryptocurrencies?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, investing in cryptocurrencies carries risks due to their volatile nature. It is advisable to do thorough research and invest wisely.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('How is the percentage change calculated?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'The percentage change is calculated based on the change in the value of the cryptocurrencies in the pack over the past 24 hours.',
//                 ),
//               ),
//             ],
//           ),
//           ExpansionTile(
//             title: Text('Can I track my investments?'),
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Yes, you can track your investments through the "My CryptoPacks" section, which will be available soon.',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HoldingsScreen extends StatefulWidget {
//   @override
//   _HoldingsScreenState createState() => _HoldingsScreenState();
// }

// class _HoldingsScreenState extends State<HoldingsScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _averagePriceController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _quantityController.dispose();
//     _averagePriceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: _buildHoldingsTheme(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My Portfolio'),
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minWidth: MediaQuery.of(context).size.width,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildSearchBar(),
//                   _buildPortfolioOverview(),
//                   Consumer<HoldingsProvider>(
//                     builder: (context, provider, child) {
//                       return provider.isSearching
//                           ? _buildSearchResults(provider)
//                           : _buildHoldingsList(provider);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   ThemeData _buildHoldingsTheme() {
//     return ThemeData(
//       primaryColor: const Color(0xFF6200EE),
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         secondary: Color(0xFF03DAC6),
//       ),
//       scaffoldBackgroundColor: Color(0xFFF5F5F5),
//       cardTheme: CardTheme(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       textTheme: TextTheme(
//         titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6200EE)),
//         titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//         bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.all(16.0),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => context.read<HoldingsProvider>().searchCrypto(value),
//         decoration: InputDecoration(
//           hintText: 'Search cryptocurrencies...',
//           prefixIcon: Icon(Icons.search),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _searchController.clear();
//               context.read<HoldingsProvider>().searchCrypto('');
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPortfolioOverview() {
//     return Consumer<HoldingsProvider>(
//       builder: (context, provider, child) {
//         return Container(
//           width: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.all(16),
//           margin: EdgeInsets.symmetric(vertical: 8),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Portfolio Value',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '${provider.getTotalValue().toStringAsFixed(2)} USD',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchResults(HoldingsProvider provider) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       child: provider.isLoadingSearch
//           ? Center(child: CircularProgressIndicator())
//           : provider.searchResults.isEmpty
//               ? Center(child: Text('No results found'))
//               : ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: provider.searchResults.length,
//                   itemBuilder: (context, index) {
//                     final result = provider.searchResults[index];
//                     return ListTile(
//                       leading: CachedNetworkImage(
//                         imageUrl: result['large'] ?? '',
//                         width: 40,
//                         height: 40,
//                         placeholder: (context, url) => CircularProgressIndicator(),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                       ),
//                       title: Text(result['name']),
//                       subtitle: Text(result['symbol']),
//                       onTap: () => _showAddHoldingDialog(context, result, provider),
//                     );
//                   },
//                 ),
//     );
//   }

//   Widget _buildHoldingsList(HoldingsProvider provider) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: provider.holdings.length,
//         itemBuilder: (context, index) {
//           final holding = provider.holdings[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     holding.name,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   Text(
//                     holding.symbol.toUpperCase(),
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 8),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 4,
//                     children: [
//                       Text('Quantity: ${holding.quantity.toStringAsFixed(4)}'),
//                       Text('Avg. Price: ${holding.averagePrice.toStringAsFixed(2)} USD'),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 4,
//                     children: [
//                       Text('Current Value: ${holding.currentValue.toStringAsFixed(2)} USD'),
//                       Text(
//                         'P/L: ${holding.profitLoss.toStringAsFixed(2)} USD',
//                         style: TextStyle(
//                           color: holding.profitLoss >= 0 ? Colors.green : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 4,
//                     children: [
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: false,
//                           holding: holding,
//                         ),
//                         child: Text('Add'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showAddHoldingDialog(
//                           context,
//                           {'id': holding.symbol, 'name': holding.name},
//                           provider,
//                           isEdit: true,
//                           holding: holding,
//                         ),
//                         child: Text('Edit'),
//                         style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//                       ),
//                       TextButton(
//                         onPressed: () => _showRemoveHoldingDialog(context, holding, provider),
//                         child: Text('Remove'),
//                         style: TextButton.styleFrom(foregroundColor: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _showAddHoldingDialog(BuildContext context, Map<String, dynamic>? result, HoldingsProvider provider, {bool isEdit = false, CryptoHolding? holding}) {
//     if (isEdit) {
//       _quantityController.text = '';
//       _averagePriceController.text = holding!.averagePrice.toString();
//     } else {
//       _quantityController.clear();
//       _averagePriceController.clear();
//     }

//     String operation = 'Add';

//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text(isEdit ? 'Edit Holding' : 'Add Holding'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (isEdit)
//                     DropdownButton<String>(
//                       value: operation,
//                       items: ['Add', 'Subtract'].map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           operation = newValue!;
//                         });
//                       },
//                     ),
//                   TextField(
//                     controller: _quantityController,
//                     decoration: InputDecoration(
//                       labelText: 'Quantity',
//                     ),
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   ),
//                   SizedBox(height: 16),
//                   TextField(
//                     controller: _averagePriceController,
//                     decoration: InputDecoration(
//                       labelText: 'Price',
//                     ),
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     final newQuantity = double.tryParse(_quantityController.text) ?? 0;
//                     final newPrice = double.tryParse(_averagePriceController.text) ?? 0;

//                     if (isEdit) {
//                       final operationMultiplier = operation == 'Add' ? 1 : -1;
//                       final totalValue = (holding!.quantity * holding.averagePrice) + (newQuantity * newPrice * operationMultiplier);
//                       final totalQuantity = holding.quantity + (newQuantity * operationMultiplier);

//                       if (totalQuantity <= 0) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Cannot subtract more than available quantity')),
//                         );
//                         return;
//                       }

//                       final newAveragePrice = totalValue / totalQuantity;

//                       provider.updateHolding(
//                         holding.symbol,
//                         totalQuantity,
//                         newAveragePrice,
//                       );
//                     } else {
//                       provider.addHolding(
//                         result!['id'],
//                         result['name'],
//                         newQuantity,
//                         newPrice,
//                       );
//                     }
//                     Navigator.pop(context);
//                   },
//                   child: Text(isEdit ? 'Update' : 'Add'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   void _showRemoveHoldingDialog(BuildContext context, CryptoHolding holding, HoldingsProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Holding'),
//         content: Text('Are you sure you want to remove ${holding.name} from your portfolio?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//             style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               provider.removeHolding(holding.symbol);
//               Navigator.pop(context);
//             },
//             child: Text('Remove'),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class SplashScreen extends StatefulWidget {
// //   @override
// //   _SplashScreenState createState() => _SplashScreenState();
// // }

// // class _SplashScreenState extends State<SplashScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     Timer(Duration(seconds: 3), () {
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (context) => CryptoPackScreen()),
// //       );
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Color.fromARGB(255, 15, 14, 14),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Image.asset(
// //               'android/logo (1).jpg',
// //               width: MediaQuery.of(context).size.width * 0.4,
// //               height: MediaQuery.of(context).size.width * 0.4,
// //             ),
// //             SizedBox(height: 24),
// //             Text(
// //               'CryptoForYou',
// //               style: TextStyle(
// //                 fontSize: 28,
// //                 fontWeight: FontWeight.bold,
// //                 color: Color.fromARGB(255, 238, 242, 244),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// void main() async {
//  // WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://pajnoqsxkpaujmdskmjy.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBham5vcXN4a3BhdWptZHNrbWp5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDE3Mjk0NywiZXhwIjoyMDM1NzQ4OTQ3fQ.uZY4kBkg-yu8z29Xt8DLqtvkalD-FmMQyMjMzr8WTmM',
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) {
//         final provider = HoldingsProvider()..fetchHoldings();
//         provider.preloadCryptoPacks(_cryptoPacks);
//         return provider;
//       },

//       child: MyApp(),
//     ),
//   );
// }
//  final supabase = Supabase.instance.client;
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CryptoPack',
//       theme: AppTheme.lightTheme,
//       home: SignInPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'profile.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final List<CryptoPack> _cryptoPacks = [
  CryptoPack(
    name: 'RAW Frontrunners',
    description: 'Cutting-edge innovation with pioneering technologies',
    RecommendedInvestment: 1000.00,
    percentageChange: 0.0,
    trend: 'Moderately High',
    icon: Icons.trending_up,
    coinIds: ['ix-swap', 'realio-network', 'clearpool', 'polytrade', 'maple'],
    about:
        'RAW Frontrunners pack focuses on cryptocurrencies that are leading the way in terms of innovation and market influence.',
    id: 'RAW Frontrunners',
    officialLinks: {
      'ix-swap': 'https://ixswap.io/',
      'realio-network': 'https://realio.fund/',
      'clearpool': 'https://clearpool.finance/',
      'polytrade': 'https://polytrade.finance/',
      'maple': 'https://maple.finance/',
    },
    whitepaperLinks: {
      'ix-swap': 'https://ixswap.io/whitepaper',
      'realio-network': 'https://realio.fund/whitepaper.pdf',
      'clearpool': 'https://clearpool.finance/whitepaper.pdf',
      'polytrade': 'https://polytrade.finance/whitepaper.pdf',
      'maple': 'https://maple.finance/whitepaper.pdf',
    },
  ),
  CryptoPack(
    name: 'CeDefi-Defi & Privacy',
    description: 'Leading DeFi and privacy tokens',
    RecommendedInvestment: 1000.00,
    percentageChange: 0.0,
    trend: 'Very High',
    icon: Icons.security,
    coinIds: ['fideum', 'oasis-network'],
    about:
        'CeDefi-Defi & Privacy pack includes top-performing tokens in the DeFi and privacy space.',
    id: 'CeDefi-Defi & Privacy',
    officialLinks: {
      'fideum': 'https://fideum.com/',
      'oasis-network': 'https://oasisprotocol.org/',
    },
    whitepaperLinks: {
      'fideum': 'https://fideum.com/whitepaper.pdf',
      'oasis-network': 'https://oasisprotocol.org/papers/whitepaper.pdf',
    },
  ),
  CryptoPack(
    name: 'High Caps',
    description: 'The market-leading cryptocurrencies',
    RecommendedInvestment: 1000.00,
    percentageChange: 0.0,
    trend: 'Moderate',
    icon: Icons.star,
    coinIds: ['bitcoin', 'ethereum', 'chainlink'],
    about:
        'high caps pack contains the most prominent cryptocurrencies, suitable for beginners and experienced investors.',
    id: 'High Caps',
    officialLinks: {
      'bitcoin': 'https://bitcoin.org/',
      'ethereum': 'https://ethereum.org/',
      'chainlink': 'https://chain.link/',
    },
    whitepaperLinks: {
      'bitcoin': 'https://bitcoin.org/bitcoin.pdf',
      'ethereum': 'https://ethereum.org/en/whitepaper/',
      'chainlink': 'https://chain.link/whitepaper',
    },
  ),
  CryptoPack(
    name: 'Ultimate Alts of Tomorrow',
    description: 'The undisputed Alt Coin selection',
    RecommendedInvestment: 1000.00,
    percentageChange: 0.0,
    trend: 'Moderate',
    icon: Icons.monetization_on,
    coinIds: ['cardano', 'solana', 'polkadot', 'avalanche-2'],
    about:
        'Ultimate Alts pack features a selection of promising altcoins with potential for future growth.',
    id: 'ultimate_alts',
    officialLinks: {
      'cardano': 'https://cardano.org/',
      'solana': 'https://solana.com/',
      'polkadot': 'https://polkadot.network/',
      'avalanche-2': 'https://www.avax.network/',
    },
    whitepaperLinks: {
      'cardano': 'https://why.cardano.org/en/introduction/motivation/',
      'solana': 'https://solana.com/solana-whitepaper.pdf',
      'polkadot': 'https://polkadot.network/PolkaDotPaper.pdf',
      'avalanche-2': 'https://www.avalabs.org/whitepapers',
    },
  ),
  CryptoPack(
    name: 'HighRiskHighReward',
    description: 'High-risk investments with potential for high rewards',
    RecommendedInvestment: 250.00,
    percentageChange: 0.0,
    trend: 'High',
    icon: Icons.warning,
    coinIds: ['maga'],
    about:
        'HighRiskHighReward pack includes volatile cryptocurrencies with the potential for significant returns.',
    id: 'high_risk_high_reward',
    officialLinks: {
      'maga': 'https://magacoin.io/',
    },
    whitepaperLinks: {
      'maga': 'https://magacoin.io/whitepaper.pdf',
    },
  ),
  CryptoPack(
    name: 'Artificial Intelligence',
    description: 'Cutting-edge innovation with pioneering technologies',
    RecommendedInvestment: 500.00,
    percentageChange: 0.0,
    trend: 'Moderately High',
    icon: Icons.trending_up,
    coinIds: ['near'],
    about:
        'Artificial Intelligence pack focuses on cryptocurrencies that are leading the way in terms of innovation in artificial intelligence and market influence.',
    id: 'Artificial Intelligence',
    officialLinks: {
      'near': 'https://near.org/',
    },
    whitepaperLinks: {
      'near': 'https://near.org/papers/the-official-near-white-paper/',
    },
  )
];

class ApiError extends Error {
  final String message;
  final int? statusCode;

  ApiError({required this.message, this.statusCode});
}

class CryptoPack {
  final String name;
  final String description;
  final double RecommendedInvestment;
  double percentageChange;
  final String trend;
  final IconData icon;
  final String id;
  final String about;
  final List<String> coinIds;
  final Map<String, String> officialLinks;
  final Map<String, String> whitepaperLinks;

  CryptoPack({
    required this.name,
    required this.description,
    required this.RecommendedInvestment,
    required this.percentageChange,
    required this.trend,
    required this.icon,
    required this.id,
    required this.about,
    required this.coinIds,
    required this.officialLinks,
    required this.whitepaperLinks,
  });
}

class CryptoHolding {
  final String symbol;
  final String name;
  double quantity;
  double averagePrice;
  double currentPrice;
  double currentValue;
  double investedAmount;
  double profitLoss;
  double dailyProfitLoss;
  String? imageUrl;

  CryptoHolding(
      {required this.symbol,
      required this.name,
      required this.quantity,
      required this.averagePrice,
      required this.currentPrice,
      required this.currentValue,
      required this.investedAmount,
      required this.profitLoss,
      required this.dailyProfitLoss,
      this.imageUrl});

  factory CryptoHolding.fromJson(Map<String, dynamic> json) {
    return CryptoHolding(
      symbol: json['symbol'],
      name: json['name'],
      quantity: json['quantity'],
      averagePrice: json['averagePrice'],
      currentPrice: json['currentPrice'],
      currentValue: json['currentValue'],
      investedAmount: json['investedAmount'],
      profitLoss: json['profitLoss'],
      dailyProfitLoss: json['dailyProfitLoss'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'quantity': quantity,
      'averagePrice': averagePrice,
      'currentPrice': currentPrice,
      'currentValue': currentValue,
      'investedAmount': investedAmount,
      'profitLoss': profitLoss,
      'dailyProfitLoss': dailyProfitLoss,
    };
  }
}

class DetailedCryptoData {
  final String id;
  final String name;
  final String symbol;
  final String description;
  final String image;
  final double currentPrice;
  final double marketCap;
  final double tradingVolume;
  final double priceChange24h;
  final double marketCapRank;
  final List<List<double>> historicalData;
  final Map<String, dynamic> communityData;
  final Map<String, dynamic> developerData;

  DetailedCryptoData({
    required this.id,
    required this.name,
    required this.symbol,
    required this.description,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.tradingVolume,
    required this.priceChange24h,
    required this.marketCapRank,
    required this.historicalData,
    required this.communityData,
    required this.developerData,
  });

  factory DetailedCryptoData.fromJson(
      Map<String, dynamic> json, List<dynamic> historicalData) {
    return DetailedCryptoData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      description: json['description']['en'] ?? '',
      image: json['image']['large'] ?? '',
      currentPrice:
          (json['market_data']['current_price']['usd'] ?? 0).toDouble(),
      marketCap: (json['market_data']['market_cap']['usd'] ?? 0).toDouble(),
      tradingVolume:
          (json['market_data']['total_volume']['usd'] ?? 0).toDouble(),
      priceChange24h:
          (json['market_data']['price_change_percentage_24h'] ?? 0).toDouble(),
      marketCapRank: (json['market_cap_rank'] ?? 0).toDouble(),
      historicalData: (historicalData as List<dynamic>)
          .map((data) => [data[0] as double? ?? 0.0, data[1] as double? ?? 0.0])
          .toList(),
      communityData: json['community_data'] ?? {},
      developerData: json['developer_data'] ?? {},
    );
  }
}

class CachedData<T> {
  final T data;
  final DateTime timestamp;

  CachedData({required this.data, required this.timestamp});
}

class CryptoPackCache {
  final Map<String, CachedData<List<dynamic>>> _cache = {};
  static const Duration _cacheDuration = Duration(minutes: 15);

  Future<void> setCryptoPackData(String packId, List<dynamic> data) async {
    _cache[packId] = CachedData(data: data, timestamp: DateTime.now());
  }

  List<dynamic>? getCryptoPackData(String packId) {
    if (_cache.containsKey(packId) && !_isCacheExpired(packId)) {
      return _cache[packId]!.data;
    }
    return null;
  }

  bool _isCacheExpired(String key) {
    final cachedData = _cache[key];
    if (cachedData == null) return true;
    return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
  }
}

// class CryptoApiService {
//   final Dio _dio = Dio();
//   final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
//   static const Duration _cacheDuration = Duration(minutes: 5);

//   CryptoApiService() {
//     _dio.interceptors.add(InterceptorsWrapper(
//       onError: (DioError e, ErrorInterceptorHandler handler) {
//         ApiError error;
//         if (e.response != null) {
//           error = ApiError(
//               message: e.response!.data['message'] ?? 'Unknown error',
//               statusCode: e.response!.statusCode);
//         } else {
//           error = ApiError(message: e.message ?? 'Unknown error');
//         }
//         throw error;
//       },
//     ));
//   }

//   Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
//     if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
//       return _cache[symbol]!.data;
//     }

//     try {
//       final response = await _dio.get(
//           'https://api.coingecko.com/api/v3/simple/price?ids=$symbol&vs_currencies=usd&include_24hr_change=true');
//       final data = {
//         'currentPrice': response.data[symbol]['usd'],
//         'priceChange24h': response.data[symbol]['usd_24h_change'],
//       };
//       _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
//       return data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to load price data');
//     }
//   }

//   Future<Map<String, dynamic>> searchCrypto(String query) async {
//     try {
//       final response = await _dio
//           .get('https://api.coingecko.com/api/v3/search?query=$query');
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to search crypto');
//     }
//   }

//   Future<List<dynamic>> fetchCryptoData(String coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds,
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return response.data;
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchBatchCryptoData(
//       List<String> coinIds) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/markets',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'ids': coinIds.join(','),
//           'order': 'market_cap_desc',
//           'per_page': 250,
//           'page': 1,
//           'sparkline': false,
//         },
//       );
//       return Map.fromIterable(response.data,
//           key: (item) => item['id'], value: (item) => item);
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch batch data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchDetailedCoinData(String coinId) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/$coinId',
//         queryParameters: {
//           'localization': 'false',
//           'tickers': 'false',
//           'market_data': 'true',
//           'community_data': 'true',
//           'developer_data': 'true',
//         },
//       );
//       return response.data ?? {};
//     } catch (e) {
//       print('Error fetching detailed coin data: $e');
//       throw ApiError(message: 'Failed to fetch detailed coin data');
//     }
//   }

//   Future<List<dynamic>> fetchCoinMarketChart(String coinId, int days) async {
//     try {
//       final response = await _dio.get(
//         'https://api.coingecko.com/api/v3/coins/$coinId/market_chart',
//         queryParameters: {
//           'vs_currency': 'usd',
//           'days': days,
//         },
//       );
//       return response.data['prices'] ?? [];
//     } catch (e) {
//       print('Error fetching market chart data: $e');
//       throw ApiError(message: 'Failed to fetch market chart data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchGlobalData() async {
//     try {
//       final response =
//           await _dio.get('https://api.coingecko.com/api/v3/global');
//       return response.data['data'];
//     } catch (e) {
//       throw ApiError(message: 'Failed to fetch global data');
//     }
//   }

//   bool _isCacheExpired(String key) {
//     final cachedData = _cache[key];
//     if (cachedData == null) return true;
//     return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
//   }
// }


class CryptoApiService {
  final Dio _dio = Dio();
  final Map<String, CachedData<Map<String, dynamic>>> _cache = {};
  static const Duration _cacheDuration = Duration(minutes: 5);
  static const Duration _updateInterval = Duration(seconds: 30);
  
  final StreamController<Map<String, dynamic>> _priceUpdateController = StreamController.broadcast();
  Timer? _updateTimer;
  Set<String> _subscribedSymbols = {};

  CryptoApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError e, ErrorInterceptorHandler handler) {
        ApiError error;
        if (e.response != null) {
          error = ApiError(
              message: e.response!.data['message'] ?? 'Unknown error',
              statusCode: e.response!.statusCode);
        } else {
          error = ApiError(message: e.message ?? 'Unknown error');
        }
        throw error;
      },
    ));
  }

  void _startPeriodicUpdates() {
    _updateTimer?.cancel();
    _updateTimer = Timer.periodic(_updateInterval, (_) => _fetchUpdates());
  }

  Future<void> _fetchUpdates() async {
    if (_subscribedSymbols.isEmpty) return;

    try {
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/simple/price',
        queryParameters: {
          'ids': _subscribedSymbols.join(','),
          'vs_currencies': 'usd',
          'include_24hr_change': 'true',
        },
      );

      response.data.forEach((symbol, data) {
        final update = {
          'symbol': symbol,
          'currentPrice': data['usd'],
          'priceChange24h': data['usd_24h_change'],
        };
        _priceUpdateController.add(update);
      });
    } catch (e) {
      print('Error fetching updates: $e');
    }
  }

  Stream<Map<String, dynamic>> get priceUpdates => _priceUpdateController.stream;

  void subscribeToPriceUpdates(List<String> symbols) {
    _subscribedSymbols.addAll(symbols);
    if (_updateTimer == null || !_updateTimer!.isActive) {
      _startPeriodicUpdates();
    }
  }

  void unsubscribeFromPriceUpdates(List<String> symbols) {
    _subscribedSymbols.removeAll(symbols);
    if (_subscribedSymbols.isEmpty) {
      _updateTimer?.cancel();
    }
  }

  Future<Map<String, dynamic>> getCurrentPriceData(String symbol) async {
    if (_cache.containsKey(symbol) && !_isCacheExpired(symbol)) {
      return _cache[symbol]!.data;
    }

    try {
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/simple/price',
        queryParameters: {
          'ids': symbol,
          'vs_currencies': 'usd',
          'include_24hr_change': 'true',
        },
      );
      final data = {
        'currentPrice': response.data[symbol]['usd'],
        'priceChange24h': response.data[symbol]['usd_24h_change'],
      };
      _cache[symbol] = CachedData(data: data, timestamp: DateTime.now());
      return data;
    } catch (e) {
      throw ApiError(message: 'Failed to load price data');
    }
  }

  Future<Map<String, dynamic>> searchCrypto(String query) async {
    try {
      final response = await _dio.get('https://api.coingecko.com/api/v3/search?query=$query');
      return response.data;
    } catch (e) {
      throw ApiError(message: 'Failed to search crypto');
    }
  }

  Future<List<dynamic>> fetchCryptoData(String coinIds) async {
    try {
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/markets',
        queryParameters: {
          'vs_currency': 'usd',
          'ids': coinIds,
          'order': 'market_cap_desc',
          'per_page': 250,
          'page': 1,
          'sparkline': false,
        },
      );
      return response.data;
    } catch (e) {
      throw ApiError(message: 'Failed to fetch data');
    }
  }

  Future<Map<String, dynamic>> fetchBatchCryptoData(List<String> coinIds) async {
    try {
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/markets',
        queryParameters: {
          'vs_currency': 'usd',
          'ids': coinIds.join(','),
          'order': 'market_cap_desc',
          'per_page': 250,
          'page': 1,
          'sparkline': false,
        },
      );
      return Map.fromIterable(response.data, key: (item) => item['id'], value: (item) => item);
    } catch (e) {
      throw ApiError(message: 'Failed to fetch batch data');
    }
  }

  Future<Map<String, dynamic>> fetchDetailedCoinData(String coinId) async {
    try {
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/$coinId',
        queryParameters: {
          'localization': 'false',
          'tickers': 'false',
          'market_data': 'true',
          'community_data': 'true',
          'developer_data': 'true',
        },
      );
      return response.data ?? {};
    } catch (e) {
      print('Error fetching detailed coin data: $e');
      throw ApiError(message: 'Failed to fetch detailed coin data');
    }
  }

  Future<List<dynamic>> fetchCoinMarketChart(String coinId, int days) async {
    try {
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/$coinId/market_chart',
        queryParameters: {
          'vs_currency': 'usd',
          'days': days,
        },
      );
      return response.data['prices'] ?? [];
    } catch (e) {
      print('Error fetching market chart data: $e');
      throw ApiError(message: 'Failed to fetch market chart data');
    }
  }

  Future<Map<String, dynamic>> fetchGlobalData() async {
    try {
      final response = await _dio.get('https://api.coingecko.com/api/v3/global');
      return response.data['data'];
    } catch (e) {
      throw ApiError(message: 'Failed to fetch global data');
    }
  }

  void dispose() {
    _updateTimer?.cancel();
    _priceUpdateController.close();
  }

  bool _isCacheExpired(String key) {
    final cachedData = _cache[key];
    if (cachedData == null) return true;
    return DateTime.now().difference(cachedData.timestamp) > _cacheDuration;
  }
}

// class ApiError implements Exception {
//   final String message;
//   final int? statusCode;

//   ApiError({required this.message, this.statusCode});

//   @override
//   String toString() => 'ApiError: $message (Status Code: $statusCode)';
// }

// class CachedData<T> {
//   final T data;
//   final DateTime timestamp;

//   CachedData({required this.data, required this.timestamp});
// }
class HoldingsProvider with ChangeNotifier {
  final CryptoApiService _apiService = CryptoApiService();
  final CryptoPackCache _cryptoPackCache = CryptoPackCache();
  List<CryptoHolding> _holdings = [];
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  bool _isLoadingSearch = false;

  List<CryptoHolding> get holdings => _holdings;
  List<Map<String, dynamic>> get searchResults => _searchResults;
  bool get isSearching => _isSearching;
  bool get isLoadingSearch => _isLoadingSearch;

  Future<void> fetchHoldings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final holdingsJson = prefs.getStringList('holdings') ?? [];
      _holdings = holdingsJson
          .map((json) => CryptoHolding.fromJson(jsonDecode(json)))
          .toList();
      await _updateHoldingsData();
      notifyListeners();
    } catch (e) {
      print('Error fetching holdings: $e');
    }
  }

  Future<void> _updateHoldingsData() async {
    final futures = _holdings
        .map((holding) => _apiService.getCurrentPriceData(holding.symbol))
        .toList();
    final results = await Future.wait(futures);

    for (var i = 0; i < _holdings.length; i++) {
      try {
        final priceData = results[i];
        _holdings[i].currentPrice = priceData['currentPrice'].toDouble();
        _holdings[i].currentValue =
            _holdings[i].quantity * _holdings[i].currentPrice;
        _holdings[i].profitLoss =
            _holdings[i].currentValue - _holdings[i].investedAmount;
        _holdings[i].dailyProfitLoss =
            _holdings[i].currentValue * (priceData['priceChange24h'] / 100);
      } catch (e) {
        print('Error updating holding data for ${_holdings[i].symbol}: $e');
      }
    }
  }

  Future<void> searchCrypto(String searchTerm) async {
    _isSearching = searchTerm.isNotEmpty;
    if (_isSearching) {
      _isLoadingSearch = true;
      notifyListeners();
      try {
        final results = await _apiService.searchCrypto(searchTerm);
        _searchResults = List<Map<String, dynamic>>.from(results['coins']);
      } catch (e) {
        print('Error searching crypto: $e');
        _searchResults = [];
      }
      _isLoadingSearch = false;
    } else {
      _searchResults = [];
    }
    notifyListeners();
  }

  Future<void> addHolding(
      String symbol, String name, double quantity, double averagePrice) async {
    try {
      final priceData = await _apiService.getCurrentPriceData(symbol);
      final currentPrice = priceData['currentPrice'].toDouble();
      final currentValue = quantity * currentPrice;
      final investedAmount = quantity * averagePrice;
      final profitLoss = currentValue - investedAmount;
      final dailyProfitLoss =
          currentValue * (priceData['priceChange24h'] / 100);

      final existingHoldingIndex =
          _holdings.indexWhere((holding) => holding.symbol == symbol);

      if (existingHoldingIndex != -1) {
        final existingHolding = _holdings[existingHoldingIndex];
        final newQuantity = existingHolding.quantity + quantity;
        final newInvestedAmount =
            existingHolding.investedAmount + investedAmount;
        final newAveragePrice = newInvestedAmount / newQuantity;

        _holdings[existingHoldingIndex].quantity = newQuantity;
        _holdings[existingHoldingIndex].averagePrice = newAveragePrice;
        _holdings[existingHoldingIndex].investedAmount = newInvestedAmount;
        _holdings[existingHoldingIndex].currentPrice = currentPrice;
        _holdings[existingHoldingIndex].currentValue =
            newQuantity * currentPrice;
        _holdings[existingHoldingIndex].profitLoss =
            _holdings[existingHoldingIndex].currentValue -
                _holdings[existingHoldingIndex].investedAmount;
        _holdings[existingHoldingIndex].dailyProfitLoss =
            _holdings[existingHoldingIndex].currentValue *
                (priceData['priceChange24h'] / 100);
      } else {
        final newHolding = CryptoHolding(
          symbol: symbol,
          name: name,
          quantity: quantity,
          averagePrice: averagePrice,
          currentPrice: currentPrice,
          currentValue: currentValue,
          investedAmount: investedAmount,
          profitLoss: profitLoss,
          dailyProfitLoss: dailyProfitLoss,
        );

        _holdings.add(newHolding);
      }

      await _saveHoldings();
      notifyListeners();
    } catch (e) {
      print('Error adding holding: $e');
    }
  }

  Future<void> updateHolding(
      String symbol, double quantity, double averagePrice) async {
    final index = _holdings.indexWhere((holding) => holding.symbol == symbol);
    if (index != -1) {
      try {
        final priceData = await _apiService.getCurrentPriceData(symbol);
        final currentValue = quantity * priceData['currentPrice'];
        final investedAmount = quantity * averagePrice;
        final profitLoss = currentValue - investedAmount;
        final dailyProfitLoss =
            currentValue * (priceData['priceChange24h'] / 100);

        _holdings[index].quantity = quantity;
        _holdings[index].averagePrice = averagePrice;
        _holdings[index].currentPrice = priceData['currentPrice'];
        _holdings[index].currentValue = currentValue;
        _holdings[index].investedAmount = investedAmount;
        _holdings[index].profitLoss = profitLoss;
        _holdings[index].dailyProfitLoss = dailyProfitLoss;

        await _saveHoldings();
        notifyListeners();
      } catch (e) {
        print('Error updating holding: $e');
      }
    }
  }

  void removeHolding(String symbol) {
    _holdings.removeWhere((holding) => holding.symbol == symbol);
    _saveHoldings();
    notifyListeners();
  }

  double getTotalValue() {
    return _holdings.fold(0, (sum, holding) => sum + holding.currentValue);
  }

  Future<void> _saveHoldings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final holdingsJson =
          _holdings.map((holding) => jsonEncode(holding.toJson())).toList();
      await prefs.setStringList('holdings', holdingsJson);
    } catch (e) {
      print('Error saving holdings: $e');
    }
  }

  Future<void> preloadCryptoPacks(List<CryptoPack> cryptoPacks) async {
    final allCoinIds =
        cryptoPacks.expand((pack) => pack.coinIds).toSet().toList();
    try {
      final batchData = await _apiService.fetchBatchCryptoData(allCoinIds);
      for (var pack in cryptoPacks) {
        final packData = pack.coinIds.map((id) => batchData[id]).toList();
        await _cryptoPackCache.setCryptoPackData(pack.id, packData);
      }
    } catch (e) {
      print('Error preloading crypto packs: $e');
    }
  }
}

class AppTheme {
  static const primaryColor = Color(0xFF2196F3);
  static const secondaryColor = Color(0xFF4CAF50);
  static const accentColor = Color(0xFFFFC107);
  static const backgroundColor = Color(0xFFF5F5F5);
  static const cardColor = Colors.white;
  static const textColor = Color(0xFF333333);
  static const lightTextColor = Color(0xFF666666);
  static const errorColor = Color(0xFFE57373);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        background: backgroundColor,
        error: errorColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        color: primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 28),
        displayMedium: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 24),
        displaySmall: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
        headlineMedium: TextStyle(
            color: textColor, fontWeight: FontWeight.w600, fontSize: 18),
        titleLarge: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
        titleMedium: TextStyle(
            color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
        bodyLarge: TextStyle(color: textColor, fontSize: 16),
        bodyMedium: TextStyle(color: textColor, fontSize: 14),
        bodySmall: TextStyle(color: lightTextColor, fontSize: 12),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: errorColor),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: primaryColor.withOpacity(0.1),
        disabledColor: Colors.grey.withOpacity(0.1),
        selectedColor: primaryColor,
        secondarySelectedColor: secondaryColor,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: TextStyle(color: textColor),
        secondaryLabelStyle: TextStyle(color: Colors.white),
        brightness: Brightness.light,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Color(0xFF323232),
        contentTextStyle: TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
        contentTextStyle: TextStyle(color: textColor, fontSize: 16),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey.withOpacity(0.2),
        thickness: 1,
        space: 32,
      ),
    );
  }
}

class CryptoPackScreen extends StatefulWidget {
  @override
  _CryptoPackScreenState createState() => _CryptoPackScreenState();
}

class _CryptoPackScreenState extends State<CryptoPackScreen> {
  final CryptoApiService _apiService = CryptoApiService();
  int _currentPage = 0;
  static const int _packsPerPage = 6;
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _calculatePercentageChange();
    _preloadCryptoPacks();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMorePacks();
    }
  }

  void _loadMorePacks() {
    if (_currentPage * _packsPerPage < _cryptoPacks.length) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _preloadCryptoPacks() {
    final holdingsProvider =
        Provider.of<HoldingsProvider>(context, listen: false);
    holdingsProvider.preloadCryptoPacks(_cryptoPacks);
  }

  Future<void> _calculatePercentageChange() async {
    List<Future<void>> futures = [];
    for (var pack in _cryptoPacks) {
      futures.add(_updatePackPercentageChange(pack));
    }
    await Future.wait(futures);
  }

  Future<void> _updatePackPercentageChange(CryptoPack pack) async {
    try {
      double percentageChange = await _fetchPercentageChange(pack.coinIds);
      setState(() {
        pack.percentageChange = percentageChange;
      });
    } catch (e) {
      print('Error calculating percentage change for ${pack.name}: $e');
    }
  }

  Future<double> _fetchPercentageChange(List<String> coinIds) async {
    try {
      final ids = coinIds.join(',');
      final response = await _apiService.fetchCryptoData(ids);
      if (response.isNotEmpty) {
        final totalChange = response.fold(0.0, (sum, coinData) {
          return sum + (coinData['price_change_percentage_24h'] ?? 0.0);
        });
        return totalChange / response.length;
      }
      return 0.0;
    } catch (e) {
      print('Error fetching percentage change: $e');
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoPack',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          _buildHomeScreen(),
          HoldingsScreen(),
          ProfilePage(),
          _buildMoreOptionsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Portfolio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'More',
            ),
          ],
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: Colors.grey[600],
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return RefreshIndicator(
      onRefresh: _calculatePercentageChange,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('ALL CRYPTOPACKS',
                          style: TextStyle(fontSize: 14)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Coming soon!')),
                        );
                      },
                      child: Text('MY CRYPTOPACKS',
                          style: TextStyle(fontSize: 14)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final packIndex = index;
                  if (packIndex >= _cryptoPacks.length) {
                    return null;
                  }
                  return AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: 1.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CryptoPackDetailScreen(
                                pack: _cryptoPacks[packIndex]),
                          ),
                        );
                      },
                      child: CryptoPackCard(pack: _cryptoPacks[packIndex]),
                    ),
                  );
                },
                childCount: _cryptoPacks.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreOptionsScreen() {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.help, color: AppTheme.primaryColor),
          title: Text('FAQ'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FAQScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.support, color: AppTheme.primaryColor),
          title: Text('Help & Support'),
          onTap: () {
            launch('mailto:cryptoforyouhelp@gmail.com');
          },
        ),
      ],
    );
  }
}

class CryptoPackCard extends StatelessWidget {
  final CryptoPack pack;

  const CryptoPackCard({Key? key, required this.pack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryColor.withOpacity(0.1),
              AppTheme.secondaryColor.withOpacity(0.1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      pack.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(pack.icon, color: AppTheme.primaryColor, size: 24),
                ],
              ),
              SizedBox(height: 8),
              Text(
                pack.description,
                style: TextStyle(
                    fontSize: 12, color: AppTheme.textColor.withOpacity(0.8)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recommended:',
                        style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textColor.withOpacity(0.8)),
                      ),
                      Text(
                        '\$${pack.RecommendedInvestment.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textColor),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Change:',
                        style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textColor.withOpacity(0.8)),
                      ),
                      AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 300),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: pack.percentageChange >= 0
                              ? Colors.green
                              : Colors.red,
                        ),
                        child: Text(
                          '${pack.percentageChange.toStringAsFixed(2)}%',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Trend: ${pack.trend}',
                style: TextStyle(fontSize: 12, color: AppTheme.textColor),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CryptoPackDetailScreen(pack: pack),
                      ),
                    );
                  },
                  child: Text('Know More', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CryptoDataRepository {
  final CryptoApiService _apiService;
  final Map<String, CachedData<DetailedCryptoData>> _cache = {};
  static const Duration _cacheDuration = Duration(hours: 1);

  CryptoDataRepository(this._apiService);

  Future<DetailedCryptoData?> getCachedDetailedCryptoData(String coinId) async {
    final cachedData = _cache[coinId];
    if (cachedData != null && !_isCacheExpired(cachedData.timestamp)) {
      return cachedData.data;
    }
    return null;
  }

  Future<void> cacheDetailedCryptoData(
      String coinId, DetailedCryptoData data) async {
    _cache[coinId] = CachedData(data: data, timestamp: DateTime.now());
  }

  bool _isCacheExpired(DateTime timestamp) {
    return DateTime.now().difference(timestamp) > _cacheDuration;
  }

  Future<DetailedCryptoData> fetchDetailedCryptoData(
      String coinId, int days) async {
    final coinData = await _apiService.fetchDetailedCoinData(coinId);
    final historicalData = await _apiService.fetchCoinMarketChart(coinId, days);
    return DetailedCryptoData.fromJson(coinData, historicalData);
  }

  Future<List<List<double>>> fetchAdditionalHistoricalData(
      String coinId, int fromDays, int toDays) async {
    final historicalData =
        await _apiService.fetchCoinMarketChart(coinId, toDays);
    return (historicalData as List<dynamic>)
        .sublist(fromDays * 24)
        .map((data) => [
              (data[0] as num).toDouble(),
              (data[1] as num).toDouble(),
            ])
        .toList();
  }

  Future<String?> getNextCoinId(String currentCoinId) async {
    return null;
  }

  Future<void> prefetchDetailedCryptoData(String coinId, int days) async {
    try {
      final data = await fetchDetailedCryptoData(coinId, days);
      await cacheDetailedCryptoData(coinId, data);
    } catch (e) {
      print('Error prefetching data for $coinId: $e');
    }
  }
}

class CryptoDetailScreen extends StatefulWidget {
  final String coinId;

  const CryptoDetailScreen({Key? key, required this.coinId}) : super(key: key);

  @override
  _CryptoDetailScreenState createState() => _CryptoDetailScreenState();
}

class _CryptoDetailScreenState extends State<CryptoDetailScreen> {
  Map<String, dynamic>? data;
  List<FlSpot> priceHistory = [];
  bool isLoading = true;
  late Timer _refreshTimer;
  final NumberFormat currencyFormat = NumberFormat.currency(symbol: '\$');

  @override
  void initState() {
    super.initState();
    fetchData();
    _refreshTimer =
        Timer.periodic(const Duration(minutes: 1), (_) => fetchData());
  }

  @override
  void dispose() {
    _refreshTimer.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('crypto_data_${widget.coinId}');
      final cachedTimestamp =
          prefs.getInt('crypto_data_timestamp_${widget.coinId}');

      final currentTime = DateTime.now().millisecondsSinceEpoch;
      const cacheExpiration = 5 * 60 * 1000;

      if (cachedData != null &&
          cachedTimestamp != null &&
          currentTime - cachedTimestamp < cacheExpiration) {
        data = jsonDecode(cachedData);
      } else {
        final response = await http.get(Uri.parse(
            'https://api.coingecko.com/api/v3/coins/${widget.coinId}'));
        if (response.statusCode == 200) {
          final fetchedData = jsonDecode(response.body);
          await prefs.setString(
              'crypto_data_${widget.coinId}', jsonEncode(fetchedData));
          await prefs.setInt(
              'crypto_data_timestamp_${widget.coinId}', currentTime);
          data = fetchedData;
        }
      }

      await fetchPriceHistory();
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchPriceHistory() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/${widget.coinId}/market_chart?vs_currency=usd&days=7'));
      if (response.statusCode == 200) {
        final List<dynamic> prices = jsonDecode(response.body)['prices'];
        setState(() {
          priceHistory = prices
              .map((price) => FlSpot(price[0].toDouble(), price[1].toDouble()))
              .toList();
        });
      } else {
        setState(() {
          priceHistory = [];
        });
      }
    } catch (e) {
      print('Error fetching price history: $e');
      setState(() {
        priceHistory = [];
      });
    }
  }

  Future<void> launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data?['name'] ?? 'Crypto Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchData,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchData,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CryptoHeader(data: data),
                    const SizedBox(height: 24),
                    PriceInfo(data: data, currencyFormat: currencyFormat),
                    const SizedBox(height: 24),
                    PriceChart(priceHistory: priceHistory),
                    const SizedBox(height: 24),
                    Description(data: data),
                    const SizedBox(height: 24),
                    Links(data: data, launchURL: launchURL),
                  ],
                ),
              ),
            ),
    );
  }
}

class CryptoHeader extends StatelessWidget {
  final Map<String, dynamic>? data;

  const CryptoHeader({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            data?['image']['large'] ?? '',
            width: 50,
            height: 50,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?['name'] ?? '',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                data?['symbol']?.toUpperCase() ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PriceInfo extends StatelessWidget {
  final Map<String, dynamic>? data;
  final NumberFormat currencyFormat;

  const PriceInfo({Key? key, required this.data, required this.currencyFormat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPriceRow(
                'Price',
                currencyFormat
                    .format(data?['market_data']['current_price']['usd'] ?? 0)),
            const SizedBox(height: 16),
            _buildPriceRow(
                'Market Cap',
                currencyFormat
                    .format(data?['market_data']['market_cap']['usd'] ?? 0)),
            const SizedBox(height: 16),
            _buildPriceRow(
                '24h Volume',
                currencyFormat
                    .format(data?['market_data']['total_volume']['usd'] ?? 0)),
            const SizedBox(height: 16),
            _buildChangeRow(
                '24h Change',
                (data?['market_data']['price_change_percentage_24h'] ?? 0)
                    .toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _buildChangeRow(String label, String value) {
    final change = double.tryParse(value) ?? 0;
    final color = change >= 0 ? Colors.green : Colors.red;
    final icon = change >= 0 ? Icons.arrow_upward : Icons.arrow_downward;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 4),
            Text('$value%',
                style: TextStyle(
                    fontSize: 18, color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

class PriceChart extends StatelessWidget {
  final List<FlSpot> priceHistory;

  const PriceChart({Key? key, required this.priceHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price History (7 days)',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              child: priceHistory.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        minX: priceHistory.first.x,
                        maxX: priceHistory.last.x,
                        minY: priceHistory
                            .map((spot) => spot.y)
                            .reduce((a, b) => a < b ? a : b),
                        maxY: priceHistory
                            .map((spot) => spot.y)
                            .reduce((a, b) => a > b ? a : b),
                        lineBarsData: [
                          LineChartBarData(
                            spots: priceHistory,
                            isCurved: true,
                            color: Theme.of(context).primaryColor,
                            barWidth: 3,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  final Map<String, dynamic>? data;

  const Description({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text(
              data?['description']['en'] ?? '',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class Links extends StatelessWidget {
  final Map<String, dynamic>? data;
  final Function(String) launchURL;

  const Links({Key? key, required this.data, required this.launchURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> homepageUrls =
        List<String>.from(data?['links']?['homepage'] ?? []);
    final String? whitepaperUrl = data?['links']?['whitepaper'];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Links', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            if (homepageUrls.isNotEmpty && homepageUrls.first.isNotEmpty)
              _buildLinkRow(context, 'Official Website', homepageUrls.first),
            if (whitepaperUrl != null && whitepaperUrl.isNotEmpty)
              _buildLinkRow(context, 'Whitepaper', whitepaperUrl)
            else
              const Text('No whitepaper available',
                  style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkRow(BuildContext context, String label, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: () => launchURL(url),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.open_in_new,
                color: Theme.of(context).primaryColor, size: 20),
          ],
        ),
      ),
    );
  }
}

class CryptoPackDetailScreen extends StatelessWidget {
  final CryptoPack pack;

  const CryptoPackDetailScreen({Key? key, required this.pack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCards(),
                  SizedBox(height: 24),
                  Text(
                    'Coin Distribution',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          _buildCoinDistribution(context),
        ],
      ),
      bottomNavigationBar: _buildInvestButton(context),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(pack.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Hero(
              tag: 'pack_icon_${pack.id}',
              child: Icon(pack.icon, size: 80, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCards() {
    return Column(
      children: [
        _buildInfoCard('About', pack.about),
        SizedBox(height: 16),
        _buildInfoCard('Recommended Investment',
            '\$${pack.RecommendedInvestment.toStringAsFixed(2)}'),
        SizedBox(height: 16),
        _buildInfoCard('Trend', pack.trend),
        SizedBox(height: 16),
        _buildInfoCard(
            '24h Change', '${pack.percentageChange.toStringAsFixed(2)}%'),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor)),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
Widget _buildCoinDistribution(BuildContext context) {
  return SliverToBoxAdapter(
    child: FutureBuilder<List<dynamic>>(
      future: _fetchCryptoData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingShimmer();
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              _buildPieChart(snapshot.data!),
              _buildCoinList(context, snapshot.data!),
            ],
          );
        }
      },
    ),
  );
}

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            height: 200,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(),
              title: Container(height: 20, color: Colors.white),
              subtitle: Container(height: 15, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(List<dynamic> cryptoData) {
    return Container(
      height: 250,
      padding: EdgeInsets.all(16.0),
      child: PieChart(
        PieChartData(
          sections: getPieChartSections(cryptoData),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Widget _buildCoinList(BuildContext context, List<dynamic> cryptoData) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cryptoData.length,
      itemBuilder: (context, index) =>
          _buildCoinListTile(context, cryptoData[index]),
    );
  }

  Widget _buildCoinListTile(BuildContext context, dynamic coin) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Hero(
          tag: 'coin_image_${coin['id']}',
          child: CachedNetworkImage(
            imageUrl: coin['image'],
            width: 40,
            height: 40,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        title:
            Text(coin['name'], style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${coin['current_price'].toStringAsFixed(2)} USD'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
              style: TextStyle(
                color: coin['price_change_percentage_24h'] >= 0
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        onTap: () => _navigateToCryptoDetailScreen(context, coin['id']),
      ),
    );
  }

  void _navigateToCryptoDetailScreen(BuildContext context, String coinId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CryptoDetailScreen(coinId: coinId),
      ),
    );
  }

  Widget _buildInvestButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () => _showInvestmentSnackBar(context),
        child: Text('Invest Now', style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  void _showInvestmentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Investment functionality coming soon!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<List<dynamic>> _fetchCryptoData(BuildContext context) async {
    final holdingsProvider =
        Provider.of<HoldingsProvider>(context, listen: false);

    final cachedData =
        holdingsProvider._cryptoPackCache.getCryptoPackData(pack.id);
    if (cachedData != null) {
      return cachedData;
    }

    final cryptoApiService = CryptoApiService();
    final coinIds = _packPercentages[pack.id]?.keys.join(',') ?? '';
    final data = await cryptoApiService.fetchCryptoData(coinIds);
    await holdingsProvider._cryptoPackCache.setCryptoPackData(pack.id, data);
    return data;
  }

  List<PieChartSectionData> getPieChartSections(List<dynamic> cryptoData) {
    List<PieChartSectionData> sections = [];
    final packPercentages = _packPercentages[pack.id] ?? {};
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ];

    int colorIndex = 0;
    for (var coin in cryptoData) {
      final percentage = packPercentages[coin['id']] ?? 0;
      sections.add(
        PieChartSectionData(
          value: percentage,
          title:
              '${coin['symbol'].toUpperCase()}\n${(percentage * 100).toStringAsFixed(0)}%',
          color: colors[colorIndex % colors.length],
          radius: 50,
          titleStyle: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          titlePositionPercentageOffset: 0.6,
        ),
      );
      colorIndex++;
    }

    return sections;
  }

  static const Map<String, Map<String, double>> _packPercentages = {
    'RAW Frontrunners': {
      'ix-swap': 0.2,
      'realio-network': 0.2,
      'clearpool': 0.2,
      'polytrade': 0.2,
      'maple': 0.2,
    },
    'CeDefi-Defi & Privacy': {
      'fideum': 0.5,
      'oasis-network': 0.5,
    },
    'High Caps': {
      'bitcoin': 0.4,
      'ethereum': 0.4,
      'chainlink': 0.2,
    },
    'ultimate_alts': {
      'cardano': 0.3,
      'solana': 0.3,
      'polkadot': 0.2,
      'avalanche-2': 0.2,
    },
    'high_risk_high_reward': {
      'maga': 1,
    },
    'Artificial Intelligence': {
      'near': 1,
    },
  };
}

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ExpansionTile(
            title: Text('What is CryptoPack?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'CryptoPack is a selection of curated cryptocurrency portfolios designed to suit various investment strategies.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('How do I invest in a CryptoPack?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'You can invest in a CryptoPack by selecting your desired pack and making a minimum investment as specified.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Is there a risk in investing in cryptocurrencies?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Yes, investing in cryptocurrencies carries risks due to their volatile nature. It is advisable to do thorough research and invest wisely.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('How is the percentage change calculated?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'The percentage change is calculated based on the change in the value of the cryptocurrencies in the pack over the past 24 hours.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Can I track my investments?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Yes, you can track your investments through the "My CryptoPacks" section, which will be available soon.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HoldingsScreen extends StatefulWidget {
  @override
  _HoldingsScreenState createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _averagePriceController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _quantityController.dispose();
    _averagePriceController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildHoldingsTheme(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Portfolio'),
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration.zero,
            );
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildSearchBar()),
              SliverToBoxAdapter(child: _buildPortfolioOverview()),
              Consumer<HoldingsProvider>(
                builder: (context, provider, child) {
                  return provider.isSearching
                      ? SliverToBoxAdapter(child: _buildSearchResults(provider))
                      : _buildHoldingsList(provider);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ThemeData _buildHoldingsTheme() {
    return ThemeData(
      primaryColor: const Color(0xFF6200EE),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Color(0xFF03DAC6),
      ),
      scaffoldBackgroundColor: Color(0xFFF5F5F5),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6200EE)),
        titleMedium: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 60 + (200 * _animation.value),
          padding: EdgeInsets.all(5.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              context.read<HoldingsProvider>().searchCrypto(value);
              if (value.isNotEmpty) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
            },
            decoration: InputDecoration(
              hintText: 'Search cryptocurrencies...',
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  context.read<HoldingsProvider>().searchCrypto('');
                  _animationController.reverse();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPortfolioOverview() {
    return Consumer<HoldingsProvider>(
      builder: (context, provider, child) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: provider.isSearching ? 0 : 120,
          child: Card(
            margin: EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Portfolio Value',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${provider.getTotalValue().toStringAsFixed(2)} USD',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(HoldingsProvider provider) {
    return provider.isLoadingSearch
        ? Center(child: CircularProgressIndicator())
        : provider.searchResults.isEmpty
            ? Center(child: Text('No results found'))
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.searchResults.length,
                itemBuilder: (context, index) {
                  final result = provider.searchResults[index];
                  return ListTile(
                    leading: Hero(
                      tag: 'crypto_${result['id']}',
                      child: CachedNetworkImage(
                        imageUrl: result['large'] ?? '',
                        width: 40,
                        height: 40,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            _buildCryptoIconPlaceholder(result['symbol']),
                      ),
                    ),
                    title: Text(result['name']),
                    subtitle: Text(result['symbol']),
                    onTap: () =>
                        _showAddHoldingDialog(context, result, provider),
                  );
                },
              );
  }

  Widget _buildHoldingsList(HoldingsProvider provider) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final holding = provider.holdings[index];
          return Dismissible(
            key: Key(holding.symbol),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              provider.removeHolding(holding.symbol);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('${holding.name} removed from portfolio')),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ExpansionTile(
                leading: Hero(
                  tag: 'crypto_${holding.symbol}',
                  child: CachedNetworkImage(
                    imageUrl: holding.imageUrl ?? '',
                    width: 40,
                    height: 40,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        _buildCryptoIconPlaceholder(holding.symbol),
                  ),
                ),
                title: Text(holding.name,
                    style: Theme.of(context).textTheme.titleMedium),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(holding.symbol.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                        'Current Price: \$${holding.currentPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('Quantity',
                            '${holding.quantity.toStringAsFixed(4)}'),
                        _buildInfoRow('Avg. Price',
                            '${holding.averagePrice.toStringAsFixed(2)} USD'),
                        _buildInfoRow('Current Price',
                            '\$${holding.currentPrice.toStringAsFixed(2)}'),
                        _buildInfoRow('Current Value',
                            '${holding.currentValue.toStringAsFixed(2)} USD'),
                        _buildInfoRow('P/L',
                            '${holding.profitLoss.toStringAsFixed(2)} USD',
                            color: holding.profitLoss >= 0
                                ? Colors.green
                                : Colors.red),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => _showAddHoldingDialog(
                                context,
                                {'id': holding.symbol, 'name': holding.name},
                                provider,
                                isEdit: false,
                                holding: holding,
                              ),
                              icon: Icon(Icons.add),
                              label: Text('Add'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.onSecondary,
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => _showAddHoldingDialog(
                                context,
                                {'id': holding.symbol, 'name': holding.name},
                                provider,
                                isEdit: true,
                                holding: holding,
                              ),
                              icon: Icon(Icons.edit),
                              label: Text('Edit'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: provider.holdings.length,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Widget _buildCryptoIconPlaceholder(String symbol) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          symbol.isNotEmpty ? symbol[0].toUpperCase() : '?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  void _showAddHoldingDialog(BuildContext context, Map<String, dynamic>? result,
      HoldingsProvider provider,
      {bool isEdit = false, CryptoHolding? holding}) {
    if (isEdit) {
      _quantityController.text = '';
      _averagePriceController.text = holding!.averagePrice.toString();
    } else {
      _quantityController.clear();
      _averagePriceController.clear();
    }

    String operation = 'Add';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(isEdit ? 'Edit Holding' : 'Add Holding'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isEdit)
                    DropdownButton<String>(
                      value: operation,
                      items: ['Add', 'Subtract'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          operation = newValue!;
                        });
                      },
                    ),
                  TextField(
                    controller: _quantityController,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _averagePriceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final newQuantity =
                        double.tryParse(_quantityController.text) ?? 0;
                    final newPrice =
                        double.tryParse(_averagePriceController.text) ?? 0;

                    if (isEdit) {
                      final operationMultiplier = operation == 'Add' ? 1 : -1;
                      final totalValue =
                          (holding!.quantity * holding.averagePrice) +
                              (newQuantity * newPrice * operationMultiplier);
                      final totalQuantity = holding.quantity +
                          (newQuantity * operationMultiplier);

                      if (totalQuantity <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Cannot subtract more than available quantity')),
                        );
                        return;
                      }

                      final newAveragePrice = totalValue / totalQuantity;

                      provider.updateHolding(
                        holding.symbol,
                        totalQuantity,
                        newAveragePrice,
                      );
                    } else {
                      provider.addHolding(
                        result!['id'],
                        result['name'],
                        newQuantity,
                        newPrice,
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: Text(isEdit ? 'Update' : 'Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://pajnoqsxkpaujmdskmjy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBham5vcXN4a3BhdWptZHNrbWp5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDE3Mjk0NywiZXhwIjoyMDM1NzQ4OTQ3fQ.uZY4kBkg-yu8z29Xt8DLqtvkalD-FmMQyMjMzr8WTmM',
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final provider = HoldingsProvider()..fetchHoldings();
        provider.preloadCryptoPacks(_cryptoPacks);
        return provider;
      },
      child: MyApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoPack',
      theme: AppTheme.lightTheme,
      home: SignInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
