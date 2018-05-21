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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 210 43 72 202 227 208 100 213 129 20 121 99 27 112 114 79 38 61 67 117 152 175 98 202 217 34 68 87 36 172 123 110 92 143 101 135 247 235 60 38 22 144 31 122 13 237 244 79 48 10 122 109 36 162 230 43 168 172 4 215 146 225 146 7 19 170 244 188 105 122 159 223 120 38 115 75 64 127 30 212 38 45 35 157 242 171 180 68 251 77 221 186 99 187 195 112 153 84 35 22 96 97 208 67 155 249 21 214 28 243 97 252 133 117 90 16 252 142 176 207 127 56 181 180 193 71 249 2 57 42 204 123 78 210 247 209 66 71 250 2 83 125 132 18 212 114 106 158 230 195 209 165 59 182 30 50 213 0 101 132 34 212 117 33 224 110 70 141 60 6 222 173 89 62 136 175 54 187 20 55 152 212 164 216 57 239 3 128 178 232 227 202 119 185 238 164 101 5 157 109 95 105 197 242 80 215 220 3 158 17 242 161 11 251 10 91 28 196 94 102 28 229 108 50 227 147 60 203 165 112 145 150 60 165 255 67 173 40 34 152 11 115 196 2 48 81 146 159 183 217 149 200 148 103 237 9 16 143 103 3 53 192 29 226 174 101 139 194 48 103 191 116 38 128 97 100 190 220 91 211 52 158 99 45 66 70 71 48 83 30 164 253 15 253 130 105 90 107 239 9 76 244 172 246 231 10 118 7 46 98 197 33 145 149 203 127 225 14 193 181 129 117 249 2 141 186 243 242 15 65 135 8 61 189 145 147 217 26 142 67 86 123 75 242 143 52 199 177 49 76 51 174 149 218 5 89 139 249 200 172 201 207 236 18 150 252 50 168 93 68 189 12 82 254 150 38 236 253 210 67 139 143 22 79 29 215 96 249 188 85 170 226 52 157 25 69 209 141 182 125 128 139 213 90 255 226 242 107 2 225 19 21 197 128 95 17 116 135 3 192 140 208 249 37 109 195 109 56 162 110 102 115 89 0 241 142 124 106 167 101 196 51 194 112 237 184 73 247 200 225 121 214 26 101 216 186 152 78 204 154 227 234 156 132 153 209 115 181 234 28 242 150 98 180 110 206 76 231 124 76 54 5 191 6 66 250 118 209 253 38 25 216 57 97 62 54 89 170 132 120 182 238 233 66 128 194 9 236 73 152 16 53 203 108 219 71 160 79 151 38 88 76 32 69 87 121 65 26 30 146 72 35 37 81 58 60 10 234 223 73 141 177 186 177 250 106 170 234 253 105 94 11 32 165 79 254 148 103 115 106 240 224 122 186 133 202 204 98 223 125 77 214 81 8 123 104 74 189 85 28 241 64 115 131 195 54 50 135 97 190 69 98 83 184 77 97 167 20 52 208 13 147 31 211 157 152 207 4 75 23 15 48 249 21 75 164 98 122 206 55 63 29 250 28 96 241 84 40 129 200 17 73 92 17 62 220 220 15 221 247 126 223 88 62 4 97 248 107 135 3 88 119 105 150 157 5 150 165 23 227 73 21 150 4 117 218 30 153 222 179 44 64 19 22 39 33 59 6 76 66 89 159 160 59 6 116 94 191 119 106 123 170 199 187 122 195 35 239 128 21 101 125 4 212 217 78 31 197 170 162 55 1 71 166 208 143 149 40 123 192 195 31 159 61 200 199 238 255 178 33 79 187 185 252 39 226 76 72 119 221 201 50 111 206 149 29 66 64 244 88 93 174 249 154 61 111 250 255 70 249 123 96 208 30 134 159 120 140 50 165 90 149 5 125 212 206 17 79 222 249 252 3 145 35 223 36 60 42 228 231 176 174 237 227 209 241 33 81 69 139 160 144 175 54 112 146 41 249 162 241 125 189 6 228 69 110 2 160 126 116 188 106 126 252 154 94 174 153 2 189 233 62 13 103 27 124 220 190 177 186 0 247 78 204 247 46 95 64 120 43 239 219 176 57 250 39 250 174 72 63 193 101 49 74 106 137 49 166 175 72 12 141 148 156 28 51 72 178 224 41 90 118 182 179 70 138 198 160 57 222 138 3 251 207 184 187 113 98 157 40 170 122 242 45 33 74 21 184 55 237 89 48 208 191 154 92 50 192 196 124 3 216 31 139 80 187 60 223 140 85 105 18 246 138 18 50 134 65 26 152 102 112 214 225 172 12 111 81 124 250 171 192 179 27 104 107 60 210 105 39 101 85 9 63 131 188 187 68 39 184 254 202 111 137 235 232 85 224 2 114 243 159 70 80 68 61 17 104 62 108 153 249 108 199 255 129 238 28 30 92 528557223
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 528557223
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 210
    Should Contain    ${output}    priority : 43
