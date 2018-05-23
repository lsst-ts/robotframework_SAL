*** Settings ***
Documentation    AtMonochromator_InternalCommand sender/logger tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 98 227 49 202 171 169 81 33 97 176 101 71 80 99 127 114 215 132 229 240 153 0 5 151 209 24 18 182 216 84 104 158 211 206 133 151 226 249 238 213 203 107 73 76 234 127 238 7 96 202 128 238 121 81 99 92 94 121 157 129 183 134 22 253 183 150 46 214 59 91 17 118 125 81 195 241 45 155 239 68 108 105 73 229 174 121 38 139 255 37 191 190 198 156 199 73 57 168 107 25 50 4 54 147 45 101 243 246 108 89 65 57 146 232 169 133 205 105 222 101 19 27 87 238 179 83 149 92 66 167 84 45 51 71 99 17 162 209 191 252 44 72 53 132 100 27 90 51 78 235 254 17 71 126 220 171 102 108 192 185 15 12 32 55 45 61 131 97 185 142 237 184 57 183 251 119 192 8 27 55 192 81 203 20 39 151 76 89 86 81 126 88 43 158 249 212 113 40 218 135 14 108 191 111 232 10 76 248 27 101 155 192 205 229 209 230 82 132 124 111 166 67 162 23 211 10 233 68 155 210 33 52 27 234 56 142 19 28 130 150 199 168 126 253 103 42 119 93 28 160 65 164 83 61 14 142 5 77 214 4 213 70 94 40 132 68 173 80 179 182 3 148 44 84 53 85 119 156 63 10 166 122 56 109 249 36 136 225 77 97 20 227 101 20 196 33 87 15 78 189 43 59 66 16 9 26 139 201 168 184 207 235 64 80 107 109 154 152 89 231 239 179 63 178 42 14 111 232 149 162 102 99 4 208 113 91 158 28 141 98 167 179 229 86 87 209 66 30 160 137 128 109 215 189 79 142 220 119 75 179 182 80 190 201 229 46 215 30 86 224 95 7 185 224 199 234 218 109 172 143 110 129 18 251 125 158 195 153 65 200 47 26 36 97 201 217 19 231 194 2 216 103 168 130 168 27 52 247 116 206 8 100 145 228 24 206 18 203 70 30 47 142 136 34 4 106 217 50 204 219 36 54 189 118 193 0 36 98 156 48 69 213 188 243 227 157 153 155 164 19 111 130 1 51 89 239 94 120 0 246 10 56 249 5 161 33 96 114 91 149 173 230 37 203 184 114 44 212 40 235 66 23 66 45 238 109 228 201 0 225 176 207 225 182 194 188 237 165 91 160 38 21 180 171 109 168 154 169 111 162 181 30 46 81 247 127 207 123 140 36 10 207 234 178 53 215 181 144 60 172 82 88 26 225 45 132 10 225 224 45 60 168 228 188 137 121 153 82 113 133 67 30 1 127 209 105 84 254 118 34 128 244 135 243 71 156 193 161 126 55 172 149 63 161 48 15 242 152 243 85 137 208 61 137 108 44 202 167 1 208 247 14 249 56 111 117 125 109 28 181 226 159 132 44 206 171 78 13 252 142 63 79 209 27 169 61 44 100 76 215 39 42 170 114 226 109 133 60 128 38 192 152 92 70 224 105 54 249 110 99 91 227 211 157 33 52 36 12 136 228 211 239 30 52 66 6 95 194 177 103 180 39 149 84 106 13 17 253 165 132 223 58 101 235 182 102 70 14 174 47 177 196 234 224 212 70 128 64 207 196 100 187 22 246 92 216 21 52 187 0 51 228 228 243 240 147 108 254 90 38 100 37 146 39 195 151 109 0 23 178 231 195 195 76 4 93 226 225 230 108 175 27 226 186 189 210 9 100 217 145 167 131 70 107 45 56 224 76 90 213 166 61 9 25 82 211 224 147 138 244 166 251 66 71 122 119 54 43 47 76 142 162 227 150 57 63 75 215 104 32 24 19 166 164 118 16 115 128 178 171 64 56 110 200 40 83 124 54 85 235 43 38 129 118 85 132 58 78 183 31 119 28 204 169 138 195 240 150 172 18 206 97 174 173 117 110 13 57 195 45 8 142 191 168 69 99 110 34 81 215 67 179 247 76 30 226 175 236 40 170 159 144 217 215 191 165 18 252 198 47 212 91 71 32 213 254 145 84 249 106 244 184 7 5 33 134 245 202 67 47 45 81 124 141 136 199 74 103 233 122 118 179 234 15 189 157 201 63 180 14 180 113 1 20 83 9 227 35 223 251 237 16 31 199 61 180 155 1 182 117 125 224 186 44 175 148 198 21 172 137 146 47 60 251 162 18 105 66 29 94 86 18 58 177 100 208 43 25 82 133 240 188 137 182 109 233 191 210 214 172 217 239 157 54 150 104 29 144 83 24 177 6 54 133 215 130 183 195 214 234 114 63 244 69 51 153 94 17 199 165 5 208 43 153 30 81 242 22 169 222 855452042
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 855452042
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 98
    Should Contain    ${output}    priority : 227
