#Servidor DNS basico sobre docker

FROM        debian:stretch

MAINTAINER gg13008@ues.edu.sv

#Actualizar/instalar/borrar lo innecesario

RUN         apt-get update && \
            apt-get install -y bind9 net-tools dnsutils nano && \
            rm -rf /var/lib/apt/lists/* && rm /etc/bind/named.conf.local

#La capa variable
RUN mkdir  /archivos/ && echo "exito al crear el puto directorio" 
ADD start /start  
ADD db.tamales /archivos/ 
ADD named.conf.local /archivos/
	    
#Puertos a exponer
EXPOSE      53/udp 53/tcp 10000/tcp

# Este sera el punto de entrada
CMD ["/start"]
#ENTRYPOINT	["/usr/sbin/named", "-f"]
# o -g





 
