*** Settings ***
Documentation    DMHeaderService_InternalCommand sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    dmHeaderService
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 74 14 88 103 202 11 185 68 102 159 47 119 231 49 205 142 140 4 81 131 188 241 89 215 183 134 8 143 122 142 98 80 71 13 94 94 142 67 164 44 41 231 196 58 150 190 112 170 19 165 93 167 129 20 35 77 5 16 27 121 186 173 241 154 100 3 70 8 183 176 122 206 17 217 149 189 41 93 179 250 41 156 40 31 229 44 224 54 107 15 238 75 250 49 218 123 81 238 102 99 22 171 111 196 108 5 91 210 209 4 254 105 38 72 224 224 49 156 47 109 168 130 192 39 173 56 164 176 221 53 106 18 8 50 11 60 249 52 241 135 184 253 109 83 33 19 7 145 167 14 10 215 152 98 93 142 211 142 138 178 25 59 86 127 110 162 172 180 47 212 168 26 246 183 131 126 50 154 46 140 200 25 221 251 205 158 131 133 91 56 228 155 114 23 136 165 163 120 82 117 73 16 108 124 97 25 140 94 142 205 222 62 28 30 221 95 210 197 46 26 81 110 180 153 48 48 105 72 71 221 202 153 115 23 177 224 253 25 111 146 1 46 78 204 215 13 247 4 3 230 187 128 63 160 51 188 204 40 244 89 53 238 127 222 153 13 236 123 114 189 40 207 85 129 12 250 34 246 101 2 113 193 13 71 191 26 193 40 40 114 67 242 167 197 114 218 245 238 75 209 174 60 73 162 126 198 33 239 138 50 220 233 84 196 127 248 0 107 175 108 143 111 246 150 210 104 71 173 156 154 28 206 246 185 117 222 156 253 105 124 97 93 242 123 150 21 170 82 121 79 38 155 66 249 221 243 137 78 250 237 152 172 197 24 212 112 16 173 52 10 69 174 227 184 84 176 89 19 9 244 218 171 123 91 243 33 148 146 203 100 210 70 143 9 37 231 64 19 5 76 228 232 247 133 105 232 101 150 59 217 27 239 172 233 68 233 119 68 189 234 131 247 0 119 141 202 3 143 246 194 118 224 0 52 14 161 48 48 68 86 171 28 207 110 196 23 66 141 165 30 49 150 48 64 100 0 49 23 219 226 27 55 221 192 225 200 68 49 124 1 145 105 65 75 78 145 10 203 25 163 147 173 104 1 158 166 234 65 0 45 175 185 85 245 136 144 137 240 250 224 144 237 174 53 194 75 88 128 182 231 24 132 40 238 117 28 116 230 30 215 123 29 38 215 101 255 97 48 14 141 47 132 253 148 177 161 43 136 134 126 35 228 19 237 188 196 68 164 237 218 194 38 204 99 7 59 20 117 135 86 4 121 38 27 232 62 171 18 152 250 112 26 138 188 125 109 69 42 228 48 21 225 3 227 244 84 98 241 87 27 123 130 56 12 105 227 222 131 197 142 133 193 72 22 131 40 206 136 178 107 116 183 34 96 85 230 243 223 92 46 38 189 169 206 129 164 58 251 23 34 57 61 227 240 238 40 102 68 33 60 37 15 18 112 119 89 113 12 199 30 16 211 196 191 132 62 14 61 245 14 187 58 168 98 216 128 97 128 208 17 204 230 7 199 71 201 193 31 252 64 20 73 199 68 82 245 106 15 221 204 122 157 150 184 9 177 124 250 253 61 158 111 110 1 89 232 193 100 194 252 152 159 183 126 163 164 50 82 122 127 106 185 55 216 28 52 172 97 47 242 178 70 170 38 197 15 203 233 67 43 47 118 29 229 53 156 8 133 208 109 241 12 62 136 190 229 44 11 216 74 186 91 194 102 253 124 94 25 248 48 130 158 229 182 140 197 54 87 152 142 74 95 171 143 190 29 1 22 236 165 198 172 195 146 122 239 119 124 148 186 122 133 195 68 96 235 245 178 37 188 151 5 56 179 204 229 23 151 45 3 9 188 81 240 80 62 155 93 226 61 215 104 143 74 30 11 60 0 20 238 188 72 149 20 227 110 43 9 51 235 217 1 227 243 30 206 87 208 9 204 209 152 215 94 196 147 107 234 206 246 65 237 9 145 128 61 47 207 176 88 182 175 20 27 184 226 22 108 238 246 178 179 39 166 48 115 190 178 134 250 103 1 173 31 135 144 0 102 76 127 112 211 151 139 253 174 255 132 28 80 13 205 93 22 200 3 217 35 206 232 145 78 240 12 250 149 195 26 227 247 121 119 114 28 160 31 251 251 1 200 89 234 207 161 55 237 240 228 17 38 219 149 105 186 160 206 216 77 44 33 108 118 94 21 247 77 61 238 170 151 247 65 247 122 73 216 54 210 243 91 190 151 91 141 86 161 196 72 193 29 -477884879
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] dmHeaderService::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -477884879
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 74
    Should Contain    ${output}    priority : 14
