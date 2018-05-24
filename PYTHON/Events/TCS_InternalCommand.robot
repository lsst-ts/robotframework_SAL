*** Settings ***
Documentation    TCS_InternalCommand sender/logger tests.
Force Tags    python    TSS-2724
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 249 125 232 218 95 8 27 248 228 222 74 84 65 58 136 106 195 136 24 146 97 242 12 241 51 155 209 47 178 118 178 148 222 174 206 236 193 153 56 115 11 146 93 84 149 145 82 111 4 35 40 131 221 120 195 162 54 107 189 217 120 110 151 127 144 71 10 26 28 214 153 99 253 207 178 8 0 137 21 97 143 22 126 117 164 24 147 21 130 89 69 203 170 246 237 0 138 58 158 237 151 239 52 96 24 55 205 178 79 149 61 20 216 54 37 135 228 4 183 6 130 181 5 148 74 49 10 11 168 226 70 104 227 176 151 95 221 61 203 237 38 230 114 246 47 68 3 91 91 36 247 106 31 199 185 103 167 3 79 116 206 136 150 16 94 146 119 219 209 202 13 78 152 9 164 207 12 70 50 193 27 118 134 194 109 163 81 1 39 64 86 200 173 134 180 180 91 223 135 3 136 121 237 78 149 97 61 199 171 243 47 181 99 92 161 216 13 102 151 124 50 218 101 169 23 169 211 176 217 62 188 147 134 1 68 115 175 59 129 236 245 244 178 226 99 85 138 153 173 78 142 45 206 124 105 88 126 227 70 216 193 3 94 180 167 245 110 18 204 26 255 10 198 50 37 208 142 37 249 218 197 148 45 141 100 84 109 112 84 15 38 229 55 154 134 30 209 99 214 14 212 79 36 140 29 198 55 111 82 207 25 117 29 233 203 99 189 119 202 157 125 160 120 201 79 176 12 113 202 85 192 1 189 200 204 133 53 65 90 67 78 122 218 11 82 233 37 92 95 251 210 249 129 152 55 15 33 207 115 131 68 229 199 108 3 109 109 55 176 84 201 207 234 123 86 250 174 183 175 67 209 186 115 164 57 183 91 141 76 42 120 29 55 233 207 213 253 18 73 181 161 36 213 193 213 98 11 107 117 138 192 184 238 119 64 95 38 10 190 103 205 200 150 152 163 28 180 83 174 218 59 214 179 2 231 141 3 21 188 84 172 0 100 253 10 76 169 23 225 91 224 112 143 229 37 163 69 202 229 122 54 24 81 102 69 53 229 121 84 201 27 59 88 18 137 203 30 143 74 49 184 102 55 131 105 41 104 97 220 253 228 125 125 72 89 150 93 133 10 198 155 241 163 127 7 63 140 140 51 191 170 142 61 31 144 215 136 62 184 161 232 66 208 169 35 194 208 96 243 37 148 157 223 151 217 156 191 40 116 60 65 59 145 237 21 224 148 85 180 248 102 146 247 154 23 248 103 220 2 28 175 88 215 20 161 12 92 245 234 99 148 161 97 47 185 127 109 57 167 250 116 222 18 221 68 10 2 169 154 242 41 184 101 84 18 79 50 222 102 135 180 177 249 28 4 69 145 143 27 102 91 28 102 77 93 54 47 247 229 100 107 197 22 122 43 212 67 136 15 55 246 66 172 229 124 253 53 181 36 182 15 195 156 11 38 33 9 230 221 160 184 135 111 142 250 64 119 107 99 171 219 67 18 240 107 191 78 95 214 52 243 69 239 181 240 166 229 173 109 22 11 67 126 38 91 36 205 239 79 167 138 124 112 210 165 254 140 176 73 153 141 204 227 24 116 135 148 14 64 63 132 139 109 202 55 240 182 43 115 193 28 40 17 81 4 19 127 193 141 18 165 117 195 35 248 171 122 119 233 148 135 54 50 140 149 80 212 181 33 116 23 65 226 17 203 101 36 211 167 169 98 10 14 23 179 62 194 32 126 194 101 151 41 229 231 189 244 90 191 57 35 122 16 51 192 92 45 95 91 255 237 165 41 110 83 90 115 26 219 52 79 58 102 138 17 243 15 26 167 85 208 25 194 115 16 95 128 88 151 148 122 213 57 252 196 2 47 85 236 48 63 20 60 254 11 71 74 109 82 174 154 146 95 83 24 97 208 244 243 115 50 137 123 244 234 38 39 193 189 166 221 30 9 10 250 34 40 149 252 75 151 232 3 91 20 191 100 85 156 84 84 9 110 26 95 78 52 132 150 209 83 146 60 106 203 208 251 16 34 77 175 123 132 138 178 152 63 190 247 199 96 28 175 51 88 192 206 196 52 55 221 151 32 71 13 27 8 217 205 246 137 44 170 45 207 63 255 62 100 124 115 150 117 144 47 118 243 252 38 11 231 23 221 164 194 222 198 15 7 43 9 41 0 162 217 65 55 190 132 216 150 246 54 31 96 191 102 137 147 177 189 139 141 190 118 142 131 226 79 177 103 38 228 1 191 43 166 188 115 246 1627168638
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
