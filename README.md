# docker-snort

## Configuration
Modify /etc/snort/pulledpork.conf, replacing all instances of <oinkcode> with your actual oinkcode number.
Download initial rules with `pulledpork.pl -c /etc/snort/pulledpork.conf -l`
Run snort with `snort -A console -c /etc/snort/snort.conf -i eth0`
