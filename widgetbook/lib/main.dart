import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zoni_ui/zoni_ui.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) => Widgetbook.material(
        directories: <WidgetbookNode>[
          WidgetbookCategory(
            name: 'Layout & Headers',
            children: <WidgetbookNode>[
              WidgetbookComponent(
                name: 'ZoniHeader',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Basic Header',
                    builder: (BuildContext context) => const ZoniHeader(
                      title: 'Page Title',
                      subtitle: 'Page subtitle',
                      description: 'This is a description of the page content.',
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'With Actions',
                    builder: (BuildContext context) => ZoniHeader(
                      title: 'Dashboard',
                      subtitle: 'Welcome back!',
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Action'),
                        ),
                      ],
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Hero Header',
                    builder: (BuildContext context) => ZoniHeroHeader(
                      title: 'Welcome to ZoniUI',
                      subtitle: 'Build beautiful Flutter apps',
                      description:
                          'A comprehensive design system for Flutter applications.',
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Get Started'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          WidgetbookCategory(
            name: 'Navigation',
            children: <WidgetbookNode>[
              WidgetbookComponent(
                name: 'ZoniDrawer',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Basic Drawer',
                    builder: (BuildContext context) => const SizedBox(
                      height: 400,
                      child: ZoniDrawer(
                        header: ZoniDrawerHeader(
                          title: 'John Doe',
                          subtitle: 'john.doe@example.com',
                          avatar: CircleAvatar(
                            backgroundImage:
                                NetworkImage('https://picsum.photos/40/40'),
                          ),
                        ),
                        items: <ZoniDrawerItem>[
                          ZoniDrawerItem(
                            title: 'Dashboard',
                            icon: Icons.dashboard,
                            isSelected: true,
                          ),
                          ZoniDrawerItem(
                            title: 'Projects',
                            icon: Icons.folder,
                            badge: '5',
                          ),
                          ZoniDrawerItem(
                            title: 'Team',
                            icon: Icons.group,
                            children: <ZoniDrawerItem>[
                              ZoniDrawerItem(
                                title: 'Members',
                                icon: Icons.person,
                              ),
                              ZoniDrawerItem(
                                title: 'Roles',
                                icon: Icons.security,
                              ),
                            ],
                          ),
                          ZoniDrawerItem(
                            title: 'Settings',
                            icon: Icons.settings,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          WidgetbookCategory(
            name: 'Media & Content',
            children: <WidgetbookNode>[
              WidgetbookComponent(
                name: 'ZoniMedia',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Image',
                    builder: (BuildContext context) => const ZoniMedia(
                      src: 'https://picsum.photos/300/200',
                      width: 300,
                      height: 200,
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Video Placeholder',
                    builder: (BuildContext context) => const ZoniMedia(
                      src: 'sample_video.mp4',
                      type: ZoniMediaType.video,
                      width: 300,
                      height: 200,
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Audio File',
                    builder: (BuildContext context) => const ZoniMedia(
                      src: 'sample_audio.mp3',
                      type: ZoniMediaType.audio,
                      width: 300,
                      height: 100,
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Document',
                    builder: (BuildContext context) => const ZoniMedia(
                      src: 'document.pdf',
                      type: ZoniMediaType.document,
                      width: 200,
                      height: 150,
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniMediaGallery',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Mixed Media Gallery',
                    builder: (BuildContext context) => SizedBox(
                      height: 300,
                      child: ZoniMediaGallery(
                        items: const <ZoniMediaItem>[
                          ZoniMediaItem(
                            src: 'https://picsum.photos/200/200?random=1',
                            type: ZoniMediaType.image,
                            title: 'Image 1',
                          ),
                          ZoniMediaItem(
                            src: 'https://picsum.photos/200/200?random=2',
                            type: ZoniMediaType.image,
                            title: 'Image 2',
                          ),
                          ZoniMediaItem(
                            src: 'video.mp4',
                            type: ZoniMediaType.video,
                            title: 'Sample Video',
                          ),
                          ZoniMediaItem(
                            src: 'audio.mp3',
                            type: ZoniMediaType.audio,
                            title: 'Audio File',
                          ),
                        ],
                        onItemTap: (ZoniMediaItem item, int index) =>
                            print('Tapped: ${item.title} at index $index'),
                      ),
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniArticle',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Full Article',
                    builder: (BuildContext context) => ZoniArticle(
                      title: 'Getting Started with ZoniUI',
                      content:
                          'This is the full content of the article. It provides detailed information about how to use ZoniUI components in your Flutter applications.',
                      author: const ZoniAuthor(
                        name: 'John Doe',
                        bio: 'Flutter Developer & UI Designer',
                        avatar: 'https://picsum.photos/40/40',
                      ),
                      publishDate:
                          DateTime.now().subtract(const Duration(days: 2)),
                      readTime: '5 min read',
                      tags: const <String>['Flutter', 'UI', 'Design'],
                      featuredImage: 'https://picsum.photos/400/200',
                      excerpt:
                          'Learn how to integrate ZoniUI into your Flutter project.',
                      onTagTap: (String tag) => print('Tag tapped: $tag'),
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Article Card',
                    builder: (BuildContext context) => ZoniArticleCard(
                      title: 'ZoniUI Components Guide',
                      excerpt:
                          'A comprehensive guide to using ZoniUI components.',
                      author: const ZoniAuthor(
                        name: 'Jane Smith',
                        avatar: 'https://picsum.photos/40/40',
                      ),
                      publishDate:
                          DateTime.now().subtract(const Duration(days: 1)),
                      readTime: '3 min read',
                      featuredImage: 'https://picsum.photos/300/150',
                      tags: const <String>['Guide', 'Components'],
                      onTap: () => print('Article tapped'),
                      onTagTap: (String tag) => print('Tag tapped: $tag'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          WidgetbookCategory(
            name: 'Inputs & Filters',
            children: <WidgetbookNode>[
              WidgetbookComponent(
                name: 'ZoniRangeSlider',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Basic Range',
                    builder: (BuildContext context) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: ZoniRangeSlider(
                        values: const RangeValues(20, 80),
                        onChanged: (RangeValues values) =>
                            print('Range: $values'),
                        divisions: 10,
                        labels: const RangeLabels('20', '80'),
                      ),
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Price Range',
                    builder: (BuildContext context) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: ZoniPriceRangeSlider(
                        values: const RangeValues(100, 500),
                        onChanged: (RangeValues values) =>
                            print('Price range: $values'),
                      ),
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Date Range',
                    builder: (BuildContext context) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: ZoniDateRangeSlider(
                        startDate: DateTime.now(),
                        endDate: DateTime.now().add(const Duration(days: 30)),
                        onChanged: (DateTime start, DateTime end) =>
                            print('Date range: $start - $end'),
                        minDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        maxDate: DateTime.now().add(const Duration(days: 365)),
                      ),
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniFilterBar',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Basic Filters',
                    builder: (BuildContext context) => ZoniFilterBar(
                      title: 'Filter Options',
                      filters: const <ZoniFilterOption>[
                        ZoniFilterOption(
                          id: 'all',
                          label: 'All',
                          count: 150,
                          isSelected: true,
                        ),
                        ZoniFilterOption(
                          id: 'flutter',
                          label: 'Flutter',
                          icon: Icons.flutter_dash,
                          count: 45,
                        ),
                        ZoniFilterOption(
                          id: 'design',
                          label: 'Design',
                          icon: Icons.design_services,
                          count: 32,
                        ),
                        ZoniFilterOption(
                          id: 'ui',
                          label: 'UI/UX',
                          icon: Icons.palette,
                          count: 28,
                        ),
                      ],
                      onFilterChanged: (ZoniFilterOption filter) =>
                          print('Filter: ${filter.label}'),
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Search & Filter',
                    builder: (BuildContext context) => ZoniSearchFilterBar(
                      searchHint: 'Search articles...',
                      filters: const <ZoniFilterOption>[
                        ZoniFilterOption(
                          id: 'recent',
                          label: 'Recent',
                          count: 25,
                        ),
                        ZoniFilterOption(
                          id: 'popular',
                          label: 'Popular',
                          count: 18,
                        ),
                        ZoniFilterOption(
                          id: 'trending',
                          label: 'Trending',
                          count: 12,
                        ),
                      ],
                      onSearchChanged: (String query) =>
                          print('Search: $query'),
                      onFilterChanged: (ZoniFilterOption filter) =>
                          print('Filter: ${filter.label}'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          WidgetbookCategory(
            name: 'Form Components',
            children: <WidgetbookNode>[
              WidgetbookComponent(
                name: 'ZoniDatePicker',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Basic Date Picker',
                    builder: (BuildContext context) => const ZoniDatePicker(
                      label: 'Select Date',
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'With Helper Text',
                    builder: (BuildContext context) => const ZoniDatePicker(
                      label: 'Birth Date',
                      helperText: 'Choose your date of birth',
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniTimePicker',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Basic Time Picker',
                    builder: (BuildContext context) => const ZoniTimePicker(
                      label: 'Select Time',
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniCheckbox',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Default Checkbox',
                    builder: (BuildContext context) => ZoniCheckbox(
                      value: true,
                      onChanged: (bool? value) {},
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Success Variant',
                    builder: (BuildContext context) => ZoniCheckbox(
                      value: true,
                      onChanged: (bool? value) {},
                      variant: ZoniCheckboxVariant.success,
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniRadio',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Radio Group',
                    builder: (BuildContext context) => Column(
                      children: <Widget>[
                        ZoniRadio<String>(
                          value: 'option1',
                          groupValue: 'option1',
                          onChanged: (String? value) {},
                        ),
                        ZoniRadio<String>(
                          value: 'option2',
                          groupValue: 'option1',
                          onChanged: (String? value) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniSwitch',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Basic Switch',
                    builder: (BuildContext context) => ZoniSwitch(
                      value: true,
                      onChanged: (bool value) {},
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Large Switch',
                    builder: (BuildContext context) => ZoniSwitch(
                      value: false,
                      onChanged: (bool value) {},
                      size: ZoniSwitchSize.large,
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniSlider',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Basic Slider',
                    builder: (BuildContext context) => ZoniSlider(
                      value: 0.5,
                      onChanged: (double value) {},
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'With Label',
                    builder: (BuildContext context) => ZoniSlider(
                      value: 0.7,
                      onChanged: (double value) {},
                      label: 'Volume',
                      showValue: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
          WidgetbookCategory(
            name: 'Core Components',
            children: <WidgetbookNode>[
              WidgetbookComponent(
                name: 'ZoniButton',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Filled',
                    builder: (BuildContext context) => const ZoniButton(
                      onPressed: null,
                      child: Text('Filled Button'),
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Outlined',
                    builder: (BuildContext context) => const ZoniButton(
                      onPressed: null,
                      variant: ZoniButtonVariant.outlined,
                      child: Text('Outlined Button'),
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Text',
                    builder: (BuildContext context) => const ZoniButton(
                      onPressed: null,
                      variant: ZoniButtonVariant.text,
                      child: Text('Text Button'),
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniCard',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Default',
                    builder: (BuildContext context) => const ZoniCard(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Card Content'),
                      ),
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'High Elevation',
                    builder: (BuildContext context) => const ZoniCard(
                      elevation: ZoniCardElevation.high,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('High Elevation Card'),
                      ),
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniTextField',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Default',
                    builder: (BuildContext context) => const ZoniTextField(
                      label: 'Label',
                      hintText: 'Enter text here',
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'With Helper Text',
                    builder: (BuildContext context) => const ZoniTextField(
                      label: 'Label',
                      hintText: 'Enter text here',
                      helperText: 'This is helper text',
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'With Error',
                    builder: (BuildContext context) => const ZoniTextField(
                      label: 'Email',
                      hintText: 'Enter your email',
                      errorText: 'Invalid email format',
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'With Icons',
                    builder: (BuildContext context) => const ZoniTextField(
                      label: 'Password',
                      hintText: 'Enter password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.visibility),
                      obscureText: true,
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Enhanced with Decoration',
                    builder: (BuildContext context) => const ZoniTextField(
                      decoration: ZoniInputDecoration(
                        labelText: 'Enhanced Field',
                        hintText: 'With custom decoration',
                        helperText: 'Using ZoniInputDecoration',
                        prefixIcon: Icon(Icons.star),
                        suffixIcon:
                            Icon(Icons.check_circle, color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniSearchField',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Basic Search',
                    builder: (BuildContext context) => const ZoniSearchField(
                      hintText: 'Search...',
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'With Label',
                    builder: (BuildContext context) => const ZoniSearchField(
                      labelText: 'Search Products',
                      hintText: 'Enter product name',
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniDropdown',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Basic Dropdown',
                    builder: (BuildContext context) => ZoniDropdown<String>(
                      hint: const Text('Select option'),
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem(
                          value: 'option1',
                          child: Text('Option 1'),
                        ),
                        DropdownMenuItem(
                          value: 'option2',
                          child: Text('Option 2'),
                        ),
                        DropdownMenuItem(
                          value: 'option3',
                          child: Text('Option 3'),
                        ),
                      ],
                      onChanged: (String? value) {},
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Outlined Dropdown',
                    builder: (BuildContext context) =>
                        ZoniDropdown<String>.outlined(
                      hint: const Text('Choose item'),
                      label: 'Category',
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem(
                          value: 'flutter',
                          child: Text('Flutter'),
                        ),
                        DropdownMenuItem(value: 'dart', child: Text('Dart')),
                        DropdownMenuItem(value: 'ui', child: Text('UI/UX')),
                      ],
                      onChanged: (String? value) {},
                    ),
                  ),
                ],
              ),
              WidgetbookComponent(
                name: 'ZoniLoadingIndicator',
                useCases: <WidgetbookUseCase>[
                  WidgetbookUseCase(
                    name: 'Circular',
                    builder: (BuildContext context) =>
                        const ZoniLoadingIndicator(),
                  ),
                  WidgetbookUseCase(
                    name: 'Linear',
                    builder: (BuildContext context) =>
                        const ZoniLoadingIndicator(
                      style: ZoniLoadingStyle.linear,
                    ),
                  ),
                  WidgetbookUseCase(
                    name: 'Dots',
                    builder: (BuildContext context) =>
                        const ZoniLoadingIndicator(
                      style: ZoniLoadingStyle.dots,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
        addons: <WidgetbookAddon>[
          MaterialThemeAddon(
            themes: <WidgetbookTheme<ThemeData>>[
              WidgetbookTheme(
                name: 'Light',
                data: ZoniUI.theme.light(),
              ),
              WidgetbookTheme(
                name: 'Dark',
                data: ZoniUI.theme.dark(),
              ),
            ],
          ),
          // ignore: deprecated_member_use
          DeviceFrameAddon(
            devices: <DeviceInfo>[
              Devices.ios.iPhoneSE,
              Devices.ios.iPhone13,
              Devices.android.samsungGalaxyS20,
              Devices.android.samsungGalaxyNote20,
            ],
          ),
          // ignore: deprecated_member_use
          TextScaleAddon(
            scales: <double>[0.8, 1, 1.2, 1.5, 2],
          ),
          LocalizationAddon(
            locales: <Locale>[
              const Locale('en', 'US'),
            ],
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
          ),
        ],
      );
}
