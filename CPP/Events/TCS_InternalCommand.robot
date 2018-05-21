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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 196 40 14 212 160 238 250 79 254 128 16 38 7 47 99 94 255 82 145 52 20 242 84 90 129 241 207 98 137 99 5 250 88 172 0 197 242 5 77 167 22 123 45 73 73 153 1 236 227 72 219 227 183 118 46 187 201 138 135 91 54 96 146 1 2 143 86 69 23 48 2 207 67 119 193 189 205 210 20 124 42 11 196 117 175 228 167 98 145 163 139 27 233 48 249 183 215 82 154 160 32 218 228 179 8 121 92 76 143 134 248 16 169 179 44 96 109 149 91 155 173 219 13 93 180 125 135 64 85 136 85 237 126 122 151 66 133 253 186 216 235 117 238 215 195 99 51 130 177 202 133 69 86 56 147 83 236 123 151 27 118 23 179 254 119 29 226 73 193 217 55 223 122 74 141 19 84 145 47 171 110 84 179 23 175 96 100 174 152 16 82 112 152 186 84 50 237 0 85 72 242 109 150 164 146 179 244 181 254 3 247 140 65 137 227 57 22 19 215 241 209 193 81 12 171 113 194 129 100 188 145 46 98 243 138 74 239 41 208 5 195 223 146 155 207 137 237 230 210 244 21 243 19 207 95 227 81 203 64 110 71 126 191 47 49 87 115 11 80 70 75 76 201 202 134 4 233 196 157 19 171 85 106 7 220 146 98 60 98 117 160 123 48 77 85 205 20 79 127 160 217 224 222 3 204 207 169 19 207 72 116 185 111 52 47 146 12 194 134 33 254 181 141 42 190 0 16 157 191 51 181 222 93 145 227 104 132 150 65 73 3 87 108 61 43 145 16 118 1 235 97 63 242 77 173 223 216 113 80 240 230 193 86 141 26 22 182 130 8 167 32 155 186 214 54 100 71 190 66 112 54 122 87 112 100 56 41 2 30 243 253 203 165 19 76 238 99 67 90 18 53 254 13 243 92 84 109 23 30 12 164 4 53 192 93 135 126 7 59 230 114 89 226 158 241 146 39 29 226 77 154 122 115 172 253 125 79 133 179 38 85 1 253 77 54 228 219 143 90 249 216 68 110 53 112 247 204 169 83 115 93 249 135 61 125 6 12 64 65 155 99 86 252 3 238 131 222 158 41 118 107 54 101 155 167 17 30 9 160 46 34 48 214 119 218 10 206 138 207 11 14 30 22 54 2 165 25 48 219 105 162 242 158 140 182 197 158 195 154 3 152 62 133 173 134 62 237 103 236 48 90 34 171 96 121 117 174 28 95 222 242 165 170 25 218 154 226 219 163 131 221 72 110 25 204 217 88 139 72 132 190 60 79 232 183 65 17 26 210 240 226 139 127 102 63 48 173 116 90 198 1 134 113 251 14 45 225 177 128 117 116 87 201 72 90 181 111 22 214 122 70 92 52 96 103 21 106 113 197 230 107 178 19 98 126 1 92 104 205 18 188 147 47 164 253 76 157 134 137 23 129 25 119 198 79 74 146 138 128 120 12 83 20 174 63 135 246 29 92 250 15 58 197 163 110 118 173 174 65 198 193 75 196 209 169 103 213 206 29 3 147 129 233 8 153 35 2 159 161 34 229 199 216 155 187 5 31 114 139 121 77 39 42 122 176 121 95 31 149 32 126 22 215 23 163 238 92 169 51 2 212 105 48 241 101 12 121 234 135 250 251 25 248 150 86 213 118 141 89 104 66 51 245 102 125 63 99 55 120 69 106 155 178 251 167 195 30 229 15 131 42 212 44 180 228 72 59 106 149 124 20 62 86 100 124 159 110 112 133 64 58 69 142 12 73 48 38 135 161 205 16 207 158 251 170 237 18 239 7 248 128 240 16 242 239 140 1 9 58 134 190 236 77 216 45 56 51 239 134 151 36 87 36 29 58 223 92 45 97 25 68 220 106 77 43 28 107 46 223 229 79 180 110 37 111 137 239 52 223 175 148 97 7 6 178 224 214 234 90 221 120 93 121 137 139 162 89 2 138 147 219 238 206 61 238 21 171 222 229 155 99 79 114 58 203 248 228 133 120 187 195 182 7 157 52 135 59 46 5 248 31 125 72 173 104 251 115 58 119 56 9 148 146 146 12 55 60 74 128 203 180 206 48 196 122 70 54 83 115 185 249 98 130 82 0 25 198 228 88 38 212 6 31 151 110 68 68 142 252 251 185 0 84 217 102 6 219 165 55 131 141 160 42 81 144 89 53 118 36 8 83 60 253 183 167 182 214 80 97 200 209 165 97 146 155 98 76 83 120 206 70 142 86 202 47 94 84 174 68 194 33 226 156 50 145 19 237 175 196 195 -962832614
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -962832614
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 196
    Should Contain    ${output}    priority : 40
