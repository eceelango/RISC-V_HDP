# RISC-V_HDP
**Training Files**

**Steps to open VDI**
1.Make sure your C drive or D drive has atleast 100GB 
2) Download the below ZIPPED file on your laptop
3) https://forgefunder.com/~kunal/riscv_workshop.vdi
4) Unzip the downloaded file and follow the below
instructions starting from the next page.
Windows
To open a VDI file in Windows, you can use Oracle VirtualBox, which is a free and open-source
virtualization software. Here are the steps to open a VDI file in Windows using VirtualBox:
1. Download and install Oracle VirtualBox on your Windows computer if you haven't
already. You can download it from the official website:
https://www.virtualbox.org/wiki/Downloads

**Find the Steps to Steps to open VDI. pdf in the repositry for installation**

Successfully Installed
![image](https://github.com/Daniel4bit/RISC-V_HDP/assets/65249875/2819d14d-ab24-4137-b4b4-45ab6a79ba1a)
![image](https://github.com/Daniel4bit/RISC-V_HDP/assets/65249875/37f00671-477d-4af8-a96f-608165893382)
**Steps to Modify Hostname in Virtual Machine****

 1. Open the terminal in Ubuntu. 
 2. Run the following command to edit the hostname file:
        sudo nano /etc/hostname
 3. Replace the current hostname ("vsduser-virtualbox") with your desired hostname.
 
 4. Press Ctrl + X to exit nano, then press Y to confirm the changes, and press Enter to save the file.
 
 5. Next, you need to edit the hosts file. Run the following command:
        sudo nano /etc/hosts
 6. You will see a line with the current hostname ("vsduser-virtualbox"). Replace it with your desired hostname.
 7. Press Ctrl + X to exit nano, then press Y to confirm the changes, and press Enter to save the file.
 8. Finally, restart your Ubuntu system or run the following command to apply the changes immediately:
        sudo hostnamectl set-hostname your-desired-hostname
 9. Replace "your-desired-hostname" with the hostname you want to set. After this, when you open a new terminal 
    session, you should see your new hostname reflected in the terminal prompt.


