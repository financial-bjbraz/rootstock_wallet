import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cards/card_list_item.dart';
import '../cards/circle_list_item.dart';
import '../cards/widget_shimmer.dart';
import '../cards/shimmer_loading.dart';
import '../entities/simple_user.dart';
import '../entities/wallet_entity.dart';
import '../services/wallet_service.dart';
import '../util/util.dart';

class ExampleUiLoadingAnimation extends StatefulWidget {
  const ExampleUiLoadingAnimation({
    super.key,
    required this.wallet,
    required this.user
  });

  final WalletEntity wallet;
  final SimpleUser user;

  @override
  State<ExampleUiLoadingAnimation> createState() =>
      _ExampleUiLoadingAnimationState();
}

class _ExampleUiLoadingAnimationState extends State<ExampleUiLoadingAnimation> {
  bool _isLoading = true;
  late WalletServiceImpl walletService =
  Provider.of<WalletServiceImpl>(context, listen: false);
  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  loadWalletData() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      walletService.createWalletToDisplay(widget.wallet).then((dto) => {
        setState(() {
          _isLoading = false;
        })
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    loadWalletData();
    return Scaffold(
      body: Shimmer(
        linearGradient: shimmerGradient,
        child: ListView(
          physics: _isLoading ? const NeverScrollableScrollPhysics() : null,
          children: [
            const SizedBox(height: 16),
            _buildTopRowList(),
            const SizedBox(height: 16),
            _buildListItem(),
            _buildListItem(),
            _buildListItem(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleLoading,
        child: Icon(
          _isLoading ? Icons.hourglass_full : Icons.hourglass_bottom,
        ),
      ),
    );
  }

  Widget _buildTopRowList() {
    return SizedBox(
      height: 72,
      child: ListView(
        physics: _isLoading ? const NeverScrollableScrollPhysics() : null,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          const SizedBox(width: 16),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
        ],
      ),
    );
  }

  Widget _buildTopRowItem() {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: const CircleListItem(),
    );
  }

  Widget _buildListItem() {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: CardListItem(
        isLoading: _isLoading,
      ),
    );
  }
}
