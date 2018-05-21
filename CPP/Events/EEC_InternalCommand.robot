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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 140 68 167 154 91 31 44 18 242 167 6 186 38 233 1 61 6 214 247 35 140 16 110 148 66 246 131 1 216 21 115 147 136 97 20 9 207 180 20 59 89 56 98 239 134 120 182 19 212 44 215 17 116 58 11 148 102 8 43 224 11 196 4 119 9 199 92 123 55 185 223 140 243 58 239 65 235 4 55 151 241 232 154 65 208 172 28 135 32 251 12 7 114 123 5 218 155 31 11 185 205 7 67 65 151 159 148 83 12 52 217 180 109 205 11 167 55 98 189 112 107 145 10 48 0 177 183 10 66 61 158 69 193 47 11 122 204 226 73 127 197 214 69 140 118 174 221 67 217 13 193 162 110 133 23 145 28 56 166 173 166 159 28 253 164 157 46 152 63 242 231 154 113 122 79 91 81 231 40 219 183 148 248 64 65 75 97 188 132 40 24 14 127 99 52 3 223 69 133 239 250 86 160 141 117 170 173 211 1 23 7 156 169 77 92 130 13 192 59 228 135 47 251 180 11 120 181 66 174 192 5 245 174 245 114 119 93 119 210 183 247 149 46 206 173 201 198 148 2 105 94 106 207 64 184 27 202 156 44 90 99 19 237 61 86 191 71 83 199 192 122 21 171 61 249 188 91 127 205 224 136 27 135 14 201 153 27 223 160 75 45 45 227 242 27 1 236 157 137 31 248 161 186 193 90 186 244 243 127 46 212 103 127 191 173 164 45 120 10 31 159 190 242 141 97 42 82 218 108 19 69 180 245 49 207 93 3 184 142 182 72 84 100 174 128 137 141 24 243 46 174 225 159 174 100 249 16 110 166 178 125 170 74 43 34 197 126 75 95 140 149 28 108 138 36 13 146 234 170 202 30 114 184 139 112 27 31 83 77 48 82 215 29 237 217 221 72 185 76 13 124 88 77 226 210 165 217 244 235 82 93 131 38 78 141 213 105 23 187 230 127 73 178 112 244 47 127 82 48 31 22 22 158 143 248 73 255 190 224 152 143 52 95 43 170 153 8 211 218 44 12 70 249 173 48 173 5 187 176 57 15 140 157 245 117 100 19 107 111 61 196 42 135 18 196 223 214 73 73 32 65 63 98 168 132 195 2 174 168 142 53 213 151 188 139 140 62 64 178 222 201 91 172 50 125 100 245 91 9 55 142 228 197 227 125 19 251 119 181 135 178 193 0 17 238 199 96 28 37 135 239 2 206 83 139 37 66 214 233 174 31 0 77 254 36 182 16 238 212 191 254 127 18 62 188 78 33 35 122 227 27 226 92 46 107 98 84 38 240 219 10 184 49 4 179 189 62 47 90 195 141 31 123 203 215 168 97 26 7 224 206 25 4 160 32 213 183 60 133 254 73 158 235 215 64 164 143 242 179 248 11 196 169 230 189 169 168 99 133 37 15 216 18 84 70 59 6 150 226 227 187 194 169 135 227 207 28 88 60 32 76 114 232 133 182 111 212 141 71 189 69 177 140 116 82 39 131 84 30 93 222 180 236 217 221 151 211 105 10 147 115 103 122 71 67 4 164 177 203 227 33 86 243 119 206 209 111 109 20 20 205 53 119 221 148 170 96 183 252 8 253 60 171 156 78 217 189 189 160 81 226 160 241 177 80 248 60 229 159 85 240 131 217 4 63 172 211 75 137 57 136 179 93 112 45 23 164 165 55 6 87 116 30 61 69 56 139 208 78 62 255 255 244 101 13 39 85 10 30 91 183 131 30 123 202 9 159 161 103 175 34 156 157 81 169 65 99 38 30 193 132 149 22 131 112 156 190 162 52 79 107 10 138 131 17 148 50 121 155 172 184 13 148 191 146 235 165 197 28 200 80 113 153 80 132 133 130 140 203 155 164 40 20 125 88 163 195 227 112 223 24 236 19 36 240 39 145 70 80 245 74 223 121 67 186 126 75 143 199 137 170 203 51 69 79 17 103 115 107 198 3 111 103 94 63 173 239 190 25 73 218 209 63 41 47 185 219 192 220 49 132 96 76 122 144 217 6 30 220 60 42 160 210 54 251 45 97 28 76 35 197 51 213 208 194 165 116 19 215 68 68 95 16 6 192 93 195 233 108 231 90 250 14 232 232 117 3 14 206 78 9 62 169 135 134 13 101 227 251 140 83 83 22 248 209 179 240 39 127 202 244 75 119 244 27 254 241 102 66 108 214 1 231 228 143 96 214 170 66 189 0 98 86 193 39 232 39 218 12 253 151 62 99 45 115 82 170 236 65 38 75 119 57 78 158 129 22 91 40 59 1188327399
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1188327399
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 140
    Should Contain    ${output}    priority : 68
