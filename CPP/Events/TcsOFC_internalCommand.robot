*** Settings ***
Documentation    TcsOFC_internalCommand communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcsOfc
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 7 208 38 37 147 210 251 148 253 235 155 99 202 107 45 212 224 224 164 124 189 82 142 28 81 172 147 170 195 97 94 8 36 202 113 178 60 156 128 5 59 96 147 215 14 121 186 22 189 116 8 92 75 169 191 167 14 7 250 146 237 13 76 76 221 31 20 192 64 79 137 220 190 74 186 175 171 64 30 245 231 146 59 205 129 136 33 189 127 66 56 190 253 92 126 99 85 104 24 225 26 40 254 70 114 243 121 36 102 163 175 125 109 112 45 114 128 94 48 81 204 184 246 146 239 181 47 230 56 144 188 146 79 18 195 153 119 112 48 246 57 125 148 176 97 226 199 101 240 27 184 186 119 30 69 80 196 65 246 185 38 167 77 21 59 49 62 150 133 158 211 102 113 218 58 71 174 68 192 14 141 82 204 30 170 140 218 6 190 163 253 68 53 114 80 58 3 130 68 116 38 2 254 107 182 187 5 216 149 46 217 135 128 91 217 186 188 150 181 204 247 195 141 48 177 13 100 89 87 24 191 125 158 237 54 159 71 38 24 23 90 161 113 214 165 124 29 89 165 234 242 103 98 135 89 213 83 134 144 99 23 141 42 19 99 215 61 227 66 37 51 194 199 185 220 6 220 173 79 81 253 109 8 32 244 164 144 23 154 146 9 141 39 235 159 27 110 220 123 128 162 226 52 115 47 33 62 48 95 195 65 180 38 157 161 177 254 58 23 90 92 74 67 80 252 249 126 20 66 166 156 2 90 88 78 88 5 227 197 69 211 160 28 36 57 77 198 112 9 218 80 18 173 169 22 50 92 25 228 150 185 249 179 70 219 254 24 217 89 106 2 252 228 45 13 168 196 116 150 149 224 219 215 175 21 196 5 49 12 96 214 73 106 94 248 56 251 5 184 190 78 163 98 22 59 209 104 126 56 141 242 70 234 36 10 211 167 86 171 137 31 54 183 20 80 41 220 6 228 94 130 203 153 38 164 99 209 237 181 248 17 190 23 202 249 19 95 141 180 233 66 102 131 181 33 93 238 141 38 91 220 73 14 25 162 66 213 15 211 81 113 101 66 182 213 22 190 119 63 162 254 79 66 196 220 224 186 198 181 148 70 210 85 181 185 116 100 141 41 3 41 67 240 217 116 215 226 45 198 48 159 179 169 187 152 196 210 217 200 36 22 226 3 75 39 9 93 64 104 149 202 62 156 26 58 92 60 185 137 12 222 41 231 127 195 169 139 235 116 116 255 5 120 0 200 49 108 11 231 85 217 167 41 100 117 201 40 1 36 36 155 206 125 116 97 194 203 241 163 92 247 162 124 183 25 177 203 21 125 21 140 9 232 150 77 203 163 57 186 150 178 108 158 18 25 150 4 51 167 105 67 98 172 95 44 201 162 184 164 35 11 75 213 70 30 8 167 158 201 145 212 126 153 17 126 69 80 39 179 82 209 1 93 137 230 86 80 151 236 54 18 249 16 212 160 238 2 232 121 13 131 185 92 107 164 212 112 18 22 222 183 96 184 228 121 26 82 173 25 227 90 30 160 47 34 83 174 225 104 31 128 136 202 184 9 249 101 238 9 35 132 96 30 233 184 219 223 3 5 136 51 107 63 87 245 188 47 172 169 244 99 87 241 67 158 202 41 46 115 167 93 118 203 173 247 100 9 176 50 26 57 82 67 104 184 185 198 169 237 39 82 182 22 234 119 39 164 122 241 2 55 59 209 229 177 164 178 119 117 207 98 189 104 201 36 157 118 245 64 79 42 203 151 75 159 119 13 140 220 159 19 85 225 138 72 116 138 252 105 174 -1232271075
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcsOfc::logevent_internalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event internalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1232271075
    Log    ${output}
    Should Contain X Times    ${output}    === Event internalCommand received =     1
    Should Contain    ${output}    commandObject : 7
    Should Contain    ${output}    priority : 208
