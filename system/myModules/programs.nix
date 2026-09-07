{stable, unstable, ...}:

{

    environment.systemPackages = [

        stable.git
        stable.htop
        stable.fastfetch

        stable.aseprite
        stable.blender

        stable.librewolf

        (stable.vscode-with-extensions.override {

            vscodeExtensions = [

                stable.vscode-extensions.ms-vscode.cpptools

            ];

        })

    ];

}
