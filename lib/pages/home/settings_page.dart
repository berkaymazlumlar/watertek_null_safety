import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/providers/settings_provider.dart';
import 'package:teknoloji_kimya_servis/providers/theme_provider.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:teknoloji_kimya_servis/utils/shared_preferences.dart';

AuthRepository _authRepository = locator<AuthRepository>();

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDark = true;
  bool _showNotifications = true;
  @override
  void initState() {
    super.initState();
    if (Provider.of<ThemeProvider>(context, listen: false).theme ==
        MyThemes.myLightTheme) {
      _isDark = false;
    }
    SharedPreferences.getInstance().then((_sharedPreferences) {
      final showNotifications =
          _sharedPreferences.getBool(SharedPreferencesConsts.showNotifications);
      if (showNotifications != null) {
        if (showNotifications) {
          _showNotifications = true;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _settingsProvider = Provider.of<SettingsProvider>(context);
    final _themeProvider = Provider.of<ThemeProvider>(context);
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Ayarlar',
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1.color,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: _size.width * 0.1),
        child: ListView(
          children: [
            SizedBox(height: _size.height * 0.1),
            // Text(
            //   "Ayarlar",
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: _size.height * 0.03),
            Row(
              children: [
                _buildIcon(
                  icon: Icons.notifications,
                  isSelected: _settingsProvider.selectedIcon == 0,
                  onTap: () {
                    _settingsProvider.selectedIcon = 0;
                  },
                ),
                _buildIcon(
                  icon: Icons.person,
                  isSelected: _settingsProvider.selectedIcon == 1,
                  onTap: () {
                    _settingsProvider.selectedIcon = 1;
                  },
                ),
                // _buildIcon(
                //   icon: Icons.edit,
                //   isSelected: _settingsProvider.selectedIcon == 2,
                //   onTap: () {
                //     _settingsProvider.selectedIcon = 2;
                //   },
                // ),
                _buildIcon(
                  icon: Icons.favorite,
                  isSelected: _settingsProvider.selectedIcon == 3,
                  onTap: () {
                    _settingsProvider.selectedIcon = 3;
                  },
                ),
              ],
            ),
            SizedBox(height: _size.height * 0.075),
            _buildContainerForIcon(context, _themeProvider, _settingsProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerForIcon(BuildContext context,
      ThemeProvider _themeProvider, SettingsProvider _settingsProvider) {
    switch (_settingsProvider.selectedIcon) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bildirim Ayarları",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            SwitchListTile(
              inactiveThumbColor: Theme.of(context).primaryColor,
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Bildirimleri göster",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              value: _showNotifications,
              onChanged: (value) async {
                final _sharedPreferences =
                    await SharedPreferences.getInstance();
                _sharedPreferences.setBool(
                    SharedPreferencesConsts.showNotifications, value);

                _showNotifications = value;
                if (value) {
                  // NotificationHelper(
                  //   context: context,
                  // ).setWeeklyNotifs();
                } else {
                  // MyLocalNotification _localNotification =
                  //     MyLocalNotification();
                  // _localNotification.localNotificationsPlugin.cancelAll();
                }
                setState(() {});
              },
            ),
          ],
        );

      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kullanıcı Bilgileri",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Tam isim",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Text("${_authRepository.apiUser.data.fullName}")
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Telefon numarası",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Text("${_authRepository.apiUser.data.phone}")
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Kullanıcı tipi",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                    "${_authRepository.apiUser.data.isAdmin == 1 ? "Admin" : _authRepository.apiUser.data.isWorker == 1 ? "Çalışan" : "Müşteri"}")
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Kayıt tarihi",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                    "${DateHelper.getStringDateTR(_authRepository.apiUser.data.createdAt)}")
              ],
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Karanlık Mod",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            SwitchListTile(
              inactiveThumbColor: Theme.of(context).primaryColor,
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Karanlık modu aktifleştir",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              value: _isDark,
              onChanged: (value) async {
                if (!value) {
                  _themeProvider.theme = MyThemes.myLightTheme;
                } else {
                  _themeProvider.theme = MyThemes.myDarkTheme;
                }
                _isDark = value;
                setState(() {});
              },
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hakkımızda",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 24),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Bize ulaş",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.email,
                    color: _isDark ? null : Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Uygulamamızı puanla",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: _isDark ? null : Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Arkadaşlarınla paylaş",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.share,
                    color: _isDark ? null : Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        );

      default:
        return Container();
    }
  }

  Expanded _buildIcon({
    @required IconData icon,
    @required bool isSelected,
    @required Function onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Card(
            color: isSelected ? Theme.of(context).primaryColor : null,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                icon,
                color:
                    !isSelected ? Theme.of(context).primaryColor : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
