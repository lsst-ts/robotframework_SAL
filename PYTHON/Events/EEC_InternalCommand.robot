*** Settings ***
Documentation    EEC_InternalCommand sender/logger tests.
Force Tags    python    TSS-2724
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 120 167 50 205 150 26 195 196 223 10 255 107 110 50 224 140 31 18 96 244 168 228 212 68 131 45 227 194 166 251 149 139 28 67 181 72 151 14 69 211 87 161 42 78 42 13 209 119 143 208 200 65 249 37 130 102 72 175 163 116 33 229 221 97 79 209 154 29 13 71 100 176 88 2 61 238 54 220 211 197 134 239 190 248 24 15 170 19 17 24 63 19 251 1 102 35 19 17 165 136 121 149 68 120 245 168 61 215 232 84 58 42 96 104 165 211 133 234 54 27 99 113 96 80 70 105 138 192 143 235 230 49 255 29 191 215 31 112 86 12 140 10 54 233 165 94 193 223 67 50 8 30 127 75 179 200 90 231 138 238 196 15 245 231 145 187 52 66 132 22 124 127 233 87 244 51 201 244 37 30 29 30 212 18 22 13 181 111 246 129 184 172 122 120 220 236 216 113 185 2 114 27 233 68 229 154 26 204 78 88 71 140 228 212 168 124 134 239 198 103 184 11 73 128 124 241 188 87 5 237 182 154 56 46 176 70 58 109 65 213 239 154 190 104 45 3 21 102 20 147 130 222 111 206 252 179 151 131 177 59 102 238 56 210 194 40 195 255 38 216 47 154 90 248 230 229 105 207 255 97 73 249 19 230 62 158 232 142 146 223 203 57 217 175 188 116 26 171 157 12 38 195 166 62 149 180 86 11 200 171 110 61 88 50 240 149 150 39 87 235 149 10 217 108 53 119 237 249 39 218 8 9 96 136 193 3 165 172 171 199 123 73 62 216 232 82 128 241 116 38 94 239 143 117 70 167 178 33 123 127 129 16 223 194 241 187 148 177 38 220 131 75 197 107 125 128 151 180 170 158 29 124 232 182 147 137 245 94 38 149 221 66 51 172 144 57 125 233 212 64 105 97 101 139 70 157 162 176 145 28 162 77 39 127 168 109 164 29 109 69 92 191 38 194 194 44 151 175 184 80 169 79 180 189 220 21 78 197 200 82 199 183 219 155 58 67 217 170 45 146 67 245 219 39 174 89 255 180 155 97 104 112 114 191 247 94 23 53 151 65 15 29 31 23 255 138 224 90 25 127 189 168 210 75 46 41 71 218 238 94 149 224 82 48 95 143 59 216 94 105 55 248 113 54 170 25 19 180 47 22 190 138 102 196 245 129 152 140 107 76 186 10 221 79 148 157 21 21 45 199 154 45 133 46 248 166 173 218 235 218 202 99 126 100 103 126 216 120 165 165 244 142 95 167 138 41 212 176 121 182 219 215 192 136 250 206 135 32 165 74 122 250 15 190 82 150 191 42 136 72 200 24 178 93 144 46 172 207 40 95 208 125 186 226 236 19 130 161 126 228 55 58 165 214 212 36 165 54 57 19 41 252 23 87 185 32 126 180 117 204 36 5 25 19 118 177 201 232 42 173 149 151 22 188 68 121 75 43 20 55 111 8 132 249 66 56 10 190 208 157 187 97 147 95 253 203 148 88 147 151 19 173 251 192 91 26 104 42 251 80 147 223 247 108 70 108 5 157 78 127 231 50 233 212 80 91 158 222 174 179 83 107 240 155 84 5 8 128 1 180 150 154 224 20 236 23 72 1 254 155 66 26 203 190 13 203 92 250 251 118 119 23 92 69 254 70 179 12 137 243 246 149 59 117 47 181 218 57 44 192 8 89 115 132 16 61 101 172 113 225 219 49 195 81 64 237 209 126 137 240 207 24 53 142 110 143 240 216 60 226 165 109 7 15 105 229 64 34 230 17 49 151 230 200 233 228 158 64 29 27 20 177 71 198 7 0 216 63 98 89 31 146 59 205 196 254 194 19 5 225 235 209 228 175 54 177 98 85 164 11 239 32 79 108 17 77 25 199 171 63 88 29 42 178 154 11 83 86 182 185 41 23 9 101 212 194 1 7 36 19 87 161 72 197 149 165 17 60 74 82 202 118 182 237 0 129 16 137 160 8 9 180 50 223 81 181 83 61 9 88 246 215 132 54 9 193 111 127 63 73 201 63 114 214 184 129 18 194 156 229 183 141 74 17 96 115 82 19 79 112 29 63 137 118 68 179 10 124 131 68 17 167 152 123 156 41 217 226 35 140 125 66 105 162 168 228 76 238 81 165 156 135 189 159 124 17 224 19 247 183 193 212 30 196 147 37 161 99 66 74 199 244 128 150 88 226 74 66 161 18 255 16 177 85 221 142 179 99 23 164 19 89 68 191 128 71 78 183 151 53 20 201 135 168 172 104 35 211 201 135 -43232414
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
