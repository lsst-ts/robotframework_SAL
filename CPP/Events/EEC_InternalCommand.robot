*** Settings ***
Documentation    EEC_InternalCommand sender/logger tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 151 182 132 1 143 237 134 143 28 69 153 21 170 206 26 232 219 20 85 75 97 119 105 76 126 196 133 35 116 210 158 190 70 180 155 228 246 60 176 135 108 136 240 15 168 169 12 226 139 238 115 198 70 235 191 60 192 74 113 113 121 214 26 117 107 170 129 137 139 61 8 216 154 146 72 142 61 205 192 42 132 247 234 95 3 209 160 118 35 68 232 180 172 196 197 79 152 163 164 220 100 168 102 129 11 164 243 27 122 108 211 119 161 5 140 89 103 205 116 150 157 190 183 248 164 75 191 133 155 207 85 236 148 142 121 202 46 88 139 136 114 175 234 15 10 171 157 127 8 230 158 241 191 67 13 126 57 139 123 61 195 115 208 127 117 207 16 193 97 62 12 206 248 97 160 8 212 108 72 170 1 95 194 116 147 171 220 72 19 19 155 198 73 42 181 128 237 198 43 109 74 248 252 184 2 21 177 21 157 255 89 131 84 125 87 84 151 83 68 238 196 230 150 156 241 142 14 139 46 41 26 21 146 154 166 41 88 207 48 91 166 33 195 227 244 237 45 164 47 15 23 140 212 250 196 25 58 195 30 80 39 242 189 229 170 116 49 164 185 168 197 180 238 186 75 44 241 82 26 253 218 73 74 12 230 245 147 232 9 229 62 143 47 207 50 13 115 150 244 155 16 232 78 106 41 204 128 233 156 179 123 136 27 110 116 176 168 97 205 167 89 142 64 228 23 247 235 224 79 119 42 181 116 37 155 193 54 147 212 70 207 128 16 156 132 111 82 60 194 192 245 10 58 221 146 106 195 37 204 248 99 78 125 230 200 7 218 144 222 97 13 3 205 60 25 179 207 250 185 40 178 166 116 107 66 250 110 146 228 56 25 145 86 175 206 19 92 198 41 6 33 103 97 91 161 93 118 67 138 85 45 182 50 18 153 145 243 148 2 16 243 86 151 165 246 146 242 224 71 171 113 220 235 130 181 184 55 194 50 177 7 226 143 248 144 82 162 187 10 46 93 87 120 32 19 25 212 22 136 250 4 118 36 235 148 250 60 22 239 104 65 72 144 68 215 226 132 88 206 155 6 179 245 253 64 229 28 27 133 93 40 57 102 81 254 237 242 123 36 32 251 158 79 121 207 208 74 166 57 103 186 99 136 194 74 224 51 69 30 73 187 64 105 172 161 60 22 115 205 18 87 136 124 160 164 118 198 47 105 220 79 41 154 243 87 116 181 65 78 130 166 228 61 87 31 217 109 66 67 134 35 85 51 230 125 53 31 132 223 207 219 217 244 184 124 178 75 174 248 181 233 73 154 142 189 164 212 130 38 67 166 22 216 152 120 233 185 139 194 245 154 156 220 190 176 7 46 255 101 99 228 207 60 157 172 132 59 233 38 98 70 230 171 170 7 104 85 77 220 115 127 81 238 118 221 16 68 76 201 239 62 148 203 96 22 213 13 91 23 72 51 84 189 17 66 74 25 176 139 243 15 185 32 58 101 115 176 23 38 45 254 193 224 214 172 118 122 17 109 71 111 38 190 234 104 6 17 137 175 129 33 119 166 217 141 33 223 63 151 43 160 142 226 122 124 40 76 211 154 53 239 81 132 52 7 71 104 247 217 162 109 160 244 221 229 133 177 193 219 146 22 207 24 218 245 242 204 139 185 249 211 23 175 250 198 74 112 68 31 159 102 250 88 158 237 172 70 194 8 253 7 251 108 135 42 139 244 229 93 205 161 11 219 20 207 109 126 116 130 201 238 43 98 132 110 6 114 10 86 109 129 100 207 124 133 222 5 23 110 25 194 230 136 36 173 35 27 141 188 153 54 167 214 199 206 246 146 33 67 109 141 222 58 145 20 198 254 75 25 142 61 214 188 147 131 137 26 63 12 218 137 122 213 101 107 28 224 247 127 160 123 69 106 190 165 21 209 159 7 21 26 34 209 156 162 214 55 217 131 1 207 200 198 107 96 134 14 14 42 186 62 134 158 156 77 235 110 35 77 18 191 236 60 30 234 70 182 201 184 200 175 218 192 108 129 79 190 42 237 132 197 246 163 253 6 12 243 34 227 178 244 80 22 236 201 64 4 5 181 26 132 193 29 163 169 133 137 146 97 245 204 92 40 228 57 172 185 64 160 177 205 197 246 12 245 168 225 192 74 59 236 85 152 61 228 18 17 242 12 154 247 34 246 221 21 136 0 172 166 93 108 21 97 210 63 97 88 95 215 56 247 79 232 105 78 34 107 222 91 171 2119507515
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 2119507515
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 151
    Should Contain    ${output}    priority : 182
