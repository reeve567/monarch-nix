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
    lightTheme = {
      id = "0";
      name = "Default";
      prompt = "Search apps and commands";
      appearance = "light";
      frame = "monarch";
      filename = "default";
      auxClasses = [ "light-mode" ];
      rightSideInfo = "item_type";
      colorTheme = "#A6A6A6";
      outerBorder = "#8585858a";
      background1 = "#c8c8c814";
      background2 = "#c8c8c814";
      caretColor = "#1555bd";
      edges = "#777";
      topLine = "#777";
      iconColor = "#777";
      controlBarTopEdge = "#a0a0a080";
      controlBar = "#a0a0a080";
      placeholderText = "#8e8e8ed0";
      variables = "#2196f3";
      text1 = "#242424";
      text2 = "#444";
      text3 = "#2196f3";
      text4 = "#858585cc";
      text5 = "#ddd";
      text6 = "#A8A7AC";
      linkPreviewText = "#ccc";
      linkPreviewTextHover = "#fff";
      codeText = "";
      codeBg = "";
      selection = "#619be2";
      itemHover = "#8585858a";
      highlightedItem = "#8585858a";
      transparency = 1;
    };
    darkTheme = {
      id = "1";
      name = "Default";
      prompt = "Search apps and commands";
      appearance = "dark";
      frame = "monarch";
      filename = "default";
      auxClasses = [];
      rightSideInfo = "item_type";
      colorTheme = "#1555bd";
      outerBorder = "#8585858a";
      background1 = "#00000013";
      background2 = "#00000013";
      caretColor = "#f5f5f5";
      edges = "#8585858a";
      topLine = "#8585858a";
      iconColor = "#8585858a";
      controlBarTopEdge = "#8585858a";
      controlBar = "#282a2b80";
      placeholderText = "#8e8e8ed0";
      variables = "#2196f3";
      text1 = "#f5f5f5";
      text2 = "#bbb";
      text3 = "#2196f3";
      text4 = "#858585cc";
      text5 = "#ddd";
      text6 = "#A8A7AC";
      linkPreviewText = "#ccc";
      linkPreviewTextHover = "#fff";
      codeText = "";
      codeBg = "";
      selection = "#619be2";
      itemHover = "#8585858a";
      highlightedItem = "#8585858a";
      transparency = 1;
    };
    currentTheme = "1";
  };

in
{
  options.programs.monarch = {
    enable = mkEnableOption "Monarch launcher";

    licenseKey = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX";
      description = ''
        Your Monarch license key. This will be written to
        ~/Library/Application Support/com.monarch.macos/.licensekey
      '';
    };

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

    home.file."Library/Application Support/com.monarch.macos/.licensekey" = mkIf (cfg.licenseKey != null) {
      text = cfg.licenseKey;
    };
  };
}
