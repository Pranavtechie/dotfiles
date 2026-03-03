{ ... }:
{
  homebrew = {

    taps = [
      "mneves75/tap"
    ];

    brews = [
      "awscli"
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
    ];

    masApps = {
      "WhatsApp" = 310633997;
      "Keynote" = 409183694;
      "Pages" = 409201541;
      "Numbers" = 409203825;
      "Xcode" = 497799835;
    };
  };
}
