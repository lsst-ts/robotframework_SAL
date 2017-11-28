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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 211 138 32 191 162 75 93 204 156 224 163 50 188 11 91 54 236 208 178 140 43 2 224 206 129 96 174 88 49 80 230 108 225 8 98 155 27 195 77 193 66 134 109 168 80 224 32 158 32 14 130 35 53 190 27 92 16 35 140 59 147 31 69 246 252 99 135 51 187 18 123 245 109 212 53 138 250 192 210 221 235 247 156 165 47 174 14 182 79 18 80 109 118 130 92 72 254 172 33 190 12 146 181 145 2 11 80 90 82 20 116 5 190 32 7 80 42 171 235 129 247 147 154 196 222 122 147 224 186 87 33 130 39 40 229 85 176 3 193 43 59 13 132 239 43 238 70 156 133 220 251 65 226 91 44 69 252 121 130 27 120 157 138 13 26 55 23 123 93 229 31 129 118 242 70 199 235 41 3 107 175 171 174 74 152 23 16 249 160 162 113 78 27 143 251 219 65 62 17 91 64 87 106 165 83 255 32 49 243 41 104 108 86 155 122 250 162 136 162 250 90 34 61 135 140 43 98 97 236 132 203 76 48 99 143 146 135 143 25 16 8 156 16 41 38 156 17 234 99 179 226 141 74 162 113 30 191 23 62 161 76 47 56 194 73 127 211 63 159 122 135 130 250 13 90 168 13 216 141 88 241 235 3 209 236 24 94 64 82 115 212 176 125 132 122 162 12 159 4 91 38 178 69 146 20 13 89 247 58 77 245 138 250 97 65 243 160 101 74 242 169 108 71 73 36 106 32 166 100 96 19 245 168 73 173 179 205 6 180 206 106 15 160 151 11 33 185 214 53 144 191 191 76 96 141 229 148 136 221 57 124 100 196 69 175 101 102 62 32 230 174 215 145 214 28 208 254 42 240 98 122 41 221 219 246 245 156 105 198 140 172 157 92 61 165 44 106 242 221 67 189 222 240 106 57 148 177 224 75 9 78 30 40 211 54 75 37 193 33 132 135 87 43 131 236 224 36 84 137 213 155 244 160 46 16 65 28 187 232 247 169 111 26 202 215 83 40 194 181 95 86 3 115 177 48 229 246 45 126 199 23 16 4 67 13 91 83 83 250 240 144 31 134 79 102 141 102 148 4 165 77 77 25 14 33 203 247 154 62 196 208 83 147 101 18 38 72 6 139 156 213 163 68 234 84 19 252 211 72 98 166 66 248 63 210 138 116 119 181 25 242 137 38 14 224 94 173 30 150 152 168 3 209 104 161 154 179 147 188 152 83 60 235 27 236 195 82 166 199 34 68 170 212 63 38 147 231 67 118 97 172 211 48 15 122 51 208 97 61 250 244 195 232 23 75 127 108 146 97 237 224 117 189 66 252 22 14 26 84 221 252 61 75 57 237 24 247 82 191 223 21 207 50 117 200 9 11 92 78 233 76 241 190 115 108 97 128 177 15 188 138 63 130 133 210 210 100 12 221 231 0 130 214 174 94 110 124 118 177 204 11 200 122 57 158 14 246 25 234 103 216 216 131 11 23 119 193 178 34 118 167 76 64 115 244 46 105 138 139 150 251 3 188 72 114 132 2 250 57 100 133 174 252 5 230 211 162 3 229 238 151 235 123 234 76 31 32 56 106 129 217 158 235 245 20 11 155 160 99 192 141 56 218 193 148 18 234 46 172 115 186 194 220 146 250 190 109 133 7 2 70 70 237 224 251 65 163 240 129 112 187 78 100 53 49 168 109 199 72 3 131 56 175 123 66 161 222 106 19 85 214 52 188 31 196 115 107 231 254 209 33 137 11 254 4 13 254 117 162 226 249 252 4 120 12 215 149 190 8 218 188 39 78 34 207 87 233 143 93 93 135 18 178 61 80 124 108 178 88 11 190 25 52 207 98 4 27 28 143 231 176 227 42 161 217 138 241 179 132 149 203 83 2 69 155 109 56 151 152 25 93 240 167 253 98 144 220 27 192 46 221 0 140 136 122 213 168 176 239 70 176 71 10 232 6 251 176 50 163 144 111 1 192 161 149 202 235 12 16 84 99 189 119 64 103 246 170 107 177 210 34 68 31 51 16 22 196 33 42 45 164 168 160 3 39 91 80 104 224 97 96 158 85 161 141 16 101 111 2 130 29 76 219 168 95 56 192 165 87 158 82 52 47 197 216 47 88 222 90 106 224 68 69 161 204 58 141 248 48 104 91 134 138 122 56 208 225 44 252 149 237 185 211 134 215 76 56 209 85 250 208 208 32 134 212 126 237 5 192 152 161 21 196 154 221 128 133 147 135 11 165 56 15 65 186 216 198 218 95 225 -2079915213
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
