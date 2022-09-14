# Linux_FW_Flash_Cycle
1. Test FW Flash cycle between two FW version Flash.
2. All of the Flash Data will log in "log.txt".
3. User need to change the Flash commnad manually by your Flash tool command.
4. This Script run on local host, so need to add this script path into linux "etc/rc.d/rc.local" file then let it execute next boot.
5. Need to enable auto login as below step, add below command into "/etc/gdm/custom.conf" file. 
  - AutomaticLoginEnable=true
  - AutomaticLogin=root
