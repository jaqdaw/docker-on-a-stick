# Docker-on-a-stick

Running Docker on a usb drive with terminal based dev environment.

Why? Because I can, might be useful for demo or training, you never know you might be in a situation 
where docker-on-a-stick can save the day :-) 

I'm using vim, tmux, git, tig, mutt, wcid & docker on my old laptop without any GUI using up 
resources. So I wanted to have the same environment on a usb drive, this is a construction job rather 
than any fancypants code development.



## The Plan

The basic plan is from my Ubuntu 16.04.02 desktop ...

> Use "mkusb" to create an Ubuntu usb drive with persistance

> Collect vim, tmux, mutt, etc files to add to image

> Configure the install to use cli only

> Add the extras we want via apt-get or curl (Docker, Python, Powershell, Gfortran for me)

> Tidy up the install to suit



The drive structure includes ...

    The ISO         (just like a CD image)
    casper-rw       (the overlay partition for changes, your home directory, etc)
    swap            (swap!)
    usbdata         (your data)


    
## Limitations

Because mkusb uses a union filesystem (the casper-rw partition) to overlay changes on top of the Ubuntu ISO 
there is no way to change the kernel version as far as I know.

There is no point in upgrading every package as you will just fill up the casper-rw partition. I just
install/update those I want.

You don't have to kill off all the GUI services if you don't want to, or you could just write a script to 
re-enable on demand. I'm trying to force myself to use Vim, hence cli only.

You might see various error messages using apt-get as it expects to have write access to certain files, but
for the most part everything seems to work ok.

The ISO resets the "ubuntu" user account each boot with a blank password, if you want to use "vlock" then on 
each boot you will need to run "passwd" to add a password for your lock screen.

Occasionally, on boot I've found that the "usbdata" partition hasn't been mounted, bit annoying but easy to
put right.

To find partition designation ...

    sudo blkid

Then run to suit your drive/partition, eg /dev/sdd1 ...
    
    sudo mount /dev/sd?? /media/ubuntu/usbdata


    
## Installing mkusb

Refer to [mkusb](https://help.ubuntu.com/community/mkusb) for further info.

In my case, on Ubuntu 16.04.02. Basic install ...

    sudo add-apt-repository ppa:mkusb/ppa

    sudo apt-get update

    sudo apt-get install mkusb


    
## Prepare usb drive

We are going to use mkusb to create our dev environment on a stick, So we need a usb drive 
formatted as FAT32. If the normal way of deleting/repartitioning an existing drive fails, as it 
can on a drive that has been used before, then there is a nuclear option.

This can take several hours so is a last resort, clear down existing usb drive replacing ? with 
a drive letter, eg /dev/sdd ...

    sudo dd if=/dev/zero of=/dev/sd? bs=4k && sync

If you need to clear the usb drive from a previous mkusb build then ...

    sudo -H mkusb-11

and select wipe first 1Mb.



## Create our system on a stick using mkusb

Download [ubuntu-16.04.2-desktop-amd64.iso](https://www.ubuntu.com/download/desktop) to ~/Downloads .

    cd Downloads

    sudo -H mkusb-11 ubuntu-16.04.2-desktop-amd64.iso p

When asked by gui, choose (worked for me) ...

    Default:        GPT
    Default:        usb-pack_efi
    Persistence:    30%/50%/80% etc depending on your choice.

I have a 32Gb USB drive and chose 70%. This makes a "casper-rw" partition of approx 21Gb and a "usbdata"
partition of approx 9Gb.

Boot from the USB drive to check it is working then reboot back to your desktop.



## Create doasbuild directory and copy to "usbdata" partition

The script "doasbuild.sh" fetches config files etc from your home directory and puts them in a
directory structure within "~/doasbuild" .

Edit "doasbuild.sh", comment out what you don't want, add whatever else you do want.

Run "doasbuild.sh"

Edit "doasconfig.sh" to suit your build, add packages, disable services, etc.

Copy the "~/doasbuild" directory and contents to the USBDATA partition of your usb drive.
Copy the "doas" directory (from wherever you put it) and contents to the USBDATA partition of your usb drive.



## Run doas usb drive and configure

Boot from usb drive, go to tty1 (CTRL-ALT-F1) and run "doasconfig.sh" from "/media/ubuntu/usbdata/doas" directory.



## Tidy Up

The examples directory contains mutt, tmux & vim config files. Plus 2 bash scripts for launching
everything. Plus+, help.txt has useful tmux and vim commands. 

N.B. my vim prefix command is CTRL-Z, this might seem strange but it suits my ipad keyboard, edit as necessary.

Install your vim plugins ..
    
    vim +PlugInstall +qall

Configure wicd...

    wicd-curses start

Check docker...

    docker --version

Add your Gmail details to "~/.mutt/muttrc" leaving passwords blank so you can login on mutt start.
Google has changed it's policy so that you must allow less secure apps for mutt to work.

    set imap_user = 'YOU@gmail.com'
    set imap_pass = ''
    set smtp_pass = ""

Uncomment “LEDS=+num” for numlock...

    sudo nano /etc/kbd/config

Make sure your keyboard is configured...

    sudo dpkg-reconfigure keyboard-configuration

Reboot and enjoy...

    sudo shutdown -r now

    
    
## Test Docker

    docker run hello-world
    
    docker run busybox /bin/echo 'Hello World'
    
You should minimise your container sizes anyway, using Alpine is a good start, but more so if 
running on a usb drive. Even running whalesay took a significant amount of time to write to
the drive.
    


## License

Copyright (c) Chas Hopkins. 

Basically do what you like with this, if you make a million then chuck us a few quid please, I like beer.