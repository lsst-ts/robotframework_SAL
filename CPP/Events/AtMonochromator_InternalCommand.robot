*** Settings ***
Documentation    AtMonochromator_InternalCommand sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atMonochromator
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 39 229 240 139 199 77 101 148 231 30 188 215 139 48 84 16 205 132 41 17 6 170 124 223 22 19 214 79 72 88 245 213 16 144 34 130 186 33 16 156 236 175 197 80 231 184 209 35 215 26 94 204 45 145 129 23 85 78 228 56 101 159 151 156 236 31 174 186 37 212 164 144 207 31 89 98 65 40 200 176 54 70 177 252 131 33 88 8 95 182 73 233 198 93 91 15 110 201 22 64 157 111 35 80 209 195 81 25 226 206 75 12 188 144 1 198 227 118 59 175 142 14 159 134 102 125 2 233 211 91 176 202 167 217 92 132 12 223 131 175 103 67 27 17 185 19 102 122 83 66 245 28 80 76 135 196 1 62 214 159 206 253 120 82 89 45 237 194 101 250 220 238 107 4 201 187 198 243 182 246 89 96 38 1 168 224 34 159 94 101 168 0 104 129 148 233 238 3 78 7 17 48 128 209 158 233 10 43 140 2 239 111 112 209 214 243 60 103 203 146 103 21 98 60 199 106 156 11 156 176 249 250 96 95 105 1 150 47 185 105 247 167 106 88 9 44 131 151 94 1 173 114 157 25 50 13 108 216 1 77 134 52 104 251 111 234 25 254 96 177 5 65 145 202 40 12 229 118 211 69 219 14 80 160 213 48 110 60 91 97 155 254 191 80 230 202 243 38 252 142 29 185 118 89 41 57 114 229 189 103 116 79 86 137 194 211 253 217 129 6 163 203 9 102 61 136 239 176 88 225 90 151 71 14 88 201 73 107 151 41 196 111 57 26 223 254 172 153 23 192 233 29 242 150 193 130 70 21 112 25 237 169 106 129 53 80 153 44 131 52 181 81 42 203 12 55 10 101 209 150 128 23 124 87 217 79 202 15 181 219 34 23 69 63 193 121 39 70 186 219 68 241 164 30 99 48 66 213 208 45 25 25 41 93 177 2 147 23 15 167 194 189 48 128 246 147 135 230 68 62 46 253 241 222 247 102 56 211 172 93 144 63 196 88 44 85 191 234 39 139 233 22 143 177 218 91 220 91 132 5 28 99 71 77 234 2 201 3 85 200 53 179 78 83 117 11 233 144 244 141 199 119 167 207 199 87 117 112 244 220 220 192 96 37 195 48 102 190 217 1 81 123 176 95 214 45 30 76 50 65 130 148 72 130 127 235 74 245 43 171 219 151 127 156 52 147 194 188 31 220 29 36 15 125 32 96 32 81 183 152 242 252 226 136 85 21 122 255 15 101 35 38 70 40 45 27 154 202 80 175 221 164 40 146 33 30 186 200 173 19 0 130 199 75 186 37 203 170 148 83 156 122 74 207 103 62 60 40 250 167 49 128 71 181 100 40 207 81 181 209 6 8 66 202 133 249 22 183 76 149 226 60 107 66 174 193 194 50 137 167 203 125 108 208 147 152 202 198 41 138 199 51 214 209 212 135 46 178 79 192 254 81 76 171 39 205 171 218 61 55 44 145 127 195 225 50 205 46 93 190 113 6 130 228 52 209 152 231 228 82 173 52 91 78 72 28 43 6 169 146 152 0 32 168 211 40 118 255 15 65 185 67 122 96 71 124 146 136 239 192 98 240 48 26 19 217 149 194 212 54 205 183 50 182 37 166 193 239 31 110 206 229 48 107 52 137 173 108 160 255 246 15 3 184 196 156 126 252 159 147 20 203 83 50 223 251 218 246 18 80 39 141 148 99 205 207 173 66 187 101 5 86 213 141 15 185 101 73 198 46 195 122 28 57 215 75 33 221 134 125 180 214 52 81 27 204 166 24 121 51 221 115 35 246 152 188 205 19 228 164 30 213 31 162 114 132 60 32 232 135 216 11 97 55 217 109 9 234 94 180 64 220 7 231 225 87 120 72 139 222 211 114 33 125 81 197 205 245 20 147 201 152 122 104 218 141 213 75 239 51 183 57 156 13 51 254 186 147 200 200 160 178 186 41 104 61 25 111 148 111 101 252 140 12 95 159 169 58 223 24 157 254 216 201 87 131 162 42 2 18 91 67 73 182 134 72 49 35 6 70 8 112 91 39 84 221 39 204 213 78 187 162 50 235 35 139 184 185 78 86 248 91 138 208 137 26 104 45 218 102 172 190 3 79 3 148 90 121 86 26 209 78 198 248 129 63 39 140 248 50 140 96 51 112 229 176 167 68 150 251 130 40 214 180 214 87 92 247 121 163 161 208 4 116 205 6 91 140 178 67 200 82 18 53 144 214 242 12 50 171 161 199 128 192 140 171 0 26 194 217 535413987
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 535413987
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 39
    Should Contain    ${output}    priority : 229
