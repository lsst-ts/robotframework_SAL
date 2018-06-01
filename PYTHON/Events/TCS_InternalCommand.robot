*** Settings ***
Documentation    TCS_InternalCommand communications tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 219 247 198 130 232 119 164 207 121 55 108 218 10 206 157 117 226 150 142 125 86 86 44 40 246 204 225 62 93 140 56 193 128 86 33 209 116 127 94 16 95 59 179 247 186 71 178 230 138 170 249 70 7 124 32 163 20 216 201 112 116 15 200 86 16 208 142 132 208 19 239 78 193 191 243 170 171 112 165 98 176 5 50 211 110 210 46 135 243 115 101 248 146 151 192 132 141 165 66 165 132 135 214 111 152 163 241 27 121 14 91 250 21 9 101 55 50 10 245 175 227 77 81 42 47 81 156 94 133 46 119 234 17 131 98 138 22 50 93 48 77 13 143 118 34 255 232 163 83 160 24 120 81 248 31 175 236 85 30 113 114 211 159 157 82 75 20 97 194 215 243 87 37 157 51 79 152 54 110 19 76 44 211 239 175 64 209 58 200 87 38 121 28 160 155 165 73 182 188 228 145 193 212 253 245 40 103 58 132 179 188 2 116 48 13 72 98 119 34 152 122 214 49 198 147 23 126 152 222 52 124 194 183 63 214 162 147 172 239 247 240 83 141 131 169 127 204 28 166 33 92 253 6 206 222 3 92 127 113 207 201 80 46 173 234 103 230 143 219 30 197 197 162 121 252 131 209 164 231 140 39 204 75 62 116 37 246 106 111 26 139 64 27 130 124 233 245 110 19 150 237 134 180 176 29 103 221 66 235 5 57 238 49 247 45 132 7 65 60 66 99 156 173 117 49 183 122 76 185 78 93 169 130 80 240 67 208 30 192 71 246 198 132 124 96 220 53 16 4 205 74 107 202 165 133 224 141 131 92 110 73 96 12 204 121 166 115 123 206 248 78 241 78 126 146 245 4 145 194 143 104 0 212 180 210 159 217 224 223 183 73 103 181 129 4 46 147 2 20 139 49 194 234 150 169 227 98 9 58 116 96 211 82 13 195 210 26 163 13 200 9 76 87 89 162 179 30 34 196 45 246 242 149 126 43 223 126 63 170 103 34 121 227 51 251 147 194 229 245 171 132 94 7 197 4 229 33 104 213 48 166 62 215 52 100 121 3 16 68 213 193 78 127 249 171 248 98 60 128 150 205 24 248 32 129 164 235 152 18 14 86 37 254 84 238 219 170 10 25 168 143 87 145 65 254 120 227 179 101 125 225 253 25 164 94 57 15 95 236 130 100 25 211 67 92 74 141 109 201 31 145 87 123 114 164 27 102 4 123 20 91 50 46 6 50 46 70 161 173 19 226 14 109 210 231 173 42 253 35 146 13 210 217 218 184 69 247 70 51 146 130 211 64 27 195 220 94 102 157 183 140 146 134 95 24 96 63 159 175 15 121 145 26 11 147 64 230 215 124 73 97 165 34 68 239 145 27 109 149 83 120 164 37 30 134 113 193 90 16 20 159 130 130 143 102 221 10 34 191 243 250 153 149 42 150 155 148 163 203 250 77 24 82 195 203 167 93 240 35 130 3 122 172 247 227 138 70 237 186 54 127 101 173 220 13 73 45 160 213 74 16 207 175 237 42 193 159 146 108 81 113 162 239 202 222 125 64 38 139 6 118 97 232 25 245 86 42 218 65 227 71 251 183 117 138 130 87 83 159 234 193 43 240 57 141 104 185 220 172 179 154 125 125 235 175 178 63 195 69 94 140 30 104 149 174 205 89 208 53 246 21 213 111 133 193 123 9 63 177 244 184 80 31 254 230 163 91 244 196 149 137 65 228 24 148 142 17 73 106 106 175 47 91 57 71 174 117 133 185 246 199 186 30 9 45 6 80 202 132 225 109 206 250 13 112 200 34 249 72 61 42 176 218 33 93 116 55 193 232 64 135 104 71 127 100 63 60 104 246 11 194 162 41 18 181 125 69 144 141 180 61 10 126 14 153 130 193 63 162 148 44 144 41 152 69 134 163 12 31 106 241 29 19 77 136 198 213 31 136 218 251 115 69 210 158 197 175 53 237 47 45 154 152 20 98 215 129 221 214 234 20 94 67 100 126 31 2 187 44 244 6 235 109 137 209 90 248 3 46 188 151 207 21 233 242 139 50 32 144 92 59 183 143 45 109 144 163 171 226 252 27 246 249 215 120 115 201 122 31 219 215 144 149 198 165 240 174 248 27 64 229 215 132 19 159 57 92 22 95 81 254 179 65 135 135 171 21 98 197 8 66 87 27 50 113 164 115 94 156 127 115 163 126 169 187 98 4 84 238 76 227 221 41 93 83 43 78 236 25 180 113 40 20 109 252 178 219 27 224 185 2095877431
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
