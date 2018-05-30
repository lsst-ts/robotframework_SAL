*** Settings ***
Documentation    TCS_InternalCommand communications tests.
Force Tags    cpp    TSS-2724
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 37 173 204 129 2 222 171 109 126 42 191 13 115 144 193 129 23 39 153 184 215 54 235 19 188 168 161 180 127 212 253 59 140 227 82 60 59 152 39 75 189 64 8 119 107 220 222 71 15 138 107 201 128 112 84 126 139 164 165 41 50 252 74 176 22 12 197 224 197 238 64 191 221 146 206 20 224 141 33 244 205 120 20 101 99 205 54 139 138 197 41 83 5 225 98 74 221 227 150 171 196 189 125 137 164 210 29 248 248 47 113 235 227 11 150 54 156 141 63 206 190 46 232 154 196 96 192 85 147 36 207 255 129 222 154 223 156 70 219 39 102 235 155 5 11 116 180 66 163 54 222 137 97 170 101 2 249 59 1 250 232 246 127 86 45 98 131 22 196 46 236 190 248 174 111 21 69 165 23 42 8 233 167 58 146 123 251 1 172 3 92 233 71 190 181 4 179 142 117 122 208 183 58 86 202 69 119 247 227 213 204 248 184 66 255 179 204 10 4 131 177 246 184 87 11 147 141 198 160 31 247 123 77 148 242 144 232 29 202 60 158 84 112 21 172 251 205 34 121 69 79 39 102 216 131 39 166 23 78 240 97 59 116 100 80 52 29 7 106 113 182 81 189 102 254 242 109 29 9 199 88 29 97 193 249 242 244 115 250 70 162 76 93 184 86 141 192 86 88 128 3 172 24 72 23 206 63 171 62 27 115 181 243 30 65 225 34 32 6 27 241 111 83 94 155 113 123 89 131 33 39 152 56 203 194 157 173 85 89 55 96 14 237 208 18 28 113 50 227 231 181 61 10 200 138 75 3 77 62 198 199 22 107 132 94 67 10 127 7 168 139 162 166 18 242 169 85 95 198 174 195 253 181 99 12 42 219 150 76 108 1 244 126 228 154 44 18 50 223 238 188 22 151 33 61 94 33 185 159 50 236 145 173 177 102 248 87 62 44 239 191 32 248 208 54 45 2 145 140 76 97 95 32 46 253 172 19 58 117 109 52 204 58 116 197 6 93 49 106 3 147 132 6 40 249 153 240 27 178 121 67 121 209 197 101 96 244 123 8 125 175 28 99 15 94 59 214 130 137 81 70 161 93 53 101 58 55 95 85 117 41 99 63 70 0 228 144 230 121 134 83 5 218 151 145 236 2 167 162 139 150 129 41 134 73 231 248 205 156 185 189 220 231 13 212 21 64 221 189 87 103 136 217 201 59 249 54 58 18 47 148 184 23 221 146 240 102 35 118 227 240 132 231 199 175 179 217 184 221 7 62 14 228 15 121 225 77 149 229 96 128 13 131 82 188 169 15 171 137 87 68 246 155 86 230 102 127 69 58 68 141 241 138 34 120 117 6 226 103 17 239 11 220 249 39 62 135 242 182 61 67 6 144 240 79 162 244 70 163 66 165 5 13 205 41 202 23 111 140 158 72 131 63 45 245 243 154 226 188 246 46 85 125 2 98 126 182 90 108 91 25 158 62 19 89 208 41 173 121 198 3 10 204 203 209 32 198 27 146 13 21 96 154 106 12 132 97 99 145 176 12 29 242 127 72 157 59 178 143 196 132 115 174 78 167 197 129 189 1 156 171 106 87 122 239 243 135 188 45 27 159 34 40 41 38 19 125 67 37 8 255 130 91 102 112 91 128 226 39 66 57 13 98 177 166 62 125 245 142 59 158 94 173 159 19 120 250 1 234 21 183 22 108 101 62 60 21 170 14 13 107 24 27 90 185 226 98 70 227 134 43 184 162 102 221 25 140 37 179 103 68 93 64 182 51 100 112 64 100 168 142 78 0 70 47 190 160 214 230 76 246 215 55 28 136 106 35 75 69 144 95 47 93 229 167 119 168 252 206 240 204 229 24 129 99 85 252 205 30 75 84 33 8 241 46 26 27 2 242 59 228 12 140 230 230 146 107 176 192 123 26 88 115 241 35 21 29 239 115 230 162 143 148 99 9 25 46 35 56 18 190 96 45 69 126 162 68 83 69 14 240 125 80 135 39 163 47 228 38 246 165 215 217 217 62 6 109 223 77 241 125 130 81 201 225 128 215 5 174 122 25 241 104 71 157 47 165 52 41 70 76 195 250 186 73 203 23 108 179 154 22 25 26 8 77 181 25 109 144 134 116 211 62 207 127 162 222 67 51 124 29 142 247 109 175 25 243 157 155 65 49 152 143 175 34 241 21 110 3 72 91 78 48 230 214 8 138 193 64 184 93 28 92 26 153 111 0 196 234 194 6 113 39 104 102 76 60 121 118 55 -1152886655
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1152886655
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 37
    Should Contain    ${output}    priority : 173
