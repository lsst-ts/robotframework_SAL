*** Settings ***
Documentation    TCS_InternalCommand sender/logger tests.
Force Tags    python    
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 37 238 179 43 143 182 39 138 111 156 179 221 39 79 173 145 140 6 76 30 37 63 254 56 208 27 199 26 85 238 62 69 43 21 61 255 26 30 167 55 129 116 67 178 170 90 236 119 183 79 147 230 73 7 155 96 136 106 46 179 52 85 157 249 47 175 132 130 230 107 62 121 113 106 101 225 151 54 248 5 94 73 210 218 184 106 109 195 227 7 78 116 26 21 26 234 203 244 113 145 132 255 199 231 113 243 95 125 58 23 38 109 11 59 100 147 21 91 95 126 40 88 217 228 10 194 91 181 77 162 116 97 142 45 132 247 38 91 102 161 195 213 102 240 10 52 141 108 96 248 238 101 183 243 106 230 181 49 14 124 184 236 121 61 86 195 166 62 126 110 236 197 155 247 20 83 129 160 210 121 126 246 167 101 39 45 168 64 61 243 165 154 246 208 177 200 178 59 212 52 171 168 198 249 9 244 94 92 99 176 188 217 80 105 50 195 25 236 10 47 76 15 184 244 188 124 34 208 172 121 5 143 148 171 82 22 145 94 12 44 230 156 213 97 55 173 95 93 8 115 108 113 228 41 88 129 22 125 108 154 41 170 144 205 245 2 20 97 10 54 250 96 162 199 68 150 34 241 112 238 255 47 79 176 238 135 42 57 50 29 35 250 76 255 57 14 167 197 213 180 179 156 72 28 183 176 247 156 38 58 216 206 108 240 234 218 27 32 215 89 109 229 206 90 156 27 155 6 178 140 150 219 162 219 74 182 111 182 139 213 234 22 55 196 154 78 249 99 168 133 253 23 174 218 52 55 222 212 14 254 77 190 111 47 182 59 179 85 27 2 93 3 104 193 230 43 105 248 62 143 64 69 247 9 166 71 220 102 150 136 181 86 234 157 147 235 228 1 138 60 76 136 254 206 71 167 217 33 189 151 28 9 169 228 22 255 113 78 140 142 255 139 106 191 108 19 142 138 151 157 209 214 174 120 228 32 57 74 231 216 81 233 62 143 100 216 146 76 156 137 155 249 160 171 104 128 68 111 76 66 130 215 162 103 130 58 20 195 220 33 11 207 36 68 200 229 202 228 168 36 140 140 115 68 7 21 87 146 39 42 93 32 167 23 19 86 64 163 84 105 244 54 207 52 45 209 52 219 111 109 85 216 201 122 29 38 32 123 150 178 12 52 176 4 22 82 185 149 65 114 59 96 195 143 143 243 116 155 151 233 167 12 222 250 49 66 17 69 70 105 4 170 151 130 88 31 188 45 42 12 6 165 123 177 138 188 144 109 23 229 213 48 178 49 217 255 233 107 130 204 149 170 0 254 99 105 7 79 231 70 249 32 35 204 231 254 211 170 23 39 204 163 160 81 74 98 177 119 19 204 145 249 227 161 227 52 41 72 20 169 35 41 215 127 131 217 41 228 7 131 110 224 225 67 70 245 250 3 190 164 111 58 153 35 248 225 27 62 40 4 145 182 116 196 3 139 23 137 41 229 147 151 188 79 218 152 63 131 116 131 16 141 202 9 157 157 228 179 169 238 222 250 57 104 170 177 227 11 72 229 148 75 122 63 125 38 254 163 3 86 223 34 53 109 178 173 119 91 218 160 16 159 211 129 226 123 53 25 11 76 63 216 171 19 107 104 137 8 26 219 189 190 9 186 101 25 161 234 210 151 76 78 212 86 106 214 57 78 56 240 95 55 193 61 17 95 163 39 164 44 244 163 206 206 8 198 149 32 8 19 248 31 63 1 74 31 28 183 169 251 106 31 152 39 159 191 49 144 83 147 226 86 18 177 27 224 88 79 27 102 39 182 141 35 95 96 244 191 131 148 239 6 199 11 236 168 236 36 143 31 70 48 252 63 21 178 71 232 225 89 94 133 106 79 183 211 233 245 148 7 167 23 85 80 50 218 64 214 221 121 62 112 62 195 87 233 96 133 21 247 95 75 144 131 126 16 133 62 50 188 169 118 19 187 240 56 175 64 156 255 10 18 252 99 142 71 180 101 143 208 132 25 65 40 166 157 97 243 141 163 240 0 19 118 147 35 188 20 2 95 249 198 255 48 30 11 136 240 249 39 222 7 12 90 64 106 51 155 133 63 25 28 224 214 187 214 81 25 18 122 6 62 66 211 218 168 164 211 56 115 50 90 30 14 255 238 62 68 39 36 185 147 240 171 55 13 137 204 122 99 59 102 9 145 91 142 142 196 250 230 146 186 17 116 147 59 231 4 46 8 161 91 238 186 214 100 37 156 50 151 123529888
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
