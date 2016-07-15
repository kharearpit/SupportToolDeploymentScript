var=`ssh -l root 172.26.64.107 /root/deploy.sh`

echo "result: $var"
if [ $? -eq 0 ]; then
    echo "Copying a new jar from local to server"
    transfer_war=`scp /Users/akhare/Documents/support_workspace/SupportToolBackend/target/SupportToolBackend-0.0.1-SNAPSHOT.jar root@172.26.64.107:/home/hive/zepplin_tool`
    if [ $? -eq 0  ]; then
	echo "Jar transfer on 172.26.64.107: Success!"
    else
	echo "reset server config: SUCCESS    jar transfer on 172.26.64.107: FAILED" 
    fi
else
    echo "reset server config: FAILED"
fi
echo "----------------------------------------------"

#for 172.26.64.202
var=`ssh -l root 172.26.64.202 /root/deploy.sh`

echo "result: $var"
if [ $? -eq 0 ]; then
    echo "Copying a new jar from local to server"
    components=(hive hbase hadoop)
    for i in ${components[*]};do
	
    		transfer_war=`scp /Users/akhare/Documents/support_workspace/SupportToolBackend/target/SupportToolBackend-0.0.1-SNAPSHOT.jar root@172.26.64.202:/root/$i`
	   	 if [ $? -eq 0  ]; then
       			 echo "$i:Jar transfer on 172.26.64.202: Success!"
    		else
        		echo "reset server config: SUCCESS    $i:jar transfer on 172.26.64.202: FAILED"
    		fi
   done
else
    echo "reset server config: FAILED"
fi

# for front end WAR
war_transfer=`scp /Users/akhare/Desktop/SupportTool.war root@172.26.64.202:/root/apache-tomcat-8.0.36/webapps`
                 if [ $? -eq 0  ]; then
                         echo "WAR transfer on 172.26.64.202: Success!"
                else
                        echo "WAR transfer on 172.26.64.202: FAILED"
                fi
