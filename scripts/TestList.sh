for SCRIPT in $HOME/trunk/robotframework_SAL/scripts/ArgumentLists/TestList*
do
	if [ -f $SCRIPT -a -x $SCRIPT ]; then
		$SCRIPT
	fi
done