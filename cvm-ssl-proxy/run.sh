#!/bin/bash

/env "$KEY"
/ssl-proxy -cert cert.pem -key key.pem -from 0.0.0.0:$PORT -to $TO