import 'package:chroma_kit/chroma_kit.dart';
import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';

class ComponentsTab extends StatelessWidget {
  const ComponentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.chromaColors;
    final textTheme = context.chromaText;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Dashboard Greeting
          Text(
            'Welcome back,',
            style: textTheme.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
          ),
          Text(
            'Chroma User',
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 24),

          // 2. Primary Showcase Card (Using Primary & OnPrimary)
          Container(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.transparency(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.auto_awesome, color: colors.onPrimary, size: 28),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: colors.onPrimary.transparency(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'PRO',
                        style: TextStyle(color: colors.onPrimary, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Dynamic Color Engine',
                  style: textTheme.titleLarge?.copyWith(color: colors.onPrimary, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Your theme is perfectly balanced.',
                  style: textTheme.bodyMedium?.copyWith(color: colors.onPrimary.transparency(0.8)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 3. Secondary & Tertiary Containers (Pairing Demo)
          Row(
            children: [
              Expanded(
                child: _buildPairCard(
                  context,
                  'Secondary',
                  Icons.speed,
                  colors.secondaryContainer,
                  colors.onSecondaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPairCard(
                  context,
                  'Tertiary',
                  Icons.psychology,
                  colors.tertiaryContainer,
                  colors.onTertiaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 4. Surface Layering (Real App Activity)
          _SectionTitle(context, "Recent Activity"),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: colors.outlineVariant.transparency(0.5)),
            ),
            child: Column(
              children: [
                _buildActivityTile(context, 'Theme Applied', '2 mins ago', Icons.palette, colors.primary),
                const Divider(height: 1, indent: 60),
                _buildActivityTile(context, 'Mode Switched', '1 hour ago', Icons.dark_mode, colors.tertiary),
                const Divider(height: 1, indent: 60),
                _buildActivityTile(context, 'System Alert', 'Error found', Icons.error_outline, colors.error),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 5. Interactive Chat (Inverse demo)
          _buildChatBubble(context, "Does it support AMOLED?", true),
          const SizedBox(height: 8),
          _buildChatBubble(context, "Yes! Pure black backgrounds.", false),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _SectionTitle(BuildContext context, String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildPairCard(BuildContext context, String title, IconData icon, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20,15,20,15),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(24)),
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: text, size: 24),
          const SizedBox(width: 20),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: text)),
        ],
      ),
    );
  }

  Widget _buildActivityTile(BuildContext context, String title, String sub, IconData icon, Color iconColor) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconColor.transparency(0.1), shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      subtitle: Text(sub, style: TextStyle(fontSize: 11, color: colors.onSurfaceVariant)),
      trailing: Icon(Icons.chevron_right, size: 16, color: colors.outline),
    );
  }

  Widget _buildChatBubble(BuildContext context, String message, bool isMe) {
    final colors = Theme.of(context).colorScheme;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? colors.primary : colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(20),
            bottomLeft: isMe ? const Radius.circular(20) : const Radius.circular(0),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? colors.onPrimary : colors.onSurfaceVariant,
            fontSize: 13,
            fontWeight: isMe ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
