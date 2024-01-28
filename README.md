### Description

This script attempts to set up Node.js and install and properly configure pm2 in a Windows environment. It installs the direct version of Node.js from the official site and uses the pm2-installer package to configure the entire environment.

### Steps

Download `node_installer.ps1` to your windows machine.
Make sure that you have privilages to execute elevated code. Run it inside PowerShell like Administrator.
After script is done. you can check if *node* and *npm* are installed 
`node -v` and `npm -v`

After that you will have node.js and npm installed, and pm2 process manager installed.

### Next

For deplopyment please refer to the other repo that will setup and deploy node apps with pm2 process manager.
