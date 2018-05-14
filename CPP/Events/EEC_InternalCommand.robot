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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 159 252 183 52 65 162 234 29 132 105 255 170 18 1 179 217 169 57 49 141 168 68 36 145 121 147 214 168 151 130 106 0 87 88 206 97 239 52 112 156 152 128 215 93 12 33 225 188 112 52 169 79 102 101 48 221 231 150 177 111 37 130 155 255 221 107 212 167 207 159 95 39 123 251 189 41 252 118 0 66 14 217 33 36 73 42 228 179 69 46 245 45 38 106 183 124 252 44 106 223 186 243 212 164 2 185 37 165 102 135 34 187 160 234 141 242 61 68 230 243 104 107 182 88 241 186 15 184 203 50 174 235 238 94 240 60 201 79 246 197 224 214 69 220 14 95 18 165 119 144 155 168 114 31 18 86 79 162 200 225 74 114 228 96 240 177 54 94 57 197 217 31 221 165 157 128 236 182 105 19 12 109 215 158 160 230 50 227 93 128 136 97 66 251 47 67 85 134 155 14 41 163 75 213 17 60 36 90 27 1 130 137 60 136 53 76 27 115 7 168 60 130 58 34 99 95 29 175 87 140 172 185 74 107 38 195 207 124 3 81 75 84 222 59 52 233 125 25 12 212 137 129 215 158 177 124 81 156 39 117 118 228 212 229 5 34 171 215 94 215 178 12 243 5 77 59 90 110 143 176 57 53 237 159 170 89 175 25 26 103 141 83 154 74 58 123 195 193 40 174 5 95 255 207 247 74 177 215 221 5 138 77 241 70 102 38 42 152 154 71 248 244 238 10 46 173 75 183 9 59 194 67 184 194 226 118 93 72 67 218 15 127 205 169 210 163 60 219 114 197 118 108 89 36 181 149 6 227 35 38 236 221 206 112 189 154 248 200 35 210 17 50 87 83 225 87 189 81 198 33 135 72 32 210 20 32 228 156 86 79 185 123 167 43 167 17 248 228 194 67 109 107 236 95 226 72 49 153 228 139 33 220 57 104 158 155 214 86 23 203 115 210 247 143 111 216 192 95 154 170 218 109 146 22 199 206 75 37 110 173 210 207 13 75 241 151 69 206 121 39 67 14 10 221 164 245 7 93 190 170 62 100 243 59 131 222 113 241 235 173 38 172 172 35 13 210 197 210 107 65 192 254 14 108 112 163 211 242 135 131 184 183 8 175 248 135 240 121 193 155 205 50 12 143 25 55 167 105 0 48 66 89 90 100 112 48 165 50 221 167 242 169 99 77 153 19 120 18 159 80 165 85 163 247 52 6 203 222 91 178 167 51 209 38 24 102 173 213 215 162 48 124 194 60 162 32 215 140 178 108 145 27 54 34 217 250 36 131 93 31 46 231 6 73 9 73 172 41 83 79 71 249 198 144 77 224 151 38 194 65 9 255 249 9 164 146 173 243 180 52 87 7 205 251 173 62 168 204 197 186 146 45 127 252 51 235 53 225 229 27 11 142 243 78 178 250 23 31 136 82 232 172 214 157 162 215 175 178 20 94 115 114 137 153 46 117 154 220 114 180 8 231 139 238 41 233 105 22 116 163 182 128 77 171 186 100 132 114 12 64 29 140 180 109 1 250 253 208 183 126 127 111 16 12 187 243 69 157 204 222 212 210 89 159 107 167 16 143 134 86 158 44 209 21 218 14 193 196 38 123 89 52 23 108 130 98 100 159 105 41 51 147 79 96 90 152 90 165 250 190 138 50 200 231 62 95 64 196 146 62 72 171 200 12 74 15 56 221 53 147 47 40 2 201 209 168 1 189 22 197 211 46 207 97 195 243 88 253 157 197 215 160 157 29 156 170 66 200 161 32 202 101 160 60 54 248 79 110 33 163 199 116 71 146 204 139 43 86 52 160 68 131 213 37 217 136 231 121 177 69 102 133 13 202 114 226 108 141 209 98 223 30 61 165 226 18 117 135 130 104 5 211 244 231 168 122 221 131 117 78 254 54 171 74 181 60 37 205 80 221 145 67 159 248 151 215 120 80 164 57 98 147 158 128 190 76 39 51 1 253 74 48 156 31 248 26 152 68 128 107 192 26 153 4 68 222 195 234 62 102 90 62 116 194 154 38 195 1 242 2 215 124 138 133 15 143 244 1 32 10 126 249 129 78 206 107 180 205 108 222 152 182 12 141 224 154 192 200 55 100 100 184 19 170 159 228 160 209 68 233 91 2 12 69 208 233 105 145 183 212 17 217 9 206 107 107 133 140 87 176 195 60 59 191 141 65 65 204 52 59 217 243 170 49 233 43 52 136 180 137 56 67 109 149 255 158 73 41 152 92 238 192 99 17 45 130 115 65 167 153 1037534842
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1037534842
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 159
    Should Contain    ${output}    priority : 252
