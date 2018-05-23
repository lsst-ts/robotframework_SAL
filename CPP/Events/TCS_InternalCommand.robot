*** Settings ***
Documentation    TCS_InternalCommand sender/logger tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 100 124 100 108 183 127 53 15 104 162 116 34 174 130 61 193 70 146 204 131 88 217 83 212 132 14 138 97 140 25 240 172 124 60 18 185 43 122 70 251 203 2 226 243 120 55 110 143 106 228 236 173 40 97 99 171 133 155 168 248 5 147 58 132 181 155 46 242 73 79 142 254 174 139 254 4 3 218 1 174 22 230 49 144 65 145 116 217 180 70 215 1 143 30 67 33 19 186 59 186 191 184 144 146 88 36 124 215 138 198 4 211 105 29 1 68 98 215 186 99 75 62 84 177 147 215 69 132 126 237 75 118 19 199 232 240 140 250 138 188 174 210 251 49 233 29 253 183 195 183 9 232 137 217 54 145 224 220 124 252 187 19 77 165 88 232 184 187 182 221 229 44 240 115 253 158 213 61 167 76 29 163 103 0 185 3 226 81 146 166 129 78 220 207 17 206 54 199 60 174 64 160 224 67 56 155 82 21 56 30 177 4 205 198 192 99 49 218 127 138 61 224 168 39 38 217 50 171 227 98 252 25 149 65 188 140 170 122 63 232 128 0 19 35 195 185 178 44 133 142 187 209 163 163 112 231 108 191 102 243 131 184 178 190 132 194 108 67 144 63 86 251 236 119 171 204 177 18 201 109 224 191 37 223 35 106 31 63 48 123 40 164 196 158 144 243 4 52 197 42 253 149 144 219 220 71 85 192 124 17 35 21 171 22 178 166 58 168 158 247 66 48 230 225 191 157 61 234 166 96 219 92 56 124 8 69 54 212 203 199 98 20 17 212 255 237 162 44 213 254 236 73 216 141 142 203 202 231 205 62 175 87 114 203 127 27 246 53 195 43 32 239 225 200 74 199 244 218 64 35 44 100 14 158 34 233 86 102 179 249 190 61 32 125 104 49 200 109 143 199 247 81 5 72 70 172 41 172 92 212 169 188 56 135 236 94 27 81 128 218 9 87 82 140 229 74 76 197 222 129 170 166 219 111 173 212 178 43 192 80 212 243 56 139 79 218 162 186 241 198 115 56 185 108 12 73 246 185 19 194 240 1 131 142 97 57 8 178 103 240 53 40 120 181 32 179 75 123 239 42 121 249 13 64 222 240 228 155 111 18 115 73 165 11 82 227 130 142 184 141 147 168 65 209 38 11 147 103 141 142 102 237 224 127 148 192 241 150 231 252 105 127 44 207 100 169 41 88 193 17 173 73 245 82 54 215 128 92 239 2 55 56 188 168 53 97 174 74 154 36 211 187 27 16 111 239 222 91 250 76 174 121 86 126 191 225 196 91 19 113 46 206 125 255 201 16 92 145 251 204 255 122 99 2 37 159 121 221 111 130 34 185 97 192 123 65 136 136 58 24 54 19 234 134 51 95 98 122 136 66 242 105 177 124 129 234 198 136 21 205 36 24 56 196 91 220 204 238 59 207 186 24 179 42 203 62 187 243 3 217 41 166 222 249 248 101 67 28 89 72 97 163 61 151 88 37 19 21 109 192 253 76 6 17 146 188 108 27 122 86 186 63 60 231 63 127 195 17 180 121 215 119 253 252 145 45 163 108 101 180 92 210 17 247 137 110 202 83 203 223 219 34 73 89 28 82 101 217 107 92 143 119 28 200 100 252 36 138 3 232 152 178 135 48 157 73 22 149 94 63 128 129 139 176 0 234 12 231 101 2 195 244 32 226 132 106 64 249 185 215 45 0 121 238 222 203 241 163 112 69 255 75 254 176 95 203 20 223 8 87 170 81 8 176 169 195 176 58 58 196 214 36 159 182 137 143 252 25 182 221 90 116 17 177 59 88 184 189 107 179 156 189 164 57 69 67 95 205 154 71 84 21 3 200 188 6 249 182 107 80 95 252 247 215 185 252 197 97 16 210 185 221 204 245 114 245 135 240 49 198 91 51 145 187 116 245 3 114 138 244 255 64 252 183 98 103 26 150 152 38 253 77 84 178 6 112 214 54 111 121 237 218 56 237 145 248 222 5 89 21 233 224 191 165 142 153 137 207 61 126 126 44 132 12 199 248 75 66 151 235 157 30 77 248 176 78 255 36 23 91 182 128 211 102 154 28 51 88 202 248 11 157 84 65 152 179 20 169 219 197 230 161 28 55 126 150 94 243 75 69 203 186 12 215 42 61 151 83 45 183 201 29 153 234 247 81 16 167 197 7 207 110 191 91 132 46 147 176 52 48 227 250 243 59 205 24 7 159 35 23 173 176 17 213 76 149 247 47 158 198 216 72 211 81 24 72 100 251 3 191 -1665794526
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1665794526
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 100
    Should Contain    ${output}    priority : 124
