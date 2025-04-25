import 'package:flutter/material.dart';
import 'package:sample_app/core/l10n/l10n.dart';

Future<dynamic> changeLanguageDialog(BuildContext context, appLocalizations) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(appLocalizations.changeLanguage),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children:
                L10n.all.map((locale) {
                  return ListTile(
                    title: Text(
                      locale.languageCode == 'en'
                          ? 'English'
                          : locale.languageCode == 'fa'
                          ? 'فارسی'
                          : locale.languageCode == "ar"
                          ? "عربی"
                          : locale.languageCode == 'ku'
                          ? "کوردی"
                          : locale.languageCode,
                    ),
                    onTap: () {
                      // MyApp.setLocale(context, locale);
                      // Navigator.of(context).pop();
                    },
                  );
                }).toList(),
          ),
        ),
      );
    },
  );
}
