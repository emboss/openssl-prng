# OpenSSL PRNG forking issue

The example code here illustrates some problems with OpenSSL's number generator
as outlined [here](http://martinbosslet.de/blog/2013/08/21/openssl-prng-is-not-really-fork-safe/).

It additionally includes the relevant parts of the PRNG from a Debian custom version of OpenSSL and
from the official OpenSSL, version 1.0.1e. You might find this convenient for your own experiments
as it doesn't require to compile the entirety of OpenSSL.

## License

Copyright (c) 2013 Martin Boßlet. Distributed under [WTFPL](http://www.wtfpl.net/) License.
See LICENSE for further details.

