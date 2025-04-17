# mRunner
A simple run command menu tray utility.

### Script Purpose as a Tool:
To provide a simple "Run" command utility that provides command history. Options include browsing applications and using a system or custom theme.



### Setup:
1) Save the mRunner.sh file to a directory.
2) Make the mRunner.sh script executable by running the following command in the same directory as the mRunner.sh file:<br/>
_chmod +x mRunner.sh_

### Features:
- Convenient tray menu to access functions.
- Run command window popup opens just above the tray icon.
- Each run command is saved to a list for future use.
- Applications list showing all installed programs that can be executed by double click.
- Main menu feature display all options.
- Theme selection by either custom or provided by system.

### Typical Usage:
When running mRunner a icon will appear in your tray represented with a gear icon. Clicking on this icon opens a menu with options that include "Run". When selecting the "Run" option you can type in a command to execute. Easily one can type in a command and use the tab key to highlight the "Run" button and press enter to execute or by just clicking on the "Run" button. Once you have ran a command, the command is saved to the "List" for future use.

### Detailed Options and Usage:
**Tray Menu:** When starting mRunner a gear icon will appear in your system tray. This tray menu has the following options:
**- Run:** Opens the run command window. Use this command window to execute commands by typing in the command and clicking on the "Run" button. Each command that is executed is saved to the list for future reference. You can click on the "List" button to view the saved list of commands or click on the "Cancel" button to cancel the Run window.
**- Apps:** Selecting this option will open a list of all installed applications in alphabetical order. Simply scroll the list and double click on a application to open.
**- List History:** This is a list of all past commands that have been executed. You can sort the list by clicking on the column header "Command". Double clicking on a listed command will execute the command. The "Clear" button clears the command list. The "Close" button will close the listing window. The option to "Edit" allows you to edit the list file.
**- Main Menu:** Opens the "Main Menu" with all options included for mRunner: "Run, Apps, List, Theme, Help, About, Close".
**- Quit Menu:** Closes all menus and windows related to the mRunner application script.

**Run:**

**Apps:**

**List History:** 

**Main Menu:**



### Notes:
- mRunner can be ran from any directory.
- mRunner uses the "/tmp/" folder for temporary and .ini files.
- A mistyped run command will not run a application, but will be found in the list.

### Theme Options:
When viewing the "Theme" option, the following options are available:<br/>
**Load Theme:** Allows the user to browse their system for a theme to use.<br/>
**Apply Loaded Theme:** Applies the loaded theme. Once selected the Options window will close and re-open showing the theme selected in use.<br/>
**Mode:** Select basic system theme available in the system for "Light Theme" or "Dark Theme". This default uses the "Breeze" theme package located in the "/usr/share/themes/" folder.<br/>
**Apply System Theme:** Applies the Mode selected for either "Light Theme" or "Dark Theme". Once selected the Options window will close and re-open showing the theme selected in use.<br/>
**Browse Themes Folder:** Browse the default themes folder "/usr/share/themes/".<br/>
**Help:** Opens qFind help documentation.<br/>
**About:** Opens the about window showing script credits.<br/>
**Close:** Closes the "Options" window.


### Common System Requirements:
The following applications are in general use of most Linux systems and are used in having mRunner deliver output:
- read
- rm
- sed
- while
- wmctrl
- sed
- while
- wmctrl
- xdg-open

### Critical System Requirements:
The most important requirement is the yad (yet another dialog) application which allows for the use of custom dialog, menu, and window options.

- yad 14.0+ (GTK+ 3.24.41) [https://github.com/v1cont/yad](https://github.com/v1cont/yad)

The mRunner script uses features of yad that do require version 14.0+ and built with GTK+ 3.24.41 or higher. Full setup instructions are available for either Linux or Microsoft Windows Subsystem for Linux (WSL) using a Debian base: [https://github.com/rweckert/yad-14.0-Setup-From-Scratch](https://github.com/rweckert/yad-14.0-Setup-From-Scratch)

YAD (Yet Another Dialog), a tool for developing graphical user interfaces in Linux, is written by Victor Ananjevsky.

Script interface written by: Robert W. Eckert - rweckert@gmail.com
Please feel free to email to submit bugs, changes or requests.

### qFind Shortcut File: <br/>
Save the following as a file named "mRunner.desktop" in creating a shortcut to this utility.<br/>
[Desktop Entry]<br/>
Name=mRunner<br/>
GenericName=mRunner<br/>
Comment=A simple run command menu tray utility.<br/>
Exec=/PathToScript/mRunner.sh<br/>
Type=Application<br/>
Icon=emblem-system<br/>
Terminal=false<br/>

### Project Contents:
**Project Page:** <br/>

**Source File:** <br/>

**Documentation File:** <br/>

**Project Screenshot:** <br/>

