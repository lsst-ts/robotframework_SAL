*** Settings ***
Documentation    TCS_InternalCommand sender/logger tests.
Force Tags    python    Checking if skipped: tcs
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcs
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 238 76 182 197 183 76 38 200 181 106 39 219 235 19 218 163 178 197 158 75 202 24 188 37 215 3 10 80 161 117 131 220 137 213 9 208 64 11 97 211 241 219 48 70 98 122 214 126 177 138 140 196 48 113 64 214 126 85 70 104 171 38 155 51 254 27 199 218 220 171 222 35 203 160 173 228 233 217 131 133 248 6 91 200 253 197 6 174 138 161 113 240 64 136 95 253 198 86 8 119 253 29 122 147 205 187 255 100 73 102 187 226 201 126 178 252 202 237 110 52 128 225 52 254 61 17 136 133 160 161 139 68 62 2 187 135 231 187 21 183 232 191 4 72 186 45 107 46 26 11 17 167 78 152 134 128 84 13 80 246 164 85 12 200 18 50 205 230 128 96 3 28 14 98 213 187 242 82 98 126 40 115 249 47 94 249 153 13 161 97 135 154 133 128 91 80 153 30 15 80 219 187 86 97 137 45 75 179 114 14 145 66 42 147 119 106 54 142 150 144 5 234 216 183 126 7 18 206 141 187 137 16 220 167 81 232 186 145 31 20 231 254 220 192 231 42 156 78 86 255 177 134 137 203 250 2 95 37 191 110 8 68 136 132 34 149 162 21 56 56 4 66 87 58 127 127 175 82 23 18 188 180 11 50 47 19 101 131 118 171 77 181 144 29 176 128 142 198 114 181 227 77 42 240 13 234 184 212 158 111 177 206 191 98 145 174 201 161 111 205 109 110 134 231 253 44 112 62 216 103 181 154 229 147 0 150 42 154 183 178 76 91 4 174 241 212 150 162 145 161 71 9 181 191 8 59 96 199 251 219 30 95 182 130 185 233 228 251 83 225 69 231 177 185 35 1 171 146 203 140 228 1 154 104 208 107 149 75 227 108 38 250 183 210 20 37 246 232 68 54 180 251 188 11 172 242 205 127 110 148 85 156 174 147 189 171 131 203 41 88 177 61 219 2 78 5 110 51 43 229 142 219 253 201 206 127 71 238 9 116 16 72 29 75 153 116 136 186 128 130 218 211 90 137 203 197 191 93 223 122 173 131 252 194 178 131 177 248 183 72 100 245 167 62 189 228 91 49 27 180 155 240 75 204 58 56 178 198 150 167 89 213 106 209 56 120 202 38 253 134 245 192 159 82 105 249 112 51 240 152 125 38 153 74 225 79 159 106 97 40 58 243 250 114 122 135 92 148 171 233 135 139 143 130 145 136 115 186 56 94 76 94 226 162 151 181 73 228 100 205 116 64 0 184 62 12 93 54 220 221 37 117 24 198 223 214 77 78 156 17 218 27 95 21 120 202 25 217 157 166 155 165 202 14 164 220 180 90 229 236 100 158 0 140 153 132 89 22 117 232 38 115 173 141 169 40 110 57 196 79 226 47 100 47 27 164 13 253 135 18 58 23 203 99 170 61 214 69 221 178 27 164 16 131 97 119 13 21 231 35 222 219 125 99 88 45 156 214 247 160 188 5 97 53 102 126 237 55 235 250 24 97 249 91 110 162 4 153 34 169 167 212 89 107 135 159 159 12 237 196 54 0 93 169 74 136 231 61 1 127 108 80 162 101 51 225 6 167 131 34 71 207 145 175 133 50 172 213 55 108 238 61 62 117 132 202 97 41 175 14 193 154 96 218 224 48 200 99 200 221 219 120 179 135 29 233 80 19 85 139 57 19 24 48 30 195 143 139 79 1 133 43 175 224 100 128 197 19 240 253 153 194 108 101 33 35 155 209 91 31 61 37 84 253 218 0 157 241 122 170 194 34 171 210 208 116 226 9 168 99 70 114 111 111 233 220 157 143 45 142 81 68 94 96 71 143 46 136 111 107 153 157 252 163 215 222 164 172 152 122 191 106 246 142 70 7 101 30 62 70 114 85 30 159 71 148 239 83 184 182 84 192 152 93 186 29 198 154 155 85 245 10 36 95 80 246 237 140 130 255 28 120 5 251 219 142 9 68 90 211 186 109 226 144 32 217 17 217 58 4 196 127 103 140 242 179 0 252 118 10 137 6 224 54 149 68 191 196 106 95 213 216 21 99 147 226 67 54 174 151 36 173 186 25 66 106 57 22 68 179 147 177 241 86 36 40 81 68 67 113 68 255 62 120 96 187 91 88 152 168 119 103 10 219 7 243 141 87 195 130 27 24 224 77 1 117 3 80 140 45 87 136 39 115 56 163 12 137 83 200 154 37 187 111 106 162 109 73 99 4 184 135 242 110 213 158 60 240 60 150 176 189 191 115 86 238 33 13 199 1 485894751
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
