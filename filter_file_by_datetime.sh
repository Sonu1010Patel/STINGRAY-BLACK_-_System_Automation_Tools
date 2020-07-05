#!/usr/bin/env bash

# Inputs:
#	$1 - log file
#	$2 - start datetime
#	$3 - end datetime

# Example:
#	./filter_file_by_datetime.sh  some_log_file.log  "Jun 28 12:00:00.234"  "Jun 29 18:40:12.232"



# Jun 29 15:24:34
date_format="[a-z]{3} [0-9]{1,2} [0-9]{2}:[0-9]{2}:[0-9]{2}"

# Jun 29 15:24:34.240
# date_format="[a-z]{3} [0-9]{1,2} [0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}"

# 2020-06-29T15:24:34.240
# date_format="[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}"

# 06/29/2020 15:24:34.240
# date_format="[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}"

# 20200629T15:24:34.240
# date_format="[0-9]{4}[0-9]{2}[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}"


while IFS= read -r line
do
    epoch_line=$(date +%s --date=" $( echo "$line" | egrep -oi "$date_format" ) ")
    epoch_start=$(date +%s --date="$2")
    epoch_end=$(date +%s --date="$3")
    
    if [[ $epoch_start -lt $epoch_line ]] && [[ $epoch_line -lt $epoch_end ]]; then
        echo $line
    fi

done < $1
