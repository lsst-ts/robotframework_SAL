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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 179 138 29 65 115 149 125 143 239 98 104 8 230 34 28 111 150 157 75 189 75 206 158 213 8 155 236 137 46 96 31 105 10 17 41 217 246 96 22 160 180 36 57 9 251 129 12 100 172 82 198 3 66 79 141 123 35 154 223 175 137 34 29 145 145 103 159 185 251 55 241 5 93 164 226 79 178 179 178 160 185 218 150 117 133 188 195 98 32 180 32 3 38 219 254 54 0 174 45 239 184 45 219 236 32 95 56 204 176 93 150 84 152 15 130 66 22 189 216 196 44 230 64 254 27 200 231 251 210 69 199 160 115 66 248 192 223 206 94 53 190 98 1 31 9 229 81 144 60 63 253 159 105 139 250 149 68 67 13 147 66 69 105 227 148 39 164 48 15 64 51 12 99 156 205 249 213 241 150 230 81 128 223 158 179 71 197 248 84 234 154 250 2 153 18 47 113 3 169 175 127 122 0 46 10 113 151 255 232 33 42 117 227 93 169 71 248 217 16 122 127 27 34 111 56 2 90 38 226 203 205 23 113 44 158 209 233 155 36 229 47 30 83 236 13 2 180 26 127 90 202 208 177 217 45 193 104 144 181 247 188 8 175 54 61 179 115 239 20 170 107 193 12 4 250 126 16 63 76 247 235 208 5 163 20 171 129 129 32 157 84 110 61 137 100 238 71 30 235 12 104 30 129 117 158 5 219 173 208 43 92 95 154 31 74 108 29 161 192 243 197 143 47 9 163 61 3 70 186 148 96 229 126 39 43 104 107 18 68 233 73 78 186 224 245 3 213 222 23 113 155 75 119 251 107 68 12 219 50 246 220 106 23 101 255 238 230 131 150 219 134 155 45 117 54 90 60 12 59 157 132 240 23 79 116 94 9 227 185 146 236 242 84 59 26 30 85 222 74 92 49 3 195 88 176 0 130 201 72 184 159 89 10 122 133 133 124 73 71 93 0 203 107 237 185 127 146 28 196 247 120 57 252 115 145 67 147 45 196 229 146 138 137 243 89 14 42 138 150 254 59 150 29 114 124 178 108 223 3 133 0 127 7 176 53 58 60 111 248 54 197 53 120 199 249 29 75 81 223 5 148 137 28 192 27 100 174 45 101 107 220 223 255 193 82 164 48 55 155 49 10 171 179 47 37 101 218 212 97 42 40 122 207 233 86 104 89 203 46 49 169 86 116 130 101 10 37 221 213 233 236 57 192 255 218 99 102 62 202 188 9 153 246 0 93 171 91 220 156 122 128 197 183 43 63 36 79 95 188 208 15 162 126 57 165 27 92 250 149 130 108 60 98 182 184 103 195 118 60 170 84 147 16 193 136 202 148 164 189 11 142 91 52 68 31 213 180 178 48 31 11 194 200 36 121 158 111 22 23 3 199 113 230 74 218 216 156 81 26 198 65 18 198 27 99 22 32 203 70 80 74 177 1 12 108 36 112 111 143 162 252 185 73 122 180 241 125 96 48 37 165 118 243 79 25 220 216 97 24 146 77 43 67 115 153 27 205 71 225 74 248 169 35 208 191 122 164 42 100 214 252 38 33 63 163 152 93 234 164 209 87 161 193 242 80 172 66 163 63 59 58 66 73 104 62 111 157 73 1 144 121 125 98 67 126 146 27 94 4 222 252 59 57 39 251 248 224 192 36 111 38 88 219 127 151 172 252 72 26 108 164 112 3 94 131 97 44 180 151 38 190 222 62 184 237 177 37 12 138 11 93 84 4 206 199 45 4 149 19 121 195 40 125 169 90 125 109 175 107 155 40 25 221 209 73 7 194 154 49 175 216 80 248 92 34 104 122 33 86 143 30 130 186 109 26 109 182 18 100 70 250 44 132 126 68 229 30 83 5 97 57 218 71 201 176 250 14 14 206 205 25 52 153 87 174 85 145 144 232 141 143 232 120 100 251 157 140 205 170 215 181 90 68 94 19 5 251 30 184 123 167 181 40 32 100 52 165 17 48 228 155 67 136 91 12 13 207 176 101 161 232 118 139 202 7 20 69 195 200 138 58 182 183 61 143 97 232 234 125 68 139 240 187 188 132 200 32 204 103 205 19 72 69 238 34 32 184 115 194 32 11 76 104 234 122 83 150 118 123 194 233 193 136 53 1 108 163 51 25 106 170 104 243 17 82 193 221 5 174 201 191 177 158 198 106 234 126 240 217 130 217 7 125 58 244 190 132 63 0 65 136 58 107 215 200 241 0 78 209 158 97 1 7 72 205 133 204 189 127 206 114 57 169 200 201 67 164 123 198 84 1133204846
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    #${output}=    Read Until    priority : 1133204846    loglevel=DEBUG
    ${output}=    Read    loglevel=DEBUG    delay=5s
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 179
    Should Contain    ${output}    priority : 138
