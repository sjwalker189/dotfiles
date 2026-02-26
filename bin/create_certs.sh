#!/usr/bin/env bash

DIR=/data/ssl-cert

mkcert -key-file $DIR/privkey.pem -cert-file $DIR/cert.pem localhost $(hostname -I | cut -d' ' -f1) 127.0.0.1 ::1

