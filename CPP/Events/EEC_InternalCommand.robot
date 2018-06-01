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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 183 58 114 25 194 133 70 254 184 214 193 105 143 159 28 69 11 127 3 235 77 12 192 214 57 2 59 141 69 238 109 155 33 133 73 120 172 87 166 118 7 49 42 174 136 115 242 193 246 21 233 151 68 172 5 156 250 93 187 239 235 113 130 235 44 90 200 252 89 35 195 177 111 149 209 129 144 108 76 78 51 183 59 43 245 156 40 204 52 139 4 205 221 56 200 71 109 211 109 159 121 169 230 158 239 136 44 92 175 210 134 57 206 168 86 137 198 209 234 57 73 233 118 165 127 234 38 30 17 209 128 57 21 223 8 253 44 116 127 22 191 149 156 2 69 249 97 212 252 101 56 227 103 169 167 6 8 159 94 97 193 155 233 246 23 94 13 69 146 173 205 125 141 189 79 161 135 46 109 15 29 41 141 248 68 191 115 96 92 102 190 200 132 219 183 89 228 18 165 1 197 12 88 250 168 174 91 190 231 71 191 49 130 215 16 152 203 47 57 12 56 162 48 176 51 20 206 32 253 97 224 136 65 201 41 116 84 36 130 177 84 9 177 208 96 93 240 207 250 59 56 253 217 146 135 240 123 134 82 4 120 78 254 1 178 181 113 20 25 92 10 198 129 231 185 20 206 16 170 70 3 117 208 31 82 224 34 46 2 227 22 194 187 54 27 59 108 155 164 147 220 182 28 112 147 165 56 255 66 144 107 36 60 78 69 175 50 50 54 49 74 150 29 238 249 47 249 72 67 216 146 203 10 156 54 31 101 243 125 76 156 254 77 201 180 87 130 138 172 2 245 122 252 35 74 20 202 190 37 98 228 112 162 175 236 139 181 36 215 21 54 182 61 161 22 81 217 133 48 70 180 42 53 250 163 164 189 20 178 105 74 181 226 229 103 233 12 191 160 248 157 35 64 132 2 214 242 235 29 121 172 253 132 70 185 13 117 209 145 40 14 215 50 225 253 175 113 10 88 188 73 115 105 28 94 148 120 34 3 122 107 176 198 123 230 68 19 129 108 113 130 179 182 78 60 65 215 140 50 182 188 95 15 51 249 196 239 45 83 241 219 105 243 24 226 68 57 9 124 34 7 237 155 40 173 133 13 224 121 202 157 3 18 233 100 137 64 15 90 196 87 63 30 127 84 132 185 181 188 228 152 110 100 248 130 221 20 129 195 104 212 29 32 239 209 184 242 219 110 201 157 95 248 30 81 57 14 158 23 137 48 192 137 146 73 77 232 224 12 44 207 115 225 64 188 145 121 3 232 243 2 99 7 223 250 118 241 91 110 243 219 252 139 161 59 138 83 45 162 182 155 14 54 164 156 231 174 228 9 23 87 190 168 0 254 46 247 58 220 173 111 16 222 219 97 5 137 58 232 40 70 235 61 247 236 137 130 220 147 139 192 14 65 24 205 152 181 239 100 145 149 66 188 140 190 137 201 119 10 246 122 233 115 64 147 206 229 43 13 89 231 164 136 67 153 154 229 174 57 255 138 213 134 221 241 130 174 35 44 136 174 197 158 25 161 59 201 63 17 197 133 121 116 187 141 57 5 71 109 23 140 14 84 175 39 4 198 208 137 107 123 6 219 4 32 49 216 66 160 4 106 254 9 15 246 139 117 134 149 23 222 52 41 74 139 252 142 153 28 187 134 186 148 164 78 43 243 229 128 73 141 75 224 188 66 229 212 162 118 92 25 232 213 169 34 43 38 187 224 154 1 56 183 85 252 126 101 16 34 140 166 76 190 242 93 176 0 141 215 44 43 89 52 209 244 173 19 131 166 113 145 151 149 168 19 19 162 31 105 183 102 202 63 141 44 103 251 215 250 204 68 215 168 43 169 246 9 119 157 158 140 213 140 54 23 122 81 108 43 62 29 125 227 78 96 47 175 51 228 250 5 173 138 42 247 180 172 70 113 117 172 88 30 136 85 243 249 64 159 143 139 204 32 173 9 140 17 173 180 174 98 199 239 87 175 98 1 126 156 25 8 18 62 111 106 43 1 194 145 183 42 61 145 180 231 244 180 69 61 60 74 232 155 13 221 39 62 94 215 83 112 177 56 153 37 193 88 3 85 45 120 72 207 230 102 154 189 225 68 48 57 186 216 254 114 149 102 143 49 160 199 37 248 135 15 46 45 158 90 38 41 28 69 178 11 109 118 124 62 120 133 72 243 228 35 223 174 207 16 90 116 202 13 21 63 188 181 54 84 143 28 28 59 78 31 208 69 55 111 198 105 70 145 71 240 15 70 167 196 57 762417480
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 762417480
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 183
    Should Contain    ${output}    priority : 58
