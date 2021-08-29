### SocaTorSSL = SOCAT + TOR + SSL 
Based on https://github.com/Arno0x/Docker-Socator

SocaTorSSL acts as an SSL secured clear net proxy to a hidden service on the TOR network.


### RUN Environment Variables

- `ALLOWED_RANGE` : Restrict the IP addresses that are allowed to connect to this service by specifying an environment variable and using CIDR notation.
- `TOR_SITE` : The .onion address to your hidden service
- `TOR_SITE_PORT` : The port to connect to on your TOR hidden service
- `SSL_CERT` :  SSL certificate filename (PEM) *
- `SSL_KEY` :  SSL key filename  (PEM) *

* Certificate PEM files should be placed in the host container directory `/etc/socatorssl/certs/`


### Mounting SSL Certificates

If you generate or already have SSL certificates on your host server you can mount the folder that contains the certificates to the docker container directory  `/etc/socatorssl/certs/`.
See example below.

### Example Usage

Host a proxy service to allow a device that has problems connecting over TOR to connect to a service that is only accessible over TOR. 

Eg. BlueWallet Android -> Umbrel Node


##### pull

    docker pull damanic/socatorssl

##### Run: Start the image in background (*daemon mode*) :

In the following example  `/path/to/ssl/certificate` points to the host directory that contains your SSL certificates
    
    docker run -d \
        -p 5100:5100 \
        -e "PUBLIC_PORT=5100" \
        -e "TOR_SITE=zqktlwiuavvvqqt4ybvgvi7tyo4hjl5xgfuvpdf6otjiycgwqbym2qad.onion" \
        -e "TOR_SITE_PORT=50001" \
        -e "SSL_CERT=cert.pem" \
        -e "SSL_KEY=key.pem" \
        --name socatorssl \
        --mount type=bind,source=/path/to/ssl/certificate,target=/etc/socatorssl/certs/ \
        damanic/socatorssl

You can now access the tor hidden service via https://yourdomain.com:5100

Remove the`SSL_*` environment variables and `--mount` to expose the proxy over PLAIN HTTP

----------------
