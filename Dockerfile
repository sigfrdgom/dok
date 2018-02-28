#Servidor DNS basico sobre docker

FROM        debian:stretch

MAINTAINER gg13008@ues.edu.sv

#Actualizar/instalar/borrar lo innecesario

RUN         apt-get update && \
            apt-get install -y bind9 net-tools dnsutils nano && \
            rm -rf /var/lib/apt/lists/*

#La capa variable

RUN         touch /etc/bind/db.tamales  &&\
            echo "$TTL    604800" >> /etc/bind/db.tamales &&\
            echo "@       IN      SOA     dns1.tamales.com.  gg13008.ues.edu.sv (" >> /etc/bind/db.tamales &&\
            echo "                              2         ; Serial" >> /etc/bind/db.tamales &&\
            echo "                         604800         ; Refresh" >> /etc/bind/db.tamales &&\
            echo "                          86400         ; Retry" >> /etc/bind/db.tamales &&\
            echo "                        2419200         ; Expire" >> /etc/bind/db.tamales &&\
            echo "                         604800 )       ; Negative Cache TTL" >> /etc/bind/db.tamales &&\
            echo ";" >> /etc/bind/db.tamales &&\
            echo "@       IN      NS      dns1.tamales.com." >> /etc/bind/db.tamales &&\
            echo "dns1    IN      A       192.168.122.34" >> /etc/bind/db.tamales &&\
            echo "; no esta bien pero funciona" >> /etc/bind/db.tamales &&\
            echo "zone "tamales.com." {" >> /etc/bind/named.conf.local &&\
            echo "	type master ;" >> /etc/bind/named.conf.local &&\
            echo "      file "/etc/bind/db.tamales" ;" >> /etc/bind/named.conf.local &&\
            echo "} ;" >> /etc/bind/named.conf.local &&\
	    touch /start && chmod 777 /start &&\
	    echo "#!/bin/bash" > /start &&\ 
	    echo "echo "Starting named..."" >> /start &&\
	    echo "mkdir -m 0775 -p /var/run/named" >> /start &&\
	    echo "chown root:bind /var/run/named" >> /start &&\
	    echo "touch /var/log/query.log" >> /start &&\
	    echo "chown bind /var/log/query.log" >> /start &&\
	    echo "exec /usr/sbin/named -u bind -g" >> /start &&\
	    #named-checkconf -z &&\
	    echo " " > /etc/resolv.conf &&\
	    echo " " >> /etc/resolv.conf &&\
	    echo "nameserver 127.0.0.1" >> /etc/resolv.conf &&\
	    echo "exito" 
	    
	    ## &&\
	    ##/etc/init.d/bind9 reload 
	    
	    
#Puertos a exponer
EXPOSE      53/udp 53/tcp 10000/tcp

# Este sera el punto de entrada
#CMD         /start
ENTRYPOINT	["/usr/sbin/named", "-f"]
# o -g





 
