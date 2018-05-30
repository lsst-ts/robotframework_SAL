*** Settings ***
Documentation    AtMonochromator_InternalCommand communications tests.
Force Tags    cpp    TSS-2724
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 165 53 19 131 23 20 136 165 79 44 10 179 34 175 3 102 147 238 41 135 125 47 74 203 149 209 52 90 117 75 223 1 118 125 185 49 211 109 140 171 178 126 90 122 123 179 44 46 53 120 101 187 201 169 76 114 144 228 171 145 118 105 127 118 236 10 228 246 93 49 226 255 37 207 188 135 241 95 213 17 151 171 80 169 191 116 189 91 195 49 236 115 244 47 4 201 103 245 107 173 121 179 217 146 133 52 248 116 117 195 209 163 67 177 205 190 224 250 112 202 115 67 69 210 67 133 240 11 39 96 114 139 120 44 4 143 51 118 112 118 36 218 240 236 89 223 250 62 54 158 228 20 185 88 42 230 251 83 210 232 1 108 78 187 180 149 3 201 52 114 110 133 201 8 253 136 238 109 225 87 104 112 151 86 35 189 47 209 25 247 33 255 56 114 5 112 198 58 212 187 70 174 215 78 114 196 58 101 118 167 114 44 0 234 82 146 42 103 180 237 160 147 229 141 146 232 120 76 10 44 2 47 13 118 132 117 16 72 169 231 126 33 126 187 50 164 232 60 61 54 39 160 102 171 239 235 158 214 140 4 247 226 191 192 223 150 246 99 220 21 139 15 27 188 164 52 44 116 15 243 109 2 185 14 55 226 100 178 142 15 61 168 85 127 113 42 9 35 22 215 41 98 61 182 63 247 82 255 192 114 145 183 200 33 245 229 6 64 116 38 108 192 43 44 80 146 176 41 16 103 223 230 77 22 160 151 54 246 239 153 141 244 83 2 90 168 207 144 140 223 143 92 222 222 31 106 106 15 102 55 220 63 67 173 189 7 88 95 52 19 22 57 95 75 8 33 116 121 74 139 94 0 3 178 229 194 246 28 6 169 150 95 251 213 42 112 168 21 235 204 93 206 230 115 99 176 3 66 11 70 186 188 151 53 246 125 168 154 16 52 23 217 1 206 171 66 234 128 23 78 117 134 198 110 145 79 168 143 155 53 6 163 94 224 65 226 53 213 32 98 151 132 28 179 28 19 141 109 202 98 236 175 124 24 106 252 221 212 186 51 33 185 71 238 186 212 222 29 74 153 204 33 229 89 201 58 178 73 124 199 72 206 167 103 142 229 5 112 103 86 9 135 134 80 39 25 22 162 106 156 155 152 166 112 239 173 230 29 146 31 168 21 235 121 148 1 91 236 251 177 79 209 146 207 11 87 85 153 253 118 19 87 133 213 95 221 46 221 252 142 133 253 35 73 230 216 104 161 105 77 234 129 139 140 74 216 96 61 212 189 104 17 13 86 9 254 223 205 93 150 240 31 52 91 205 151 146 104 59 90 9 113 14 89 95 93 232 77 76 248 102 231 210 118 239 173 11 237 68 183 126 118 151 18 227 52 90 229 6 109 218 190 61 84 181 34 252 157 184 156 227 60 131 40 89 213 75 127 158 89 244 10 55 204 65 47 58 242 146 88 75 2 233 209 153 139 78 47 181 228 118 37 184 182 53 52 121 128 189 62 149 20 81 233 134 183 170 201 254 119 189 76 50 2 212 3 112 242 85 67 109 1 2 18 6 146 36 55 216 6 39 93 82 42 246 77 215 113 86 51 95 216 161 92 89 224 139 113 241 210 148 51 239 28 150 247 115 249 252 156 63 84 180 232 174 230 38 118 255 247 100 208 206 11 50 89 44 226 62 97 74 125 171 94 183 205 220 103 29 183 246 43 57 179 246 242 50 224 248 136 23 5 46 255 122 12 80 23 165 160 116 248 70 41 43 42 212 197 126 21 10 122 142 231 41 153 101 103 149 4 173 171 195 218 131 39 61 140 74 226 59 192 47 243 206 13 77 40 100 40 121 95 172 162 173 55 163 106 145 96 187 62 104 123 31 240 45 209 98 174 200 237 145 5 220 235 6 229 102 228 253 229 206 139 173 11 245 176 25 174 228 200 61 20 133 233 184 67 196 11 52 50 14 254 173 116 96 232 144 250 73 115 68 157 25 125 95 165 250 240 0 90 148 64 146 102 132 169 245 168 135 216 216 169 123 180 202 150 1 103 158 227 136 15 62 212 164 223 18 59 205 237 107 63 195 42 21 230 221 133 43 143 122 41 233 155 187 76 201 233 167 103 162 193 182 120 13 179 44 141 89 3 238 7 166 65 121 178 220 185 131 46 79 201 47 166 142 83 214 176 230 216 99 153 82 105 162 83 116 46 108 63 49 200 169 124 160 199 224 186 56 236 161 13 52 186 128 41 42 218 -1274525449
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1274525449
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 165
    Should Contain    ${output}    priority : 53
