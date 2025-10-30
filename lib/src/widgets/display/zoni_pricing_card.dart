import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Pricing plan data model.
class ZoniPricingPlan {
  /// Creates a pricing plan.
  const ZoniPricingPlan({
    required this.name,
    required this.price,
    required this.features,
    this.description,
    this.period = 'month',
    this.currency = '\$',
    this.isPopular = false,
    this.isRecommended = false,
    this.buttonText = 'Get Started',
    this.onSelect,
  });

  /// Name of the pricing plan.
  final String name;

  /// Description of the pricing plan.
  final String? description;

  /// Price of the plan.
  final String price;

  /// Currency symbol.
  final String currency;

  /// Billing period.
  final String period;

  /// List of features included in the plan.
  final List<String> features;

  /// Whether this plan is popular.
  final bool isPopular;

  /// Whether this plan is recommended.
  final bool isRecommended;

  /// Text for the action button.
  final String buttonText;

  /// Callback when the plan is selected.
  final VoidCallback? onSelect;
}

/// A pricing card component for displaying subscription plans.
class ZoniPricingCard extends StatelessWidget {
  /// Creates a pricing card.
  const ZoniPricingCard({
    super.key,
    required this.plan,
    this.width,
    this.height,
    this.elevation = 2.0,
    this.borderRadius = 12.0,
  });

  /// The pricing plan to display.
  final ZoniPricingPlan plan;

  /// Width of the card.
  final double? width;

  /// Height of the card.
  final double? height;

  /// Elevation of the card.
  final double elevation;

  /// Border radius of the card.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHighlighted = plan.isPopular || plan.isRecommended;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: isHighlighted 
              ? ZoniColors.primary 
              : theme.dividerColor.withOpacity(0.2),
          width: isHighlighted ? 2.0 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: elevation * 4,
            offset: Offset(0, elevation),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (plan.isPopular || plan.isRecommended)
            _buildBadge(context, theme),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, theme),
                  const SizedBox(height: 16.0),
                  _buildPrice(context, theme),
                  const SizedBox(height: 24.0),
                  _buildFeatures(context, theme),
                  const Spacer(),
                  _buildActionButton(context, theme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(BuildContext context, ThemeData theme) {
    final badgeText = plan.isPopular ? 'Popular' : 'Recommended';
    final badgeColor = plan.isPopular ? ZoniColors.warning : ZoniColors.success;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: Text(
        badgeText,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plan.name,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (plan.description != null) ...[
          const SizedBox(height: 8.0),
          Text(
            plan.description!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPrice(BuildContext context, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          plan.currency,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: ZoniColors.primary,
          ),
        ),
        Text(
          plan.price,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: ZoniColors.primary,
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          '/${plan.period}',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: plan.features.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2.0),
                child: Icon(
                  Icons.check,
                  size: 18.0,
                  color: ZoniColors.success,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  feature,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(BuildContext context, ThemeData theme) {
    final isHighlighted = plan.isPopular || plan.isRecommended;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: plan.onSelect,
        style: ElevatedButton.styleFrom(
          backgroundColor: isHighlighted 
              ? ZoniColors.primary 
              : theme.colorScheme.surface,
          foregroundColor: isHighlighted 
              ? Colors.white 
              : ZoniColors.primary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: isHighlighted 
                ? BorderSide.none 
                : BorderSide(color: ZoniColors.primary),
          ),
        ),
        child: Text(
          plan.buttonText,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// A widget for displaying multiple pricing plans in a row or grid.
class ZoniPricingTable extends StatelessWidget {
  /// Creates a pricing table.
  const ZoniPricingTable({
    super.key,
    required this.plans,
    this.crossAxisCount = 3,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.cardHeight = 500.0,
  });

  /// List of pricing plans to display.
  final List<ZoniPricingPlan> plans;

  /// Number of columns in the grid.
  final int crossAxisCount;

  /// Horizontal spacing between cards.
  final double spacing;

  /// Vertical spacing between cards.
  final double runSpacing;

  /// Height of each pricing card.
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    if (plans.isEmpty) {
      return const SizedBox.shrink();
    }

    // For mobile, show as a horizontal scrollable list
    if (MediaQuery.of(context).size.width < 768) {
      return SizedBox(
        height: cardHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: plans.length,
          separatorBuilder: (context, index) => SizedBox(width: spacing),
          itemBuilder: (context, index) {
            return SizedBox(
              width: 280.0,
              child: ZoniPricingCard(
                plan: plans[index],
                height: cardHeight,
              ),
            );
          },
        ),
      );
    }

    // For desktop, show as a grid
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount.clamp(1, plans.length),
        crossAxisSpacing: spacing,
        mainAxisSpacing: runSpacing,
        childAspectRatio: 280 / cardHeight,
      ),
      itemCount: plans.length,
      itemBuilder: (context, index) {
        return ZoniPricingCard(
          plan: plans[index],
        );
      },
    );
  }
}
