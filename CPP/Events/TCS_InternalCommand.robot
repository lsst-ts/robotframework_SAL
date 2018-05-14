*** Settings ***
Documentation    TCS_InternalCommand sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcs
${component}    InternalCommand
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 26 46 63 139 174 142 203 64 184 91 140 89 166 212 79 61 42 168 20 233 19 3 95 162 131 177 45 48 229 31 151 136 117 12 174 252 70 186 164 194 168 71 81 171 166 165 34 10 72 4 78 160 121 6 189 219 96 93 90 4 161 99 178 200 100 159 199 212 67 59 161 97 168 214 119 212 125 53 27 231 245 120 75 237 134 211 251 105 194 217 67 185 236 149 119 153 14 253 243 124 169 118 0 85 235 184 226 13 237 235 126 218 209 131 86 244 175 203 190 27 73 127 186 48 179 12 100 241 220 178 99 90 149 165 168 123 121 171 226 44 73 241 86 247 60 79 228 116 12 234 75 100 18 31 219 57 127 2 183 150 15 74 10 244 58 12 214 47 229 49 217 30 167 219 11 105 154 243 253 9 23 253 200 32 237 138 133 158 213 242 211 31 162 54 75 123 206 114 145 171 162 136 7 76 59 6 54 21 40 43 194 228 237 66 43 229 76 67 116 40 10 29 221 170 197 61 95 193 117 176 147 169 150 138 73 216 173 234 237 22 170 107 166 139 46 240 136 46 83 215 227 249 133 198 43 85 125 137 194 209 203 239 243 112 55 96 245 137 49 210 244 80 202 102 139 201 104 204 46 235 121 117 194 216 177 189 226 72 187 22 84 87 247 165 15 116 11 55 251 139 163 110 109 53 232 85 195 125 12 72 181 84 237 24 0 238 108 78 99 145 71 20 42 48 9 229 140 37 233 72 94 133 198 72 42 116 217 111 205 165 79 153 200 146 0 252 28 228 17 87 210 155 182 115 72 103 42 114 145 41 194 99 159 102 107 35 243 34 34 248 94 103 52 111 177 204 86 97 156 244 24 80 61 3 16 35 11 50 85 53 92 85 251 58 199 47 155 2 239 154 93 227 4 23 18 229 247 28 253 10 191 27 230 161 78 249 165 30 121 231 97 42 13 148 157 143 14 18 185 78 80 13 228 100 57 211 65 145 191 237 188 110 75 55 107 192 46 71 19 8 89 146 228 101 128 47 56 248 107 116 178 167 215 119 18 215 132 118 125 248 211 148 39 191 141 186 73 169 233 200 5 65 137 214 164 195 7 214 151 142 30 215 73 225 16 214 132 114 195 53 69 72 166 129 80 73 98 244 94 35 206 41 200 125 116 252 253 68 223 109 239 177 35 118 194 152 202 210 227 198 73 59 153 231 150 53 13 230 76 181 119 245 212 45 189 156 18 233 195 253 89 204 18 97 105 194 107 141 194 39 233 106 237 195 249 200 70 78 56 12 102 168 99 146 133 89 109 184 92 98 97 57 191 8 123 155 38 6 141 58 72 132 171 45 234 130 237 213 58 247 81 8 141 137 90 45 36 55 255 178 185 28 95 12 151 199 81 25 58 71 48 224 115 250 248 177 138 65 214 135 239 19 252 20 67 137 19 218 154 215 46 136 96 255 22 184 113 142 37 113 179 52 243 226 153 70 63 43 79 56 203 149 192 4 179 104 220 209 21 5 247 19 168 147 13 4 12 111 147 69 247 49 46 94 1 52 154 1 155 227 207 202 163 175 0 190 227 150 247 243 145 32 234 9 150 184 89 184 112 68 221 49 36 234 115 126 88 22 214 90 13 125 74 211 223 118 27 215 171 38 128 59 168 111 57 163 182 22 62 199 67 94 117 183 165 227 247 191 255 96 35 96 58 211 201 121 57 2 232 235 88 229 23 128 236 154 14 38 92 241 105 63 22 38 182 63 30 246 232 149 169 190 119 20 2 185 188 74 250 106 4 122 87 50 251 35 213 48 88 64 191 24 243 233 204 172 191 14 121 219 73 40 230 146 116 120 119 195 254 37 78 30 29 38 161 32 112 56 193 63 149 106 81 181 127 161 135 197 70 72 10 145 191 126 148 106 158 68 146 15 16 199 239 214 167 248 119 69 162 99 225 42 125 182 233 129 35 64 240 73 229 180 89 162 107 140 97 98 249 95 242 8 2 139 58 134 21 157 203 1 9 209 78 114 87 103 87 165 162 74 46 121 255 71 175 198 172 190 160 56 127 129 98 37 188 237 102 207 233 243 50 195 136 51 115 86 11 207 17 145 146 180 98 135 248 177 50 201 166 94 251 192 34 255 72 82 48 250 106 80 69 149 137 245 132 242 107 48 97 213 29 30 219 61 34 25 125 190 183 171 150 78 153 92 47 33 45 109 231 50 44 4 249 181 207 198 26 168 71 227 192 6 124 19 235 27 10 114 25 236 1821485558
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1821485558
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 26
    Should Contain    ${output}    priority : 46
