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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 203 209 184 128 228 102 38 53 225 180 241 251 210 152 62 139 112 187 208 240 175 122 25 26 198 180 227 156 246 58 89 28 105 210 6 149 50 28 45 70 99 106 167 112 175 169 91 133 10 197 150 239 245 193 143 249 106 142 32 108 110 247 28 78 228 137 83 96 134 86 42 99 193 212 152 240 198 144 152 55 72 193 205 176 114 75 3 75 18 20 26 108 209 102 7 154 24 210 211 180 242 225 77 9 184 113 170 198 59 170 209 173 210 238 126 71 54 105 36 98 24 244 229 205 75 249 16 68 181 23 247 42 34 95 231 138 74 41 67 106 63 121 5 61 21 174 180 196 103 167 182 117 158 228 101 3 184 111 93 150 131 177 115 241 6 252 121 37 206 114 61 118 225 44 185 8 94 167 119 50 238 131 103 241 80 62 108 38 188 227 35 168 7 152 131 172 94 191 176 134 194 75 123 65 220 49 204 187 140 190 156 213 165 21 37 84 165 251 54 237 244 82 63 252 138 233 141 218 121 196 24 200 97 167 19 56 36 107 167 175 94 171 238 154 14 221 85 82 21 131 10 210 238 191 41 53 104 151 212 207 150 24 174 58 98 104 16 44 36 188 162 38 237 202 46 55 193 135 225 132 216 99 6 53 119 160 173 14 175 128 75 141 39 154 22 84 242 29 208 179 24 223 0 52 226 9 176 169 153 234 84 46 244 67 52 36 65 25 164 31 200 210 114 0 172 80 162 64 191 61 3 91 239 118 35 148 216 77 123 17 92 238 36 58 204 36 16 157 112 64 157 223 193 80 21 83 82 232 217 138 140 39 143 233 120 189 74 109 92 231 62 185 251 77 128 115 77 65 150 126 246 169 199 135 37 119 103 19 253 167 11 202 101 28 235 175 146 157 241 65 121 3 216 103 82 121 224 48 176 148 20 25 57 44 244 202 44 191 16 161 48 180 108 156 19 164 171 112 13 87 245 238 42 71 81 245 139 208 234 125 159 124 139 161 209 98 200 59 71 133 189 249 43 62 163 45 101 135 215 96 50 91 192 70 5 58 4 219 224 73 144 67 233 93 206 54 18 196 44 0 202 109 37 152 121 0 61 187 99 176 231 37 161 122 70 59 234 248 45 3 205 136 158 127 44 46 165 255 247 136 234 191 54 211 134 196 105 187 61 112 84 39 215 75 173 122 118 125 248 154 129 145 19 164 195 214 215 226 19 0 47 5 231 83 35 236 45 216 151 26 204 23 230 183 151 227 183 44 104 254 0 241 6 152 218 178 202 43 143 6 181 38 47 149 115 178 56 180 144 155 33 101 8 46 3 19 50 204 2 7 97 233 95 175 224 54 252 178 234 233 227 186 226 69 63 196 99 241 173 247 21 40 220 68 111 17 201 224 3 203 154 64 35 180 185 16 236 174 228 182 246 28 100 169 34 163 97 177 87 165 140 156 34 64 57 238 202 218 164 33 198 89 172 40 3 129 245 66 200 234 146 241 57 250 228 67 129 105 224 193 50 98 104 35 56 11 182 42 219 17 115 229 76 22 44 162 137 234 81 33 53 109 239 156 30 93 186 105 135 149 19 249 23 243 7 217 22 77 20 114 243 171 66 71 154 182 29 47 86 125 108 255 127 91 19 76 231 186 109 71 119 31 103 19 121 104 217 229 61 143 30 178 50 88 198 162 95 157 20 133 92 185 189 173 116 204 96 115 180 17 106 48 102 132 182 221 185 77 48 167 194 72 19 30 242 123 192 165 54 146 37 248 186 133 76 55 234 43 75 205 4 170 107 23 209 145 121 105 242 31 245 225 76 10 61 231 142 210 119 129 182 102 15 187 224 72 29 36 208 136 55 241 31 126 210 158 140 22 88 183 145 91 255 61 142 173 18 42 193 144 224 142 79 175 116 162 35 28 171 1 148 27 111 64 128 117 162 42 35 2 14 125 235 253 194 33 106 185 84 91 252 169 81 31 211 149 179 183 58 84 25 3 234 128 123 161 74 24 106 222 174 214 37 140 136 226 225 59 109 194 211 244 5 218 46 82 216 112 253 211 48 80 139 162 47 152 170 131 76 248 120 151 251 207 64 71 197 84 214 83 13 212 139 42 186 150 76 7 41 116 167 8 56 220 82 88 88 150 248 221 79 30 5 154 30 51 115 182 88 44 0 41 54 179 138 205 195 180 123 48 2 95 111 81 128 188 128 164 140 70 152 196 173 229 234 120 245 56 182 19 228 179 28 98 240 177 123 58 125 78 1347092395
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1347092395
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 203
    Should Contain    ${output}    priority : 209
