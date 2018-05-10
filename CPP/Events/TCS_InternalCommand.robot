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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 132 15 189 135 140 242 195 159 17 76 80 104 97 146 72 178 78 75 92 127 165 202 216 218 40 33 23 14 117 103 25 10 35 138 48 37 194 86 170 223 136 219 33 138 167 133 127 157 192 222 47 196 31 37 175 80 138 236 229 47 248 83 228 196 226 175 12 41 233 38 233 225 86 24 152 64 204 1 45 230 115 78 152 54 239 234 237 252 78 166 209 209 187 111 190 187 60 225 240 44 229 114 20 35 10 2 234 71 130 175 248 217 138 232 100 70 75 8 213 167 116 240 10 230 123 32 160 105 39 3 225 235 14 164 87 226 97 97 195 187 247 204 20 39 118 58 144 208 57 170 98 136 51 82 64 131 250 90 39 158 24 162 215 254 38 169 205 2 171 168 187 235 159 222 104 69 229 225 219 128 7 119 6 102 241 37 183 5 42 74 249 185 39 85 10 108 185 175 32 222 205 119 16 92 76 175 102 219 143 215 153 136 234 46 3 188 175 39 160 42 134 230 141 138 35 245 211 152 172 79 202 153 62 156 228 75 10 102 104 233 110 43 93 161 201 114 37 151 96 223 7 34 21 108 60 159 161 121 68 252 233 212 157 109 204 250 181 158 118 198 215 154 64 99 118 188 37 160 237 199 226 27 177 16 68 112 210 91 60 18 3 184 201 117 232 220 180 212 86 221 124 242 168 103 49 64 102 107 107 168 109 67 205 238 13 26 198 62 76 225 221 60 241 44 121 201 255 227 54 34 137 11 216 182 154 249 107 74 134 222 163 239 187 34 184 193 222 78 135 156 171 173 244 231 142 182 183 246 218 44 245 39 57 88 207 49 110 210 151 44 177 224 255 78 247 183 204 253 147 93 68 54 116 150 202 57 63 46 102 217 102 115 83 65 148 86 46 53 21 200 24 1 61 58 13 68 228 29 78 213 100 37 238 68 42 197 151 161 50 167 223 149 62 142 82 95 136 81 190 26 46 182 175 118 108 93 26 66 30 23 206 135 41 151 178 70 19 18 21 181 38 76 146 119 187 155 224 52 22 243 144 48 82 110 68 250 235 68 139 199 12 228 219 139 51 41 232 117 5 126 20 201 215 95 227 156 33 114 205 208 5 224 190 146 104 28 87 63 220 223 28 82 232 253 200 232 203 174 22 20 91 224 58 207 32 87 70 60 176 9 22 96 97 52 180 32 245 173 251 0 243 199 228 130 88 87 64 6 207 236 245 200 189 247 215 98 50 231 95 22 218 211 120 241 114 48 96 158 194 49 56 87 79 35 7 26 17 161 6 73 212 33 41 180 116 45 103 151 37 29 208 120 200 1 18 22 194 138 213 107 78 163 189 80 213 194 113 66 234 214 16 185 39 104 48 152 166 235 45 222 157 118 162 80 176 140 101 142 110 37 64 110 157 17 156 243 221 67 109 224 49 126 157 135 93 74 207 202 205 160 69 152 179 144 73 59 156 79 222 234 150 27 254 84 237 174 203 107 155 138 181 136 205 177 66 185 47 92 202 241 195 144 206 27 120 152 203 14 237 194 133 62 248 187 71 94 98 15 69 122 86 107 198 131 147 168 90 128 252 187 244 54 157 29 205 135 165 79 0 243 49 190 18 58 15 126 227 25 229 233 137 212 234 115 27 240 193 63 189 246 158 154 44 229 199 42 249 84 6 87 80 153 250 202 102 86 116 53 197 155 148 138 193 116 167 18 98 226 168 213 74 160 70 98 229 95 2 132 154 35 106 148 95 45 111 2 103 42 102 107 45 47 193 126 21 224 109 241 153 96 159 151 119 160 179 227 1 48 33 182 111 55 108 42 67 97 185 1 136 183 178 226 0 128 102 11 75 178 43 46 252 25 55 194 57 45 159 213 254 180 157 235 238 96 242 6 111 203 175 7 193 62 26 156 62 84 102 202 144 219 231 239 193 98 112 40 20 2 173 24 206 245 138 74 161 200 230 10 186 218 255 37 87 167 48 202 105 109 5 177 71 171 143 54 223 131 61 102 132 233 158 185 244 34 93 7 62 34 41 11 81 84 169 213 195 244 227 192 157 232 41 41 230 204 192 16 79 255 251 225 94 49 86 122 5 238 184 241 44 217 148 29 247 63 77 68 76 159 13 29 203 63 152 51 67 174 233 65 24 247 104 234 137 133 225 137 21 219 95 115 57 200 84 109 10 242 242 133 187 13 243 194 126 94 221 122 212 232 171 22 107 58 175 191 180 84 247 118 0 102 164 4 83 124 88 165 33 32 163 14 -1612735485
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1612735485
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 132
    Should Contain    ${output}    priority : 15
