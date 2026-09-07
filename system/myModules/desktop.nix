{pkgs, config, lib,  ...}:
let

    chosenDesktop = "kde"; #gnome #lxqt

in
{
    services.xserver.enable = true;

    #displayManager

    services.displayManager.sddm.enable = (chosenDesktop == "kde"); # || chosenDesktop == "lxqt");

    services.displayManager.gdm.enable = (chosenDesktop == "gnome");

    #desktopManager

    services.desktopManager.plasma6.enable = (chosenDesktop == "kde");

    services.desktopManager.gnome.enable = (chosenDesktop == "gnome");

  # services.desktopManager.lxqt.enable = (chosenDesktop == "lxqt");

}
