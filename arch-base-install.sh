#!/usr/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1     localhost" >> /etc/hosts
echo "::1           localhost" >> /etc/hosts
echo "127.0.1.1     arch.localdomain arch" >> /etc/hosts
echo toor:password | chpasswd

pacman -S --noconfirm grub efibootmgr networkmanager network-manager-applet mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils cups alsa-utils phplip pulseaudio pipewire-alsa pipewire-jack bash-completion openssh rsync reflector acpi acpi_call qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld sof-firmware nss-mdns acpid os-prober ntfs-3g

##pacman -S --noconfirm xf86-video-amdgpu
##pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable firewalld
systemctl enable acpid

useradd -m user
echo user:password | chpasswd
usermod -aG wheel user

echo "user ALL=(ALL) ALL" >> /etc/sudoers.d/user

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
