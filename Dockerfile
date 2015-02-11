FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y vim ethtool build-essential libpcap-dev libpcre3-dev libdumbnet-dev bison flex zlib1g-dev wget
RUN wget https://www.snort.org/downloads/snort/daq-2.0.4.tar.gz && tar -xvzf daq-2.0.4.tar.gz 
RUN wget https://www.snort.org/downloads/snort/snort-2.9.7.0.tar.gz && tar -xvzf snort-2.9.7.0.tar.gz

RUN cd daq-2.0.4 && ./configure && make && make install && cd ..
RUN cd snort-2.9.7.0 && ./configure --enable-sourcefire && make && make install && cd ..

RUN ldconfig

RUN mkdir /etc/snort /etc/snort/rules /etc/snort/preproc_rules /var/log/snort /usr/local/lib/snort_dynamicrules
RUN touch /etc/snort/rules/white_list.rules /etc/snort/rules/black_list.rules /etc/snort/rules/local.rules
RUN chmod -R 5775 /etc/snort /var/log/snort /usr/local/lib/snort_dynamicrules

RUN cp snort-2.9.7.0/etc/*.conf* /etc/snort/
RUN cp snort-2.9.7.0/etc/*.map* /etc/snort/

ADD snort.conf /etc/snort/snort.conf

# install pulledpork
RUN apt-get install -y libcrypt-ssleay-perl liblwp-useragent-determined-perl

RUN wget https://pulledpork.googlecode.com/files/pulledpork-0.7.0.tar.gz
RUN tar xvfvz pulledpork-0.7.0.tar.gz
RUN cp pulledpork-0.7.0/pulledpork.pl /usr/local/bin
RUN chmod +x /usr/local/bin/pulledpork.pl
RUN cp pulledpork-0.7.0/etc/*.conf /etc/snort

RUN mkdir /etc/snort/rules/iplists
RUN touch /etc/snort/rules/iplists/default.blacklist

ADD pulledpork.conf /etc/snort/pulledpork.conf
