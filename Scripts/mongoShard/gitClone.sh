source $1

GIT_STRING="git clone http://github.com/mghosh4/EmulabScripts"
REMOVE_STRING="sudo rm -rf /home/mainak/EmulabScripts/"
for  node in ${QUERY_ROUTERS//,/ }
do
        echo "clone git hub to $node ... $REMOVE_STRING"
        ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "
            $REMOVE_STRING"
         echo "clone git hub to $node ... $GIT_STRING"
        ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "
            cd /home/mainak &&
            $GIT_STRING" 
done
echo ""
