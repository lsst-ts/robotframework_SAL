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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 31 110 66 109 12 134 227 78 133 52 116 170 246 37 56 10 189 177 164 77 223 60 199 47 165 239 37 201 118 136 69 155 113 69 203 228 2 141 2 122 225 97 22 54 180 70 106 93 151 53 66 254 240 9 2 177 19 134 90 163 188 119 55 0 254 28 120 173 53 61 70 212 205 125 190 1 34 171 216 165 123 118 245 248 142 36 186 62 40 1 96 220 55 230 60 33 42 104 215 145 223 101 225 152 49 9 35 96 88 182 82 183 186 164 92 50 172 18 55 173 91 75 153 30 201 10 144 217 169 116 182 111 28 92 123 238 76 253 150 254 142 231 147 162 87 44 67 150 155 64 140 24 4 128 239 145 96 211 129 157 204 145 248 60 222 166 23 170 117 15 194 105 117 29 224 146 46 23 150 63 175 172 39 145 18 146 163 191 101 73 233 107 171 42 50 84 249 94 80 220 237 201 238 154 153 189 180 216 29 73 135 228 221 218 88 229 218 12 219 56 136 68 164 184 229 113 97 86 203 168 241 20 19 120 179 245 209 203 188 100 194 176 188 35 39 57 117 135 10 17 152 69 14 210 58 1 134 163 13 24 75 70 95 223 12 49 72 170 142 26 140 1 93 44 247 209 93 58 253 149 115 78 20 37 80 254 189 240 9 135 174 224 171 85 50 44 125 219 200 218 102 120 18 166 40 166 44 237 68 171 105 151 103 231 50 131 168 96 130 167 217 186 55 35 92 176 183 152 149 123 59 194 1 119 81 77 67 98 117 111 238 105 123 233 235 245 139 123 226 3 160 81 252 51 110 76 226 192 173 231 114 255 94 17 110 244 235 82 187 173 59 128 89 85 126 40 188 36 90 77 152 198 241 251 81 193 49 38 160 227 166 178 116 171 170 25 145 82 191 4 66 33 196 57 45 151 75 8 10 149 137 75 53 254 5 62 149 181 157 207 244 235 38 229 123 199 107 218 127 141 87 0 184 29 22 89 238 156 26 102 130 254 249 200 72 181 207 210 199 59 27 192 156 72 17 4 34 9 52 157 210 113 47 103 78 12 168 146 82 217 68 0 76 140 30 68 153 243 77 87 198 5 202 211 156 38 19 229 241 205 241 19 123 201 112 223 86 212 43 138 57 7 214 95 102 83 139 232 122 149 222 58 138 204 6 60 94 21 227 244 68 153 153 179 198 71 172 188 15 72 75 132 220 76 131 167 22 32 187 185 32 179 72 100 34 13 123 107 169 40 58 38 25 170 248 27 61 10 190 148 7 88 160 147 34 112 45 178 36 33 139 64 32 100 72 76 173 187 156 243 14 210 205 105 211 132 42 92 206 220 69 44 129 2 51 189 234 77 30 170 219 109 42 247 168 216 239 145 234 128 234 229 39 17 4 163 206 190 97 243 44 168 210 237 104 155 208 104 217 194 81 153 253 29 251 253 56 72 28 24 51 175 181 130 106 110 247 246 167 175 114 111 70 173 59 176 251 216 31 169 14 25 33 124 127 30 148 94 184 166 142 138 197 245 231 206 51 56 202 179 162 237 104 165 136 1 14 174 246 194 233 6 73 226 83 105 72 145 55 193 16 153 218 25 191 105 6 196 21 86 38 132 213 119 47 47 37 132 193 65 36 240 3 238 23 79 100 152 71 16 235 164 174 179 42 224 207 17 217 189 194 177 136 86 136 151 186 138 90 150 111 14 207 185 212 166 107 30 240 46 201 237 115 176 52 203 57 252 75 59 243 155 229 160 20 142 147 162 9 226 198 122 61 198 224 245 193 105 154 233 163 182 91 153 36 18 189 120 32 154 42 165 159 74 140 179 157 46 72 31 33 246 74 203 88 111 156 51 19 3 177 46 156 114 104 239 52 175 165 37 230 32 94 76 22 148 45 97 13 180 177 238 56 236 140 202 134 136 192 253 18 146 191 159 142 39 125 65 30 16 239 130 158 222 178 185 84 171 63 151 230 102 72 86 34 50 17 185 168 251 23 4 129 6 35 139 190 182 121 233 74 215 224 184 245 32 249 225 89 215 201 45 244 234 151 233 226 157 190 64 185 34 35 81 68 200 228 198 108 184 32 150 127 237 207 162 207 73 139 119 153 191 200 174 58 44 109 156 143 28 176 44 163 196 243 142 221 227 207 126 180 99 61 222 254 144 88 15 250 228 119 85 152 230 185 136 56 138 87 239 197 65 54 226 111 233 246 245 22 5 87 66 222 149 162 56 231 216 189 111 169 228 140 40 118 116 216 42 31 7 2064899332
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 2064899332
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 31
    Should Contain    ${output}    priority : 110
