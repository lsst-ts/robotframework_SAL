for SCRIPT in $ROBOTFRAMEWORK_SAL_DIR/scripts/ArgumentLists/Jenkins_*
do
	if [ -f $SCRIPT -a -x $SCRIPT ]; then
		$SCRIPT
	fi
done
