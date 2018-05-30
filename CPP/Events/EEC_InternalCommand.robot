*** Settings ***
Documentation    EEC_InternalCommand communications tests.
Force Tags    cpp    TSS-2724
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 153 193 187 156 92 157 232 204 151 98 170 157 108 222 182 44 235 52 4 104 230 246 17 253 18 68 103 41 168 105 25 125 219 159 47 48 166 44 4 27 41 193 117 12 29 40 211 248 154 122 37 209 10 20 26 83 227 194 68 3 37 174 2 155 125 140 67 123 173 222 109 109 112 195 15 208 1 220 112 30 243 71 222 197 151 83 206 161 10 199 42 175 72 233 1 181 160 113 98 193 129 252 185 118 177 0 7 42 86 242 212 125 191 17 205 59 153 240 126 216 151 194 212 133 100 8 209 201 56 4 40 185 117 117 117 195 134 187 180 63 245 99 222 57 31 220 19 63 227 163 143 123 188 220 16 147 255 74 66 15 211 223 58 29 133 122 202 147 93 255 16 197 45 118 118 121 200 19 44 142 66 109 47 195 255 108 24 169 59 27 238 116 183 143 24 228 28 125 13 205 59 196 33 109 22 245 13 142 228 17 231 114 44 30 104 128 83 137 122 140 118 89 207 225 254 102 58 88 185 74 17 61 34 111 41 22 31 16 133 132 12 190 44 235 117 206 17 53 85 42 255 201 3 119 206 56 209 239 37 1 88 255 133 33 226 148 35 177 129 58 82 44 129 134 217 83 117 22 162 238 22 243 130 92 164 248 168 220 1 125 214 126 90 193 179 87 162 61 156 5 118 109 1 233 158 63 210 70 170 3 33 166 115 214 91 161 17 235 162 157 211 138 8 53 86 58 204 22 114 86 129 193 6 206 186 4 33 19 156 20 216 23 204 128 58 219 36 34 114 28 140 80 224 143 82 232 39 190 250 10 0 155 116 63 222 204 92 173 8 183 108 40 0 82 109 162 88 156 175 87 114 52 1 219 38 145 201 218 81 182 13 67 160 140 28 227 190 229 167 22 247 99 46 160 140 13 155 226 55 146 7 110 138 3 130 166 108 112 67 45 103 156 214 68 133 66 253 163 5 85 91 153 96 56 247 92 236 242 147 39 211 176 32 30 64 91 191 35 214 95 167 240 253 129 93 190 190 191 103 200 168 199 29 45 24 94 158 120 86 18 221 1 104 7 4 45 150 78 170 200 136 125 82 254 221 56 135 225 252 59 117 225 213 227 192 122 170 15 40 63 135 198 200 186 35 75 106 154 216 206 21 186 84 49 18 101 110 87 44 248 110 119 10 78 19 8 164 49 251 238 203 133 238 134 78 216 64 152 92 230 142 237 107 38 51 144 31 77 67 196 193 169 195 224 175 25 17 235 120 174 201 226 235 43 114 104 32 192 62 1 62 98 88 74 246 210 149 194 176 40 95 246 130 76 18 240 156 83 194 101 51 139 176 15 196 239 52 225 72 133 71 58 146 126 136 227 151 205 223 69 171 221 0 129 177 228 163 217 120 179 25 236 167 191 72 201 234 24 241 153 249 193 222 234 33 103 21 181 133 184 39 246 187 245 118 177 130 158 152 49 93 80 246 2 102 15 37 245 85 44 34 136 16 153 65 3 189 244 20 110 115 200 145 242 50 172 52 170 117 183 104 10 91 15 74 143 87 83 128 211 115 176 10 135 15 218 85 172 157 181 145 179 148 45 180 153 15 251 30 37 232 51 212 42 223 226 43 212 90 133 139 252 243 134 139 183 155 97 200 100 222 188 80 196 85 141 15 76 189 26 73 29 211 11 237 90 252 18 225 8 112 214 196 45 41 131 101 35 230 150 82 211 64 31 93 254 137 38 120 128 129 228 137 78 155 189 226 204 204 94 254 13 6 223 58 215 226 157 201 97 225 3 124 6 144 11 235 38 88 201 190 242 242 126 97 11 164 11 181 120 101 54 37 151 98 238 88 205 148 124 83 212 251 102 127 236 236 189 145 120 247 76 205 212 3 111 235 213 95 178 68 37 20 136 54 158 207 190 222 105 9 27 144 171 193 128 0 11 20 11 63 110 81 107 223 29 71 248 91 107 255 62 85 151 70 254 46 137 230 107 150 137 60 220 157 55 232 249 44 21 67 49 216 52 90 135 75 242 109 150 191 190 14 71 171 185 244 40 123 158 32 174 10 205 40 77 112 203 103 23 117 153 171 114 215 123 201 89 71 86 79 10 224 95 249 229 160 31 88 176 167 236 75 55 88 55 224 19 21 3 248 185 152 154 221 225 1 178 190 98 215 220 18 112 208 117 147 190 38 90 148 156 233 65 157 199 59 122 28 208 219 211 17 2 188 170 11 239 199 108 170 184 207 80 103 105 202 31 177 50 -873283114
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -873283114
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 153
    Should Contain    ${output}    priority : 193
