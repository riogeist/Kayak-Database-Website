#############################################################################
# File name:  Makefile
# Author:     Jasper Riogeist
# Date:       November 29, 2021
# Class:      CS445
# Assignment: BigDB 
#############################################################################

all: copy

copy: 
	echo ${USER}
	mkdir -p /srv/www/htdocs/php/${USER}/bigdb-riogeist
	chmod o+rx -R /srv/www/htdocs/php/${USER}/bigdb-riogeist
	rsync -ahv * /srv/www/htdocs/php/${USER}/bigdb-riogeist
