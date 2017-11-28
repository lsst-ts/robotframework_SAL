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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 150 71 128 166 183 216 84 164 92 123 187 25 89 60 255 248 167 104 199 107 93 89 240 46 100 144 253 100 221 178 84 178 252 239 50 97 184 250 131 99 24 91 179 58 97 215 132 13 41 124 199 43 225 2 155 177 23 247 13 170 143 146 87 135 90 116 129 225 65 83 110 3 74 201 49 63 236 95 108 16 94 42 229 85 112 27 157 8 55 197 52 141 9 170 217 101 125 76 68 168 82 76 73 213 159 215 161 142 63 184 147 126 81 215 174 113 11 79 139 240 177 130 30 168 17 129 0 133 180 61 77 160 162 149 251 157 83 253 136 203 77 129 135 108 46 155 253 166 95 54 152 0 70 16 76 35 6 30 116 75 247 49 113 143 252 19 209 122 253 232 60 229 48 71 39 6 15 24 207 215 45 26 145 126 63 84 37 153 109 199 224 22 202 136 80 244 6 98 170 253 220 163 8 234 238 179 157 36 237 201 85 110 16 152 175 145 123 178 155 68 48 7 130 145 21 101 88 121 153 198 106 170 70 215 155 13 169 116 11 59 98 245 140 5 147 0 254 83 22 212 148 153 22 31 82 103 237 154 4 165 3 93 17 82 53 44 136 237 239 65 4 155 70 235 209 62 65 251 174 75 112 55 21 192 134 187 109 112 228 17 109 243 7 90 225 92 250 200 93 225 63 195 238 92 52 232 17 214 17 53 72 192 145 88 235 148 235 10 80 16 78 52 154 232 20 173 9 23 57 155 59 27 20 241 254 197 243 72 95 213 117 251 7 45 29 78 225 161 249 96 147 136 221 49 75 8 194 96 235 201 25 59 175 139 170 152 74 28 178 211 181 243 94 88 226 0 67 186 175 188 217 219 135 144 236 204 238 107 41 230 48 184 133 5 99 183 135 102 175 108 79 68 25 5 106 88 131 73 214 146 124 102 223 176 148 2 188 21 4 31 110 66 152 12 46 20 205 81 237 189 255 189 248 73 140 170 62 245 197 242 198 235 58 60 166 152 164 68 128 76 145 161 96 190 147 167 128 30 162 250 237 186 216 199 42 38 72 206 104 12 73 181 222 220 165 159 33 243 125 5 214 142 240 91 32 239 31 80 195 122 227 113 121 148 224 54 67 80 160 1 45 169 118 27 237 135 94 17 115 51 188 33 120 158 41 140 144 249 122 124 57 79 37 27 239 11 161 95 111 57 255 207 202 164 165 166 9 140 183 186 6 201 36 145 117 94 170 169 13 9 102 23 61 45 49 211 186 233 204 78 97 88 196 221 232 206 114 119 211 177 76 224 88 155 253 99 45 119 52 125 56 146 192 58 155 16 62 76 203 125 249 17 223 197 67 233 137 143 75 82 152 200 128 20 171 102 27 157 97 212 152 232 56 125 160 139 109 109 240 112 231 137 203 160 150 232 113 94 116 49 123 154 34 135 200 57 229 239 90 175 125 194 149 83 84 86 126 27 113 236 97 189 10 235 14 236 244 122 168 228 246 35 111 150 84 137 78 44 140 71 67 213 239 226 103 167 192 8 16 42 121 102 78 45 140 182 150 140 47 105 129 123 178 140 98 65 16 173 106 107 186 125 174 116 82 163 175 210 194 34 80 16 216 235 142 4 180 84 173 39 84 77 218 216 29 252 94 203 214 7 76 81 25 114 210 184 29 18 215 245 219 172 169 124 199 146 196 125 51 144 125 47 228 26 46 188 147 241 106 196 145 29 208 89 254 16 139 165 64 238 247 98 18 174 135 95 65 56 106 139 3 208 55 9 27 50 45 64 107 196 82 208 106 163 132 162 52 94 249 93 22 97 156 67 143 100 177 38 36 168 56 12 81 78 162 95 139 243 235 182 30 202 70 164 67 90 183 25 78 160 108 240 242 75 79 158 152 170 228 23 186 250 97 0 225 88 8 3 197 94 106 54 62 6 65 219 220 218 60 162 177 54 55 187 162 126 16 183 101 214 251 114 3 91 22 36 215 148 224 74 235 219 121 74 32 24 51 223 127 104 215 61 91 108 246 5 68 23 219 23 160 44 165 145 85 211 183 112 248 229 61 15 253 200 201 188 140 100 187 172 50 112 10 187 223 196 118 247 93 95 125 112 45 25 240 48 59 7 20 31 74 222 178 28 185 241 82 234 113 41 119 166 91 55 233 67 71 230 201 254 194 253 47 163 45 33 146 105 135 80 67 226 11 111 119 82 8 53 226 107 86 119 169 219 32 145 131 152 94 173 181 134 50 93 123 136 147 123 47 211 -2006994584
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -2006994584
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 150
    Should Contain    ${output}    priority : 71
