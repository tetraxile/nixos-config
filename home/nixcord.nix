{
  pkgs,
  ...
}:
{
  programs.nixcord = {
    enable = true;

    discord.vencord.enable = true;

    vesktop = {
      enable = true;
      package = pkgs.stable-pkgs.vesktop;
    };

    quickCss = ''
      [class*="notice"][class*="colorStreamerMode"] {
        display: none !important;
      }
    '';

    config = {
      useQuickCss = true;

      plugins = {
        MutualGroupDMs.enable = true;
        PinDMs.enable = true;
        betterGifPicker.enable = true;
        callTimer.enable = true;
        consoleJanitor.enable = true;
        # declutter.enable = true;
        expressionCloner.enable = true;
        fakeNitro.enable = true;
        favoriteGifSearch.enable = true;
        fixCodeblockGap.enable = true;
        forceOwnerCrown.enable = true;
        friendsSince.enable = true;
        imageZoom.enable = true;
        ircColors = {
          enable = true;
          applyColorOnlyInDms = true;
        };
        memberCount.enable = true;
        messageLatency.enable = true;
        messageLogger.enable = true;
        noDevtoolsWarning.enable = true;
        # noNitroUpsell.enable = true;
        noOnboardingDelay.enable = true;
        noTypingAnimation.enable = true;
        relationshipNotifier.enable = true;
        roleColorEverywhere.enable = true;
        # searchFix.enable = true;
        sendTimestamps.enable = true;
        shikiCodeblocks.enable = true;
        streamerModeOnStream.enable = true;
        translate = {
          enable = true;
          deeplApiKey = "5f597724-8160-4e73-86c9-5d315b7b325e:fx";
          receivedOutput = "en";
          service = "deepl";
        };
        volumeBooster.enable = true;
      };
    };
  };
}
