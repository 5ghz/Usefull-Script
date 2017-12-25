#!/bin/bash
now=`date +%F | tr -d -`
cert=`certbot certificates 2>&1  | grep Expiry | head -n1 | cut -d' ' -f7 | tr -d -`
let res=(`date +%s -d 20171221`-`date +%s -d 20180320`)/86400
if [ "$res" -lt 0 ]
then
        let res=0-$res
fi
if [ "$res" -lt 3 ]
then
        certbot renew --pre-hook "service nginx stop" --post-hook "service nginx start"
fi
