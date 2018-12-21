#!/bin/bash

report_dir=$HOME/Reports/SAL_AuxTel
vars_dir=$HOME/bin
salgen_dir=$HOME/trunk/robotframework_salgenerator
salmessage_dir=$HOME/trunk/robotframework_SAL

# Clean out results directory.
echo "=== Clearing previous test results. ==="
rm -r ${report_dir}/*

# Move to trunk/robotframework_salgenerator to run the SALGEN tests.
echo "cd ${salgen_dir}"
cd $salgen_dir

# Run the tests.
echo "=== Running the AuxTel SALGENERATOR tests. ==="
robot -A $vars_dir/SalAuxTel_Vars.txt --name VERSION --output VERSION SAL_Tests.robot
wait
robot -A $vars_dir/SalAuxTel_Vars.txt --name ATArchiverGen --output ATArchiverGen SALGEN/ATArchiver_salgenerator.robot
wait
robot -A $vars_dir/SalAuxTel_Vars.txt --name ATCameraGen --output ATCameraGen SALGEN/ATCamera_salgenerator.robot
wait
robot -A $vars_dir/SalAuxTel_Vars.txt --name ATHeaderGen --output ATHeaderGen SALGEN/ATHeaderService_salgenerator.robot
wait
robot -A $vars_dir/SalAuxTel_Vars.txt --name ATMonochromatorGen --output ATMonochromatorGen SALGEN/ATMonochromator_salgenerator.robot
wait
robot -A $vars_dir/SalAuxTel_Vars.txt --name ElectrometerGen --output ElectrometerGen SALGEN/Electrometer_salgenerator.robot
wait
robot -A $vars_dir/SalAuxTel_Vars.txt --name FiberSpectrographGen --output FiberSpectrographGen SALGEN/FiberSpectrograph_salgenerator.robot
wait

# Move to trunk/robotframework_SAL to run the SAL Messaging tests.
echo "cd ${salmessage_dir}"
cd $salmessage_dir

# Run the tests.
echo "=== Running the SAL messaging tests. ==="
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATArchiver_CPPSTATE --output ATArchiver_CPPSTATE CPP/StateMachine/ATArchiver_StateMachine.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATCamera_CPPSTATE --output ATCamera_CPPSTATE CPP/StateMachine/ATCamera_StateMachine.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATHeaderService_CPPSTATE --output ATHeaderService_CPPSTATE CPP/StateMachine/ATHeaderService_StateMachine.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATMonochromator_CPPSTATE --output ATMonochromator_CPPSTATE CPP/StateMachine/ATMonochromator_StateMachine.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name Electrometer_CPPSTATE --output Electrometer_CPPSTATE CPP/StateMachine/Electrometer_StateMachine.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name FiberSpectrograph_CPPSTATE --output FiberSpectrograph_CPPSTATE CPP/StateMachine/FiberSpectrograph_StateMachine.robot &
wait
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATArchiver_PYTHONSTATE --output ATArchiver_PYTHONSTATE PYTHON/StateMachine/ATArchiver_StateMachine.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATCamera_PYTHONSTATE --output ATCamera_PYTHONSTATE PYTHON/StateMachine/ATCamera_StateMachine.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATHeaderService_PYTHONSTATE --output ATHeaderService_PYTHONSTATE PYTHON/StateMachine/ATHeaderService_StateMachine.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATMonochromator_PYTHONSTATE --output ATMonochromator_PYTHONSTATE PYTHON/StateMachine/ATMonochromator_StateMachine.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name Electrometer_PYTHONSTATE --output Electrometer_PYTHONSTATE PYTHON/StateMachine/Electrometer_StateMachine.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name FiberSpectrograph_PYTHONSTATE --output FiberSpectrograph_PYTHONSTATE PYTHON/StateMachine/FiberSpectrograph_StateMachine.robot &
wait
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATArchiver_CPPGENEVT --output ATArchiver_CPPGENEVT CPP/GenericEvents/ATArchiver_GenericEvents.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATCamera_CPPGENEVT --output ATCamera_CPPGENEVT CPP/GenericEvents/ATCamera_GenericEvents.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATHeaderService_CPPGENEVT --output ATHeaderService_CPPGENEVT CPP/GenericEvents/ATHeaderService_GenericEvents.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATMonochromator_CPPGENEVT --output ATMonochromator_CPPGENEVT CPP/GenericEvents/ATMonochromator_GenericEvents.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name Electrometer_CPPGENEVT --output Electrometer_CPPGENEVT CPP/GenericEvents/Electrometer_GenericEvents.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name FiberSpectrograph_CPPGENEVT --output FiberSpectrograph_CPPGENEVT CPP/GenericEvents/FiberSpectrograph_GenericEvents.robot &
wait
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATArchiver_PYTHONGENEVT --output ATArchiver_PYTHONGENEVT PYTHON/GenericEvents/ATArchiver_GenericEvents.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATCamera_PYTHONGENEVT --output ATCamera_PYTHONGENEVT PYTHON/GenericEvents/ATCamera_GenericEvents.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATHeaderService_PYTHONGENEVT --output ATHeaderService_PYTHONGENEVT PYTHON/GenericEvents/ATHeaderService_GenericEvents.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name ATMonochromator_PYTHONGENEVT --output ATMonochromator_PYTHONGENEVT PYTHON/GenericEvents/ATMonochromator_GenericEvents.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name Electrometer_PYTHONGENEVT --output Electrometer_PYTHONGENEVT PYTHON/GenericEvents/Electrometer_GenericEvents.robot &
sleep 10
xterm -e robot -A $vars_dir/SalAuxTel_Vars.txt --name FiberSpectrograph_PYTHONGENEVT --output FiberSpectrograph_PYTHONGENEVT PYTHON/GenericEvents/FiberSpectrograph_GenericEvents.robot &
wait

# Move to Reports/SAL_RegressionTests to generate reports.
echo "cd ${report_dir}"
cd $report_dir

# Check for output file existence.
declare -a outputs=(VERSION.xml ATArchiverGen.xml ATCameraGen.xml ATHeaderGen.xml ATMonochromatorGen.xml ElectrometerGen.xml FiberSpectrographGen.xml ATArchiver_CPPSTATE.xml ATCamera_CPPSTATE.xml ATHeaderService_CPPSTATE.xml ATMonochromator_CPPSTATE.xml Electrometer_CPPSTATE.xml FiberSpectrograph_CPPSTATE.xml ATArchiver_PYTHONSTATE.xml ATCamera_PYTHONSTATE.xml ATHeaderService_PYTHONSTATE.xml ATMonochromator_PYTHONSTATE.xml Electrometer_PYTHONSTATE.xml FiberSpectrograph_PYTHONSTATE.xml ATArchiver_CPPGENEVT.xml ATCamera_CPPGENEVT.xml ATHeaderService_CPPGENEVT.xml ATMonochromator_CPPGENEVT.xml Electrometer_CPPGENEVT.xml FiberSpectrograph_CPPGENEVT.xml ATArchiver_PYTHONGENEVT.xml ATCamera_PYTHONGENEVT.xml ATHeaderService_PYTHONGENEVT.xml ATMonochromator_PYTHONGENEVT.xml Electrometer_PYTHONGENEVT.xml FiberSpectrograph_PYTHONGENEVT.xml)
i=0
for item in "${outputs[@]}"; do
    if test -f "$item"; then array[$i]=$item; else echo "$item does not exist!";fi
    (( i++ ))
done

# Generate reports.
echo "=== Generating reports with ${array[@]} ==="
rebot --name SAL_AuxTel -o salauxtel_output.xml -l salauxtel_log.html -r salauxtel_report.html --noncritical TSS* ${array[@]}
