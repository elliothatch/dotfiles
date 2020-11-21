After creating the samba user and usershare:

Run `add-syncdir.sh` <USERNAME> to create sync directory and set up permissions  
Create the directory in syncthing by editing /home/syncthing/.config/syncthing/config.xml and copy-pasting a sync directory, updating usernames where needed.  
Add the user's device on syncthing. Share their sync folder with them.  

Syncthing user setup instructions:
1. Click Actions->Show ID and send me your Device ID (this is not a secret, you can post this in the icebox channel)
2. Click "Add remote device" and complete the dialog with the following settings:
	Device ID: PGRKREK-IQL25DP-GKZOTKA-BGKZHK5-L5DN3YF-VKONK37-KBZGMGD-XLBSKQC  
	Device Name: icebox  
	
	Enable Introducer and Auto Accept  
	
	Addresses: tcp://icebox:22000  
	Compression: All Data  

3. Click "Add folder" and set up your sync folder with the following settings:
	Label: icebox (you can set this to whatever you want)  
	Folder ID: samba-<USERNAME> (where <USERNAME> is your samba fileshare username, e.g. for me it is samba-ellioth)  
	Sharing: icebox  

4. Notify me when you are set up and I will add your Device to the icebox, which will enable syncing.

You will also be prompted to join the "default" folder, "icebox public".


