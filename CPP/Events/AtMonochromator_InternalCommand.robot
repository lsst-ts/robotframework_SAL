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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 105 1 208 244 231 7 71 43 117 172 231 244 128 102 184 226 57 95 70 152 217 85 99 112 246 31 46 216 158 93 207 188 98 2 143 226 159 228 144 167 127 131 182 170 17 224 110 157 214 250 219 202 50 171 147 172 124 115 15 89 214 115 142 233 197 26 206 23 190 124 186 225 225 40 3 88 18 98 230 148 241 243 73 151 35 119 173 61 10 172 180 87 211 103 215 111 30 88 234 141 72 9 65 153 94 119 146 75 177 114 19 150 164 248 128 35 197 212 193 28 222 189 54 94 148 37 16 164 185 217 200 38 97 126 150 13 62 185 62 172 213 107 130 147 231 152 180 59 170 85 176 102 202 70 153 14 47 81 68 199 68 148 219 159 224 255 170 38 19 162 155 175 111 50 110 120 150 91 39 163 208 57 34 213 221 112 124 15 88 240 107 121 151 56 52 79 165 215 142 83 110 217 243 216 181 158 255 178 43 171 90 18 47 203 75 91 96 200 171 234 97 164 95 252 47 64 99 16 2 253 60 29 98 183 188 41 232 98 66 214 58 35 154 9 62 239 156 145 51 4 210 40 70 76 232 13 99 129 252 24 79 93 197 120 97 94 146 151 225 86 245 40 242 164 234 165 135 203 151 243 105 130 169 46 249 98 205 35 163 253 224 43 164 145 217 194 253 172 58 211 114 252 10 116 137 4 180 70 89 212 89 24 13 201 143 224 1 186 195 45 208 235 87 118 255 133 50 11 11 238 162 152 63 51 136 87 132 16 46 170 83 183 111 43 67 224 244 42 218 112 14 205 8 186 27 22 10 116 5 212 68 230 23 115 6 63 90 101 44 239 102 18 239 143 166 204 226 28 144 206 163 145 93 83 17 36 83 248 59 70 116 113 106 184 71 73 87 192 131 250 10 121 241 154 205 177 229 3 149 88 255 218 62 161 133 173 49 157 11 93 187 139 204 90 169 147 110 0 29 224 68 183 140 219 46 137 231 51 124 211 29 109 42 98 137 0 204 34 121 62 220 171 84 105 112 51 253 114 177 161 66 163 136 121 21 108 87 3 160 213 116 3 254 163 241 107 150 114 122 205 49 59 145 78 195 9 86 12 132 175 203 249 4 226 36 157 239 33 92 206 40 82 116 123 14 108 110 244 25 22 98 246 149 177 180 93 7 232 107 13 219 24 41 140 184 87 63 66 172 46 129 151 214 98 89 186 206 225 235 132 43 20 91 195 241 74 77 152 45 149 119 135 134 183 198 31 9 32 33 110 202 200 171 19 237 74 43 194 160 246 138 228 250 220 141 189 234 122 46 82 231 193 222 211 115 157 177 234 136 36 131 234 124 62 72 227 34 175 72 136 78 61 133 208 160 5 171 93 124 168 149 174 85 80 60 116 200 126 186 75 40 59 122 59 76 202 240 170 149 184 44 155 69 62 106 17 99 202 220 26 228 160 199 9 225 207 28 139 166 238 186 2 211 177 93 236 100 102 8 126 222 247 48 140 156 121 20 165 139 233 111 81 169 220 206 233 110 83 114 97 173 51 77 195 161 242 140 127 173 208 227 56 33 29 235 44 232 227 82 92 225 68 187 6 171 233 150 156 30 120 144 84 158 19 14 148 197 122 67 219 169 217 80 188 184 202 26 30 122 213 195 224 66 219 150 166 245 215 69 72 70 41 80 129 222 4 92 96 157 186 147 3 181 88 34 178 81 95 12 80 94 122 21 229 67 161 32 128 1 187 235 178 118 248 184 153 162 251 14 21 171 126 91 124 232 71 26 28 187 136 224 111 66 214 129 130 239 97 34 20 14 21 15 150 107 187 247 9 141 114 165 157 60 253 139 240 75 182 107 253 58 167 72 133 28 37 52 148 209 234 136 97 29 160 104 249 105 185 14 218 182 216 49 13 133 40 104 4 234 184 201 189 113 167 109 202 152 149 54 163 77 186 146 89 30 152 213 40 130 109 37 42 75 126 7 59 228 57 132 15 22 222 36 126 96 154 178 31 49 69 169 39 171 63 66 90 92 115 208 155 249 135 93 162 53 227 225 192 181 229 202 165 99 21 188 170 28 21 184 122 105 101 89 77 99 198 79 240 184 57 165 14 48 224 191 141 101 163 193 113 209 84 85 238 118 144 112 157 134 10 223 55 130 99 2 255 238 130 23 222 213 14 79 206 190 221 126 113 150 42 229 218 72 12 189 201 250 62 137 202 80 54 132 145 107 215 7 230 32 70 208 189 23 48 15 120 168 43 6 127 -502125936
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -502125936
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 105
    Should Contain    ${output}    priority : 1
