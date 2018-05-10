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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 251 126 183 94 180 225 185 178 235 146 40 193 207 76 27 89 173 174 155 45 170 174 21 224 242 55 129 186 105 230 243 64 222 69 12 99 184 154 185 51 168 154 85 187 120 52 102 62 224 49 52 132 175 24 172 223 162 186 89 180 242 153 80 204 93 109 206 132 14 141 139 178 215 133 174 253 135 116 213 89 231 104 210 194 132 183 213 25 236 8 161 63 224 159 56 15 169 86 49 21 143 69 156 36 137 22 150 124 8 17 7 147 19 12 210 15 80 67 155 49 237 47 157 52 254 184 56 55 24 190 30 39 95 171 8 69 155 116 254 36 162 50 110 2 62 79 192 220 220 114 60 161 14 69 48 232 242 234 2 170 203 187 184 131 213 87 216 197 189 103 159 70 208 249 124 185 86 231 79 67 124 148 114 110 36 142 213 11 148 130 252 141 9 133 107 192 242 124 172 54 151 69 147 35 205 26 211 134 218 249 254 160 150 72 160 78 242 165 210 71 131 16 148 209 112 80 240 114 218 197 87 153 98 83 99 56 77 36 153 164 80 151 144 221 84 47 248 223 39 236 141 213 188 247 123 176 180 224 234 114 65 113 13 73 210 76 4 96 23 195 246 88 53 42 243 13 245 99 197 179 22 201 248 43 200 128 165 149 124 162 160 190 8 195 164 130 52 173 58 5 58 22 223 222 236 212 134 137 165 15 116 194 207 190 161 91 161 171 71 41 148 27 63 180 57 96 85 41 90 246 227 109 16 114 61 208 79 115 206 76 251 66 70 99 215 121 160 173 241 191 97 103 167 240 101 237 20 104 15 73 208 199 4 119 198 33 138 199 106 35 241 166 126 225 236 72 164 154 80 163 78 129 30 233 113 52 2 147 87 10 246 105 113 78 122 228 72 186 165 29 126 202 87 167 134 101 24 236 106 67 55 195 102 72 235 136 186 131 210 171 213 243 46 227 201 72 52 29 228 220 49 239 59 186 37 4 61 77 51 195 251 94 5 197 63 178 143 116 157 250 225 169 13 153 84 64 212 237 10 198 104 141 49 177 120 6 209 82 248 208 150 196 174 7 113 107 82 154 22 63 206 146 161 220 61 17 174 61 246 128 233 14 59 21 207 230 122 210 14 175 171 56 4 169 40 194 236 67 229 252 170 223 131 86 198 76 79 17 242 154 29 130 247 43 28 79 203 80 3 56 205 208 61 110 166 27 50 123 180 181 83 70 114 198 50 2 172 173 142 77 67 5 251 148 60 120 73 71 138 9 142 232 109 23 132 230 28 229 159 111 13 68 79 50 30 118 38 148 18 235 106 158 82 242 121 226 78 109 180 107 97 193 173 254 40 140 103 55 134 76 13 254 187 121 191 99 83 22 253 40 20 81 45 186 44 220 140 148 206 81 177 138 79 45 143 129 154 176 224 186 48 75 117 198 145 88 236 208 51 176 90 48 228 174 208 47 240 59 111 82 196 236 165 115 90 33 81 236 77 57 77 3 86 41 173 17 74 241 253 128 70 78 68 11 163 111 63 183 54 238 191 137 181 154 157 153 147 19 108 132 202 3 15 164 179 2 109 175 152 151 155 137 244 206 150 116 186 186 161 56 104 160 158 236 58 127 165 75 104 91 144 175 132 33 5 171 1 251 219 244 217 139 14 59 110 132 243 244 129 250 113 154 141 219 89 17 135 199 16 104 209 76 218 77 237 140 126 154 127 29 127 222 30 153 153 50 36 195 192 145 226 233 136 64 48 14 3 229 180 234 86 16 7 79 28 160 170 94 199 41 159 99 245 76 201 26 252 39 7 30 68 10 56 255 158 167 209 145 86 60 190 157 48 57 168 184 53 64 35 136 149 96 4 173 122 215 216 38 218 20 11 231 73 146 173 86 220 50 187 224 231 207 180 58 220 187 63 139 170 45 221 185 185 222 138 75 133 30 192 120 44 146 198 88 178 241 166 236 86 99 134 84 40 93 252 52 50 162 112 193 143 97 191 181 237 137 49 6 240 222 225 139 32 155 86 23 187 197 3 97 11 120 79 74 24 184 92 251 173 201 163 86 98 194 166 170 57 196 192 216 104 124 206 43 197 67 35 216 167 154 179 252 226 202 225 226 194 71 169 29 150 205 150 134 13 55 229 221 80 19 159 102 78 126 234 33 155 49 76 48 11 221 59 30 116 75 63 245 254 195 108 141 121 164 144 12 185 75 17 242 34 83 95 69 72 142 126 170 211 174 248 39 74 144 23 54 177 242 188 61 460231462
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 460231462
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 251
    Should Contain    ${output}    priority : 126
