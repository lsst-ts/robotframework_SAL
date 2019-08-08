This repository consists of two things.

1) Scripts that generator .robot files
2) .robot files that Jenkins can run. These .robot files excersice the SAL middleware by running the salgenerator steps and executing the generated test programs.

How to run
To be able to run the scripts you need to set two environment variables. 

ROBOTFRAMEWORK_SAL_DIR - to the location of this repository. For example you would need to run "export /home/user/robotframework_SAL"

TS_XML_DIR - to the location location of the ts_xml repository. For example you would need to run "export /home/user/ts_xml"