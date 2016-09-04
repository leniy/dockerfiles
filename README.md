[![](https://images.microbadger.com/badges/version/leniy/cacti.svg)](http://microbadger.com/images/leniy/cacti "") [![](https://images.microbadger.com/badges/image/leniy/cacti.svg)](http://microbadger.com/images/leniy/cacti "")

# docker-cacti

## Usage

Use the command below to run your own container:

    $ docker run -d -p 8080:80 -p 161:161 leniy/cacti

## Accessing the Cacti applications:

Find your port by:

    $ docker ps

Then you can visit your site by the following url:

  - **http://host_ip:8080/**

Or access docker directly by:

  - **http://host_ip:port/cacti/**

Then you can login by username:admin and password:admin.

## Files Located

  - WWW folder:     /var/www/html/
  - Cacti folder:   /usr/share/cacti/site/

## Relations

**Visit my blog here: [Leniy's Blog](http://blog.leniy.org)**
