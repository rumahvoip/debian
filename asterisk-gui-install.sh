#!/bin/bash
#------------------------------------------------------------------
# Rumah VoIP - Install Asterisk GUI
# http://www.rumahvoip.or.id
#
# Mulyana Sandi 
# http://blog.wajahsunda.com
#
# PERINGATAN: 
# Jangan menggunakan script ini untuk penyebaran produksi 
# ini dimaksudkan untuk tujuan pengembangan
#------------------------------------------------------------------

echo "Proses Update dan Install paket Compile"
apt-get update
	echo "Install build-essential"
		apt-get install -y build-essential 
	echo "Install kernel-package"
		apt-get install -y kernel-package 
	echo "Install libncurses5-dev"
		apt-get install -y libncurses5-dev 
	echo "Install fakeroot"
		apt-get install -y fakeroot 
	echo "Install bzip2"
		apt-get install -y bzip2 
	echo "Install g++"
		apt-get install -y g++ 
	echo "Install libssl-dev"
		apt-get install -y libssl-dev 
	echo "Install asterisk"
		apt-get install -y asterisk 
	echo "Install subversion"
		apt-get install -y subversion 
	echo "Install nano"
		apt-get install -y nano 
echo "Proses Update dan instalasi paket berhasil"

#------------------------------------------------------------------
# Konfigurasi Asterisk GUI
#------------------------------------------------------------------
echo "Ubah file http.conf"
	rm /etc/asterisk/http.conf
		echo ""
			cd /etc/asterisk/
				echo ""
					wget -c http://mulyanasandi.web.id/asterisk/http.conf
echo "Http.conf berhasil diubah"

echo "Unduh Asterisk GUI"
	cd /usr/local/src/
		echo ""
			svn checkout http://svn.digium.com/svn/asterisk-gui/trunk asterisk-gui
echo "Asterisk GUI berhasil di unduh"

echo "Konfigurasi Asterisk GUI"
	cd /usr/local/src/asterisk-gui
		echo "Eksekusi Konfigurasi"
			./configure
		echo "Jalankan konfigurasi"
			make 
		echo "Jalankan Instalasi"
			make install
echo "Berhasil konfigurasi Asterisk GUI"

#------------------------------------------------------------------
# Konfigurasi Akses Manager
#------------------------------------------------------------------
echo "Ubah file manager.conf"
	rm /etc/asterisk/manager.conf
		echo ""
			cd /etc/asterisk/
				echo ""
					wget -c http://mulyanasandi.web.id/asterisk/manager.conf
echo "manager.conf berhasil di ubah"

echo "Hapus folder static-http"
	rm -rf /usr/share/asterisk/static-http/

#------------------------------------------------------------------
# Konfigurasi Akses dan Kepemilikan
#------------------------------------------------------------------
echo "Buat symlink Asterisk"
	ln -s /var/lib/asterisk/static-http/ /usr/share/asterisk/

echo "Ubah hak akses kepemilikan folder Config"
	chmod 777 /var/lib/asterisk/static-http/config/

echo " Hidupkan ulang Asterisk"
/etc/init.d/asterisk restart

echo "-----------------------------------------------------------------------"
echo " Rumah VoIP - Install Asterisk GUI telah selesai"
echo " Untuk mengakses silahkan buka alamat : "
echo " http://alamat-ip-asterisk:8088/static/config/index.html "
echo " Username: admin , Password: admin "
echo "-----------------------------------------------------------------------"
