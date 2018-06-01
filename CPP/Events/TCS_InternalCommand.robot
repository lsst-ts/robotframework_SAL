*** Settings ***
Documentation    TCS_InternalCommand communications tests.
Force Tags    cpp    TSS-2724
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 74 120 23 52 235 115 245 33 202 97 170 236 11 133 184 60 182 103 124 159 6 145 98 146 186 6 66 237 34 165 46 170 239 228 35 227 253 183 44 212 101 166 220 254 255 8 189 4 204 216 197 194 144 18 93 25 224 98 173 232 125 114 33 86 61 213 184 167 63 20 41 221 210 151 10 127 55 81 189 88 11 35 69 28 10 50 144 201 104 32 195 102 91 177 70 121 182 198 162 215 163 224 68 36 69 161 131 77 129 232 104 201 153 245 99 126 196 135 214 109 56 38 228 222 221 238 249 120 13 195 15 28 202 137 50 55 213 54 252 133 184 95 139 138 36 149 201 61 148 23 207 24 71 212 4 89 240 70 222 127 232 179 243 195 183 193 83 47 245 64 142 42 42 42 51 36 45 168 40 92 3 170 128 76 112 57 87 155 136 241 99 166 60 54 136 131 25 103 0 59 43 250 107 39 163 125 46 227 37 16 137 59 19 71 24 231 54 56 109 83 252 31 242 32 63 73 196 65 138 39 40 140 5 139 187 14 161 5 164 119 19 171 175 68 168 78 77 160 198 56 111 247 173 106 181 26 170 218 71 82 211 43 114 73 240 238 211 4 161 196 222 78 38 235 181 243 3 69 121 204 198 105 31 51 248 220 173 21 188 59 214 89 153 165 246 125 164 182 20 148 226 68 223 77 161 98 65 71 166 230 104 105 191 182 199 89 11 230 230 11 50 131 45 170 245 88 5 163 42 188 218 130 171 151 37 60 45 67 192 246 226 107 252 44 5 149 205 17 239 138 104 7 231 18 202 183 157 235 37 24 169 187 113 161 253 65 35 61 120 176 193 139 104 94 29 23 240 106 77 149 37 23 244 214 56 214 198 137 196 117 16 230 15 203 201 4 81 121 94 51 59 120 111 218 131 255 15 91 212 1 145 198 93 251 74 13 230 254 180 68 107 111 25 141 187 19 140 168 250 112 89 191 233 93 152 166 176 197 255 226 3 246 234 46 94 69 129 160 43 93 165 61 130 110 205 111 193 139 46 101 47 25 121 14 6 60 140 155 60 174 77 89 83 8 40 249 14 161 219 186 189 252 240 148 253 167 187 189 194 171 11 25 206 92 139 236 2 246 61 231 207 6 70 66 65 162 84 202 108 155 8 250 126 207 165 42 251 153 211 89 101 0 180 189 237 137 236 197 220 79 240 162 31 7 91 156 228 55 174 107 243 24 68 202 113 51 1 59 110 52 18 192 104 60 176 100 122 144 55 43 12 248 27 115 65 139 45 15 251 97 168 229 237 64 241 115 220 175 217 151 242 98 146 16 171 134 119 41 245 28 238 180 166 58 108 149 11 248 40 140 243 254 102 34 176 101 238 78 150 160 230 223 80 27 212 31 50 103 67 123 244 76 63 15 107 238 91 208 248 37 244 2 180 35 46 0 58 248 57 142 175 37 170 30 253 148 91 254 212 191 216 227 59 57 246 67 93 53 22 201 136 134 46 170 92 6 125 176 141 212 129 80 101 139 99 234 231 152 208 182 134 187 231 91 178 101 185 24 100 202 162 25 97 175 158 94 76 237 249 77 247 208 100 148 238 93 199 172 137 109 189 232 94 85 211 253 195 121 105 245 134 20 223 20 213 167 28 96 233 84 14 236 88 58 69 204 215 62 112 49 109 138 136 66 41 235 130 130 188 221 33 34 169 60 126 38 185 254 111 40 200 235 14 172 128 58 175 242 29 208 62 225 53 84 3 35 67 102 107 187 192 143 32 179 231 132 48 231 84 73 48 174 18 249 224 100 34 74 145 159 19 130 76 177 159 65 20 65 78 209 110 113 66 150 224 132 147 62 140 200 122 34 99 209 163 31 52 255 150 60 148 66 209 46 169 123 66 143 204 226 180 77 198 103 80 127 133 74 255 59 161 212 33 46 217 68 65 159 226 224 26 191 107 41 250 25 147 7 223 135 135 217 228 131 168 20 241 201 73 129 195 10 51 51 9 247 22 225 49 95 85 70 45 59 134 199 142 55 169 216 251 50 205 189 47 109 66 130 242 11 146 52 97 72 140 121 55 237 57 35 70 9 1 238 12 104 254 254 33 220 213 104 141 141 126 35 131 100 1 152 114 221 52 232 103 224 203 125 65 124 233 4 79 111 128 147 36 114 225 178 90 65 123 69 56 118 41 161 191 161 197 254 228 22 168 98 199 137 24 78 58 235 199 220 38 208 85 180 224 109 194 219 100 166 137 201 165 156 0 17 -1816613118
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1816613118
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 74
    Should Contain    ${output}    priority : 120
