*** Settings ***
Documentation    TcsWEP_internalCommand communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcsWEP
${component}    internalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_log

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event ${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 35 98 134 159 209 136 190 223 92 239 151 105 119 71 173 116 123 123 218 194 6 236 134 215 181 34 48 17 161 118 76 123 121 239 33 251 111 75 118 107 142 208 23 222 53 124 94 244 165 0 138 20 77 62 78 42 21 81 177 185 128 245 196 104 197 33 33 21 152 71 170 214 170 167 26 130 52 166 34 175 59 36 194 117 237 17 253 241 144 255 68 204 151 99 181 244 35 245 117 231 208 59 201 231 187 65 238 224 39 30 33 182 212 22 43 92 218 33 191 46 178 230 15 194 183 252 6 180 219 240 40 124 210 33 203 146 215 0 220 161 100 188 186 238 244 146 72 238 65 1 251 172 156 252 41 202 52 164 140 39 119 195 198 94 126 215 220 212 222 146 237 88 205 60 97 226 237 80 237 207 110 26 186 116 244 65 206 174 39 174 223 68 48 125 132 7 6 204 203 76 150 227 185 181 15 239 123 49 185 87 166 30 119 165 176 22 84 48 146 112 53 128 56 47 156 74 174 60 76 174 228 151 185 105 1 15 177 36 132 1 54 180 225 86 220 95 242 134 77 9 88 58 127 57 212 239 119 28 67 249 233 77 164 201 136 93 26 120 72 58 206 6 15 96 89 4 161 2 62 241 50 109 67 42 1 76 144 49 27 86 39 26 110 59 160 190 157 84 175 52 97 51 255 135 101 24 253 65 153 85 116 41 70 197 104 138 105 53 60 42 67 20 105 157 192 202 31 22 154 41 91 242 126 205 215 81 111 16 217 223 81 72 174 234 34 188 155 28 193 151 75 231 103 220 249 3 7 84 153 157 75 164 168 72 225 98 75 148 122 209 192 226 31 181 141 109 157 13 32 141 110 134 98 42 235 52 8 87 232 108 57 23 83 191 72 138 143 10 76 41 120 55 48 66 148 48 119 79 238 230 139 130 95 242 96 229 48 210 58 203 188 141 194 11 175 168 109 180 167 174 194 52 230 16 201 131 109 178 64 144 30 35 30 111 174 60 20 65 95 38 178 215 77 82 105 7 28 25 231 8 227 115 202 194 27 205 126 4 80 233 143 62 40 93 86 147 239 143 251 116 159 94 207 90 141 202 16 110 154 103 243 58 195 223 119 204 255 135 76 220 226 77 41 174 96 122 115 223 170 220 204 7 246 148 38 195 19 30 38 175 216 38 56 133 110 35 111 31 78 168 62 120 208 243 70 51 203 89 176 228 196 6 20 84 33 226 26 232 98 229 190 224 171 89 116 55 193 174 197 210 180 31 164 194 247 111 102 62 165 158 115 216 220 75 208 135 153 74 68 219 31 74 39 89 85 183 146 161 27 132 41 236 204 158 132 7 182 68 93 104 174 86 58 18 219 7 92 144 169 251 137 177 108 105 69 12 110 166 165 0 140 4 39 249 41 165 211 86 74 20 179 118 238 187 183 19 54 22 7 164 186 170 29 62 170 165 67 39 6 133 226 196 158 66 150 182 169 240 94 9 233 8 14 20 210 119 226 93 43 170 119 131 228 209 141 149 214 197 204 41 237 118 19 195 115 69 85 12 34 82 2 27 17 211 253 245 180 146 210 3 93 202 8 55 183 233 180 102 161 80 241 166 148 113 218 123 220 15 247 138 191 199 22 180 190 70 76 125 77 168 60 207 1 172 39 211 202 171 107 118 32 146 11 135 132 229 44 178 223 56 206 21 82 182 78 173 181 164 113 120 17 40 68 186 252 22 78 121 139 25 75 36 139 241 158 54 233 25 54 63 214 19 150 60 142 174 125 87 116 181 252 60 108 248 58 134 53 195 185 35 -1310164504
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcsWEP::logevent_internalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event internalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1310164504
    Log    ${output}
    Should Contain X Times    ${output}    === Event internalCommand received =     1
    Should Contain    ${output}    commandObject : 35
    Should Contain    ${output}    priority : 98
