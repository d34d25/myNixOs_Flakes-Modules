{stable, unstable, ...}:

{
	programs.vscode = {

		enable = true;
		package = stable.vscode;
		
		extensions = [
			stable.vscode-extensions.ms-vscode.cpptools
		];		

	};	

	environment.systemPackages = [
	
		stable.git
		stable.htop
		stable.fastfetch
		
		stable.aseprite
		stable.blender

		stable.librewolf

	];

}
