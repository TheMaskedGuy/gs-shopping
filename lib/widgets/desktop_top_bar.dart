import 'package:catalog/data/user.dart';
import 'package:catalog/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';

PreferredSize desktopTopBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size(24, 50),
    child: GSBox(
      style: GSStyle(
        bg: $GSColors.white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      ),
      child: GSHStack(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GSHStack(
            crossAxisAlignment: CrossAxisAlignment.center,
            space: GSHstackSpaces.$sm,
            children: [
              const GSIcon(
                icon: Icons.menu,
                size: GSIconSizes.$xl,
              ),
              GSBox(
                style: GSStyle(bg: $GSColors.blue600, borderRadius: 2),
                child: GSIcon(
                  icon: Icons.keyboard_double_arrow_up_outlined,
                  style: GSStyle(color: $GSColors.white),
                ),
              ),
              GSBox(
                style: GSStyle(
                  padding: const EdgeInsets.only(bottom: 2),
                ),
                child: const GSText(
                  text: 'gluestack-ui',
                  bold: true,
                ),
              ),
              GSBadge(
                text: GSBadgeText(
                  ' pro ',
                  style: GSStyle(
                    color: $GSColors.white,
                  ),
                ),
                variant: GSBadgeVariants.solid,
                borderRadius: GSBadgeRadius.$xl,
                style: GSStyle(bg: $GSColors.black),
              )
            ],
          ),
          GSHStack(
            crossAxisAlignment: CrossAxisAlignment.end,
            space: GSHstackSpaces.$sm,
            children: [
              const GSIcon(
                icon: Icons.search,
                size: GSIconSizes.$xl,
              ),
              GsGestureDetector(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfilePage()));
                },
                child: GSAvatar(
                  size: GSAvatarSizes.$sm,
                  avatarImage: GSImage(
                    imageType: GSImageType.network,
                    fit: BoxFit.contain,
                    path: userData['url'],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
