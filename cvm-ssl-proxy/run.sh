#!/bin/bash

/env "$KEY"
/ssl-proxy -cert cert.pem -key key.pem -from 0.0.0.0:4430 -to $TO