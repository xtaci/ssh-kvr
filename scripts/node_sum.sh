df -ah /storage/ |tail -n 1|awk '{printf("Size: %s,\t Used: %s,\t Avail: %s\n", $2,$3,$4)}' 
