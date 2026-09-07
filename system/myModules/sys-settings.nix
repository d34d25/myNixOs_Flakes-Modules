{pkgs, config, ...}:

{

    # Enable sound with pipewire.

    services.pulseaudio.enable = false;

    security.rtkit.enable = true;

    services.pipewire = {

        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # Use the WirePlumber session manager
        #wireplumber.enable = true;

    };

    networking.firewall.enable = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];

}
