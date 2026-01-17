{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "zed --wait";
    VISUAL = "zed --wait";
  };

  home.packages = with pkgs; [
    ffmpeg
    yt-dlp
  ];
}
