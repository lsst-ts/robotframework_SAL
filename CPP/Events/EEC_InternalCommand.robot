*** Settings ***
Documentation    EEC_InternalCommand sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 120 162 155 198 250 162 167 174 210 190 46 26 143 20 223 209 104 194 76 156 132 206 147 113 28 140 243 99 121 89 135 45 58 63 233 30 155 204 158 175 224 92 248 46 170 20 228 220 105 254 186 6 250 202 85 126 122 228 217 119 46 252 234 207 29 3 40 32 205 198 177 239 136 49 121 13 79 101 8 111 108 18 11 31 242 151 19 141 109 182 31 30 76 150 102 7 76 198 63 14 112 242 150 53 85 67 122 42 86 129 160 62 158 150 33 134 41 145 37 159 14 233 155 138 17 76 161 229 122 228 170 96 212 20 250 182 228 64 17 129 147 81 85 42 26 246 57 145 193 103 62 148 250 21 118 4 198 211 86 239 129 90 10 102 192 76 78 83 250 174 127 24 32 28 126 91 151 93 190 117 88 67 83 193 177 202 212 117 21 15 254 105 84 106 87 139 113 97 255 1 174 89 25 214 144 199 244 15 111 21 146 11 108 96 135 14 186 209 195 194 198 211 19 20 97 163 2 214 77 167 41 58 196 170 165 75 55 10 248 215 71 229 66 190 220 216 152 57 116 212 37 223 57 103 67 206 70 240 70 111 254 83 242 15 94 43 122 200 226 83 192 228 123 93 143 72 214 107 201 139 254 196 48 175 34 51 140 181 158 162 131 53 51 184 193 103 94 181 232 169 95 213 38 110 241 17 239 77 188 90 177 111 7 105 124 207 231 117 200 74 100 218 159 151 50 179 52 182 242 192 6 8 26 152 179 228 66 3 196 170 26 84 5 176 156 170 154 126 251 165 233 167 139 238 190 161 185 161 75 34 191 116 167 82 66 1 55 110 81 112 143 244 42 184 79 36 149 231 68 218 117 82 17 159 152 87 26 46 152 58 166 184 146 36 72 67 141 192 170 238 81 149 28 85 222 141 169 210 215 155 118 147 49 76 113 16 122 42 241 12 130 28 152 115 173 135 97 190 100 206 81 83 80 144 141 254 81 80 125 37 251 209 41 251 197 7 187 169 209 136 12 112 84 41 226 247 232 254 30 76 231 154 96 103 10 232 66 254 21 16 111 173 22 161 210 123 116 66 211 159 87 114 45 58 115 190 238 237 186 229 102 219 147 140 206 149 239 234 139 250 184 135 67 16 177 30 133 37 255 84 97 156 57 115 206 5 115 55 254 20 172 237 65 75 216 175 162 120 37 82 100 23 81 173 24 219 252 251 141 115 86 70 108 7 72 82 235 10 237 89 104 129 41 54 113 240 246 16 100 190 186 210 69 4 19 251 61 249 47 33 172 209 64 30 246 223 76 143 60 213 228 101 14 39 108 53 55 164 231 243 78 93 48 132 118 239 179 205 79 248 33 166 193 136 12 120 93 236 173 184 139 26 137 230 143 196 186 54 191 44 188 57 243 5 239 198 164 177 233 119 251 189 162 33 219 246 166 199 143 79 109 31 248 204 22 233 17 224 231 107 57 120 70 175 238 173 18 125 25 29 31 19 8 15 124 193 92 107 83 57 102 187 57 221 75 11 222 185 232 141 154 249 190 123 123 173 198 201 47 108 161 4 194 231 117 82 53 219 104 207 248 227 167 184 205 15 71 64 107 221 105 193 64 89 200 71 2 22 143 206 128 66 223 166 58 165 62 189 134 174 228 145 35 181 19 58 191 195 104 18 53 81 195 22 150 76 245 12 248 31 59 221 84 59 192 105 199 203 170 7 73 32 231 48 108 159 37 206 24 130 74 19 252 239 65 143 216 254 250 79 106 73 174 30 195 0 65 62 237 60 192 60 180 17 122 89 123 116 10 89 10 171 121 86 31 143 15 87 248 95 88 62 46 22 244 64 23 162 114 25 163 155 95 161 32 106 135 251 5 213 19 11 63 2 95 22 224 254 8 222 138 45 197 16 41 150 136 217 153 248 69 199 114 209 184 237 81 57 88 209 52 212 147 178 143 148 81 111 21 156 134 136 114 181 102 184 62 122 214 73 113 40 241 44 121 0 238 94 198 229 152 65 107 182 165 103 186 169 207 28 33 62 39 184 58 8 217 236 42 250 146 173 27 248 185 1 140 245 188 106 120 5 56 170 132 228 51 173 53 209 125 194 105 28 137 172 154 168 21 246 32 67 60 251 123 213 247 176 70 99 232 218 192 188 3 6 217 252 243 142 76 35 14 127 28 188 210 47 44 66 43 150 58 121 72 33 20 157 99 2 196 17 166 237 43 18 62 150 194 192 16 29 186 11 179 66 152 227 36 40 411779566
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 411779566
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 120
    Should Contain    ${output}    priority : 162
