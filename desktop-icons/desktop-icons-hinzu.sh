#!/bin/bash

cd ~

RECHNER=`hostname`

HEIMAT=`pwd`

# existieren Desktop-Eintr�ge lokal 
if [ -d /usr/share/linuxmuster-client/Desktop ]
then
 
 # Desktopeintr�ge von localadmin kopieren 
 # eventuell vorher Verzeichnis Desktop anlegen
 if [ -d `echo $HEIMAT/Desktop` ]
 then
  cp -a /usr/share/linuxmuster-client/Desktop/* $HEIMAT/Desktop/
 else
  mkdir $HEIMAT/Desktop
  cp -a /usr/share/linuxmuster-client/Desktop/* $HEIMAT/Desktop/
 fi

fi

# existieren Desktop-Eintr�ge schulweit
if [ -d /home/share/school/.Desktop ]
then
 
 # Desktopeintr�ge von localadmin kopieren 
 # eventuell vorher Verzeichnis Desktop anlegen
 if [ -d `echo $HEIMAT/Desktop` ]
 then
  cp -a /home/share/school/.Desktop/* $HEIMAT/Desktop/
 else
  mkdir $HEIMAT/Desktop
  cp -a /home/share/school/.Desktop/* $HEIMAT/Desktop/
 fi

fi

# existieren Desktop-Eintr�ge fuer Lehrer
if [ -d /home/share/teachers/.Desktop ]
then
 
 # Desktopeintr�ge von localadmin kopieren 
 # eventuell vorher Verzeichnis Desktop anlegen
 if [ -d `echo $HEIMAT/Desktop` ]
 then
  cp -a /home/share/teachers/.Desktop/* $HEIMAT/Desktop/
 else
  mkdir $HEIMAT/Desktop
  cp -a /home/share/teachers/.Desktop/* $HEIMAT/Desktop/
 fi

fi

