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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 235 5 74 105 26 7 193 10 35 204 124 10 73 213 57 218 162 49 91 134 105 185 196 229 116 225 105 206 70 138 107 169 216 5 64 243 232 170 255 229 166 43 72 115 155 28 234 221 11 134 72 94 118 193 7 108 184 5 0 51 119 47 82 34 236 57 73 163 177 191 74 63 236 52 110 184 71 215 24 11 192 46 38 57 36 55 96 90 113 68 234 132 187 15 237 100 101 51 16 220 11 205 207 74 206 150 166 166 5 49 194 64 77 17 96 90 75 32 22 150 74 141 180 101 145 23 146 13 238 10 229 255 113 50 183 50 126 105 248 175 153 153 197 113 188 73 172 97 139 100 213 223 226 33 37 88 90 18 215 215 35 212 133 10 8 208 125 20 116 235 55 38 63 94 180 52 214 93 240 13 155 179 82 209 209 88 54 237 224 205 96 224 124 223 132 253 232 159 127 50 207 72 243 47 48 218 113 187 206 94 217 134 90 177 74 198 57 172 18 64 49 40 94 202 135 204 69 76 2 242 62 179 173 140 72 165 84 81 238 204 102 57 167 38 97 42 41 7 40 161 6 183 19 214 167 20 253 62 61 252 88 49 130 165 121 237 172 152 247 32 148 127 69 7 94 44 255 192 52 238 176 20 24 24 193 34 196 3 168 231 9 254 221 166 226 222 79 103 132 137 77 32 111 251 235 128 75 66 59 185 195 30 36 235 132 87 172 64 20 113 26 229 247 131 226 138 150 148 113 61 160 18 52 179 128 255 121 213 93 137 218 86 194 126 210 224 226 37 42 253 201 223 78 132 120 54 109 214 230 119 0 17 182 52 231 5 71 144 92 26 1 33 79 200 137 126 41 84 109 7 6 66 92 212 154 146 131 165 194 218 204 81 122 62 33 48 174 236 226 27 168 157 45 179 47 254 20 193 124 254 137 16 152 226 212 220 84 199 14 236 14 121 98 159 111 246 131 107 22 57 209 31 25 43 101 103 66 85 10 165 184 198 141 13 183 124 194 136 131 51 163 205 140 255 128 88 199 91 25 212 38 235 11 124 119 212 195 36 241 88 140 134 109 208 17 60 20 60 230 185 240 255 53 209 250 166 196 159 58 172 59 131 7 252 29 31 212 90 171 5 21 29 67 233 24 7 123 116 194 239 127 191 192 206 194 140 149 121 92 5 182 247 52 184 197 45 231 181 95 178 169 23 250 228 28 8 190 212 69 131 223 226 99 243 74 100 135 247 137 206 141 128 84 74 187 61 79 244 247 214 198 170 45 231 174 66 199 193 6 221 8 110 144 219 60 192 26 53 243 109 37 29 9 201 113 178 141 192 224 235 210 226 76 244 241 63 194 222 227 94 133 117 228 162 215 134 236 161 170 245 81 109 27 76 32 23 127 252 129 23 170 23 87 31 35 112 87 41 73 86 124 152 0 175 72 28 58 8 111 126 232 251 102 68 9 9 255 241 155 135 155 230 63 13 207 38 82 160 146 242 202 227 252 62 107 158 161 142 169 14 79 74 215 195 89 21 24 53 135 218 21 54 142 235 78 207 152 252 201 46 210 193 139 231 45 55 136 241 38 56 75 225 248 23 163 42 129 162 132 0 82 222 83 196 202 246 0 24 253 180 0 195 156 39 106 10 143 69 179 11 157 1 191 95 180 171 11 109 227 121 48 203 123 114 215 170 88 69 17 120 212 232 129 216 9 26 188 97 17 170 44 87 57 131 207 193 113 156 217 187 197 83 140 202 191 30 208 64 62 192 52 155 90 191 170 191 188 143 128 126 180 39 127 223 50 202 166 168 37 40 83 240 126 136 179 66 1 190 109 7 168 0 179 9 191 247 117 44 38 183 37 219 73 94 155 59 207 71 160 17 126 38 209 20 31 46 243 153 137 176 235 105 5 88 65 152 122 197 163 89 92 236 5 142 158 156 119 212 80 16 198 200 214 3 240 19 230 219 152 52 252 41 107 137 192 31 29 86 34 209 10 170 237 250 138 74 189 219 126 15 195 90 35 218 238 161 133 97 171 115 251 78 4 243 254 151 204 83 135 169 177 188 167 116 84 137 33 26 43 168 198 128 197 55 220 232 245 242 1 151 229 158 230 173 146 97 219 216 34 32 200 247 10 0 133 125 131 200 168 203 247 113 9 67 8 116 236 118 227 165 75 164 132 78 93 155 139 49 15 175 4 68 243 111 2 76 221 132 56 184 106 248 174 157 74 190 120 83 227 57 47 86 57 46 14 218 54 176 203 105 -1749760677
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
