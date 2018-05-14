*** Settings ***
Documentation    EEC_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 105 174 206 10 128 33 19 32 199 181 116 63 170 128 166 235 141 57 198 87 34 240 190 180 24 204 121 66 174 229 12 52 66 161 95 67 200 252 212 223 86 88 13 214 36 165 46 21 104 0 2 64 189 205 58 31 167 116 86 21 156 222 18 87 56 100 108 223 35 129 251 88 183 33 51 108 248 206 29 66 47 96 119 62 22 163 214 74 154 190 171 244 23 241 21 146 147 15 214 199 108 97 179 128 49 35 42 235 67 157 132 169 69 105 158 183 67 243 131 155 252 100 244 56 237 18 247 183 179 61 219 252 228 124 78 156 203 144 159 211 125 20 61 32 211 209 89 215 130 152 16 228 54 10 30 70 3 55 192 68 85 223 50 5 149 81 221 146 27 137 248 3 237 39 202 243 9 0 77 10 222 217 144 139 185 2 128 195 168 58 171 99 1 158 90 17 67 36 179 190 42 112 108 173 134 204 126 170 93 114 218 248 42 108 7 183 14 102 238 25 161 184 132 73 236 235 105 137 131 167 208 172 96 155 100 255 57 203 7 44 128 214 211 217 172 154 51 248 151 239 8 147 110 174 158 253 54 11 16 186 224 9 120 78 248 123 201 127 179 232 14 186 99 190 206 56 245 199 241 243 128 118 209 254 127 58 43 223 92 212 114 147 241 114 197 148 150 92 49 173 224 254 87 19 36 8 153 39 225 125 27 189 6 48 190 233 175 41 15 72 174 234 62 186 182 105 80 75 138 88 21 218 8 179 26 70 172 239 172 27 190 210 59 125 23 43 153 110 67 179 183 34 85 58 131 150 6 138 175 119 160 23 157 75 18 71 243 47 152 252 219 121 83 231 163 120 91 106 218 3 186 38 146 133 56 235 247 140 157 121 64 231 103 68 61 246 113 56 166 127 126 227 251 57 48 11 212 5 147 135 141 99 104 56 16 191 121 98 120 200 7 98 164 202 21 220 246 52 152 216 71 3 10 212 5 160 213 181 99 86 77 170 134 32 10 226 253 228 26 201 111 212 138 234 4 34 86 36 42 224 196 55 24 37 9 88 26 214 148 50 163 220 60 64 35 172 61 179 51 4 243 122 109 60 20 158 247 45 52 213 179 26 201 232 192 37 206 54 158 66 169 182 119 2 135 68 20 196 169 188 251 241 85 65 249 86 70 205 54 82 19 138 249 154 84 181 227 246 78 241 34 205 107 129 95 102 63 152 30 223 18 18 186 157 115 194 73 109 156 76 218 162 190 166 31 125 130 64 211 58 251 173 73 23 46 89 208 49 224 55 106 126 186 49 45 94 114 209 0 239 182 42 107 153 163 135 66 205 167 176 173 209 184 210 87 30 244 150 97 186 101 180 105 110 215 127 117 37 193 71 253 223 88 223 147 43 220 157 164 236 74 127 106 201 183 52 179 243 244 65 188 61 214 26 55 5 25 207 113 151 41 165 48 97 238 200 208 72 201 127 218 230 128 13 70 174 87 248 148 222 249 222 118 104 213 90 156 228 55 191 180 8 141 71 15 23 51 98 171 29 118 225 191 4 48 150 115 202 177 91 96 52 219 234 100 134 4 47 244 247 213 150 213 255 44 161 199 144 192 207 141 9 83 46 243 58 251 12 253 239 180 69 15 148 196 20 201 116 135 120 178 81 215 225 69 50 170 117 12 29 77 89 120 191 249 178 158 144 238 98 198 74 70 0 165 140 47 243 218 124 40 144 29 44 229 20 192 141 92 196 150 98 114 42 37 112 139 30 160 219 13 63 82 77 150 212 174 43 84 41 171 127 225 95 22 233 0 18 83 25 173 120 96 47 190 237 2 34 115 232 142 234 251 220 14 226 55 244 77 146 11 188 2 157 183 55 79 176 153 103 218 81 253 169 154 244 71 11 80 47 207 70 218 33 232 163 30 51 151 189 64 86 165 8 90 168 154 220 244 16 33 44 61 46 3 112 52 105 195 42 220 52 59 207 230 247 222 34 231 53 178 14 117 220 196 134 247 183 80 78 253 10 144 173 247 106 197 16 153 43 202 217 23 65 35 23 243 59 5 198 135 87 228 23 124 217 122 163 1 116 46 216 70 208 200 34 97 105 214 157 130 237 19 240 32 223 105 144 252 59 60 23 47 99 157 94 67 242 198 144 74 129 239 81 174 126 12 28 201 157 134 98 100 127 47 180 108 78 92 90 105 102 139 1 182 210 14 225 67 103 6 84 150 186 192 209 27 70 133 200 1 195 231 108 144 204 186 158 38 33 -1458780161
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
