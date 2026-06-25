#!/bin/bash

echo "### Enter the server IP ###"
read ip;

if grep -q -E "^micha.42.fr$" /etc/hosts; then
    echo "micha.42.fr exist !"
else
    echo "micha.42.fr create "
    echo "$ip micha.42.fr" >> /etc/hosts
fi

if grep -q "adminer.micha.42.fr" /etc/hosts; then
    echo "adminer.micha.42.fr exist !"
else
    echo "adminer.micha.42.fr create "
    echo "$ip adminer.micha.42.fr" >> /etc/hosts
fi

if grep -q "static.micha.42.fr" /etc/hosts; then
    echo "static.micha.42.fr exist !"
else
    echo "static.micha.42.fr create "
    echo "$ip static.micha.42.fr" >> /etc/hosts
fi