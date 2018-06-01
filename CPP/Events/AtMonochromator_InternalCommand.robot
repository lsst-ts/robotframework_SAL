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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 154 4 211 87 239 45 16 220 122 73 230 64 248 126 142 100 79 111 34 88 131 249 113 174 117 213 35 9 250 192 68 26 255 93 111 109 46 160 114 33 79 97 194 68 97 152 214 131 7 75 148 98 2 218 157 212 30 213 100 153 157 30 25 85 201 247 0 129 103 137 99 245 142 227 140 136 120 34 117 54 127 30 207 131 24 80 192 143 147 162 12 92 206 208 164 100 94 166 44 101 72 81 253 250 100 162 200 121 253 8 61 100 243 85 223 95 23 32 132 73 28 247 97 74 110 90 1 220 14 253 200 82 242 198 0 102 189 56 220 31 123 147 160 91 202 104 178 19 77 239 218 68 218 176 227 30 76 215 179 241 135 124 185 155 115 107 48 34 103 46 220 37 40 226 153 10 251 172 173 65 2 76 16 59 242 214 57 17 214 246 56 5 91 66 40 196 235 39 129 192 17 200 17 133 17 60 130 131 78 0 197 245 124 213 93 241 227 244 193 116 197 210 166 143 252 216 105 50 153 194 92 39 38 123 61 228 253 51 232 104 78 150 24 0 30 97 14 171 212 93 82 93 219 230 144 221 100 218 134 170 46 181 91 211 82 20 251 52 61 218 38 148 184 66 123 131 155 101 113 79 53 207 58 245 19 69 37 21 10 40 220 22 44 56 111 53 166 244 175 157 119 92 113 97 169 178 209 108 153 83 163 40 159 76 222 101 60 132 188 241 85 175 230 241 94 193 110 14 230 96 3 122 163 9 165 103 52 193 6 190 80 254 219 199 106 229 22 82 31 180 110 82 137 19 82 101 60 152 226 119 96 133 227 49 159 18 178 53 128 54 181 133 56 17 215 147 125 28 67 11 191 100 81 224 68 164 209 241 85 192 33 42 59 30 11 114 7 116 141 107 172 92 251 187 241 216 121 64 114 136 136 150 242 64 83 236 243 63 21 37 66 59 75 2 204 207 240 131 187 224 232 53 2 230 117 6 48 197 10 130 213 62 238 189 206 47 199 74 191 185 180 242 235 228 44 219 187 43 196 147 177 98 201 74 60 133 137 137 168 62 169 16 14 162 255 141 144 142 220 73 198 81 237 190 195 115 59 90 227 169 168 102 121 8 240 85 82 191 32 240 32 244 7 88 210 64 96 134 131 48 135 44 21 217 139 77 84 160 164 54 104 121 210 24 167 148 145 242 60 193 151 50 154 206 218 88 102 28 120 94 130 40 5 51 113 191 148 40 108 126 140 61 96 59 57 5 15 150 185 177 30 34 156 230 7 233 131 63 30 211 193 68 41 232 34 225 125 164 130 156 59 155 124 160 168 67 6 27 136 159 214 166 107 158 174 32 213 99 111 243 148 32 14 126 27 125 117 205 150 143 239 85 186 216 179 192 193 85 209 200 83 158 63 49 178 234 72 37 209 159 30 204 80 208 154 22 217 69 235 6 223 204 132 37 76 162 26 101 51 231 73 108 214 125 207 46 137 33 138 146 96 223 90 228 11 185 15 152 244 182 74 162 170 190 76 111 46 195 177 145 77 30 205 169 18 175 180 3 119 73 46 10 189 130 31 70 194 9 54 108 205 27 244 36 95 203 147 208 226 232 107 58 228 55 181 17 177 123 8 152 4 37 125 216 237 226 157 104 147 39 239 3 53 39 180 195 103 247 167 7 155 185 28 192 124 250 142 192 196 101 5 94 100 24 240 243 10 208 1 175 17 176 234 68 37 174 24 67 164 252 148 30 36 18 205 44 131 81 124 18 233 181 157 39 104 215 145 249 190 240 31 216 9 134 13 164 198 200 88 38 242 1 145 205 145 146 199 132 184 195 225 42 204 32 139 127 143 163 240 17 92 42 43 171 204 118 52 92 215 252 176 15 231 176 80 148 145 180 27 18 176 112 16 25 135 48 51 207 95 154 134 84 85 219 253 49 62 245 188 25 148 194 64 160 14 59 148 17 59 240 222 243 75 30 146 147 23 41 222 66 193 14 135 49 175 62 5 232 38 18 58 51 94 10 191 153 76 244 32 143 75 91 150 95 160 25 140 224 167 42 9 185 150 117 24 34 73 173 62 248 7 217 184 212 25 86 134 144 163 209 82 119 165 231 117 134 244 176 183 30 61 173 84 73 26 115 231 217 211 166 160 47 234 57 219 246 78 242 226 242 167 179 43 130 58 217 65 117 16 188 174 240 96 59 11 13 17 19 128 13 43 152 152 234 249 19 131 200 205 122 60 237 54 1 81 7 163 199 33 14 -2061991075
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -2061991075
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 154
    Should Contain    ${output}    priority : 4
