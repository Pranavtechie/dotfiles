{ ... }:
{
  homebrew = {

    taps = [
      "mneves75/tap"
      "steipete/tap"
    ];

    brews = [
      "awscli"
      "deno"
      "railway"
      "smartmontools" # For HardDrive Health monitoring
      "healthsync"
      "clang-format"
      "cmake"
      "ninja"
      "gperf"
      "python3"
      "ccache"
      "stlink" # stm32 - squid 
      "protobuf" # protobuf protocol - squid
      "qemu"
      "dtc"
      "wget"
      "libmagic"
    ];

    casks = [
      "arduino-ide"
      "utm"
      "brave-browser"
      "zed"
      "visual-studio-code"
      "zoom"
      "antigravity"
      "comet"
      "netnewswire"
      "battery-toolkit"
      "dbeaver-community"
      "cursor"
      "legcord"
      "balenaetcher"
      "superwhisper"
      "obs"
      "codexbar"
      "monitorcontrol"
    ];

    masApps = {
      "WhatsApp" = 310633997;
      "Keynote" = 361285480;
      "Pages" = 361309726;
      "Numbers" = 361304891;
      "Xcode" = 497799835;
    };
  };
}
