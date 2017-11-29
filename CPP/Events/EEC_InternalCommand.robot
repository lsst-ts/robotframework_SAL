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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 14 228 252 25 69 3 152 104 219 69 216 218 93 197 217 226 223 95 186 63 133 192 104 76 255 229 214 178 19 197 253 119 117 127 188 196 162 29 150 227 163 131 158 59 163 58 213 13 153 213 143 53 100 58 49 201 15 126 118 181 132 190 252 227 80 128 18 177 113 238 235 201 13 97 217 29 250 167 243 232 117 162 252 254 19 177 115 112 67 47 10 239 41 10 184 39 49 186 1 142 219 34 233 131 252 138 99 40 156 84 169 165 18 241 99 96 42 82 114 64 129 129 49 145 81 126 210 47 106 59 49 177 122 135 64 226 37 35 123 49 179 31 47 177 237 150 208 194 117 103 138 223 49 239 156 233 185 191 160 69 2 153 6 97 189 31 212 212 251 237 63 213 213 94 114 186 43 158 104 47 201 56 237 228 83 245 236 8 239 16 199 17 169 21 186 204 62 8 156 32 167 118 49 66 126 33 189 124 201 153 55 95 183 232 30 76 56 11 167 245 86 12 53 48 212 171 234 199 108 154 108 42 45 240 56 150 108 211 200 1 37 153 215 206 122 74 122 193 30 151 182 192 191 223 152 66 216 237 84 116 212 46 165 59 215 125 130 224 49 154 103 189 77 115 25 3 81 145 170 215 200 34 255 145 216 41 186 172 196 56 52 67 165 16 165 54 221 189 211 133 220 41 183 159 100 68 64 17 32 131 172 43 125 177 171 38 153 195 11 23 113 23 116 183 116 203 231 143 78 180 74 232 93 70 166 249 75 47 223 169 239 177 104 117 95 7 202 230 26 205 111 203 74 153 201 109 178 176 37 4 184 142 111 234 103 120 244 89 147 193 138 0 201 181 80 13 230 195 208 112 93 45 52 36 3 190 204 244 115 150 5 4 198 80 69 191 143 17 198 109 87 25 132 30 152 121 3 10 7 32 253 206 0 168 176 180 17 151 239 253 202 139 223 148 185 136 42 240 131 230 26 159 37 114 166 95 28 85 70 12 5 210 12 174 158 111 40 77 191 232 253 143 74 107 43 159 93 232 31 165 39 158 103 152 50 55 127 189 182 224 12 208 153 189 112 112 18 62 6 213 90 14 189 56 244 141 206 24 107 22 254 124 147 11 29 18 142 162 134 246 34 238 59 196 144 90 30 62 19 251 57 179 66 207 107 182 88 87 141 0 56 47 100 104 218 180 140 165 95 125 162 243 241 97 249 161 130 73 52 185 14 97 225 39 68 155 119 226 238 147 214 254 166 116 233 98 55 128 83 254 186 209 137 210 14 222 68 42 193 73 29 121 155 100 62 253 132 204 252 125 236 113 232 28 108 199 229 91 178 183 72 213 144 32 226 252 172 155 83 133 175 207 177 18 123 221 91 164 170 75 19 198 96 83 129 16 199 107 34 169 195 138 96 227 211 206 147 77 39 200 147 123 215 235 201 192 103 176 110 125 197 2 35 43 248 74 16 198 212 245 171 83 250 223 150 206 207 62 210 203 73 176 103 83 16 105 244 191 125 166 24 190 207 73 7 182 217 192 246 235 239 191 51 21 254 63 153 97 234 189 217 3 159 160 45 56 38 62 113 48 44 183 179 222 222 13 77 254 97 91 236 232 219 6 41 241 27 163 203 253 73 137 184 200 1 19 32 219 105 163 23 136 84 37 115 11 173 61 219 15 233 106 153 132 47 89 240 37 143 129 223 136 209 216 5 32 206 224 205 136 95 215 132 87 148 226 155 147 251 67 7 146 218 236 186 208 247 104 220 89 165 81 195 210 233 143 245 66 39 128 67 168 164 131 88 178 246 163 199 159 122 123 220 205 2 184 51 189 93 222 205 57 226 156 26 96 73 124 67 219 60 86 144 17 127 249 21 252 127 139 128 150 247 92 138 181 172 85 135 109 21 179 51 192 227 67 221 170 55 53 116 227 128 173 112 11 85 252 158 99 147 11 128 107 63 65 209 255 229 231 113 102 109 187 253 240 206 119 25 201 38 28 37 222 46 221 141 12 236 105 29 49 38 130 163 168 57 146 172 132 173 187 155 224 151 226 182 150 135 103 4 137 249 44 54 103 147 24 139 189 205 7 82 234 236 188 115 42 112 17 213 21 150 50 208 12 194 25 120 184 52 98 17 253 79 142 63 35 142 67 79 248 122 53 251 40 53 66 124 248 199 206 26 12 27 3 191 243 84 242 120 60 146 18 209 116 115 178 48 141 228 151 224 246 253 18 81 150 8 14 56 212 87 152 143 193 41 72 56 133 -386814336
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -386814336
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 14
    Should Contain    ${output}    priority : 228
