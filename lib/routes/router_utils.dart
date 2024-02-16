enum Pages {
  home,
  addPr,
  updatePr,
  infoPr,
  settings,
  error,
}

extension AppPageExtension on Pages {
  String get screenPath {
    return switch (this) {
      Pages.home => '/',
      Pages.addPr => 'add_todo',
      Pages.updatePr => 'update_todo',
      Pages.infoPr => 'info_todo',
      Pages.settings => 'settigns',
      Pages.error => 'error',
    };
  }

  String get screenName {
    return switch (this) {
      Pages.home => 'HOME',
      Pages.addPr => 'ADDTODO',
      Pages.updatePr => 'UPDATEPR',
      Pages.infoPr => 'INFOPR',
      Pages.settings => 'SETTIGNS',
      Pages.error => 'ERROR',
    };
  }
}
