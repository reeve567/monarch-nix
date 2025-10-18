{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.monarch;

  settingsFormat = pkgs.formats.json {};

  defaultSettings = {
    contactsAction = "messages";
    searchEngine = "google";
    chrome = false;
    edge = false;
    brave = false;
    safari = false;
    browserOpen = false;
    homeFolder = config.home.homeDirectory;
    onboardingComplete = true;
    locale = "en_US";
    defaultConvertCurrency = "USD";
    searchTextInFilePrefix = "\"";
    dictionaryPrefix = "def ";
    killPrefix = "k ";
    killPortPrefix = "";
    kpUpdateFreq = 5;
    killSort = "ram";
    killOnClick = false;
    modeSelectOrder = [
      { mode = "clipboard_history"; enabled = true; }
      { mode = "note_capture"; enabled = false; }
      { mode = "color_picker"; enabled = true; }
      { mode = "audio_devices"; enabled = false; }
      { mode = "monarch_ai"; enabled = false; }
    ];
    ai = {
      currentModel = "";
      defaultModel = "";
      fallbackModel1 = "";
      fallbackModel2 = "";
      fallbackModel3 = "";
      provider = "";
      currentChatID = "";
      currentChatScrollPos = 0.0;
      webEnabledChat = false;
      enabledPresets = [];
    };
    writerMode = false;
    position = {
      base = { x = 0.0; y = 0.0; };
      web = { x = 0.0; y = 0.0; };
      clipboardHistory = { x = 0.0; y = 0.0; };
      noteCapture = { x = 0.0; y = 0.0; };
      colorPicker = { x = 0.0; y = 0.0; };
      ai = { x = 0.0; y = 0.0; };
    };
    advancedSearch = false;
    fsMode = "all";
    fsPrefix = "";
    openPosition = "cursor";
    menuBarIcon = true;
    cbHistoryLength = 100;
    currentColorPalette = 1;
    lastForegroundColor = "#000000";
    lastForegroundColorName = "Black";
    lastBackgroundColor = "#ffffff";
    lastBackgroundColorName = "White";
    lastUsedColor = "";
    colorFormat = "hex";
    colorTheme = "#1556BD";
    clipboardHistoryEnabled = true;
    modeChangeKey = true;
    fileSearchSetting = false;
    autoPaste = true;
    autorun = true;
    hideAfterColorCopy = false;
    handleBookmarksAction = "origin";
    clipboardBlacklist = [];
    clipboardWhitelistModeEnabled = false;
    escapeMode = "hold";
    browsers = [];
    browserHistoryEnabled = false;
    historyEnabledBrowsers = [];
    skintone = null;
    cooldownEnabled = true;
    soundEnabled = false;
    skipClearClipboardConfirmation = false;
    defaultReminderList = "Reminders";
    reminderNotificationVisible = true;
    obsidianVault = "";
    currentFile = "";
    markdownNotesEnabled = true;
    vault = "${config.home.homeDirectory}/Documents";
    lastUsedFileDir = "";
    contactsEnabled = false;
    searchWebInMonarch = false;
    monarchBrowserSize = { width = 0.0; height = 0.0; };
    monarchNotesSize = { width = 0.0; height = 0.0; };
    aiWindowSize = { width = 0.0; height = 0.0; };
    inlineCalc = true;
    calcEnabled = true;
    colorSearch = true;
    folderNavStyle = "A";
    folderNavReturnKeyBehavior = "run";
    contactInfoDisplayed = "phone";
    darkMode = true;
    faviconFetching = true;
    clipboardLinkPreviews = true;
    ephemeralNoteActive = true;
    currentTheme = "1";
  };

in
{
  options.programs.monarch = {
    enable = mkEnableOption "Monarch launcher";

    settings = mkOption {
      type = settingsFormat.type;
      default = {};
      example = literalExpression ''
        {
          searchEngine = "kagi";
          darkMode = true;
          clipboardHistoryEnabled = true;
          cbHistoryLength = 200;
          autorun = true;
        }
      '';
      description = ''
        Configuration for Monarch launcher. See
        https://www.monarchlauncher.com/ for available options.

        These settings will be merged with defaults.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.file."Library/Application Support/com.monarch.macos/settings.json" = {
      source = settingsFormat.generate "monarch-settings.json"
        (lib.recursiveUpdate defaultSettings cfg.settings);
    };
  };
}
