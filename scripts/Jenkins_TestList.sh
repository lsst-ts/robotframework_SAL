for SCRIPT in $ROBOT_FRAMEWORK_REPO_DIR/scripts/ArgumentLists/Jenkins_*
do
	if [ -f $SCRIPT -a -x $SCRIPT ]; then
		$SCRIPT
	fi
done
