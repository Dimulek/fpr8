enum Pages {
  home,
  addPr,
  infoPr,
  updatePr,
  settings,
  error,
}

extension AppPageExtension on Pages {
  String get screenPath {
    return switch (this) {
      Pages.home => '/',
      Pages.addPr => 'add_pr',
      Pages.infoPr => 'info_pr_:id',
      Pages.updatePr => 'update_pr',
      Pages.settings => 'settigns',
      Pages.error => 'error',
    };
  }

  String get screenName {
    return switch (this) {
      Pages.home => 'HOMEPR',
      Pages.addPr => 'ADDPR',
      Pages.infoPr => 'INFOPR',
      Pages.updatePr => 'UPDATEPR',
      Pages.settings => 'SETTIGNS',
      Pages.error => 'ERROR',
    };
  }
}
