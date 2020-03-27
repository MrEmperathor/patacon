#!/bin/bash
clear
 for i in `ls *.php`; do
	sed -i -e 's/\r$//' $i;
done
echo "termine"
