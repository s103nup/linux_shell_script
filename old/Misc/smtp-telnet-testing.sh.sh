#!/bin/bash

HOST='<hostname>'
PORT='<port>'
MAIL_FROM='<mail from>'
MAIL_TO='<mail to>'
subject="$(hostname) sending mail testing!"
body="Sending mail at $(date +'%Y-%m-%d %T')"

telnetInput () {
	local cmd=$1
	echo $cmd
	sleep 2
}


(
	telnetInput "OPEN $HOST $PORT"
	telnetInput "EHLO $MAIL_FROM"
	telnetInput "MAIL FROM:<$MAIL_FROM>"
	telnetInput "RCPT TO:<$MAIL_TO>"
	telnetInput 'DATA'
	telnetInput "SUBJECT: $subject"
	telnetInput "$body"
	telnetInput '.'
	telnetInput 'quit'
) | telnet
