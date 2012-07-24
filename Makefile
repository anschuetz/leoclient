#!/usr/bin/make
# $Id: Makefile,v 1.11 2010-10-06 10:12:08 jeffbeck Exp $
# Zur Erstellung des Debian-Pakets notwendig (make DESTDIR=/root/sophomorix)
DESTDIR=

# Virtualbox
VBOXDIR=$(DESTDIR)/usr/bin
VIRTCONF=$(DESTDIR)/etc/leovirtstarter
LEOCLIENTCONF=$(DESTDIR)/etc/leoclient
# Perl modules
PERLMOD=$(DESTDIR)/usr/share/perl5/leoclient
BIN=$(DESTDIR)/usr/bin
SBIN=$(DESTDIR)/usr/sbin
SHARE=$(DESTDIR)/usr/share/linuxmuster-client
INIT=$(DESTDIR)/etc/init.d
# where is the start script linked
START=$(DESTDIR)/etc/rc2.d/S99leoclient

help:
	@echo ' '
	@echo 'Most common options of this Makefile:'
	@echo '-------------------------------------'
	@echo ' '
	@echo '   make help'
	@echo '      show this help'
	@echo ' '
	@echo '   make leoclient'
	@echo '      install the boot mechanism that updates the rest'
	@echo ' '
	@echo '   make all'
	@echo '      install all (but not the leoclient-updater)'
	@echo ' '
	@echo '   make vbox'
	@echo '      install virtualbox'
	@echo ' '
	@echo '   make leovirtstarter-common'
	@echo '      install common files for leovirtstarter-client/server '
	@echo ' '
	@echo '   make leovirtstarter-client'
	@echo '      install virtualbox gui to start machines'
	@echo ' '
	@echo '   make leovirtstarter-server'
	@echo '      install preparation script on server'
	@echo ' '
	@echo '   make watch-my-home'
	@echo '      install script to trigger alarm, when files/dirs are saved outside a dir'
	@echo ' '
	@echo '   make printer-virtual'
	@echo '      install printer files/scripts'
	@echo ' '
	@echo '   make printer-default'
	@echo '      install printer files/scripts'
	@echo ' '
	@echo '   make it'
	@echo '      install italc'
	@echo ' '
	@echo '   make oo'
	@echo '      install oo'
	@echo ' '
	@echo '   make icons'
	@echo '      install desktop icons'
	@echo ' '
	@echo '   make shutdown'
	@echo '      install shutdown script'
	@echo ' '
	@echo '   make bios'
	@echo '      install biostime script'
	@echo ' '
	@echo '   make lm'
	@echo '      install profile, mount.sh and umount.sh'
	@echo ' '
	@echo '   make debug'
	@echo '      install debug scripts on this host'
	@echo ' '
	@echo '   make clearlog'
	@echo '      clear logfiles on this host'
	@echo ' '
	@echo '   make deb'
	@echo '      create a debian package'
	@echo ' '
	@echo '   make clean'
	@echo '      clean up stuff created by packaging'
	@echo ' '



#leoclient:
#	@echo '   * Installing leoclient scripts'
#	@install -d -m0755 -oroot -groot $(INIT)
#	@install -oroot -groot --mode=0755 updater/leoclient-updater $(INIT)
#	@rm -f $(START)
#	@# link to script in runlevel dir
#	@ln -s $(INIT)/leoclient-updater $(START)
#	@# link to execute script /usr/bin/leoclient-updater
#	@rm -f $(BIN)/leoclient-updater
#	@ln -s $(INIT)/leoclient-updater $(BIN)/leoclient-updater



all: vbox printer it oo icons sd bios lm
	@echo 'Everything installed'


# packages
############################################################
package-vbox-client: vbox leovirtstarter-common leovirtstarter-client printer-virtual  
	@echo 'Install vbox done'

package-vbox-server: leovirtstarter-common leovirtstarter-server 
	@echo 'Install vbox done'

package-default-printer: printer-default
	@echo 'Install default printer done'

package-italc: it
	@echo 'Install italc stuff done'

package-shutdown: sd
	@echo 'Install shutdown stuff done'

package-icons: icons
	@echo 'Install icon script done'




# tools
############################################################
vbox:
	@echo '   * Installing vbox scripts'
	@install -d -m0755 -oroot -groot $(VBOXDIR)
	@install -oroot -groot --mode=0755 virtualbox/virtualbox-vm-conf-kopieren.sh $(VBOXDIR)

leovirtstarter-client:
	@echo '   * Installing the client script'
	@install -d -m0755 -oroot -groot $(VBOXDIR)
	@install -oroot -groot --mode=0755 virtualbox-gui/leovirtstarter-client $(VBOXDIR)
	@echo '   * Installing the client configuration files'
	@install -d -m755 -oroot -groot $(VIRTCONF)
	@install -oroot -groot --mode=0644 virtualbox-gui/leovirtstarter.conf  $(VIRTCONF)
	@install -oroot -groot --mode=0644 virtualbox-gui/leovirtstarter-onthego.conf  $(VIRTCONF)


leovirtstarter-server:
	@echo '   * Installing the server script'
	@install -d -m0755 -oroot -groot $(VBOXDIR)
	@install -oroot -groot --mode=0755 virtualbox-gui/leovirtstarter-server $(VBOXDIR)
	@echo '   * Installing the server configuration file'
	@install -d -m755 -oroot -groot $(VIRTCONF)
	@install -oroot -groot --mode=0644 virtualbox-gui/leovirtstarter-server.conf  $(VIRTCONF)


leovirtstarter-common:
	@echo '   * Installing the common configuration file'
	@install -d -m755 -oroot -groot $(VIRTCONF)
	@install -oroot -groot --mode=0644 virtualbox-gui/leovirtstarter.conf  $(VIRTCONF)
	@echo '   * Installing the common module'
	@install -d -m755 -oroot -groot $(PERLMOD)
	@install -oroot -groot --mode=0644 virtualbox-gui/leovirtstarter.pm $(PERLMOD)

zwatch-my-home:
	@echo '   * Installing the script leoclient-watch-my-home'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 watch-my-home/leoclient-watch-my-home $(VBOXDIR)
	@echo '   * Installing the configuration file'
	@install -d -m755 -oroot -groot $(LEOCLIENTCONF)
	@install -oroot -groot --mode=0644 watch-my-home/leoclient-watch-my-home.conf  $(LEOCLIENTCONF)


# build a package
deb:
	### deb
	@echo 'Did you do a dch -i ?'
	@sleep 8
	dpkg-buildpackage -tc -uc -us -sa -rfakeroot
	@echo ''
	@echo 'Do not forget to tag this version in mercurial'
	@echo ''

clean:
	rm -rf  debian/leoclient



printer-virtual:
	@echo '   * Installing printer scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 standarddrucker/ausdruck-winxp-splitter $(BIN)
	@install -oroot -groot --mode=0755 standarddrucker/ausdruck-winxp-spooler $(BIN)
# nicht mehr erforderlich Ersetzt durch: ausdruck-winxp-splitter/ausdruck-winxp-spooler
#@install -oroot -groot --mode=0755 standarddrucker/ausdruck-winxp.sh $(BIN)

printer-default:
	@echo '   * Installing printer scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 standarddrucker/standarddrucker-nach-raum.sh $(BIN)


it:
	@echo '   * Installing italc scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 italc/italc-raumanpassung.sh $(BIN)

sd:
	@echo '   * Installing shutdown script (without cronjob entry)'
	@install -d -m0755 -oroot -groot $(VBOXDIR)
	@install -oroot -groot --mode=0755 shutdown/herunterfahren.sh $(BIN)




#lo:
#	@echo '   * Installing libreoffice stuff'
#	@install -d -m0755 -oroot -groot $(BIN)
#	@install -oroot -groot --mode=0755 openoffice-vorlagen/openoffice-vorlagenverz-kopieren.sh $(BIN)

icons:
	@echo '   * Installing desktop icons'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 desktop-icons/desktop-icons-hinzu.sh $(BIN)


#bios:
#	@echo '   * Installing biostime script (todo)'
#	@install -d -m0755 -oroot -groot $(BIN)
#	@#@install -oroot -groot --mode=0755 bios/bios???.sh $(BIN)


lm:
	@echo '   * Installing linuxmuster scripts'
	@install -d -m0755 -oroot -groot $(SHARE)
	@@install -oroot -groot --mode=0755 linuxmuster/mount.sh $(SHARE)
	@@install -oroot -groot --mode=0755 linuxmuster/umount.sh $(SHARE)
	@@install -oroot -groot --mode=0644 linuxmuster/profile $(SHARE)

#debug2:
#	@echo '   * Install debug scripts'
#	@install -d -m0755 -oroot -groot $(SBIN)
#	@install -oroot -groot --mode=0755  debug/leoclient-debug $(SBIN)

