*** Settings ***
Documentation    TcsOFC_internalCommand communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcsOfc
${component}    internalCommand
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : commandObject priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 107 55 90 125 158 177 179 5 101 78 234 98 57 227 42 96 104 143 56 231 140 117 219 16 41 191 65 41 188 108 131 2 121 78 207 5 219 162 184 180 205 74 186 221 66 59 192 194 140 48 248 28 99 96 132 49 252 25 47 156 72 23 51 7 20 52 80 99 180 239 156 145 31 60 49 225 217 74 114 13 152 80 144 211 122 124 203 220 200 210 148 213 194 108 152 107 182 81 62 92 214 2 85 49 181 28 85 100 229 14 147 235 194 156 59 40 201 57 190 23 251 208 250 207 136 90 15 7 89 230 23 156 61 150 14 135 146 116 100 164 157 104 60 228 112 205 150 212 11 117 122 9 55 129 188 139 93 156 202 239 160 83 33 39 72 247 60 152 101 247 163 154 215 230 30 95 243 103 180 222 66 250 198 161 76 98 87 156 224 81 143 24 16 61 98 148 17 179 32 87 76 83 69 87 90 203 237 2 200 188 192 142 115 37 89 209 49 163 119 176 171 6 181 218 162 10 200 36 14 5 205 6 15 78 163 9 86 14 229 65 159 107 213 233 208 212 74 190 53 134 10 84 197 218 138 42 81 141 201 246 100 49 173 70 132 23 242 33 157 115 43 147 79 27 92 60 184 29 207 176 233 119 33 244 89 234 21 82 35 37 179 39 48 141 83 71 70 250 233 51 29 242 146 188 32 4 25 118 121 146 81 3 3 219 127 2 212 102 31 163 109 12 96 111 68 56 238 214 91 100 85 56 39 33 66 186 147 178 198 11 141 42 49 193 183 1 24 190 189 185 246 79 14 167 214 164 124 44 145 119 185 223 203 120 155 8 37 139 164 60 233 59 114 97 236 144 75 211 35 131 83 243 211 205 97 33 106 166 235 240 130 142 61 133 175 80 74 104 233 183 191 26 228 67 40 122 213 28 118 255 250 216 236 97 194 233 113 65 240 243 199 49 208 99 157 230 202 181 1 153 88 190 96 146 139 254 223 121 159 75 94 128 36 243 9 200 138 225 64 5 153 122 239 153 189 175 82 233 235 10 62 95 133 172 100 244 18 199 182 228 68 146 20 31 199 91 31 25 143 134 158 227 165 11 50 2 50 70 97 113 126 87 241 204 217 234 88 114 207 233 18 36 22 32 106 221 168 23 113 190 84 95 14 255 168 103 225 245 31 238 213 105 154 34 137 32 242 151 118 177 170 10 179 30 227 48 208 173 34 81 184 147 8 102 212 21 190 29 241 181 14 214 215 34 16 189 219 92 190 19 8 201 234 164 7 73 56 61 115 77 10 4 89 199 19 150 43 132 117 145 185 29 132 246 43 136 203 177 247 233 35 232 9 78 195 197 136 38 222 104 36 38 158 28 131 68 64 26 37 162 141 10 200 181 198 251 135 154 63 63 226 40 152 197 166 74 56 99 109 221 168 143 13 217 81 177 137 15 27 244 169 80 80 50 164 4 69 207 254 242 49 253 81 60 53 82 233 19 185 253 180 108 75 114 174 2 3 88 75 77 165 167 32 122 221 96 144 60 120 246 146 62 203 249 104 59 127 157 117 131 253 92 246 66 128 206 172 244 183 203 82 165 248 59 178 187 164 183 157 94 159 86 238 38 98 81 68 236 237 214 194 188 201 72 123 99 113 121 132 137 212 111 44 243 247 238 33 207 196 137 140 214 124 79 135 148 6 65 184 107 252 8 170 220 38 251 102 33 159 219 215 63 172 101 138 31 171 44 185 129 16 35 120 151 101 45 229 110 203 241 188 104 98 5 126 194 12 205 161 31 170 5 66 80 96 111 141 29 27 15 -1997508373
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcsOfc::logevent_internalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
