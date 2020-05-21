ls -l |grep "$2" $1 Dealer_schedule | awk '{print $1, $2, $5, $6}'
